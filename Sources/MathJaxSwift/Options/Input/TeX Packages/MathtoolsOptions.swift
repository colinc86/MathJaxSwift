//
//  AMSOptions.swift
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

@objc internal protocol MathtoolsOptionsExports: JSExport {
  var multlinegap: String { get set }
  var multlinedPos: String { get set }
  var firstlineAfterskip: String { get set }
  var lastlinePreskip: String { get set }
  var smallmatrixAlign: String { get set }
  var shortvdotsadjustabove: String { get set }
  var shortvdotsadjustbelow: String { get set }
  var centercolon: Bool { get set }
  var centercolonOffset: String { get set }
  var thincolonDx: String { get set }
  var thincolonDw: String { get set }
  var useUnicode: Bool { get set }
  var prescriptSubFormat: String { get set }
  var prescriptSupFormat: String { get set }
  var prescriptArgFormat: String { get set }
  var allowMathtoolsset: Bool { get set }
  var pairedDelimiters: [String: [String]] { get set }
  var tagforms: [String: [String]] { get set }
}

@objc public class MathtoolsOptions: NSObject, Codable, MathtoolsOptionsExports {
  
  // MARK: Types
  
  internal enum CodingKeys: String, CodingKey {
    case multlinegap = "multlinegap"
    case multlinedPos = "multlined-pos"
    case firstlineAfterskip = "firstline-afterskip"
    case lastlinePreskip = "lastline-preskip"
    case smallmatrixAlign = "smallmatrix-align"
    case shortvdotsadjustabove = "shortvdotsadjustabove"
    case shortvdotsadjustbelow = "shortvdotsadjustbelow"
    case centercolon = "centercolon"
    case centercolonOffset = "centercolon-offset"
    case thincolonDx = "thincolon-dx"
    case thincolonDw = "thincolon-dw"
    case useUnicode = "use-unicode"
    case prescriptSubFormat = "prescript-sub-format"
    case prescriptSupFormat = "prescript-sup-format"
    case prescriptArgFormat = "prescript-arg-format"
    case allowMathtoolsset = "allow-mathtoolsset"
    case pairedDelimiters = "pairedDelimiters"
    case tagforms = "tagforms"
  }
  
  // MARK: Default values
  
  public static let defaultMultlinegap: String = "1em"
  public static let defaultMultlinedPos: String = "c"
  public static let defaultFirstlineAfterskip: String = ""
  public static let defaultLastlinePreskip: String = ""
  public static let defaultSmallmatrixAlign: String = "c"
  public static let defaultShortvdotsadjustabove: String = ".2em"
  public static let defaultShortvdotsadjustbelow: String = ".2em"
  public static let defaultCentercolon: Bool = false
  public static let defaultCentercolonOffset: String = ".04em"
  public static let defaultThincolonDx: String = "-.04em"
  public static let defaultThincolonDw: String = "-.04em"
  public static let defaultUseUnicode: Bool = false
  public static let defaultPrescriptSubFormat: String = ""
  public static let defaultPrescriptSupFormat: String = ""
  public static let defaultPrescriptArgFormat: String = ""
  public static let defaultAllowMathtoolsset: Bool = true
  public static let defaultPairedDelimiters: [String: [String]] = [:]
  public static let defaultTagforms: [String: [String]] = [:]
  
  
  // MARK: Properties
  
  dynamic public var multlinegap: String
  dynamic public var multlinedPos: String
  dynamic public var firstlineAfterskip: String
  dynamic public var lastlinePreskip: String
  dynamic public var smallmatrixAlign: String
  dynamic public var shortvdotsadjustabove: String
  dynamic public var shortvdotsadjustbelow: String
  dynamic public var centercolon: Bool
  dynamic public var centercolonOffset: String
  dynamic public var thincolonDx: String
  dynamic public var thincolonDw: String
  dynamic public var useUnicode: Bool
  dynamic public var prescriptSubFormat: String
  dynamic public var prescriptSupFormat: String
  dynamic public var prescriptArgFormat: String
  dynamic public var allowMathtoolsset: Bool
  dynamic public var pairedDelimiters: [String: [String]]
  dynamic public var tagforms: [String: [String]]
  
  // MARK: Initializers
  
  public init(
    multlinegap: String = defaultMultlinegap,
    multlinedPos: String = defaultMultlinedPos,
    firstlineAfterskip: String = defaultFirstlineAfterskip,
    lastlinePreskip: String = defaultLastlinePreskip,
    smallmatrixAlign: String = defaultSmallmatrixAlign,
    shortvdotsadjustabove: String = defaultShortvdotsadjustabove,
    shortvdotsadjustbelow: String = defaultShortvdotsadjustbelow,
    centercolon: Bool = defaultCentercolon,
    centercolonOffset: String = defaultCentercolonOffset,
    thincolonDx: String = defaultThincolonDx,
    thincolonDw: String = defaultThincolonDw,
    useUnicode: Bool = defaultUseUnicode,
    prescriptSubFormat: String = defaultPrescriptSubFormat,
    prescriptSupFormat: String = defaultPrescriptSupFormat,
    prescriptArgFormat: String = defaultPrescriptArgFormat,
    allowMathtoolsset: Bool = defaultAllowMathtoolsset,
    pairedDelimiters: [String: [String]] = defaultPairedDelimiters,
    tagforms: [String: [String]] = defaultTagforms
  ) {
    self.multlinegap = multlinegap
    self.multlinedPos = multlinedPos
    self.firstlineAfterskip = firstlineAfterskip
    self.lastlinePreskip = lastlinePreskip
    self.smallmatrixAlign = smallmatrixAlign
    self.shortvdotsadjustabove = shortvdotsadjustabove
    self.shortvdotsadjustbelow = shortvdotsadjustbelow
    self.centercolon = centercolon
    self.centercolonOffset = centercolonOffset
    self.thincolonDx = thincolonDx
    self.thincolonDw = thincolonDw
    self.useUnicode = useUnicode
    self.prescriptSubFormat = prescriptSubFormat
    self.prescriptSupFormat = prescriptSupFormat
    self.prescriptArgFormat = prescriptArgFormat
    self.allowMathtoolsset = allowMathtoolsset
    self.pairedDelimiters = pairedDelimiters
    self.tagforms = tagforms
  }
  
}
