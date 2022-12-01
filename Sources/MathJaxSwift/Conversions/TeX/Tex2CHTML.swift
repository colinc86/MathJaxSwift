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
  ///   - containerConfig: The CHTML container configuration.
  ///   - outputConfig: The CHTML output processor configuration.
  ///   - queue: The queue to execute the conversion on.
  /// - Returns: CHTML formatted output.
  public func tex2chtml(
    _ input: String,
    inline: Bool = false,
    containerConfig: CHTMLContainerConfiguration = CHTMLContainerConfiguration(),
    outputConfig: CHTMLOutputProcessorConfiguration = CHTMLOutputProcessorConfiguration(),
    queue: DispatchQueue = .global()
  ) async throws -> String {
    return try await perform(on: queue) { mathjax in
      try mathjax.tex2chtml(
        input,
        inline: inline,
        containerConfig: containerConfig,
        outputConfig: outputConfig
      )
    }
  }
  
  /// Converts a TeX input string to CHTML.
  ///
  /// - Parameters:
  ///   - input: The input string containing TeX.
  ///   - inline: Process the math as inline or not.
  ///   - containerConfig: The CHTML container configuration.
  ///   - outputConfig: The CHTML output processor configuration.
  /// - Returns: CHTML formatted output.
  public func tex2chtml(
    _ input: String,
    inline: Bool = false,
    containerConfig: CHTMLContainerConfiguration = CHTMLContainerConfiguration(),
    outputConfig: CHTMLOutputProcessorConfiguration = CHTMLOutputProcessorConfiguration()
  ) throws -> String {
    return try callFunction(.tex2chtml, with: [
      input,
      inline,
      try containerConfig.json(),
      try outputConfig.json()
    ])
  }
  
}
