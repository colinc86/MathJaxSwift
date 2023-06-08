//
//  MathJax.swift
//  MathJaxSwift
//
//  Copyright (c) 2023 Colin Campbell
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//

import Foundation
import JavaScriptCore

/// A class that exposes MathJax conversion methods.
public final class MathJax {
  
  // MARK: Types
  
  /// The npm `mathjax-full` metadata.
  public struct Metadata: Codable {
    
    /// The version of the module.
    let version: String
    
    /// The URL of the module.
    let resolved: URL?
    
    /// The module's SHA-512.
    let integrity: String?
  }
  
  /// An output format.
  public enum OutputFormat: CaseIterable {
    
    /// The CommonHTML output format.
    case chtml
    
    /// The MathML output format.
    case mml
    
    /// The SVG output format.
    case svg
    
    /// The format's bundle URL.
    internal var url: URL? {
      switch self {
      case .chtml: return Constants.URLs.chtmlBundle
      case .mml:   return Constants.URLs.mmlBundle
      case .svg:   return Constants.URLs.svgBundle
      }
    }
  }
  
  // MARK: Private/internal properties
  
  /// The JS context.
  private let context: JSContext
  
  /// The output formats that have been initialized by the instance.
  private var supportedOutputFormats = [OutputFormat]()
  
  // MARK: Initializers
  
  /// Initializes a new `MathJax` instance.
  ///
  /// - Parameter outputFormats: The preferred output formats.
  public init(preferredOutputFormats: [OutputFormat] = OutputFormat.allCases) throws {
    // Make sure we're using the correct MathJax version
    let metadata = try MathJax.metadata()
    guard metadata.version == Constants.expectedMathJaxVersion else {
      throw MathJaxError.unexpectedVersion(version: metadata.version)
    }

    // Create the JavaScript context
    guard let ctx = JSContext() else {
      throw MathJaxError.unableToCreateContext
    }
    context = ctx
    
    // Uncomment the following to enable logging from the JS context
//    context.evaluateScript("var console = { log: function(message) { _consoleLog(message) } }")
//    let consoleLog: @convention(block) (String) -> Void = { message in
//      if debugLogs {
//        NSLog("JSContext: " + message)
//      }
//    }
//    context.setObject(unsafeBitCast(consoleLog, to: AnyObject.self), forKeyedSubscript: "_consoleLog" as NSString)
    
    // Register our options classes
    try registerClasses([
      CHTMLOutputProcessorOptions.self,
      SVGOutputProcessorOptions.self,
      TeXInputProcessorOptions.self,
      MMLInputProcessorOptions.self,
      AMInputProcessorOptions.self,
      DocumentOptions.self,
      ConversionOptions.self
    ])
    
    // Load the bundles for the preferred output formats
    try loadBundles(with: preferredOutputFormats)
  }
  
  /// Initializes a new `MathJax` instance.
  ///
  /// - Parameter preferredOutputFormat: The preferred output format.
  public convenience init(preferredOutputFormat: OutputFormat) throws {
    try self.init(preferredOutputFormats: [preferredOutputFormat])
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
      throw MathJaxError.missingPackageFile
    }
    
    // Get the file's data.
    let package = try JSONDecoder().decode(PackageLock.self, from: try Data(contentsOf: packageLockURL))
    
    // Find the mathjax module and return its metadata.
    guard let dependency = package.packages[Constants.Names.Modules.mathjax] else {
      throw MathJaxError.missingDependencyInformation
    }
    return dependency
  }
  
}

// MARK: - Private/internal methods

extension MathJax {
  
  /// Loads the bundles with the given output formats.
  ///
  /// - Parameter outputFormats: The output formats.
  private func loadBundles(with outputFormats: [OutputFormat]) throws {
    for format in outputFormats {
      try loadBundle(with: format)
    }
  }
  
  /// Loads the JavaScript bundle that corresponds to the given output format.
  ///
  /// - Note: If the bundle has already been loaded, then this method returns
  ///   without doing anything.
  ///
  /// - Parameter outputFormat: The output format to load.
  private func loadBundle(with outputFormat: OutputFormat) throws {
    // Only attempt to load the bundle if it hasn't been loaded
    guard !supportedOutputFormats.contains(outputFormat) else {
      return
    }
    
    // Get the url
    guard let url = outputFormat.url else {
      throw MathJaxError.unknown
    }
    
    // Check to see if the file exists
    guard FileManager.default.isReadableFile(atPath: url.path) else {
      throw MathJaxError.missingBundle(url: url)
    }
    
    // Load the file contents
    let fileContents = try String(contentsOf: url, encoding: .utf8)
    
    // Evaluate the JavaScript
    context.evaluateScript(fileContents, withSourceURL: url)
    
    // Check for js errors
    try checkForJSException()
    
    // Save the supported format
    supportedOutputFormats.append(outputFormat)
  }
  
  private func registerClasses(_ classes: [JSExport.Type]) throws {
    for aClass in classes {
      context.setObject(aClass.self, forKeyedSubscript: String(describing: aClass.self) as NSString)
      try checkForJSException()
    }
  }
  
  /// Checks for an exception in the JS context and throws an error if one is
  /// present.
  private func checkForJSException() throws {
    // Do we have an exception?
    guard let exception = context.exception else {
      return
    }
    
    // Throw its string value.
    throw MathJaxError.javascriptException(value: exception.toString())
  }
  
  /// Calls the function with the given arguments.
  ///
  /// - Parameters:
  ///   - function: The function to call.
  ///   - arguments: The arguments to pass to the function.
  /// - Returns: The function's return value.
  internal func callFunction(_ function: Function, with arguments: [Any]) throws -> String {
    var error: Error?
    let output = callFunction(function, with: arguments, error: &error)
    if let error = error {
      throw error
    }
    return output
  }
  
  /// Calls the function with the given arguments and stores any errors produced
  /// to an inout parameter.
  ///
  /// - Parameters:
  ///   - function: The function to call.
  ///   - arguments: The arguments to pass to the function.
  ///   - error: The error that was produced by the function call.
  /// - Returns: The function's return value.
  internal func callFunction(_ function: Function, with arguments: [Any], error: inout Error?) -> String {
    var output = ""
    do {
      // Lazily load the bundle that owns the function if it hasn't been loaded
      if !supportedOutputFormats.contains(function.outputFormat) {
        try loadBundle(with: function.outputFormat)
      }
      
      // Get the module's JS value
      guard let module = context.objectForKeyedSubscript(function.jsModuleName) else {
        throw MathJaxError.missingModule
      }
      
      // Get the class's JS value
      guard let converter = module.objectForKeyedSubscript(function.className) else {
        throw MathJaxError.missingClass
      }
      
      // Get the function's JS value
      guard let jsFunction = converter.objectForKeyedSubscript(function.name) else {
        throw MathJaxError.missingFunction(name: function.name)
      }
      
      // Call the function and get its return value
      guard let value = jsFunction.call(withArguments: arguments) else {
        throw MathJaxError.conversionFailed
      }
      
      // Make sure no exceptions were thrown.
      try checkForJSException()
      
      // Make sure the value isn't undefined.
      guard !value.isUndefined else {
        throw MathJaxError.conversionUnknownError
      }
      
      // Get the string value and return it
      guard let stringValue = value.toString() else {
        throw MathJaxError.conversionInvalidFormat
      }
      
      // Capture the output
      output = stringValue
      
      // Validate and return the string
      return try function.outputParser.validate(stringValue)
    }
    catch let callError {
      error = callError
      return output
    }
  }
  
  /// Performs the throwing closure asynchronously.
  ///
  /// - Parameters:
  ///   - queue: The queue to perform the block on.
  ///   - block: The block to execute.
  /// - Returns: A string.
  internal func perform(on queue: DispatchQueue, _ block: @escaping (MathJax) throws -> String) async throws -> String {
    return try await withCheckedThrowingContinuation { [weak self] continuation in
      guard let self = self else {
        continuation.resume(throwing: MathJaxError.deallocatedSelf)
        return
      }
      
      queue.async {
        do {
          continuation.resume(returning: try block(self))
        }
        catch {
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
}
