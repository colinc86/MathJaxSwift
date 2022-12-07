//
//  Tex2SVG.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 11/29/22.
//

import Foundation

extension MathJax {
  
  /// Converts a TeX input string to SVG.
  ///
  /// - Parameters:
  ///   - input: The input string containing TeX.
  ///   - css: Whether the document's CSS should be output.
  ///   - assistiveMml: Whether the include assistive MathML output.
  ///   - container: Whether the document's outer HTML should be returned.
  ///   - styles: Whether CSS styles should be included. (Default is `true`.)
  ///   - conversionOptions: The MathJax conversion options.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The TeX input processor options.
  ///   - outputOptions: The SVG output processor options.
  ///   - queue: The queue to execute the conversion on.
  /// - Returns: SVG formatted output.
  public func tex2svg(
    _ input: String,
    css: Bool = false,
    assistiveMml: Bool = false,
    container: Bool = false,
    styles: Bool = true,
    conversionOptions: ConversionOptions = ConversionOptions(),
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: TexInputProcessorOptions = TexInputProcessorOptions(),
    outputOptions: SVGOutputProcessorOptions = SVGOutputProcessorOptions(),
    queue: DispatchQueue = .global()
  ) async throws -> String {
    return try await perform(on: queue) { mathjax in
      try mathjax.tex2svg(
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
  
  /// Converts a TeX input string to SVG.
  ///
  /// - Parameters:
  ///   - input: The input string containing TeX.
  ///   - css: Whether the document's CSS should be output.
  ///   - assistiveMml: Whether the include assistive MathML output.
  ///   - container: Whether the document's outer HTML should be returned.
  ///   - styles: Whether CSS styles should be included. (Default is `true`.)
  ///   - conversionOptions: The MathJax conversion options.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The TeX input processor options.
  ///   - outputOptions: The SVG output processor options.
  /// - Returns: SVG formatted output.
  public func tex2svg(
    _ input: String,
    css: Bool = false,
    assistiveMml: Bool = false,
    container: Bool = false,
    styles: Bool = true,
    conversionOptions: ConversionOptions = ConversionOptions(),
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: TexInputProcessorOptions = TexInputProcessorOptions(),
    outputOptions: SVGOutputProcessorOptions = SVGOutputProcessorOptions()
  ) throws -> String {
    return try callFunction(.tex2svg, with: [
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
