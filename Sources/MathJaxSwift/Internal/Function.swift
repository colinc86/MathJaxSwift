//
//  Function.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 12/1/22.
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
