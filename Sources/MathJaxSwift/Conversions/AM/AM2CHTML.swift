//
//  AM2CHTML.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 11/29/22.
//

import Foundation

extension MathJax {
  
  /// Converts an ASCIIMath input string to CHTML.
  ///
  /// - Parameters:
  ///   - input: The input string containing ASCIIMath.
  ///   - inline: Process the math as inline or not.
  ///   - containerOptions: The CHTML container options.
  ///   - outputOptions: The CHTML output processor options.
  ///   - queue: The queue to execute the conversion on.
  /// - Returns: CHTML formatted output.
  public func am2chtml(
    _ input: String,
    inline: Bool = false,
    containerOptions: CHTMLContainerOptions = CHTMLContainerOptions(),
    outputOptions: CHTMLOutputProcessorOptions = CHTMLOutputProcessorOptions(),
    queue: DispatchQueue = .global()
  ) async throws -> String {
    return try await perform(on: queue) { mathjax in
      try self.am2chtml(
        input,
        inline: inline,
        containerOptions: containerOptions,
        outputOptions: outputOptions
      )
    }
  }
  
  /// Converts an ASCIIMath input string to CHTML.
  ///
  /// - Parameters:
  ///   - input: The input string containing ASCIIMath.
  ///   - inline: Process the math as inline or not.
  ///   - containerOptions: The CHTML container options.
  ///   - outputOptions: The CHTML output processor options.
  /// - Returns: CHTML formatted output.
  public func am2chtml(
    _ input: String,
    inline: Bool = false,
    containerOptions: CHTMLContainerOptions = CHTMLContainerOptions(),
    outputOptions: CHTMLOutputProcessorOptions = CHTMLOutputProcessorOptions()
  ) throws -> String {
    return try callFunction(.am2chtml, with: [
      input,
      inline,
      containerOptions,
      outputOptions
    ])
  }
  
}
