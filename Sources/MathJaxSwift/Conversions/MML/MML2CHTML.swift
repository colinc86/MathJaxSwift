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
  ///   - inline: Process the math as inline or not.
  ///   - containerOptions: The CHTML container options.
  ///   - inputOptions: The MathML input processor options.
  ///   - outputOptions: The CHTML output processor options.
  ///   - queue: The queue to execute the conversion on.
  /// - Returns: CHTML formatted output.
  public func mml2chtml(
    _ input: String,
    inline: Bool = false,
    containerOptions: CHTMLContainerOptions = CHTMLContainerOptions(),
    inputOptions: MMLInputProcessorOptions = MMLInputProcessorOptions(),
    outputOptions: CHTMLOutputProcessorOptions = CHTMLOutputProcessorOptions(),
    queue: DispatchQueue = .global()
  ) async throws -> String {
    return try await perform(on: queue) { mathjax in
      try self.mml2chtml(
        input,
        inline: inline,
        containerOptions: containerOptions,
        inputOptions: inputOptions,
        outputOptions: outputOptions
      )
    }
  }
  
  /// Converts a MathML input string to CHTML.
  ///
  /// - Parameters:
  ///   - input: The input string containing MathML.
  ///   - inline: Process the math as inline or not.
  ///   - containerOptions: The CHTML container options.
  ///   - inputOptions: The MathML input processor options.
  ///   - outputOptions: The CHTML output processor options.
  /// - Returns: CHTML formatted output.
  public func mml2chtml(
    _ input: String,
    inline: Bool = false,
    containerOptions: CHTMLContainerOptions = CHTMLContainerOptions(),
    inputOptions: MMLInputProcessorOptions = MMLInputProcessorOptions(),
    outputOptions: CHTMLOutputProcessorOptions = CHTMLOutputProcessorOptions()
  ) throws -> String {
    return try callFunction(.mml2chtml, with: [
      input,
      inline,
      containerOptions,
      inputOptions,
      outputOptions
    ])
  }
  
}
