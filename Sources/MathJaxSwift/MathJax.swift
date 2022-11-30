//
//  MathJax.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 11/26/22.
//

import Foundation
import JavaScriptCore

/// An object that receives messages from a MathJax instance.
public protocol MathJaxDelegate: AnyObject {

  /// The MathJax instance received an exception through its JavaScript context.
  ///
  /// - Parameter exception: The exception that was received.
  func mathJax(_ mathJax: MathJax, receivedException exception: String?)
  
}

/// A class that exposes MathJax conversion methods.
public final class MathJax {
  
  // MARK: Types
  
  /// An error thrown by the `MathJax` package.
  public enum MJError: Error, CustomStringConvertible {
    case unknown
    case missingPackageFile
    case missingDependencyInformation
    case unableToCreateContext
    case missingBundle(url: URL)
    case missingModule
    case missingClass
    case missingFunction(name: String)
    case unexpectedVersion(version: String)
    case deallocatedSelf
    case conversionFailed
    case conversionUnknownError
    case conversionInvalidFormat
    
    public var description: String {
      switch self {
      case .unknown:                        return "An unknown error occurred."
      case .missingPackageFile:             return "The npm package-lock file was missing or is inaccessable."
      case .missingDependencyInformation:   return "The mathjax-full node module metadata was missing."
      case .unableToCreateContext:          return "The required JavaScript context could not be created."
      case .missingBundle(let url):         return "The bundled JavaScript file at \(url) is missing or is inaccessable."
      case .missingModule:                  return "The module is missing or is inaccessable."
      case .missingClass:                   return "The class is missing or is inaccessable."
      case .missingFunction(let name):      return "The function, \(name), is missing or is inaccessable."
      case .unexpectedVersion(let version): return "The MathJax version (\(version)) was not the expected version (\(Constants.expectedMathJaxVersion))."
      case .deallocatedSelf:                return "An internal error occurred."
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

  // MARK: Public properties

  /// The delegate to receive exceptions.
  public weak var delegate: MathJaxDelegate?
  
  // MARK: Initializers
  
  /// Initializes a new `MathJax` instance.
  ///
  /// - Parameter delegate: The MathJax delegate to receive exceptions.
  public init(delegate: MathJaxDelegate? = nil) throws {
    self.delegate = delegate
    
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
    context.exceptionHandler = handleException
    
    // Load the bundle's contents to the context
    context.evaluateScript(try String(contentsOf: bundleURL))
  }
  
}

// MARK: - Public static methods

extension MathJax {
  
  /// The MathJax npm module metadata.
  ///
  /// - Returns: An npm package metadata structure containing version, URL, and
  ///   hash information about the `mathjax-full` module.
  public static func metadata() throws -> Metadata {
    guard let packageLockURL = Constants.URLs.packageLock else {
      throw MJError.missingPackageFile
    }
    let package = try JSONDecoder().decode(
      PackageLock.self,
      from: try Data(contentsOf: packageLockURL))
    guard let dependency = package.dependencies[Constants.Names.Modules.mathjax] else {
      throw MJError.missingDependencyInformation
    }
    return dependency
  }
  
}

// MARK: - Private/internal methods

extension MathJax {
  
  /// Handles an exception from the JS context.
  ///
  /// - Parameters:
  ///   - context: The JS context that produced the exception.
  ///   - value: The value passed as an exception.
  private func handleException(from context: JSContext?, value: JSValue?) {
    delegate?.mathJax(self, receivedException: value?.toString())
  }
  
  /// Calls the function with the given arguments.
  ///
  /// - Parameters:
  ///   - function: The function to call.
  ///   - arguments: The arguments to pass to the function.
  /// - Returns: The function's return value.
  internal func callFunction(_ functionName: String, with arguments: [Any]) throws -> String {
    guard let module = context.objectForKeyedSubscript(Constants.Names.Modules.mjn) else {
      throw MJError.missingModule
    }
    guard let converter = module.objectForKeyedSubscript(Constants.Names.converterClass) else {
      throw MJError.missingClass
    }
    guard let function = converter.objectForKeyedSubscript(functionName) else {
      throw MJError.missingFunction(name: functionName)
    }
    guard let value = function.call(withArguments: arguments) else {
      throw MJError.conversionFailed
    }
    guard !value.isUndefined else {
      throw MJError.conversionUnknownError
    }
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
