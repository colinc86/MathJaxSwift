//
//  MathJaxError.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 12/5/22.
//

import Foundation

/// An error thrown by the `MathJax` package.
public enum MathJaxError: Error, CustomStringConvertible, Equatable {
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
  case conversionError(error: String)
  
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
    case .conversionError(let error):     return error
    }
  }
}
