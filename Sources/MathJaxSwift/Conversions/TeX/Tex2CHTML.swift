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
  ///   - outputOptions: The CHTML output processor options.
  ///   - queue: The queue to execute the conversion on.
  /// - Returns: CHTML formatted output.
  public func tex2chtml(
    _ input: String,
    inline: Bool = false,
    containerOptions: CHTMLContainerOptions = CHTMLContainerOptions(),
    outputOptions: CHTMLOutputProcessorOptions = CHTMLOutputProcessorOptions(),
    queue: DispatchQueue = .global()
  ) async throws -> String {
    return try await perform(on: queue) { mathjax in
      try mathjax.tex2chtml(
        input,
        inline: inline,
        containerOptions: containerOptions,
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
  ///   - outputOptions: The CHTML output processor options.
  /// - Returns: CHTML formatted output.
  public func tex2chtml(
    _ input: String,
    inline: Bool = false,
    containerOptions: CHTMLContainerOptions = CHTMLContainerOptions(),
    outputOptions: CHTMLOutputProcessorOptions = CHTMLOutputProcessorOptions()
  ) throws -> String {
    return try callFunction(.tex2chtml, with: [
      input,
      inline,
      containerOptions,
      outputOptions
    ])
  }
  
}
