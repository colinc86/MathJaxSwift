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
public final class MathJax {
  
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
  
  // MARK: Public static properties
  
  /// The default `em` method parameter value.
  public static let defaultEMValue: Float = 16
  
  /// The default `ex` method parameter value.
  public static let defaultEXValue: Float = 8
  
  /// The default `width` method parameter value.
  public static let defaultWidthValue: Float = 80 * 16
  
  /// The default `fontURL` method parameter value.
  public static let defaultFontURLValue: URL = URL(string: "https://cdn.jsdelivr.net/npm/mathjax@3/es5/output/chtml/fonts/woff-v2")!
  
  // MARK: Private static properties
  
  /// The name of the MathJax npm module.
  private static let mathJaxModuleName = "mathjax-full"
  
  /// The name of the mjn npm module.
  private static let mjnModuleName = "mjn"
  
  /// The name of the converter JS class.
  private static let converterClassName = "Converter"
  
  /// The name of the tex2svg function.
  private static let tex2svgFunctionName = "tex2svg"
  
  /// The name of the tex2chtml function.
  private static let tex2chtmlFunctionName = "tex2chtml"
  
  /// The name of the tex2mml function.
  private static let tex2mmlFunctionName = "tex2mml"
  
  /// The path to the mjn JS bundle.
  private static let mjnBundleFilePath = "dist/mjn.bundle.js"
  
  /// The path to the mjn package-lock.json file.
  private static let packageLockFilePath = "package-lock.json"
  
  /// The URL of the mjn top-level directory.
  private static let mjn = Bundle.module.url(forResource: mjnModuleName, withExtension: nil)
  
  /// The URL of the JS bundle file.
  private static let bundle = mjn?.appendingPathComponent(mjnBundleFilePath)
  
  /// The URL of the mjn package-lock.json file.
  private static let packageLock = mjn?.appendingPathComponent(packageLockFilePath)
  
  // MARK: Private properties
  
  /// The JS virtual machine.
  private let vm = JSVirtualMachine()
  
  /// The JS context.
  private let context: JSContext
  
  /// The TeX to SVG function.
  private var tex2svgFunction: JSValue!
  
  /// The TeX to CHTML function.
  private var tex2chtmlFunction: JSValue!
  
  /// The TeX to MML function.
  private var tex2mmlFunction: JSValue!

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
          FileManager.default.fileExists(atPath: bundleURL.path) else {
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
    tex2chtmlFunction = converter?.objectForKeyedSubscript(MathJax.tex2chtmlFunctionName)
    tex2mmlFunction = converter?.objectForKeyedSubscript(MathJax.tex2mmlFunctionName)
    
    // Make sure we were able to get the convert function
    guard tex2svgFunction?.isObject == true,
          tex2chtmlFunction?.isObject == true,
          tex2mmlFunction?.isObject == true else {
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
  /// - Returns: SVG formatted output.
  public func tex2svg(
    _ input: String,
    inline: Bool = false,
    em: Float = defaultEMValue,
    ex: Float = defaultEXValue,
    width: Float = defaultWidthValue,
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
  /// - Returns: SVG formatted output.
  public func tex2svg(
    _ input: String,
    inline: Bool = false,
    em: Float = defaultEMValue,
    ex: Float = defaultEXValue,
    width: Float = defaultWidthValue,
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

// MARK: tex2chtml methods

extension MathJax {
  
  /// Converts a TeX input string to CHTML.
  ///
  /// - Parameters:
  ///   - input: The input string containing TeX.
  ///   - inline: Process the math as inline or not.
  ///   - em: The em-size in pixels.
  ///   - ex: The ex-size in pixels.
  ///   - width: Width of the container in pixels.
  ///   - css: Output the CSS instead of the SVG.
  ///   - assistiveMml: Whether to include assistive MathML output.
  ///   - fontURL: The URL of the font to use.
  /// - Returns: CHTML formatted output.
  public func tex2chtml(
    _ input: String,
    inline: Bool = false,
    em: Float = defaultEMValue,
    ex: Float = defaultEXValue,
    width: Float = defaultWidthValue,
    css: Bool = false,
    assistiveMml: Bool = false,
    fontURL: URL = defaultFontURLValue
  ) async throws -> String {
    return try await withCheckedThrowingContinuation { [weak self] continuation in
      guard let self = self else {
        continuation.resume(throwing: MathJaxError.deallocatedSelf)
        return
      }
      
      Task {
        do {
          continuation.resume(returning: try self.tex2chtml(
            input,
            inline: inline,
            em: em,
            ex: ex,
            width: width,
            css: css,
            assistiveMml: assistiveMml,
            fontURL: fontURL
          ))
        }
        catch {
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
  /// Converts a TeX input string to CHTML.
  ///
  /// - Parameters:
  ///   - input: The input string containing TeX.
  ///   - inline: Process the math as inline or not.
  ///   - em: The em-size in pixels.
  ///   - ex: The ex-size in pixels.
  ///   - width: Width of the container in pixels.
  ///   - css: Output the CSS instead of the SVG.
  ///   - assistiveMml: Whether to include assistive MathML output.
  ///   - fontURL: The URL of the font to use.
  /// - Returns: CHTML formatted output.
  public func tex2chtml(
    _ input: String,
    inline: Bool = false,
    em: Float = defaultEMValue,
    ex: Float = defaultEXValue,
    width: Float = defaultWidthValue,
    css: Bool = false,
    assistiveMml: Bool = false,
    fontURL: URL = defaultFontURLValue
  ) throws -> String {
    return try callFunction(tex2chtmlFunction, with: [
      input,
      inline,
      em,
      ex,
      width,
      css,
      assistiveMml,
      fontURL
    ])
  }
  
}

// MARK: tex2mml methods

extension MathJax {
  
  /// Converts a TeX input string to MathML.
  ///
  /// - Parameters:
  ///   - input: The input string containing TeX.
  ///   - inline: Process the math as inline or not.
  /// - Returns: MathML formatted output.
  public func tex2mml(_ input: String, inline: Bool = false) async throws -> String {
    return try await withCheckedThrowingContinuation { [weak self] continuation in
      guard let self = self else {
        continuation.resume(throwing: MathJaxError.deallocatedSelf)
        return
      }
      
      Task {
        do {
          continuation.resume(returning: try self.tex2mml(input, inline: inline))
        }
        catch {
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
  /// Converts a TeX input string to MathML.
  ///
  /// - Parameters:
  ///   - input: The input string containing TeX.
  ///   - inline: Process the math as inline or not.
  /// - Returns: MathML formatted output.
  public func tex2mml(_ input: String, inline: Bool = false) throws -> String {
    return try callFunction(tex2mmlFunction, with: [input, inline])
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
