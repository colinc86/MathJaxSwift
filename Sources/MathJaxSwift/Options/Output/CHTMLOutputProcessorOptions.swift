//
//  CHTMLOutputProcessorOptions.swift
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
import JavaScriptCore

@objc internal protocol CHTMLOutputProcessorOptionsJSExports: JSExport {
  var matchFontHeight: Bool { get set }
  var fontURL: URL { get set }
  var adaptiveCSS: Bool { get set }
  var scale: Double { get set }
  var minScale: Double { get set }
  var mtextInheritFont: Bool { get set }
  var merrorInheritFont: Bool { get set }
  var mtextFont: String { get set }
  var merrorFont: String { get set }
  var unknownFamily: String { get set }
  var mathmlSpacing: Bool { get set }
  var skipAttributes: [String: Bool] { get set }
  var exFactor: Double { get set }
  var displayAlign: String { get set }
  var displayIndent: Double { get set }
}

@objc public class CHTMLOutputProcessorOptions: OutputProcessorOptions, CHTMLOutputProcessorOptionsJSExports {
  
  // MARK: Types
  
  internal enum CodingKeys: CodingKey {
    case matchFontHeight
    case fontURL
    case adaptiveCSS
  }
  
  // MARK: Default values
  
  public static let defaultMatchFontHeight: Bool = true
  public static let defaultFontURL: URL = URL(string: "https://cdn.jsdelivr.net/npm/mathjax@3/es5/output/chtml/fonts/woff-v2")!
  public static let defaultAdaptiveCSS: Bool = true
  
  // MARK: Properties
  
  dynamic public var matchFontHeight: Bool
  dynamic public var fontURL: URL
  dynamic public var adaptiveCSS: Bool
  
  // MARK: Initializers
  
  public init(
    matchFontHeight: Bool = defaultMatchFontHeight,
    fontURL: URL = defaultFontURL,
    adaptiveCSS: Bool = defaultAdaptiveCSS,
    scale: Double = defaultScale,
    minScale: Double = defaultMinScale,
    mtextInheritFont: Bool = defaultMtextInheritFont,
    merrorInheritFont: Bool = defaultMerrorInheritFont,
    mtextFont: String = defaultMtextFont,
    merrorFont: String = defaultMerrorFont,
    unknownFamily: String = defaultUnknownFamily,
    mathmlSpacing: Bool = defaultMathmlSpacing,
    skipAttributes: [String: Bool] = defaultSkipAttributes,
    exFactor: Double = defaultExFactor,
    displayAlign: String = defaultDisplayAlign,
    displayIndent: Double = defaultDisplayIndent
  ) {
    self.matchFontHeight = matchFontHeight
    self.fontURL = fontURL
    self.adaptiveCSS = adaptiveCSS
    super.init(
      scale: scale,
      minScale: minScale,
      mtextInheritFont: mtextInheritFont,
      merrorInheritFont: merrorInheritFont,
      mtextFont: mtextFont,
      merrorFont: merrorFont,
      unknownFamily: unknownFamily,
      mathmlSpacing: mathmlSpacing,
      skipAttributes: skipAttributes,
      exFactor: exFactor,
      displayAlign: displayAlign,
      displayIndent: displayIndent
    )
  }
  
  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    matchFontHeight = try container.decode(Bool.self, forKey: .matchFontHeight)
    fontURL = try container.decode(URL.self, forKey: .fontURL)
    adaptiveCSS = try container.decode(Bool.self, forKey: .adaptiveCSS)
    try super.init(from: decoder)
  }
  
  public override func encode(to encoder: Encoder) throws {
    try super.encode(to: encoder)
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(matchFontHeight, forKey: .matchFontHeight)
    try container.encode(fontURL, forKey: .fontURL)
    try container.encode(adaptiveCSS, forKey: .adaptiveCSS)
  }
  
}
