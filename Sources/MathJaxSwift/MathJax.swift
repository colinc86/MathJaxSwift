//
//  MathJax.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 11/26/22.
//

import Foundation
import JavaScriptCore

/// A class that exposes MathJax conversion methods.
public final class MathJax {
  
  // MARK: Types
  
  /// An error thrown by the `MathJax` package.
  public enum MJError: Error, CustomStringConvertible {
    case unknown
    case deallocatedSelf
    case unableToCreateContext
    case javascriptException(value: String?)
    
    case missingPackageFile
    case missingDependencyInformation
    case missingBundle(url: URL)
    case missingModule
    case missingClass
    case missingFunction(name: String)
    
    case unexpectedVersion(version: String)
    
    case conversionFailed
    case conversionUnknownError
    case conversionInvalidFormat
    
    public var description: String {
      switch self {
      case .unknown:                        return "An unknown error occurred."
      case .deallocatedSelf:                return "An internal error occurred."
      case .unableToCreateContext:          return "The required JavaScript context could not be created."
      case .javascriptException(let value): return "The JavaScript context threw an exception: \(value ?? "(unknown)")"
        
      case .missingPackageFile:             return "The npm package-lock file was missing or is inaccessible."
      case .missingDependencyInformation:   return "The mathjax-full node module metadata was missing."
      case .missingBundle(let url):         return "The bundled JavaScript file at \(url) is missing or is inaccessible."
      case .missingModule:                  return "The module is missing or is inaccessible."
      case .missingClass:                   return "The class is missing or is inaccessible."
      case .missingFunction(let name):      return "The function, \(name), is missing or is inaccessible."
        
      case .unexpectedVersion(let version): return "The MathJax version (\(version)) was not the expected version (\(Constants.expectedMathJaxVersion))."
      
      case .conversionFailed:               return "The function failed to convert the input string."
      case .conversionUnknownError:         return "The conversion failed for an unknown reason."
      case .conversionInvalidFormat:        return "The output format was invalid."
      }
    }
  }
  
  /// The npm `mathjax-full` metadata.
  public struct Metadata: Codable {
    
    /// The version of the module.
    let version: String
    
    /// The URL of the module.
    let resolved: URL
    
    /// The module's SHA-512.
    let integrity: String
  }
  
  // MARK: Private/internal properties
  
  /// The JS context.
  private let context: JSContext
  
  // MARK: Initializers
  
  /// Initializes a new `MathJax` instance.
  public init() throws {
    // Make sure we're using the correct MathJax version
    let metadata = try MathJax.metadata()
    guard metadata.version == Constants.expectedMathJaxVersion else {
      throw MJError.unexpectedVersion(version: metadata.version)
    }
    
    // Get the bundle path
    guard let bundleURL = Constants.URLs.bundle else {
      throw MJError.unknown
    }
    
    // Make sure the bundle exists
    guard FileManager.default.fileExists(atPath: bundleURL.path) else {
      throw MJError.missingBundle(url: bundleURL)
    }

    // Create the JavaScript context
    guard let ctx = JSContext() else {
      throw MJError.unableToCreateContext
    }
    context = ctx
    
    // Load the bundle's contents to the context
    context.evaluateScript(try String(contentsOf: bundleURL))
    
    // Make sure no exception was thrown
    try checkForJSException()
  }
  
}

// MARK: - Public static methods

extension MathJax {
  
  /// The MathJax npm module metadata.
  ///
  /// - Returns: An npm package metadata structure containing version, URL, and
  ///   hash information about the `mathjax-full` module.
  public static func metadata() throws -> Metadata {
    // Get the URL of the package-lock.json file.
    guard let packageLockURL = Constants.URLs.packageLock else {
      throw MJError.missingPackageFile
    }
    
    // Get the file's data.
    let package = try JSONDecoder().decode(PackageLock.self, from: try Data(contentsOf: packageLockURL))
    
    // Find the mathjax module and return its metadata.
    guard let dependency = package.dependencies[Constants.Names.Modules.mathjax] else {
      throw MJError.missingDependencyInformation
    }
    return dependency
  }
  
}

// MARK: - Private/internal methods

extension MathJax {
  
  /// Checks for an exception in the JS context and throws an error if one is
  /// present.
  private func checkForJSException() throws {
    // Do we have an exception?
    guard let exception = context.exception else {
      return
    }
    
    // Throw its string value.
    throw MJError.javascriptException(value: exception.toString())
  }
  
  /// Calls the function with the given arguments.
  ///
  /// - Parameters:
  ///   - function: The function to call.
  ///   - arguments: The arguments to pass to the function.
  /// - Returns: The function's return value.
  internal func callFunction(_ functionName: String, with arguments: [Any]) throws -> String {
    // Get the module's JS value
    guard let module = context.objectForKeyedSubscript(Constants.Names.Modules.mjn) else {
      throw MJError.missingModule
    }
    
    // Get the class's JS value
    guard let converter = module.objectForKeyedSubscript(Constants.Names.converterClass) else {
      throw MJError.missingClass
    }
    
    // Get the function's JS value
    guard let function = converter.objectForKeyedSubscript(functionName) else {
      throw MJError.missingFunction(name: functionName)
    }
    
    // Call the function and get its return value
    guard let value = function.call(withArguments: arguments) else {
      throw MJError.conversionFailed
    }
    
    // Make sure no exceptions were thrown.
    try checkForJSException()
    
    // Make sure the value isn't undefined.
    guard !value.isUndefined else {
      throw MJError.conversionUnknownError
    }
    
    // Get the string value and return it
    guard let stringValue = value.toString() else {
      throw MJError.conversionInvalidFormat
    }
    return stringValue
  }
  
  /// Performs the throwing closure asynchronously.
  ///
  /// - Parameter closure: The closure to execute.
  /// - Returns: A string.
  internal func performAsync(_ closure: @escaping (MathJax) throws -> String) async throws -> String {
    return try await withCheckedThrowingContinuation { [weak self] continuation in
      guard let self = self else {
        continuation.resume(throwing: MJError.deallocatedSelf)
        return
      }
      
      Task {
        do {
          continuation.resume(returning: try closure(self))
        }
        catch {
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
}
