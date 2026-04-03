//
//  MML2Speech.swift
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

  /// Converts MathML input strings to speech text.
  ///
  /// - Parameters:
  ///   - input: The input strings containing MathML.
  ///   - queue: The queue to execute the conversion on.
  /// - Returns: Speech text output.
  public func mml2speech(
    _ input: [String],
    queue: DispatchQueue = .global()
  ) async throws -> [Response] {
    return try await perform(on: queue) { mathjax in
      try mathjax.mml2speech(input)
    }
  }

  /// Converts MathML input strings to speech text.
  ///
  /// - Parameters:
  ///   - input: The input strings containing MathML.
  /// - Returns: Speech text output.
  public func mml2speech(
    _ input: [String]
  ) throws -> [Response] {
    return try callFunctionAndValidate(
      .toSpeech,
      input: input,
      arguments: [])
  }

  /// Converts a MathML input string to speech text.
  ///
  /// - Parameters:
  ///   - input: The input string containing MathML.
  ///   - queue: The queue to execute the conversion on.
  /// - Returns: Speech text output.
  public func mml2speech(
    _ input: String,
    queue: DispatchQueue = .global()
  ) async throws -> String {
    return try await perform(on: queue) { mathjax in
      try mathjax.mml2speech(input)
    }
  }

  /// Converts a MathML input string to speech text.
  ///
  /// - Parameters:
  ///   - input: The input string containing MathML.
  /// - Returns: Speech text output.
  public func mml2speech(
    _ input: String
  ) throws -> String {
    return try callFunctionAndValidate(
      .toSpeech,
      input: input,
      arguments: [])
  }

}
