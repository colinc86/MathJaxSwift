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
  ///   - containerConfig: The CHTML container configuration.
  ///   - outputConfig: The CHTML output processor configuration.
  /// - Returns: CHTML formatted output.
  public func am2chtml(
    _ input: String,
    inline: Bool = false,
    containerConfig: CHTMLContainerConfiguration = CHTMLContainerConfiguration(),
    outputConfig: CHTMLOutputProcessorConfiguration = CHTMLOutputProcessorConfiguration()
  ) async throws -> String {
    return try await performAsync { mathjax in
      try self.am2chtml(
        input,
        inline: inline,
        containerConfig: containerConfig,
        outputConfig: outputConfig
      )
    }
  }
  
  /// Converts an ASCIIMath input string to CHTML.
  ///
  /// - Parameters:
  ///   - input: The input string containing ASCIIMath.
  ///   - inline: Process the math as inline or not.
  ///   - containerConfig: The CHTML container configuration.
  ///   - outputConfig: The CHTML output processor configuration.
  /// - Returns: CHTML formatted output.
  public func am2chtml(
    _ input: String,
    inline: Bool = false,
    containerConfig: CHTMLContainerConfiguration = CHTMLContainerConfiguration(),
    outputConfig: CHTMLOutputProcessorConfiguration = CHTMLOutputProcessorConfiguration()
  ) throws -> String {
    return try callFunction(.am2chtml, with: [
      input,
      inline,
      try containerConfig.json(),
      try outputConfig.json()
    ])
  }
  
}
