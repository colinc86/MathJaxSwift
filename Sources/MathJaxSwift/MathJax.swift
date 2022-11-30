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

/// A class that exposes the `tex2svg`, `tex2chtml`, and `tex2mml` MathJax
/// methods.
public final class MathJax {
  
  // MARK: Types
  
  /// An error thrown by the `MathJax` package.
  public enum MathJaxError: Error, CustomStringConvertible {
    case missingPackageFile
    case missingDependencyInformation
    case missingJSContext
    case missingBundle
    case missingFunction
    case unexpectedVersion
    case deallocatedSelf
    case conversionFailed
    case conversionUnknownError
    case conversionInvalidFormat
    
    public var description: String {
      switch self {
      case .missingPackageFile: return "The npm package-lock file was missing or is inaccessable."
      case .missingDependencyInformation: return "The mathjax-full dependency metadata was missing."
      case .missingJSContext: return "The required JavaScript context could not be created."
      case .missingBundle: return "The bundled JavaScript file was missing or is inaccessable."
      case .missingFunction: return "The conversion function was missing from the JavaScript bundle."
      case .unexpectedVersion: return "The MathJax version was not the expected version."
      case .deallocatedSelf: return "An internal error occurred."
      case .conversionFailed: return "The function failed to convert the input string."
      case .conversionUnknownError: return "The conversion failed for an unknown reason."
      case .conversionInvalidFormat: return "The output format was invalid."
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
  
  /// NPM package-lock.json metadata for extracting the mathjax-full version
  /// string.
  internal struct PackageLock: Codable {
    
    /// The package-lock file's dependencies.
    let dependencies: [String: Metadata]
  }
  
  // MARK: Private/internal properties
  
  /// The JS virtual machine.
  private let vm = JSVirtualMachine()
  
  /// The JS context.
  private let context: JSContext
  
  /// The TeX to SVG function.
  internal var tex2svgFunction: JSValue!
  
  /// The TeX to CHTML function.
  internal var tex2chtmlFunction: JSValue!
  
  /// The TeX to MML function.
  internal var tex2mmlFunction: JSValue!

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
      throw MathJaxError.unexpectedVersion
    }

    // Create the JavaScript context
    guard let ctx = JSContext(virtualMachine: vm) else {
      throw MathJaxError.missingJSContext
    }
    context = ctx
    context.exceptionHandler = handleException
    
    // Get the bundle path and make sure it exists.
    guard let bundleURL = Constants.URLs.bundle,
          FileManager.default.fileExists(atPath: bundleURL.path) else {
      throw MathJaxError.missingBundle
    }
    
    // Load the bundle's contents.
    context.evaluateScript(try String(contentsOf: bundleURL))
    
    // Get a reference to the converter.
    let converter = context
      .objectForKeyedSubscript(Constants.Names.mjnModuleName)?
      .objectForKeyedSubscript(Constants.Names.converterClassName)
    
    // Get a reference to the functions.
    tex2svgFunction = converter?.objectForKeyedSubscript(Constants.Names.tex2svgFunctionName)
    tex2chtmlFunction = converter?.objectForKeyedSubscript(Constants.Names.tex2chtmlFunctionName)
    tex2mmlFunction = converter?.objectForKeyedSubscript(Constants.Names.tex2mmlFunctionName)
    
    // Make sure we were able to get the convert function
    guard tex2svgFunction?.isObject == true,
          tex2chtmlFunction?.isObject == true,
          tex2mmlFunction?.isObject == true else {
      throw MathJaxError.missingFunction
    }
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
      throw MathJaxError.missingPackageFile
    }
    let package = try JSONDecoder().decode(
      PackageLock.self,
      from: try Data(contentsOf: packageLockURL))
    guard let dependency = package.dependencies[Constants.Names.mathJaxModuleName] else {
      throw MathJaxError.missingDependencyInformation
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
  internal func callFunction(_ function: JSValue?, with arguments: [Any]) throws -> String {
    guard let value = function?.call(withArguments: arguments) else {
      throw MathJaxError.conversionFailed
    }
    guard let stringValue = value.toString() else {
      throw MathJaxError.conversionInvalidFormat
    }
    return stringValue
  }
  
}
