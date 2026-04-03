//
//  Parser.swift
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

/// The regex to use when searching for the error's element.
fileprivate let errorElementRegex = #"data-mjx-error=\".*?\""#

internal protocol Parser {
  
  /// The type's shared parser.
  static var shared: Self { get }
  
  /// The regex that should be used to search for an error.
  static var errorRegex: String { get }
  
}

extension Parser {
  
  /// Validates that the input string does not contain an error.
  ///
  /// - Parameter input: The input.
  /// - Returns: The input.
  func validate(_ input: String) throws -> String {
    // We want to look for the MathML error node.
    guard let range = input.range(of: Self.errorRegex, options: .regularExpression) else {
      return input
    }
    
    // Get the node
    let node = String(input[range])
    
    // Look for the error element
    guard let elementRange = node.range(of: errorElementRegex, options: .regularExpression) else {
      return input
    }
    
    // Get the error element
    let element = String(node[elementRange])
    
    // Get the error
    let components = element.components(separatedBy: CharacterSet(charactersIn: "="))
    guard components.count == 2,
          let errorText = components.last?.trimmingCharacters(in: CharacterSet(charactersIn: "\"")) else {
      return input
    }
    
    // Throw the error
    throw MathJaxError.conversionError(error: errorText)
  }
  
}
