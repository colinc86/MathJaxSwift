//
//  MathJaxError.swift
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
