//
//  Tex2CHTML.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 11/29/22.
//

import Foundation

extension MathJax {
  
  /// Converts a TeX input string to CHTML.
  ///
  /// - Parameters:
  ///   - input: The input string containing TeX.
  ///   - inline: Process the math as inline or not.
  ///   - containerOptions: The CHTML container options.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The TeX input processor options.
  ///   - outputOptions: The CHTML output processor options.
  ///   - queue: The queue to execute the conversion on.
  /// - Returns: CHTML formatted output.
  public func tex2chtml(
    _ input: String,
    inline: Bool = false,
    containerOptions: CHTMLContainerOptions = CHTMLContainerOptions(),
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: TexInputProcessorOptions = TexInputProcessorOptions(),
    outputOptions: CHTMLOutputProcessorOptions = CHTMLOutputProcessorOptions(),
    queue: DispatchQueue = .global()
  ) async throws -> String {
    return try await perform(on: queue) { mathjax in
      try mathjax.tex2chtml(
        input,
        inline: inline,
        containerOptions: containerOptions,
        documentOptions: documentOptions,
        inputOptions: inputOptions,
        outputOptions: outputOptions
      )
    }
  }
  
  /// Converts a TeX input string to CHTML.
  ///
  /// - Parameters:
  ///   - input: The input string containing TeX.
  ///   - inline: Process the math as inline or not.
  ///   - containerOptions: The CHTML container options.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The TeX input processor options.
  ///   - outputOptions: The CHTML output processor options.
  /// - Returns: CHTML formatted output.
  public func tex2chtml(
    _ input: String,
    inline: Bool = false,
    containerOptions: CHTMLContainerOptions = CHTMLContainerOptions(),
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: TexInputProcessorOptions = TexInputProcessorOptions(),
    outputOptions: CHTMLOutputProcessorOptions = CHTMLOutputProcessorOptions()
  ) throws -> String {
    return try callFunction(.tex2chtml, with: [
      input,
      inline,
      containerOptions,
      documentOptions,
      inputOptions,
      outputOptions
    ])
  }
  
}
