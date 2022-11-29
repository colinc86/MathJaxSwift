//
//  MathJaxSwift.swift
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
  public enum MathJaxError: Error {
    
    /// The npm package file was missing.
    case missingPackageFile

    /// The package-lock file's dependency information is missing for the 
    // mathjax-full module.
    case missingDependencyInformation
    
    /// Unable to create the JS context.
    case missingJSContext
    
    /// The package is missing the bundled JS file.
    case missingBundle
    
    /// The conversion function could not be found in the bundled JS class.
    case missingFunction
    
    /// The MathJax instance was deallocated.
    case deallocatedSelf
    
    /// The instance failed to convert the input string.
    case conversionFailed
    
    /// An unknown error occurred during conversion.
    case conversionUnknownError

    /// The returned format was invalid.
    case conversionInvalidFormat
  }
  
  // MARK: Private static properties
  
  /// The URL of the mjn top-level directory.
  private static let mjn = Bundle.module.url(forResource: "mjn", withExtension: nil)
  
  /// The URL of the JS bundle file.
  private static let bundle = mjn?.appending(components: "dist", "mjn.bundle.js")
  
  /// The URL of the mjn package-lock.json file.
  private static let packageLock = mjn?.appending(path: "package-lock.json")
  
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
    
    // Get a reference to the convert functions.
    let converter = context
      .objectForKeyedSubscript("mjn")?
      .objectForKeyedSubscript("Converter")
    tex2svgFunction = converter?.objectForKeyedSubscript("tex2svg")
    
    // Make sure we were able to get the convert function
    guard tex2svgFunction?.isObject == true else {
      throw MathJaxError.missingFunction
    }
  }
  
}

// MARK: Public static methods

extension MathJax {
  
  /// The MathJax npm package metadata.
  public static func package() throws -> NPMPackage.Dependency {
    guard let packageLockURL = packageLock else {
      throw MathJaxError.missingPackageFile
    }
    let package = try JSONDecoder().decode(
      NPMPackage.self,
      from: try Data(contentsOf: packageURL))
    guard let dependency = package.dependencies.first(where: { $0.name == "mathjax-full" }) else {
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
