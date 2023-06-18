//
//  DocumentOptions.swift
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

@objc internal protocol DocumentOptionsExports: JSExport {
  var skipHtmlTags: [String] { get set }
  var includeHtmlTags: [String: String] { get set }
  var ignoreHtmlClass: String { get set }
  var processHtmlClass: String { get set }
  var enableEnrichment: Bool { get set }
  var enableComplexity: Bool { get set }
  var makeCollapsible: Bool { get set }
  var identifyCollapsible: Bool { get set }
  var enableExplorer: Bool { get set }
  var enableAssistiveMml: Bool { get set }
  var enableMenu: Bool { get set }
  var annotationTypes: [String: [String]] { get set }
  var font: DocumentOptions.Font { get set }
  var a11y: A11YOptions { get set }
  var sre: SREOptions { get set }
  var menuOptions: MenuOptions { get set }
  var safeOptions: SafeOptions { get set }
  var linebreaks: LineBreaksOptions { get set }
  var enrichError: DocumentOptions.ErrorFunction? { get set }
  var compileError: DocumentOptions.ErrorFunction? { get set }
  var typesetError: DocumentOptions.ErrorFunction? { get set }
}

@objc public class DocumentOptions: NSObject, Codable, DocumentOptionsExports {
  
  // MARK: Types
  
  internal enum CodingKeys: CodingKey {
    case skipHtmlTags
    case includeHtmlTags
    case ignoreHtmlClass
    case processHtmlClass
    case enableEnrichment
    case enableComplexity
    case makeCollapsible
    case identifyCollapsible
    case enableExplorer
    case enableAssistiveMml
    case enableMenu
    case annotationTypes
    case font
    case a11y
    case sre
    case menuOptions
    case safeOptions
    case linebreaks
  }
  
  public typealias ErrorFunction = @convention(block) (_ doc: JSValue?, _ math: JSValue?, _ err: JSValue?) -> Void
  
  public typealias Font = String
  public struct Fonts {
    public static let modern = Font("mathjax-modern")
    public static let asana = Font("mathjax-asana")
    public static let bonum = Font("mathjax-bonum")
    public static let dejavu = Font("mathjax-dejavu")
    public static let pagella = Font("mathjax-pagella")
    public static let schola = Font("mathjax-schola")
    public static let termes = Font("mathjax-termes")
    public static let stix2 = Font("mathjax-stix2")
    public static let fira = Font("mathjax-fira")
    public static let euler = Font("mathjax-euler")
    public static let tex = Font("mathjax-tex")
  }
  
  // MARK: Default values
  
  public static let defaultSkipHtmlTags: [String] = [
    "script",
    "noscript",
    "style",
    "textarea",
    "pre",
    "code",
    "annotation",
    "annotation-xml"
  ]
  
  public static let defaultIncludedHtmlTags: [String: String] = [
    "br": "\n",
    "wbr": "",
    "#comment": ""
  ]
  
  public static let defaultAnnotationTypes: [String: [String]] = [
    "TeX": ["TeX", "LaTeX", "application/x-tex"],
    "StarMath": ["StarMath 5.0"],
    "Maple": ["Maple"],
    "ContentMathML": ["MathML-Content", "application/mathml-content+xml"],
    "OpenMath": ["OpenMath"]
  ]
  
  public static let defaultIgnoreHtmlClass: String = "tex2jax_ignore"
  public static let defaultProcessHtmlClass: String = "tex2jax_process"
  public static let defaultEnableEnrichment: Bool = true
  public static let defaultEnableComplexity: Bool = true
  public static let defaultMakeCollapsible: Bool = true
  public static let defaultIdentifyCollapsible: Bool = true
  public static let defaultEnableExplorer: Bool = true
  public static let defaultEnableAssistiveMml: Bool = false
  public static let defaultEnableMenu: Bool = true
  public static let defaultFont: Font = Fonts.modern
  public static let defaultA11Y: A11YOptions = A11YOptions()
  public static let defaultSREOptions: SREOptions = SREOptions()
  public static let defaultMenuOptions: MenuOptions = MenuOptions()
  public static let defaultSafeOptions: SafeOptions = SafeOptions()
  public static let defaultLinebreaks: LineBreaksOptions = LineBreaksOptions()
  public static let defaultEnrichError: ErrorFunction? = nil
  public static let defaultCompileError: ErrorFunction? = nil
  public static let defaultTypesetError: ErrorFunction? = nil
  
  // MARK: Properties
  
  dynamic public var skipHtmlTags: [String]
  dynamic public var includeHtmlTags: [String: String]
  dynamic public var ignoreHtmlClass: String
  dynamic public var processHtmlClass: String
  dynamic public var enableEnrichment: Bool
  dynamic public var enableComplexity: Bool
  dynamic public var makeCollapsible: Bool
  dynamic public var identifyCollapsible: Bool
  dynamic public var enableExplorer: Bool
  dynamic public var enableAssistiveMml: Bool
  dynamic public var enableMenu: Bool
  dynamic public var annotationTypes: [String : [String]]
  dynamic public var font: Font
  dynamic public var a11y: A11YOptions
  dynamic public var sre: SREOptions
  dynamic public var menuOptions: MenuOptions
  dynamic public var safeOptions: SafeOptions
  dynamic public var linebreaks: LineBreaksOptions
  dynamic public var enrichError: ErrorFunction?
  dynamic public var compileError: ErrorFunction?
  dynamic public var typesetError: ErrorFunction?
  
  // MARK: Initializers
  
  public init(
    skipHtmlTags: [String] = defaultSkipHtmlTags,
    includeHtmlTags: [String: String] = defaultIncludedHtmlTags,
    ignoreHtmlClass: String = defaultIgnoreHtmlClass,
    processHtmlClass: String = defaultProcessHtmlClass,
    enableEnrichment: Bool = defaultEnableEnrichment,
    enableComplexity: Bool = defaultEnableComplexity,
    makeCollapsible: Bool = defaultMakeCollapsible,
    identifyCollapsible: Bool = defaultIdentifyCollapsible,
    enableExplorer: Bool = defaultEnableExplorer,
    enableAssistiveMml: Bool = defaultEnableAssistiveMml,
    enableMenu: Bool = defaultEnableMenu,
    annotationTypes: [String: [String]] = defaultAnnotationTypes,
    font: Font = defaultFont,
    a11y: A11YOptions = defaultA11Y,
    sre: SREOptions = defaultSREOptions,
    menuOptions: MenuOptions = defaultMenuOptions,
    safeOptions: SafeOptions = defaultSafeOptions,
    linebreaks: LineBreaksOptions = defaultLinebreaks,
    enrichError: ErrorFunction? = defaultEnrichError,
    compileError: ErrorFunction? = defaultCompileError,
    typesetError: ErrorFunction? = defaultTypesetError
  ) {
    self.skipHtmlTags = skipHtmlTags
    self.includeHtmlTags = includeHtmlTags
    self.ignoreHtmlClass = ignoreHtmlClass
    self.processHtmlClass = processHtmlClass
    self.enableEnrichment = enableEnrichment
    self.enableComplexity = enableComplexity
    self.makeCollapsible = makeCollapsible
    self.identifyCollapsible = identifyCollapsible
    self.enableExplorer = enableExplorer
    self.enableAssistiveMml = enableAssistiveMml
    self.enableMenu = enableMenu
    self.annotationTypes = annotationTypes
    self.font = font
    self.a11y = a11y
    self.sre = sre
    self.menuOptions = menuOptions
    self.safeOptions = safeOptions
    self.linebreaks = linebreaks
    self.enrichError = enrichError
    self.compileError = compileError
    self.typesetError = typesetError
  }
  
}
