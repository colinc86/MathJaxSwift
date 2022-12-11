//
//  TeXInputProcessorOptions.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 12/6/22.
//

import Foundation
import JavaScriptCore

@objc internal protocol TexInputProcessorOptionsJSExports: JSExport {
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
  var baseURL: String? { get set }
  var formatError: TexInputProcessorOptions.ErrorFunction? { get set }
}

/// The options below control the operation of the [TeX input processor](https://docs.mathjax.org/en/latest/basic/mathematics.html#tex-input)
/// that is run when you include `input/tex`, `input/tex-full`, or
/// `input/tex-base` in the load array of the loader block of your MathJax
/// configuration, or if you load a combined component that includes the TeX
/// input jax. They are listed with their default values. To set any of these
/// options, include a tex section in your `MathJax` global object.
@objc public class TexInputProcessorOptions: InputProcessorOptions, TexInputProcessorOptionsJSExports {
  
  // MARK: Types
  
  public typealias ErrorFunction = @convention(block) (_ jax: JSValue?, _ err: JSValue?) -> Void
  
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
  
  // MARK: Package options
  
  dynamic public var ams: [String: Any]? = nil
  dynamic public var amscd: [String: Any]? = nil
  dynamic public var autoload: [String: Any]? = nil
  dynamic public var color: [String: Any]? = nil
  dynamic public var configmacros: [String: Any]? = nil
  dynamic public var mathtools: [String: Any]? = nil
  dynamic public var noundefined: [String: Any]? = nil
  dynamic public var physics: [String: Any]? = nil
  dynamic public var require: [String: Any]? = nil
  dynamic public var setoptions: [String: Any]? = nil
  dynamic public var tagformat: [String: Any]? = nil
  
  // MARK: Initializers
  
  public init(
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
  }
  
}
