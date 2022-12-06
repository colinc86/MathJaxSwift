//
//  AM2MML.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 11/29/22.
//

import Foundation

extension MathJax {
  
  /// Converts an ASCIIMath input string to MathML.
  ///
  /// - Parameters:
  ///   - input: The input string containing ASCIIMath.
  ///   - inline: Process the math as inline or not.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The ASCIIMath input processor options.
  ///   - queue: The queue to execute the conversion on.
  /// - Returns: MathML formatted output.
  public func am2mml(
    _ input: String,
    inline: Bool = false,
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: AMInputProcessorOptions = AMInputProcessorOptions(),
    queue: DispatchQueue = .global()
  ) async throws -> String {
    return try await perform(on: queue) { mathjax in
      try mathjax.am2mml(
        input,
        inline: inline,
        documentOptions: documentOptions,
        inputOptions: inputOptions
      )
    }
  }
  
  /// Converts an ASCIIMath input string to MathML.
  ///
  /// - Parameters:
  ///   - input: The input string containing ASCIIMath.
  ///   - inline: Process the math as inline or not.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The ASCIIMath input processor options.
  /// - Returns: MathML formatted output.
  public func am2mml(
    _ input: String,
    inline: Bool = false,
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: AMInputProcessorOptions = AMInputProcessorOptions()
  ) throws -> String {
    return try callFunction(.am2mml, with: [
      input,
      inline,
      documentOptions,
      inputOptions
    ])
  }
  
}
