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
  ///   - inline: Process the math as inline or not.
  ///   - containerOptions: The SVG container options.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The TeX input processor options.
  ///   - outputOptions: The SVG output processor options.
  ///   - queue: The queue to execute the conversion on.
  /// - Returns: SVG formatted output.
  public func tex2svg(
    _ input: String,
    inline: Bool = false,
    containerOptions: SVGContainerOptions = SVGContainerOptions(),
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: TexInputProcessorOptions = TexInputProcessorOptions(),
    outputOptions: SVGOutputProcessorOptions = SVGOutputProcessorOptions(),
    queue: DispatchQueue = .global()
  ) async throws -> String {
    return try await perform(on: queue) { mathjax in
      try mathjax.tex2svg(
        input,
        inline: inline,
        containerOptions: containerOptions,
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
  ///   - inline: Process the math as inline or not.
  ///   - containerOptions: The SVG container options.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The TeX input processor options.
  ///   - outputOptions: The SVG output processor options.
  /// - Returns: SVG formatted output.
  public func tex2svg(
    _ input: String,
    inline: Bool = false,
    containerOptions: SVGContainerOptions = SVGContainerOptions(),
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: TexInputProcessorOptions = TexInputProcessorOptions(),
    outputOptions: SVGOutputProcessorOptions = SVGOutputProcessorOptions()
  ) throws -> String {
    return try callFunction(.tex2svg, with: [
      input,
      inline,
      containerOptions,
      documentOptions,
      inputOptions,
      outputOptions
    ])
  }
  
}
