import Foundation
import JavaScriptCore

/// A wrapper for the MathJax repo.
public class MathJax {
  
  // MARK: Types
  
  /// An error thrown by the `MathJax` package.
  public enum MathJaxError: Error {
    
    /// The npm package file was missing.
    case missingPackageFile
    
    case missingJSContext
    
    case missingBundle
    
    case missingFunction
    
    case deallocatedSelf
    
    case conversionFailed
    
    case conversionUnknownError
  }
  
  // MARK: Private static properties
  
  /// The URL of the mjn top-level directory.
  private static let mjn = Bundle.module.url(forResource: "mjn", withExtension: nil)
  
  private static let bundle = mjn?.appending(components: "dist", "mjn.bundle.js")
  
  // MARK: Public static properties
  
  public static let base = mjn?.appending(components: "node_modules", "mathjax-full")
  
  // MARK: Private properties
  
  private let vm = JSVirtualMachine()
  private let context: JSContext
  private var convertFunction: JSValue!
  private var conversionQueue = DispatchQueue(label: "mathjax.swift.conversionQueue")
  
  // MARK: Public properties
  
  // MARK: Initializers
  
  init() throws {
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
    
    // Get a reference to the convert function.
    convertFunction = context
      .objectForKeyedSubscript("mjn")
      .objectForKeyedSubscript("Converter")
      .objectForKeyedSubscript("convert")
    
    // Make sure we were able to get the convert function
    guard convertFunction?.isObject == true else {
      throw MathJaxError.missingFunction
    }
  }
  
}

// MARK: Public static methods

extension MathJax {
  
  /// The MathJax npm package metadata.
  public static func package() throws -> NPMPackage {
    guard let packageURL = base?.appending(path: "package.json") else {
      throw MathJaxError.missingPackageFile
    }
    return try JSONDecoder().decode(
      NPMPackage.self,
      from: try Data(contentsOf: packageURL))
  }
  
}

// MARK: Public methods

extension MathJax {
  
  
  
}

// MARK: Private methods

extension MathJax {
  
  private func convert(
    input: String,
    inline: Bool = false,
    em: Float = 16,
    ex: Float = 8,
    width: Float = 80 * 16,
    styles: Bool = true,
    container: Bool = false,
    css: Bool = false,
    fontCache: Bool = true,
    assistiveMml: Bool = false
  ) async throws -> String {
    return try await withCheckedThrowingContinuation({ [weak self] continuation in
      guard let self = self else {
        continuation.resume(throwing: MathJaxError.deallocatedSelf)
        return
      }
      self.convert(input: input, inline: inline, em: em, ex: ex, width: width, styles: styles, container: container, css: css, fontCache: fontCache, assistiveMml: assistiveMml) { output, error in
        if let error = error {
          continuation.resume(throwing: error)
        }
        else if let output = output {
          continuation.resume(returning: output)
        }
        else {
          continuation.resume(throwing: MathJaxError.conversionUnknownError)
        }
      }
    })
  }
  
  private func convert(
    input: String,
    inline: Bool = false,
    em: Float = 16,
    ex: Float = 8,
    width: Float = 80 * 16,
    styles: Bool = true,
    container: Bool = false,
    css: Bool = false,
    fontCache: Bool = true,
    assistiveMml: Bool = false,
    completion: @escaping (String?, Error?) -> Void
  ) {
    conversionQueue.async { [weak self] in
      guard let self = self else {
        completion(nil, MathJaxError.deallocatedSelf)
        return
      }
      
      guard let value = self.convertFunction?.call(withArguments: [
        input,
        inline,
        em,
        ex,
        width,
        styles,
        container,
        css,
        fontCache,
        assistiveMml
      ]) else {
        completion(nil, MathJaxError.conversionFailed)
        return
      }
      
      if let stringValue = value.toString() {
        completion(stringValue, nil)
      }
      else {
        completion(nil, MathJaxError.conversionUnknownError)
      }
    }
  }
  
  private func handleException(from context: JSContext?, value: JSValue?) {
    guard let value = value else {
      print("Received exception: (no value)")
      return
    }
    guard let stringValue = value.toString() else {
      print("Received exception: (unable to get string value)")
      return
    }
    print("Received exception: \(stringValue)")
  }
  
}
