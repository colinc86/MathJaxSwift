//
//  AM2Speech.swift
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

  /// Converts AsciiMath input strings to speech text.
  ///
  /// Internally converts AsciiMath to MathML, then passes the MathML through
  /// SRE to produce speech text.
  ///
  /// - Parameters:
  ///   - input: The input strings containing AsciiMath.
  ///   - conversionOptions: The MathJax conversion options.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The AsciiMath input processor options.
  ///   - queue: The queue to execute the conversion on.
  /// - Returns: Speech text output.
  public func am2speech(
    _ input: [String],
    conversionOptions: ConversionOptions = ConversionOptions(),
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: AMInputProcessorOptions = AMInputProcessorOptions(),
    queue: DispatchQueue = .global()
  ) async throws -> [Response] {
    return try await perform(on: queue) { mathjax in
      try mathjax.am2speech(
        input,
        conversionOptions: conversionOptions,
        documentOptions: documentOptions,
        inputOptions: inputOptions
      )
    }
  }

  /// Converts AsciiMath input strings to speech text.
  ///
  /// - Parameters:
  ///   - input: The input strings containing AsciiMath.
  ///   - conversionOptions: The MathJax conversion options.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The AsciiMath input processor options.
  /// - Returns: Speech text output.
  public func am2speech(
    _ input: [String],
    conversionOptions: ConversionOptions = ConversionOptions(),
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: AMInputProcessorOptions = AMInputProcessorOptions()
  ) throws -> [Response] {
    let mmlResponses = try am2mml(
      input,
      conversionOptions: conversionOptions,
      documentOptions: documentOptions,
      inputOptions: inputOptions
    )
    let mmlStrings = mmlResponses.map { $0.value }
    return try mml2speech(mmlStrings)
  }

  /// Converts an AsciiMath input string to speech text.
  ///
  /// - Parameters:
  ///   - input: The input string containing AsciiMath.
  ///   - conversionOptions: The MathJax conversion options.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The AsciiMath input processor options.
  ///   - queue: The queue to execute the conversion on.
  /// - Returns: Speech text output.
  public func am2speech(
    _ input: String,
    conversionOptions: ConversionOptions = ConversionOptions(),
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: AMInputProcessorOptions = AMInputProcessorOptions(),
    queue: DispatchQueue = .global()
  ) async throws -> String {
    return try await perform(on: queue) { mathjax in
      try mathjax.am2speech(
        input,
        conversionOptions: conversionOptions,
        documentOptions: documentOptions,
        inputOptions: inputOptions
      )
    }
  }

  /// Converts an AsciiMath input string to speech text.
  ///
  /// - Parameters:
  ///   - input: The input string containing AsciiMath.
  ///   - conversionOptions: The MathJax conversion options.
  ///   - documentOptions: The math document options.
  ///   - inputOptions: The AsciiMath input processor options.
  /// - Returns: Speech text output.
  public func am2speech(
    _ input: String,
    conversionOptions: ConversionOptions = ConversionOptions(),
    documentOptions: DocumentOptions = DocumentOptions(),
    inputOptions: AMInputProcessorOptions = AMInputProcessorOptions()
  ) throws -> String {
    let mml = try am2mml(
      input,
      conversionOptions: conversionOptions,
      documentOptions: documentOptions,
      inputOptions: inputOptions
    )
    return try mml2speech(mml)
  }

}
