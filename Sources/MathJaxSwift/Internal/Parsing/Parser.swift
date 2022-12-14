//
//  Parser.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 12/9/22.
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
