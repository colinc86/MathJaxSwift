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
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The TeX input processor options.
  ///   - queue: The queue to execute the conversion on.
  /// - Returns: MathML formatted output.
  public func tex2mml(
    _ input: String,
    inline: Bool = false,
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: TexInputProcessorOptions = TexInputProcessorOptions(),
    queue: DispatchQueue = .global()
  ) async throws -> String {
    return try await perform(on: queue) { mathjax in
      try mathjax.tex2mml(
        input,
        inline: inline,
        documentOptions: documentOptions,
        inputOptions: inputOptions
      )
    }
  }
  
  /// Converts a TeX input string to MathML.
  ///
  /// - Parameters:
  ///   - input: The input string containing TeX.
  ///   - inline: Process the math as inline or not.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The TeX input processor options.
  /// - Returns: MathML formatted output.
  public func tex2mml(
    _ input: String,
    inline: Bool = false,
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: TexInputProcessorOptions = TexInputProcessorOptions()
  ) throws -> String {
    return try callFunction(.tex2mml, with: [
      input,
      inline,
      documentOptions,
      inputOptions
    ])
  }
  
}
