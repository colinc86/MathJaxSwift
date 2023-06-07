//
//  TeXInputProcessorOptions.swift
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

@objc internal protocol TeXInputProcessorOptionsJSExports: JSExport {
  var loadPackages: [TeXInputProcessorOptions.Package] { get set }
  var inlineMath: [[String]] { get set }
  var displayMath: [[String]] { get set }
  var processEscapes: Bool { get set }
  var processRefs: Bool { get set }
  var processEnvironments: Bool { get set }
  var digits: String { get set }
  var tags: TeXInputProcessorOptions.Tag { get set }
  var tagSide: TeXInputProcessorOptions.TagSide { get set }
  var tagIndent: String { get set }
  var useLabelIds: Bool { get set }
  var maxMacros: Int { get set }
  var maxBuffer: Int { get set }
  var baseURL: String? { get set }
  var formatError: TeXInputProcessorOptions.ErrorFunction? { get set }
  
  var ams: AMSOptions { get set }
  var amscd: AMSCDOptions { get set }
  var autoload: AutoloadOptions { get set }
  var color: ColorOptions { get set }
}

/// The options below control the operation of the [TeX input processor](https://docs.mathjax.org/en/latest/basic/mathematics.html#tex-input)
/// that is run when you include `input/tex`, `input/tex-full`, or
/// `input/tex-base` in the load array of the loader block of your MathJax
/// configuration, or if you load a combined component that includes the TeX
/// input jax. They are listed with their default values. To set any of these
/// options, include a tex section in your `MathJax` global object.
@objc public class TeXInputProcessorOptions: InputProcessorOptions, TeXInputProcessorOptionsJSExports {
  
  // MARK: Types
  
  internal enum CodingKeys: CodingKey {
    case loadPackages
    case inlineMath
    case displayMath
    case processEscapes
    case processRefs
    case processEnvironments
    case digits
    case tags
    case tagSide
    case tagIndent
    case useLabelIds
    case maxMacros
    case maxBuffer
    case baseURL
    case ams
    case amscd
    case autoload
    case color
  }
  
  public typealias ErrorFunction = @convention(block) (_ jax: JSValue?, _ err: JSValue?) -> Void
  
  public typealias Package = String
  public struct Packages {
    public static let action = "action"
    public static let ams = "ams"
    public static let amscd = "amscd"
    public static let base = "base"
    public static let bbox = "bbox"
    public static let boldsymbol = "boldsymbol"
    public static let braket = "braket"
    public static let bussproofs = "bussproofs"
    public static let cancel = "cancel"
    public static let cases = "cases"
    public static let centernot = "centernot"
    public static let color = "color"
    public static let colortbl = "colortbl"
    public static let configmacros = "configmacros"
    public static let empheq = "empheq"
    public static let enclose = "enclose"
    public static let extpfeil = "extpfeil"
    public static let gensymb = "gensymb"
    public static let html = "html"
    public static let mathtools = "mathtools"
    public static let mhchem = "mhchem"
    public static let newcommand = "newcommand"
    public static let noerrors = "noerrors"
    public static let noundefined = "noundefined"
    public static let tagformat = "tagformat"
    public static let textcomp = "textcomp"
    public static let textmacros = "textmacros"
    public static let unicode = "unicode"
    public static let upgreek = "upgreek"
    public static let verb = "verb"
    public static let all = [
      action,
      ams,
      amscd,
      base,
      bbox,
      boldsymbol,
      braket,
      bussproofs,
      cancel,
      cases,
      centernot,
      color,
      colortbl,
      configmacros,
      empheq,
      enclose,
      extpfeil,
      gensymb,
      html,
      mathtools,
      mhchem,
      newcommand,
      noerrors,
      noundefined,
      tagformat,
      textcomp,
      textmacros,
      unicode,
      upgreek,
      verb
    ]
  }
  
  public typealias Tag = String
  public struct Tags {
    /// No tags.
    public static let none = Tag("none")
    
    /// AMS style tags.
    public static let ams = Tag("ams")
    
    /// All tags.
    public static let all = Tag("all")
  }
  
  public typealias TagSide = String
  public struct TagSides {
    /// Tags should be displayed on the left.
    public static let left = TagSide("left")
    
    /// Tags should be displayed on the right.
    public static let right = TagSide("right")
  }
  
  // MARK: Default values
  
  public static let defaultLoadPackages: [Package] = [Packages.base]
  public static let defaultInlineMath: [[String]] = [["\\(", "\\)"]]
  public static let defaultDisplayMath: [[String]] = [["$$", "$$"], ["\\[", "\\]"]]
  public static let defaultProcessEscapes: Bool = false
  public static let defaultProcessRefs: Bool = true
  public static let defaultProcessEnvironments: Bool = true
  public static let defaultDigits: String = "^(?:[0-9]+(?:{,}[0-9]{3})*(?:.[0-9]*)?|.[0-9]+)"
  public static let defaultTags: Tag = Tags.none
  public static let defaultTagSide: TagSide = TagSides.right
  public static let defaultTagIndent: String = "0.8em"
  public static let defaultUseLabelIds: Bool = true
  public static let defaultMaxMacros: Int = 10000
  public static let defaultMaxBuffer: Int = 5 * 1024
  public static let defaultBaseURL: String? = nil
  public static let defaultFormatError: ErrorFunction? = nil
  public static let defaultAMS: AMSOptions = AMSOptions()
  public static let defaultAMSCD: AMSCDOptions = AMSCDOptions()
  public static let defaultAutoload: AutoloadOptions = AutoloadOptions()
  public static let defaultColor: ColorOptions = ColorOptions()
  
  // MARK: Properties
  
  dynamic public var loadPackages: [Package]
  dynamic public var inlineMath: [[String]]
  dynamic public var displayMath: [[String]]
  dynamic public var processEscapes: Bool
  dynamic public var processRefs: Bool
  dynamic public var processEnvironments: Bool
  dynamic public var digits: String
  dynamic public var tags: Tag
  dynamic public var tagSide: TagSide
  dynamic public var tagIndent: String
  dynamic public var useLabelIds: Bool
  dynamic public var maxMacros: Int
  dynamic public var maxBuffer: Int
  dynamic public var baseURL: String?
  dynamic public var formatError: ErrorFunction?
  dynamic public var ams: AMSOptions
  dynamic public var amscd: AMSCDOptions
  dynamic public var autoload: AutoloadOptions
  dynamic public var color: ColorOptions
  
  // MARK: Initializers
  
  public init(
    loadPackages: [Package] = defaultLoadPackages,
    inlineMath: [[String]] = defaultInlineMath,
    displayMath: [[String]] = defaultDisplayMath,
    processEscapes: Bool = defaultProcessEscapes,
    processRefs: Bool = defaultProcessRefs,
    processEnvironments: Bool = defaultProcessEnvironments,
    digits: String = defaultDigits,
    tags: Tag = defaultTags,
    tagSide: TagSide = defaultTagSide,
    tagIndent: String = defaultTagIndent,
    useLabelIds: Bool = defaultUseLabelIds,
    maxMacros: Int = defaultMaxMacros,
    maxBuffer: Int = defaultMaxBuffer,
    baseURL: String? = defaultBaseURL,
    formatError: ErrorFunction? = defaultFormatError,
    ams: AMSOptions = defaultAMS,
    amscd: AMSCDOptions = defaultAMSCD,
    autoload: AutoloadOptions = defaultAutoload,
    color: ColorOptions = defaultColor
  ) {
    self.loadPackages = loadPackages
    self.inlineMath = inlineMath
    self.displayMath = displayMath
    self.processEscapes = processEscapes
    self.processRefs = processRefs
    self.processEnvironments = processEnvironments
    self.digits = digits
    self.tags = tags
    self.tagSide = tagSide
    self.tagIndent = tagIndent
    self.useLabelIds = useLabelIds
    self.maxMacros = maxMacros
    self.maxBuffer = maxBuffer
    self.baseURL = baseURL
    self.formatError = formatError
    self.ams = ams
    self.amscd = amscd
    self.autoload = autoload
    self.color = color
    super.init()
  }
  
  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    loadPackages = try container.decode([Package].self, forKey: .loadPackages)
    inlineMath = try container.decode([[String]].self, forKey: .inlineMath)
    displayMath = try container.decode([[String]].self, forKey: .displayMath)
    processEscapes = try container.decode(Bool.self, forKey: .processEscapes)
    processRefs = try container.decode(Bool.self, forKey: .processRefs)
    processEnvironments = try container.decode(Bool.self, forKey: .processEnvironments)
    digits = try container.decode(String.self, forKey: .digits)
    tags = try container.decode(Tag.self, forKey: .tags)
    tagSide = try container.decode(TagSide.self, forKey: .tagSide)
    tagIndent = try container.decode(String.self, forKey: .tagIndent)
    useLabelIds = try container.decode(Bool.self, forKey: .useLabelIds)
    maxMacros = try container.decode(Int.self, forKey: .maxMacros)
    maxBuffer = try container.decode(Int.self, forKey: .maxBuffer)
    baseURL = try container.decode(String?.self, forKey: .baseURL)
    ams = try container.decode(AMSOptions.self, forKey: .ams)
    amscd = try container.decode(AMSCDOptions.self, forKey: .amscd)
    autoload = try container.decode(AutoloadOptions.self, forKey: .autoload)
    color = try container.decode(ColorOptions.self, forKey: .color)
    try super.init(from: decoder)
  }
  
  public override func encode(to encoder: Encoder) throws {
    try super.encode(to: encoder)
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(loadPackages, forKey: .loadPackages)
    try container.encode(inlineMath, forKey: .inlineMath)
    try container.encode(displayMath, forKey: .displayMath)
    try container.encode(processEscapes, forKey: .processEscapes)
    try container.encode(processRefs, forKey: .processRefs)
    try container.encode(processEnvironments, forKey: .processEnvironments)
    try container.encode(digits, forKey: .digits)
    try container.encode(tags, forKey: .tags)
    try container.encode(tagSide, forKey: .tagSide)
    try container.encode(tagIndent, forKey: .tagIndent)
    try container.encode(useLabelIds, forKey: .useLabelIds)
    try container.encode(maxMacros, forKey: .maxMacros)
    try container.encode(maxBuffer, forKey: .maxBuffer)
    try container.encode(baseURL, forKey: .baseURL)
    try container.encode(ams, forKey: .ams)
    try container.encode(amscd, forKey: .amscd)
    try container.encode(autoload, forKey: .autoload)
    try container.encode(color, forKey: .color)
  }
  
}
