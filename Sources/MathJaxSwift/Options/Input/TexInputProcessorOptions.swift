//
//  TeXInputProcessorOptions.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 12/6/22.
//

import Foundation
import JavaScriptCore

@objc public protocol TexInputProcessorOptionsJSExports: JSExport {
  var packages: [String] { get set }
  var inlineMath: [[String]] { get set }
  var displayMath: [[String]] { get set }
  var processEscapes: Bool { get set }
  var processRefs: Bool { get set }
  var processEnvironments: Bool { get set }
  var digits: String { get set }
  var tags: TexInputProcessorOptions.Tag { get set }
  var tagSide: TexInputProcessorOptions.TagSide { get set }
  var tagIndent: String { get set }
  var useLabelIds: Bool { get set }
  var maxMacros: Int { get set }
  var maxBuffer: Int { get set }
}

@objc public class TexInputProcessorOptions: InputProcessorOptions, TexInputProcessorOptionsJSExports {
  
  // MARK: Types
  
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
  
  public static let defaultPackages: [String] = ["base"]
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
  dynamic public var packages: [String]
  
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
  
  // MARK: Initializers
  
  public init(
    packages: [String] = defaultPackages,
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
    maxBuffer: Int = defaultMaxBuffer
  ) {
    self.packages = packages
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
  }
  
}
