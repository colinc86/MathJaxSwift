//
//  MathMLInputProcessorOptions.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 12/6/22.
//

import Foundation
import JavaScriptCore

@objc public protocol MMLInputProcessorOptionsJSExports: JSExport {
  var parseAs: MMLInputProcessorOptions.Parser { get set }
  var forceReparse: Bool { get set }
  var parseError: MMLInputProcessorOptions.ErrorFunction? { get set }
  var verify: MMLInputProcessorOptions.Verify { get set }
}

@objc public protocol VerifyJSExports: JSExport {
  var checkArity: Bool { get set }
  var checkAttributes: Bool { get set }
  var fullErrors: Bool { get set }
  var fixMmultiscripts: Bool { get set }
  var fixMtables: Bool { get set }
}

/// The options below control the operation of the [MathML input processor](https://docs.mathjax.org/en/latest/basic/mathematics.html#mathml-input)
/// that is run when you include `input/mml` in the load array of the loader
/// block of your MathJax configuration, or if you load a combined component
/// that includes the MathML input jax. They are listed with their default
/// values. To set any of these options, include an mml section in your
/// `MathJax` global object.
@objc public class MMLInputProcessorOptions: InputProcessorOptions, MMLInputProcessorOptionsJSExports {
  
  // MARK: Types
  
  public typealias ErrorFunction = @convention(block) (_ node: JSValue?) -> Void
  
  public typealias Parser = String
  public struct Parsers {
    /// An HTML parser.
    public static let html: Parser = "html"
    
    /// A XML parser.
    public static let xml: Parser = "xml"
  }
  
  @objc public class Verify: NSObject, VerifyJSExports {
    
    // MARK: Default values
    
    public static let defaultCheckArity: Bool = true
    public static let defaultCheckAttributes: Bool = false
    public static let defaultFullErrors: Bool = false
    public static let defaultFixMmultiscripts: Bool = true
    public static let defaultFixMtables: Bool = true
    
    // MARK: Properties
    
    /// This specifies whether the number of children is verified or not.
    ///
    /// The default is to check for the correct number of children. If the
    /// number is wrong, the node is replaced by an `<merror>` node containing
    /// either a message indicating the wrong number of children, or the name of
    /// the node itself, depending on the setting of `fullErrors` below.
    ///
    /// - Note: The default value is `true`.
    /// - SeeAlso: [MathML Input Processor Options](https://docs.mathjax.org/en/latest/options/input/mathml.html#mathml-verify-checkarity)
    dynamic public var checkArity: Bool
    
    /// This specifies whether the names of all attributes are checked to see if
    /// they are valid on the given node (i.e., they have a default value, or
    /// are one of the standard attributes such as style, class, id, href, or a
    /// data- attribute.
    ///
    /// If an attribute is in error, the node is either placed inside an
    /// `<merror>` node (so that it is marked in the output as containing an
    /// error), or is replaced by an `<merror>` containing a full message
    /// indicating the bad attribute, depending on the setting of `fullErrors`
    /// below.
    ///
    /// Currently only names are checked, not values. Value verification may be
    /// added in a future release.
    ///
    /// - Note: The default value is `false`.
    /// - SeeAlso: [MathML Input Processor Options](https://docs.mathjax.org/en/latest/options/input/mathml.html#mathml-verify-checkattributes)
    dynamic public var checkAttributes: Bool
    
    /// This specifies whether a full error message is displayed when a node
    /// produces an error, or whether just the node name is displayed (or the
    /// node itself in the case of attribute errors).
    ///
    /// - Note: The default value is `false`.
    /// - SeeAlso: [MathML Input Processor Options](https://docs.mathjax.org/en/latest/options/input/mathml.html#mathml-verify-fullerrors)
    dynamic public var fullErrors: Bool
    
    /// This specifies whether extra `<none/>` entries are added to
    /// `<mmultiscripts>` elements to balance the super- ans subscripts, as
    /// required by the specification, or whether to generate an error instead.
    ///
    /// - Note: The default value is `true`.
    /// - SeeAlso: [MathML Input Processor Options](https://docs.mathjax.org/en/latest/options/input/mathml.html#mathml-verify-fixmmultiscripts)
    dynamic public var fixMmultiscripts: Bool
    
    /// This specifies whether missing `<mtable>`, `<mtr>` and `<mtd>` elements
    /// are placed around cells or not.
    ///
    /// When `true`, MathJax will attempt to correct the table structure if
    /// these elements are missing from the tree. For example, an `<mtr>`
    /// element that is not within an `<mtable>` will have an `<mtable>` placed
    /// around it automatically, and an `<mtable>` containing an `<mi>` as a
    /// direct child node will have an `<mtr>` and `<mtd>` inserted around the
    /// `<mi>`.
    ///
    /// - Note: The default value is `true`.
    /// - SeeAlso: [MathML Input Processor Options](https://docs.mathjax.org/en/latest/options/input/mathml.html#mathml-verify-fixmtables)
    dynamic public var fixMtables: Bool
    
    // MARK: Initializers
    
    public init(
      checkArity: Bool = defaultCheckArity,
      checkAttributes: Bool = defaultCheckAttributes,
      fullErrors: Bool = defaultFullErrors,
      fixMmultiscripts: Bool = defaultFixMmultiscripts,
      fixMtables: Bool = defaultFixMtables
    ) {
      self.checkArity = checkArity
      self.checkAttributes = checkAttributes
      self.fullErrors = fullErrors
      self.fixMmultiscripts = fixMmultiscripts
      self.fixMtables = fixMtables
    }
    
  }
  
  // MARK: Default values
  
  public static let defaultParseAs: Parser = Parsers.html
  public static let defaultForceReparse: Bool = false
  public static let defaultParseError: ErrorFunction? = nil
  public static let defaultVerify: Verify = Verify()
  
  // MARK: Properties
  
  /// Specifies how MathML strings should be parsed: as XML or as HTML. When set
  /// to `xml`, the browser’s XML parser is used, which is more strict about
  /// format (e.g., matching end tags) than the HTML parser, which is the
  /// default.
  ///
  /// In node application (where the `liteDOM` is used), these both use the same
  /// parser, which is not very strict.
  ///
  /// - Note: The default value is `html`.
  /// - SeeAlso: [MathML Input Processor Options](https://docs.mathjax.org/en/latest/options/input/mathml.html#mathml-parseas)
  dynamic public var parseAs: Parser
  
  /// Specifies whether MathJax will serialize and re-parse MathML found in the
  /// document.
  ///
  /// This can be useful if you want to do XML parsing of the MathML from an
  /// HTML document.
  ///
  /// - Note: The default value is `false`.
  /// - SeeAlso: [MathML Input Processor Options](https://docs.mathjax.org/en/latest/options/input/mathml.html#mathml-forcereparse)
  dynamic public var forceReparse: Bool
  
  /// Specifies a function to be called when there is a parsing error in the
  /// MathML (usually only happens with XML parsing).
  ///
  /// The node is a DOM node containing the error text. Your function can
  /// process that in any way it sees fit. The default is to call the MathML
  /// input processor’s error function with the text of the error (which will
  /// create an merror node with the error message). Note that this function
  /// runs with this being the MathML input processor object.
  dynamic public var parseError: ErrorFunction?
  
  /// This object controls what verification/modifications are to be performed
  /// on the MathML that is being processed by MathJax.
  ///
  /// - SeeAlso: [MathML Input Processor Options](https://docs.mathjax.org/en/latest/options/input/mathml.html#mathml-verify)
  dynamic public var verify: Verify
  
  // MARK: Initializers
  
  public init(
    parseAs: Parser = defaultParseAs,
    forceReparse: Bool = defaultForceReparse,
    parseError: ErrorFunction? = defaultParseError,
    verify: Verify = defaultVerify
  ) {
    self.parseAs = parseAs
    self.forceReparse = forceReparse
    self.parseError = parseError
    self.verify = verify
  }
}
