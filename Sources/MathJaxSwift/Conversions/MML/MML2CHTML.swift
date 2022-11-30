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
  ///   - containerConfig: The CHTML container configuration.
  ///   - outputConfig: The CHTML output processor configuration.
  /// - Returns: CHTML formatted output.
  public func mml2chtml(
    _ input: String,
    inline: Bool = false,
    containerConfig: CHTMLContainerConfiguration = CHTMLContainerConfiguration(),
    outputConfig: CHTMLOutputProcessorConfiguration = CHTMLOutputProcessorConfiguration()
  ) async throws -> String {
    return try await performAsync { mathjax in
      try self.mml2chtml(
        input,
        inline: inline,
        containerConfig: containerConfig,
        outputConfig: outputConfig
      )
    }
  }
  
  /// Converts a MathML input string to CHTML.
  ///
  /// - Parameters:
  ///   - input: The input string containing MathML.
  ///   - inline: Process the math as inline or not.
  ///   - containerConfig: The CHTML container configuration.
  ///   - outputConfig: The CHTML output processor configuration.
  /// - Returns: CHTML formatted output.
  public func mml2chtml(
    _ input: String,
    inline: Bool = false,
    containerConfig: CHTMLContainerConfiguration = CHTMLContainerConfiguration(),
    outputConfig: CHTMLOutputProcessorConfiguration = CHTMLOutputProcessorConfiguration()
  ) throws -> String {
    return try callFunction(
      Constants.Names.Functions.mml2chtml,
      with: [
        input,
        inline,
        try containerConfig.json(),
        try outputConfig.json()
      ])
  }
  
}
