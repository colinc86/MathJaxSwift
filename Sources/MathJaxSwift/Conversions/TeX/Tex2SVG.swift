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
  ///   - containerConfig: The SVG container configuration.
  ///   - outputConfig: The SVG output processor configuration.
  /// - Returns: SVG formatted output.
  public func tex2svg(
    _ input: String,
    inline: Bool = false,
    containerConfig: SVGContainerConfiguration = SVGContainerConfiguration(),
    outputConfig: SVGOutputProcessorConfiguration = SVGOutputProcessorConfiguration()
  ) async throws -> String {
    return try await performAsync { mathjax in
      try mathjax.tex2svg(
        input,
        inline: inline,
        containerConfig: containerConfig,
        outputConfig: outputConfig
      )
    }
  }
  
  /// Converts a TeX input string to SVG.
  ///
  /// - Parameters:
  ///   - input: The input string containing TeX.
  ///   - inline: Process the math as inline or not.
  ///   - containerConfig: The SVG container configuration.
  ///   - outputConfig: The SVG output processor configuration.
  /// - Returns: SVG formatted output.
  public func tex2svg(
    _ input: String,
    inline: Bool = false,
    containerConfig: SVGContainerConfiguration = SVGContainerConfiguration(),
    outputConfig: SVGOutputProcessorConfiguration = SVGOutputProcessorConfiguration()
  ) throws -> String {
    return try callFunction(.tex2svg, with: [
      input,
      inline,
      try containerConfig.json(),
      try outputConfig.json()
    ])
  }
  
}
