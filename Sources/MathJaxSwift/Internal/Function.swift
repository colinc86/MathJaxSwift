//
//  Function.swift
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

/// A MathJax conversion function.
internal enum Function: String {
  
  /// TeX to CommonHTML.
  case tex2chtml
  
  /// TeX to MathML.
  case tex2mml
  
  /// TeX to SVG.
  case tex2svg
  
  /// MathML to CommonHTML.
  case mml2chtml
  
  /// MathML to SVG.
  case mml2svg
  
  /// AsciiMath to CommonHTML.
  case am2chtml
  
  /// AsciiMath to MathML.
  case am2mml
  
  // MARK: Properties
  
  /// The function's JavaScript module name.
  var jsModuleName: String {
    switch self {
    case .tex2chtml, .mml2chtml, .am2chtml:
      return Constants.Names.JSModules.chtml
    case .tex2mml, .am2mml:
      return Constants.Names.JSModules.mml
    case .tex2svg, .mml2svg:
      return Constants.Names.JSModules.svg
    }
  }
  
  /// The function's JavaScript class name.
  var className: String {
    switch self {
    case .tex2chtml, .mml2chtml, .am2chtml:
      return Constants.Names.Classes.chtmlConverter
    case .tex2mml, .am2mml:
      return Constants.Names.Classes.mmlConverter
    case .tex2svg, .mml2svg:
      return Constants.Names.Classes.svgConverter
    }
  }
  
  /// The function's name.
  ///
  /// This is a helper that return's the function's `rawValue`.
  var name: String {
    rawValue
  }
  
  /// The function's output format.
  var outputFormat: MathJax.OutputFormat {
    switch self {
    case .tex2chtml, .mml2chtml, .am2chtml:
      return .chtml
    case .tex2mml, .am2mml:
      return .mml
    case .tex2svg, .mml2svg:
      return .svg
    }
  }
  
  /// The output parser to use with this function.
  var outputParser: Parser {
    switch self {
    case .tex2chtml, .mml2chtml, .am2chtml:
      return HTMLParser.shared
    case .tex2mml, .am2mml:
      return MMLParser.shared
    case .tex2svg, .mml2svg:
      return SVGParser.shared
    }
  }
  
}
