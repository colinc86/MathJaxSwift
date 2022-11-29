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

  /// The MathJax instance received an exception.
  ///
  /// - Parameter exception: The exception that was received.
  func mathJax(_ mathJax: MathJax, receivedException exception: String?)
}

/// A class that exposes the `tex2svg`, `tex2chtml`, and `tex2mml` MathJax 
/// methods.
public class MathJax {
  
  // MARK: Types
  
  /// An error thrown by the `MathJax` package.
  public enum MathJaxError: Error, CustomStringConvertible {
    case missingPackageFile
    case missingDependencyInformation
    case missingJSContext
    case missingBundle
    case missingFunction
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
  
  // MARK: Private static properties
  
  private static let mathJaxModuleName = "mathjax-full"
  private static let mjnModuleName = "mjn"
  private static let converterClassName = "Converter"
  private static let tex2svgFunctionName = "tex2svg"
  
  private static let mjnBundleFilePath = "dist/mjn.bundle.js"
  private static let packageLockFilePath = "package-lock.json"
  
  /// The URL of the mjn top-level directory.
  private static let mjn = Bundle.module.url(forResource: mjnModuleName, withExtension: nil)
  
  /// The URL of the JS bundle file.
  private static let bundle = mjn?.appending(path: mjnBundleFilePath)
  
  /// The URL of the mjn package-lock.json file.
  private static let packageLock = mjn?.appending(path: packageLockFilePath)
  
  // MARK: Private properties
  
  /// The JS virtual machine.
  private let vm = JSVirtualMachine()
  
  /// The JS context.
  private let context: JSContext
  
  /// The TeX to SVG function.
  private var tex2svgFunction: JSValue!

  // MARK: Public properties

  /// The delegate to receive exceptions.
  public weak var delegate: MathJaxDelegate?
  
  // MARK: Initializers
  
  /// Initializes a new `MathJax` instance.
  ///
  /// - Parameter delegate: The MathJax delegate to receive exceptions.
  public init(delegate: MathJaxDelegate? = nil) throws {
    self.delegate = delegate

    // Create the JavaScript context
    guard let ctx = JSContext(virtualMachine: vm) else {
      throw MathJaxError.missingJSContext
    }
    context = ctx
    context.exceptionHandler = handleException
    
    // Get the bundle path and make sure it exists.
    guard let bundleURL = MathJax.bundle,
          FileManager.default.fileExists(atPath: bundleURL.path()) else {
      throw MathJaxError.missingBundle
    }
    
    // Load the bundle's contents.
    context.evaluateScript(try String(contentsOf: bundleURL))
    
    // Get a reference to the converter.
    let converter = context
      .objectForKeyedSubscript(MathJax.mjnModuleName)?
      .objectForKeyedSubscript(MathJax.converterClassName)
    
    // Get a reference to the functions.
    tex2svgFunction = converter?.objectForKeyedSubscript(MathJax.tex2svgFunctionName)
    
    // Make sure we were able to get the convert function
    guard tex2svgFunction?.isObject == true else {
      throw MathJaxError.missingFunction
    }
  }
  
}

// MARK: Public static methods

extension MathJax {
  
  /// The MathJax npm module metadata.
  ///
  /// - Returns: An npm package metadata structure containing version, URL, and
  ///   hash information about the `mathjax-full` module.
  public static func metadata() throws -> Metadata {
    guard let packageLockURL = packageLock else {
      throw MathJaxError.missingPackageFile
    }
    let package = try JSONDecoder().decode(
      PackageLock.self,
      from: try Data(contentsOf: packageLockURL))
    guard let dependency = package.dependencies[MathJax.mathJaxModuleName] else {
      throw MathJaxError.missingDependencyInformation
    }
    return dependency
  }
  
}

// MARK: tex2svg methods

extension MathJax {
  
  /// Converts a TeX input string to SVG.
  ///
  /// - Parameters:
  ///   - input: The input string containing TeX.
  ///   - inline: Process the math as inline or not.
  ///   - em: The em-size in pixels.
  ///   - ex: The ex-size in pixels.
  ///   - width: Width of the container in pixels.
  ///   - css: Output the CSS instead of the SVG.
  ///   - styles: Include CSS styles for the image.
  ///   - container: Include the `<mjx-container>` element.
  ///   - fontCache: Wether or not a local font cache should be used.
  ///   - assistiveMml: Whether to include assistive MathML output.
  /// - Returns: Contents of an SVG.
  public func tex2svg(
    _ input: String,
    inline: Bool = false,
    em: Float = 16,
    ex: Float = 8,
    width: Float = 80 * 16,
    css: Bool = false,
    styles: Bool = true,
    container: Bool = false,
    fontCache: Bool = true,
    assistiveMml: Bool = false
  ) async throws -> String {
    return try await withCheckedThrowingContinuation { [weak self] continuation in
      guard let self = self else {
        continuation.resume(throwing: MathJaxError.deallocatedSelf)
        return
      }
      
      Task {
        do {
          continuation.resume(returning: try self.tex2svg(
            input,
            inline: inline,
            em: em,
            ex: ex,
            width: width,
            css: css,
            styles: styles,
            container: container,
            fontCache: fontCache,
            assistiveMml: assistiveMml
          ))
        }
        catch {
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
  /// Converts a TeX input string to SVG.
  ///
  /// - Parameters:
  ///   - input: The input string containing TeX.
  ///   - inline: Process the math as inline or not.
  ///   - em: The em-size in pixels.
  ///   - ex: The ex-size in pixels.
  ///   - width: Width of the container in pixels.
  ///   - css: Output the CSS instead of the SVG.
  ///   - styles: Include CSS styles for the image.
  ///   - container: Include the `<mjx-container>` element.
  ///   - fontCache: Wether or not a local font cache should be used.
  ///   - assistiveMml: Whether to include assistive MathML output.
  /// - Returns: Contents of an SVG.
  public func tex2svg(
    _ input: String,
    inline: Bool = false,
    em: Float = 16,
    ex: Float = 8,
    width: Float = 80 * 16,
    css: Bool = false,
    styles: Bool = true,
    container: Bool = false,
    fontCache: Bool = true,
    assistiveMml: Bool = false
  ) throws -> String {
    return try callFunction(tex2svgFunction, with: [
      input,
      inline,
      em,
      ex,
      width,
      css,
      styles,
      container,
      fontCache,
      assistiveMml
    ])
  }
  
}

// MARK: Private methods

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
  private func callFunction(_ function: JSValue?, with arguments: [Any]) throws -> String {
    guard let value = function?.call(withArguments: arguments) else {
      throw MathJaxError.conversionFailed
    }
    guard let stringValue = value.toString() else {
      throw MathJaxError.conversionInvalidFormat
    }
    return stringValue
  }
  
}
