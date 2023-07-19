//
//  AM2MML.swift
//  MathJaxSwift
//
//  Copyright (c) 2023 Colin Campbell
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//

import Foundation

extension MathJax {
  
  /// Converts ASCIIMath input strings to MathML.
  ///
  /// - Parameters:
  ///   - input: The input strings containing ASCIIMath.
  ///   - conversionOptions: The MathJax conversion options.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The ASCIIMath input processor options.
  ///   - queue: The queue to execute the conversion on.
  /// - Returns: MathML formatted output.
  public func am2mml(
    _ input: [String],
    conversionOptions: ConversionOptions = ConversionOptions(),
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: AMInputProcessorOptions = AMInputProcessorOptions(),
    queue: DispatchQueue = .global()
  ) async throws -> [Response] {
    return try await perform(on: queue) { mathjax in
      try mathjax.am2mml(
        input,
        conversionOptions: conversionOptions,
        documentOptions: documentOptions,
        inputOptions: inputOptions
      )
    }
  }
  
  /// Converts ASCIIMath input strings to MathML.
  ///
  /// - Parameters:
  ///   - input: The input strings containing ASCIIMath.
  ///   - conversionOptions: The MathJax conversion options.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The ASCIIMath input processor options.
  /// - Returns: MathML formatted output.
  public func am2mml(
    _ input: [String],
    conversionOptions: ConversionOptions = ConversionOptions(),
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: AMInputProcessorOptions = AMInputProcessorOptions()
  ) throws -> [Response] {
    return try callFunctionAndValidate(
      .am2mml,
      input: input,
      arguments: [
        conversionOptions,
        documentOptions,
        inputOptions
      ])
  }
  
  /// Converts an ASCIIMath input string to MathML.
  ///
  /// - Parameters:
  ///   - input: The input string containing ASCIIMath.
  ///   - conversionOptions: The MathJax conversion options.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The ASCIIMath input processor options.
  ///   - queue: The queue to execute the conversion on.
  /// - Returns: MathML formatted output.
  public func am2mml(
    _ input: String,
    conversionOptions: ConversionOptions = ConversionOptions(),
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: AMInputProcessorOptions = AMInputProcessorOptions(),
    queue: DispatchQueue = .global()
  ) async throws -> String {
    return try await perform(on: queue) { mathjax in
      try mathjax.am2mml(
        input,
        conversionOptions: conversionOptions,
        documentOptions: documentOptions,
        inputOptions: inputOptions
      )
    }
  }
  
  /// Converts an ASCIIMath input string to MathML.
  ///
  /// - Parameters:
  ///   - input: The input string containing ASCIIMath.
  ///   - conversionOptions: The MathJax conversion options.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The ASCIIMath input processor options.
  /// - Returns: MathML formatted output.
  public func am2mml(
    _ input: String,
    conversionOptions: ConversionOptions = ConversionOptions(),
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: AMInputProcessorOptions = AMInputProcessorOptions()
  ) throws -> String {
    return try callFunctionAndValidate(
      .am2mml,
      input: input,
      arguments: [
        conversionOptions,
        documentOptions,
        inputOptions
      ])
  }
  
  /// Converts an ASCIIMath input string to MathML.
  ///
  /// - Parameters:
  ///   - input: The input string containing ASCIIMath.
  ///   - conversionOptions: The MathJax conversion options.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The ASCIIMath input processor options.
  ///   - error: The error produced by the conversion.
  /// - Returns: MathML formatted output.
  public func am2mml(
    _ input: String,
    conversionOptions: ConversionOptions = ConversionOptions(),
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: AMInputProcessorOptions = AMInputProcessorOptions(),
    error: inout Error?
  ) -> String {
    return callFunctionAndValidate(
      .am2mml,
      input: input,
      arguments: [
        conversionOptions,
        documentOptions,
        inputOptions
      ], error: &error)
  }
  
}
