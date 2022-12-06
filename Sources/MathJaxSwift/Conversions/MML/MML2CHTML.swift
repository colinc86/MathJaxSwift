//
//  MML2CHTML.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 11/29/22.
//

import Foundation

extension MathJax {
  
  /// Converts a MathML input string to CHTML.
  ///
  /// - Parameters:
  ///   - input: The input string containing MathML.
  ///   - css: Whether the document's CSS should be output.
  ///   - assistiveMml: Whether the include assistive MathML output.
  ///   - conversionOptions: The MathJax conversion options.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The MathML input processor options.
  ///   - outputOptions: The CHTML output processor options.
  ///   - queue: The queue to execute the conversion on.
  /// - Returns: CHTML formatted output.
  public func mml2chtml(
    _ input: String,
    css: Bool = false,
    assistiveMml: Bool = false,
    conversionOptions: ConversionOptions = ConversionOptions(),
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: MMLInputProcessorOptions = MMLInputProcessorOptions(),
    outputOptions: CHTMLOutputProcessorOptions = CHTMLOutputProcessorOptions(),
    queue: DispatchQueue = .global()
  ) async throws -> String {
    return try await perform(on: queue) { mathjax in
      try self.mml2chtml(
        input,
        css: css,
        assistiveMml: assistiveMml,
        conversionOptions: conversionOptions,
        documentOptions: documentOptions,
        inputOptions: inputOptions,
        outputOptions: outputOptions
      )
    }
  }
  
  /// Converts a MathML input string to CHTML.
  ///
  /// - Parameters:
  ///   - input: The input string containing MathML.
  ///   - css: Whether the document's CSS should be output.
  ///   - assistiveMml: Whether the include assistive MathML output.
  ///   - conversionOptions: The MathJax conversion options.
  ///   - documentOptions: The math document options.
  ///   - containerOptions: The CHTML container options.
  ///   - inputOptions: The MathML input processor options.
  ///   - outputOptions: The CHTML output processor options.
  /// - Returns: CHTML formatted output.
  public func mml2chtml(
    _ input: String,
    css: Bool = false,
    assistiveMml: Bool = false,
    conversionOptions: ConversionOptions = ConversionOptions(),
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: MMLInputProcessorOptions = MMLInputProcessorOptions(),
    outputOptions: CHTMLOutputProcessorOptions = CHTMLOutputProcessorOptions()
  ) throws -> String {
    return try callFunction(.mml2chtml, with: [
      input,
      css,
      assistiveMml,
      conversionOptions,
      documentOptions,
      inputOptions,
      outputOptions
    ])
  }
  
}
