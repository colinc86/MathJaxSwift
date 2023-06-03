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
  
  // MARK: Properties
  
  /// This array lists the names of the packages that should be initialized by
  /// the TeX input processor.
  ///
  /// The [input/tex](https://docs.mathjax.org/en/latest/basic/mathematics.html#tex-input)
  /// and [input/tex-full](https://docs.mathjax.org/en/latest/basic/mathematics.html#tex-input)
  /// components automatically add to this list the packages that they load. If
  /// you explicitly load addition tex extensions, you should add them to this
  /// list. For example:
  ///
  /// ```javascript
  /// MathJax = {
  ///   loader: {load: ['[tex]/enclose']},
  ///   tex: {
  ///     packages: {'[+]': ['enclose']}
  ///   }
  /// };
  /// ```
  ///
  /// This loads the [enclose](https://docs.mathjax.org/en/latest/input/tex/extensions/enclose.html#tex-enclose)
  /// extension and acticates it by including it in the package list.
  ///
  /// You can remove packages from the default list using `'[-]'` rather than
  /// `[+]`, as in the followiong example:
  ///
  /// ```javascript
  /// MathJax = {
  ///   tex: {
  ///     packages: {'[-]': ['noundefined']}
  ///   }
  /// };
  /// ```
  ///
  /// This would disable the
  /// [noundefined](https://docs.mathjax.org/en/latest/input/tex/extensions/noundefined.html#tex-noundefined)
  /// extension, so that unknown macro names would cause error messages rather
  /// than be displayed in red.
  ///
  /// If you need to both remove some default packages and add new ones, you can
  /// do so by including both within the braces:
  ///
  /// ```javascript
  /// MathJax = {
  ///   loader: {load: ['[tex]/enclose']},
  ///   tex: {
  ///     packages: {'[-]': ['noundefined', 'autoload'], '[+]': ['enclose']}
  ///   }
  /// };
  /// ```
  ///
  /// This disables the
  /// [noundefined](https://docs.mathjax.org/en/latest/input/tex/extensions/noundefined.html#tex-noundefined)
  /// and
  /// [autoload](https://docs.mathjax.org/en/latest/input/tex/extensions/autoload.html#tex-autoload)
  /// extensions, and adds in the
  /// [enclose](https://docs.mathjax.org/en/latest/input/tex/extensions/enclose.html#tex-enclose)
  /// extension.
  ///
  /// - Note: The default value is `["base"]`.
  /// - SeeAlso: [TeX Input Processor Options](https://docs.mathjax.org/en/latest/options/input/tex.html#tex-packages)
  dynamic public var loadPackages: [Package]
  
  /// This is an array of pairs of strings that are to be used as in-line math
  /// delimiters.
  ///
  /// The first in each pair is the initial delimiter and the second
  /// is the terminal delimiter. You can have as many pairs as you want. For
  /// example,
  ///
  /// ```javascript
  /// inlineMath: [ ['$','$'], ['\\(','\\)'] ]
  /// ```
  ///
  /// would cause MathJax to look for `$...$` and `\(...\)` as delimiters for
  /// in-line mathematics. (Note that the single dollar signs are not enabled by
  /// default because they are used too frequently in normal text, so if you
  /// want to use them for math delimiters, you must specify them explicitly.)
  ///
  /// Note that the delimiters can’t look like HTML tags (i.e., can’t include
  /// the less-than sign), as these would be turned into tags by the browser
  /// before MathJax has the chance to run. You can only include text, not tags,
  /// as your math delimiters.
  ///
  /// - Note: The default value is `[["\\(", "\\)"]]`.
  /// - SeeAlso: [TeX Input Processor Options](https://docs.mathjax.org/en/latest/options/input/tex.html#tex-inlinemath)
  dynamic public var inlineMath: [[String]]
  
  /// This is an array of pairs of strings that are to be used as delimiters for
  /// displayed equations.
  ///
  /// The first in each pair is the initial delimiter and
  /// the second is the terminal delimiter. You can have as many pairs as you
  /// want.
  ///
  /// Note that the delimiters can’t look like HTML tags (i.e., can’t include
  /// the less-than sign), as these would be turned into tags by the browser
  /// before MathJax has the chance to run. You can only include text, not tags,
  /// as your math delimiters.
  ///
  /// - Note: The default value is `[["$$", "$$"], ["\\[", "\\]"]]`.
  /// - SeeAlso: [TeX Input Processor Options](https://docs.mathjax.org/en/latest/options/input/tex.html#tex-displaymath)
  dynamic public var displayMath: [[String]]
  
  /// When set to `true`, you may use `\$` to represent a literal dollar sign,
  /// rather than using it as a math delimiter, and `\\` to represent a literal
  /// backslash (so that you can use `\\\$` to get a literal `\$` or `\\$...$`
  /// to get a backslash jsut before in-line math).
  ///
  /// When `false`, `\$` will not be altered, and its dollar sign may be
  /// considered part of a math delimiter. Typically this is set to `true` if
  /// you enable the `$ ... $` in-line delimiters, so you can type `\$` and
  /// MathJax will convert it to a regular dollar sign in the rendered document.
  ///
  /// - Note: The default value is `false`.
  /// - SeeAlso: [TeX Input Processor Options](https://docs.mathjax.org/en/latest/options/input/tex.html#tex-processescapes)
  dynamic public var processEscapes: Bool
  
  /// When set to `true`, MathJax will process `\ref{...}` outside of math mode.
  ///
  /// - Note: The default value is `true`.
  /// - SeeAlso: [TeX Input Processor Options](https://docs.mathjax.org/en/latest/options/input/tex.html#tex-processrefs)
  dynamic public var processRefs: Bool
  
  /// When `true`, _tex2jax_ looks not only for the in-line and display math
  /// delimiters, but also for LaTeX environments (`\begin{something}...\end{something}`)
  /// and marks them for processing by MathJax.
  ///
  /// When `false`, LaTeX environments will not be processed outside of math
  /// mode.
  ///
  /// - Note: The default value is `true`.
  /// - SeeAlso: [TeX Input Processor Options](https://docs.mathjax.org/en/latest/options/input/tex.html#tex-processenvironments)
  dynamic public var processEnvironments: Bool
  
  /// This gives a regular expression that is used to identify numbers during
  /// the parsing of your TeX expressions.
  ///
  /// By default, the decimal point is `.` and you can use `{,}` between every
  /// three digits before that. If you want to use `{,}` as the decimal
  /// indicator, use
  ///
  /// ```javascript
  /// MathJax = {
  ///   tex: {
  ///     digits: /^(?:[0-9]+(?:\{,\}[0-9]*)?|\{,\}[0-9]+)/
  ///   }
  /// };
  /// ```
  ///
  /// - Note: The default value is `^(?:[0-9]+(?:{,}[0-9]{3})*(?:.[0-9]*)?|.[0-9]+)`.
  /// - SeeAlso: [TeX Input Processor Options](https://docs.mathjax.org/en/latest/options/input/tex.html#tex-digits)
  dynamic public var digits: String
  
  /// This controls whether equations are numbered and how.
  ///
  /// By default it is set to `none` to be compatible with earlier versions of
  /// MathJax where auto-numbering was not performed (so pages will not change
  /// their appearance). You can change this to `ams` for equations numbered as
  /// the _AMSmath_ package would do, or `all` to get an equation number for
  /// every displayed equation.
  ///
  /// - Note: The default value is `none`.
  /// - SeeAlso: [TeX Input Processor Options](https://docs.mathjax.org/en/latest/options/input/tex.html#tex-tags)
  dynamic public var tags: Tag
  
  /// This specifies the side on which `\tag{}` macros will place the tags, and
  /// on which automatic equation numbers will appear.
  ///
  /// Set it to `left` to place the tags on the left-hand side.
  ///
  /// - Note: The default value is `right`.
  /// - SeeAlso: [TeX Input Processor Options](https://docs.mathjax.org/en/latest/options/input/tex.html#tex-tagside)
  dynamic public var tagSide: TagSide
  
  /// This is the amount of indentation (from the right or left) for the tags
  /// produced by the `\tag{}` macro or by automatic equation numbers.
  ///
  /// - Note: The default value is `0.8em`.
  /// - SeeAlso: [TeX Input Processor Options](https://docs.mathjax.org/en/latest/options/input/tex.html#tex-tagindent)
  dynamic public var tagIndent: String
  
  /// This controls whether element IDs for tags use the `\label` name or the
  /// equation number.
  ///
  /// When `true`, use the label, when `false`, use the equation number.
  ///
  /// - Note: The default value is `true`.
  /// - SeeAlso: [TeX Input Processor Options](https://docs.mathjax.org/en/latest/options/input/tex.html#tex-uselabelids)
  dynamic public var useLabelIds: Bool
  
  /// Because a definition of the form `\def\x{\x} \x` would cause MathJax to
  /// loop infinitely, the `maxMacros` constant will limit the number of macro
  /// substitutions allowed in any expression processed by MathJax.
  ///
  /// - Note: The default value is `10000`.
  /// - SeeAlso: [TeX Input Processor Options](https://docs.mathjax.org/en/latest/options/input/tex.html#tex-maxmacros)
  dynamic public var maxMacros: Int
  
  /// Because a definition of the form `\def\x{\x aaa} \x` would loop
  /// infinitely, and at the same time stack up lots of a’s in MathJax’s
  /// equation buffer, the `maxBuffer` constant is used to limit the size of the
  /// string being processed by MathJax.
  ///
  /// It is set to 5KB, which should be sufficient for any reasonable equation.
  ///
  /// - Note: The default value is `5 * 1024`.
  /// - SeeAlso: [TeX Input Processor Options](https://docs.mathjax.org/en/latest/options/input/tex.html#tex-maxbuffer)
  dynamic public var maxBuffer: Int
  
  /// This is the base URL to use when creating links to tagged equations (via
  /// `\ref{}` or `\eqref{}`) when there is a `<base>` element in the document
  /// that would affect those links.
  ///
  /// You can set this value by hand if MathJax doesn’t produce the correct
  /// link.
  dynamic public var baseURL: String?
  
  /// This is a function that is called when the TeX input jax reports a syntax
  /// or other error in the TeX that it is processing.
  ///
  /// The default is to generate an `<merror>` MathML element with the message
  /// indicating the error that occurred. You can override the function to
  /// perform other tasks, like recording the message, replacing the message
  /// with an alternative message, or throwing the error so that MathJax will
  /// stop at that point (you can catch the error using promises or a
  /// `try/catch` block).
  dynamic public var formatError: ErrorFunction?
  
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
    formatError: ErrorFunction? = defaultFormatError
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
  }
  
}
