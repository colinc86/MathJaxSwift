//
//  SVGOutputProcessorOptions.swift
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

@objc internal protocol SVGOutputProcessorOptionsJSExports: JSExport {
  var fontCache: SVGOutputProcessorOptions.FontCache { get set }
  var internalSpeechTitles: Bool { get set }
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
  var localID: String? { get set }
  var titleID: Int { get set }
}

@objc public class SVGOutputProcessorOptions: OutputProcessorOptions, SVGOutputProcessorOptionsJSExports {
  
  // MARK: Types
  
  internal enum CodingKeys: CodingKey {
    case fontCache
    case internalSpeechTitles
    case localID
    case titleID
  }
  
  public typealias FontCache = String
  public struct FontCaches {
    public static let none = FontCache("none")
    public static let local = FontCache("local")
    public static let global = FontCache("global")
  }
  
  // MARK: Default values
  
  public static let defaultFontCache: FontCache = FontCaches.local
  public static let defaultInternalSpeechTitles: Bool = true
  public static let defaultLocalID: String? = nil
  public static let defaultTitleID: Int = 0
  
  // MARK: Properties
  
  dynamic public var fontCache: FontCache
  dynamic public var internalSpeechTitles: Bool
  dynamic public var localID: String?
  dynamic public var titleID: Int
  
  // MARK: Initializers
  
  public init(
    fontCache: FontCache = defaultFontCache,
    internalSpeechTitles: Bool = defaultInternalSpeechTitles,
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
    displayIndent: Double = defaultDisplayIndent,
    localID: String? = defaultLocalID,
    titleID: Int = defaultTitleID
  ) {
    self.fontCache = fontCache
    self.internalSpeechTitles = internalSpeechTitles
    self.localID = localID
    self.titleID = titleID
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
    fontCache = try container.decode(FontCache.self, forKey: .fontCache)
    internalSpeechTitles = try container.decode(Bool.self, forKey: .internalSpeechTitles)
    localID = try container.decodeIfPresent(String.self, forKey: .localID)
    titleID = try container.decode(Int.self, forKey: .titleID)
    try super.init(from: decoder)
  }
  
  public override func encode(to encoder: Encoder) throws {
    try super.encode(to: encoder)
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(fontCache, forKey: .fontCache)
    try container.encode(internalSpeechTitles, forKey: .internalSpeechTitles)
    try container.encodeIfPresent(localID, forKey: .localID)
    try container.encode(titleID, forKey: .titleID)
  }
  
}
