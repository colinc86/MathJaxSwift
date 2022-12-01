//
//  Tex2MML.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 11/29/22.
//

import Foundation

extension MathJax {
  
  /// Converts a TeX input string to MathML.
  ///
  /// - Parameters:
  ///   - input: The input string containing TeX.
  ///   - inline: Process the math as inline or not.
  /// - Returns: MathML formatted output.
  public func tex2mml(_ input: String, inline: Bool = false) async throws -> String {
    return try await performAsync { mathjax in
      try mathjax.tex2mml(input, inline: inline)
    }
  }
  
  /// Converts a TeX input string to MathML.
  ///
  /// - Parameters:
  ///   - input: The input string containing TeX.
  ///   - inline: Process the math as inline or not.
  /// - Returns: MathML formatted output.
  public func tex2mml(_ input: String, inline: Bool = false) throws -> String {
    return try callFunction(.tex2mml, with: [
      input,
      inline
    ])
  }
  
}
