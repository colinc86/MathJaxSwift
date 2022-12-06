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
      throw MJError.unexpectedVersion(version: metadata.version)
    }

    // Create the JavaScript context
    guard let ctx = JSContext() else {
      throw MJError.unableToCreateContext
    }
    context = ctx
    
    // Register our options classes
    try registerClasses([
      CHTMLContainerOptions.self,
      SVGContainerOptions.self,
      CHTMLOutputProcessorOptions.self,
      SVGOutputProcessorOptions.self
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
      throw MJError.unknown
    }
    
    // Check to see if the file exists
    guard FileManager.default.isReadableFile(atPath: url.path) else {
      throw MJError.missingBundle(url: url)
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
      print("registering class \(String(describing: aClass))")
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
    throw MJError.javascriptException(value: exception.toString())
  }
  
  /// Calls the function with the given arguments.
  ///
  /// - Parameters:
  ///   - function: The function to call.
  ///   - arguments: The arguments to pass to the function.
  /// - Returns: The function's return value.
  internal func callFunction(_ function: Function, with arguments: [Any]) throws -> String {
    // Lazily load the bundle that owns the function if it hasn't been loaded
    if !supportedOutputFormats.contains(function.outputFormat) {
      try loadBundle(with: function.outputFormat)
    }
    
    // Get the module's JS value
    guard let module = context.objectForKeyedSubscript(function.jsModuleName) else {
      throw MJError.missingModule
    }
    
    // Get the class's JS value
    guard let converter = module.objectForKeyedSubscript(function.className) else {
      throw MJError.missingClass
    }
    
    // Get the function's JS value
    guard let function = converter.objectForKeyedSubscript(function.name) else {
      throw MJError.missingFunction(name: function.name)
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
  /// - Parameters:
  ///   - queue: The queue to perform the block on.
  ///   - block: The block to execute.
  /// - Returns: A string.
  internal func perform(on queue: DispatchQueue, _ block: @escaping (MathJax) throws -> String) async throws -> String {
    return try await withCheckedThrowingContinuation { [weak self] continuation in
      guard let self = self else {
        continuation.resume(throwing: MJError.deallocatedSelf)
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
