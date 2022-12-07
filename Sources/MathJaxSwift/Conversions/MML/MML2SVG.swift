//
//  MML2SVG.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 11/29/22.
//

import Foundation

extension MathJax {
  
  /// Converts a MathML input string to SVG.
  ///
  /// - Parameters:
  ///   - input: The input string containing MathML.
  ///   - css: Whether the document's CSS should be output.
  ///   - assistiveMml: Whether the include assistive MathML output.
  ///   - container: Whether the document's outer HTML should be returned.
  ///   - styles: Whether CSS styles should be included.
  ///   - conversionOptions: The MathJax conversion options.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The MathML input processor options.
  ///   - outputOptions: The SVG output processor options.
  ///   - queue: The queue to execute the conversion on.
  /// - Returns: SVG formatted output.
  public func mml2svg(
    _ input: String,
    css: Bool = false,
    assistiveMml: Bool = false,
    container: Bool = false,
    styles: Bool = false,
    conversionOptions: ConversionOptions = ConversionOptions(),
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: MMLInputProcessorOptions = MMLInputProcessorOptions(),
    outputOptions: SVGOutputProcessorOptions = SVGOutputProcessorOptions(),
    queue: DispatchQueue = .global()
  ) async throws -> String {
    return try await perform(on: queue) { mathjax in
      try mathjax.mml2svg(
        input,
        css: css,
        assistiveMml: assistiveMml,
        container: container,
        styles: styles,
        conversionOptions: conversionOptions,
        documentOptions: documentOptions,
        inputOptions: inputOptions,
        outputOptions: outputOptions
      )
    }
  }
  
  /// Converts a MathML input string to SVG.
  ///
  /// - Parameters:
  ///   - input: The input string containing MathML.
  ///   - css: Whether the document's CSS should be output.
  ///   - assistiveMml: Whether the include assistive MathML output.
  ///   - container: Whether the document's outer HTML should be returned.
  ///   - styles: Whether CSS styles should be included.
  ///   - conversionOptions: The MathJax conversion options.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The MathML input processor options.
  ///   - outputOptions: The SVG output processor options.
  /// - Returns: SVG formatted output.
  public func mml2svg(
    _ input: String,
    css: Bool = false,
    assistiveMml: Bool = false,
    container: Bool = false,
    styles: Bool = false,
    conversionOptions: ConversionOptions = ConversionOptions(),
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: MMLInputProcessorOptions = MMLInputProcessorOptions(),
    outputOptions: SVGOutputProcessorOptions = SVGOutputProcessorOptions()
  ) throws -> String {
    return try callFunction(.mml2svg, with: [
      input,
      css,
      assistiveMml,
      container,
      styles,
      conversionOptions,
      documentOptions,
      inputOptions,
      outputOptions
    ])
  }
  
}
