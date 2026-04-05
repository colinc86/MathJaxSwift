//
//  OutputProcessorOptions.swift
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

@objc public class OutputProcessorOptions: NSObject, Codable {
  
  // MARK: Types
  
  public typealias DisplayAlignment = String
  public struct DisplayAlignments {
    public static let left = DisplayAlignment("left")
    public static let center = DisplayAlignment("center")
    public static let right = DisplayAlignment("right")
  }
  
  // MARK: Default values
  
  public static let defaultScale: Double = 1
  public static let defaultMinScale: Double = 0.5
  public static let defaultMtextInheritFont: Bool = false
  public static let defaultMerrorInheritFont: Bool = false
  public static let defaultMtextFont: String = ""
  public static let defaultMerrorFont: String = "serif"
  public static let defaultUnknownFamily: String = "serif"
  public static let defaultMathmlSpacing: Bool = false
  public static let defaultSkipAttributes: [String: Bool] = [:]
  public static let defaultExFactor: Double = 0.5
  public static let defaultDisplayAlign: DisplayAlignment = DisplayAlignments.center
  public static let defaultDisplayIndent: String = "0"
  public static let defaultDisplayOverflow: String = "overflow"
  public static let defaultLinebreaks: LinebreakOptions = LinebreakOptions()

  // MARK: Properties
  
  @objc dynamic public var scale: Double
  @objc dynamic public var minScale: Double
  @objc dynamic public var mtextInheritFont: Bool
  @objc dynamic public var merrorInheritFont: Bool
  /// The font to use for `<mtext>` elements. When set to a non-empty value
  /// (e.g. `"serif"`), MathJax renders text as SVG `<text>` elements referencing
  /// that CSS font family instead of self-contained `<path>` glyphs. The SVG is
  /// valid but requires a font-capable renderer (browser, WKWebView) to display
  /// the text. Leave empty (the default) for fully self-contained SVG output.
  @objc dynamic public var mtextFont: String
  /// The font to use for `<merror>` elements. Same rendering caveat as
  /// `mtextFont` — produces CSS-font-dependent `<text>` elements when non-empty.
  @objc dynamic public var merrorFont: String
  @objc dynamic public var unknownFamily: String
  @objc dynamic public var mathmlSpacing: Bool
  @objc dynamic public var skipAttributes: [String: Bool]
  @objc dynamic public var exFactor: Double
  @objc dynamic public var displayAlign: DisplayAlignment
  @objc dynamic public var displayIndent: String
  @objc dynamic public var displayOverflow: String
  @objc dynamic public var linebreaks: LinebreakOptions

  // MARK: Initializers

  init(
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
    displayAlign: DisplayAlignment = defaultDisplayAlign,
    displayIndent: String = defaultDisplayIndent,
    displayOverflow: String = defaultDisplayOverflow,
    linebreaks: LinebreakOptions = defaultLinebreaks
  ) {
    self.scale = scale
    self.minScale = minScale
    self.mtextInheritFont = mtextInheritFont
    self.merrorInheritFont = merrorInheritFont
    self.mtextFont = mtextFont
    self.merrorFont = merrorFont
    self.unknownFamily = unknownFamily
    self.mathmlSpacing = mathmlSpacing
    self.skipAttributes = skipAttributes
    self.exFactor = exFactor
    self.displayAlign = displayAlign
    self.displayIndent = displayIndent
    self.displayOverflow = displayOverflow
    self.linebreaks = linebreaks
  }

}
