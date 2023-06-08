//
//  MathMLInputProcessorOptions.swift
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

@objc internal protocol MMLInputProcessorOptionsJSExports: JSExport {
  var parseAs: MMLInputProcessorOptions.Parser { get set }
  var forceReparse: Bool { get set }
  var parseError: MMLInputProcessorOptions.ErrorFunction? { get set }
  var verify: MMLInputProcessorOptions.Verify { get set }
}

@objc internal protocol VerifyJSExports: JSExport {
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
  
  internal enum CodingKeys: CodingKey {
    case parseAs
    case forceReparse
    case verify
  }
  
  public typealias ErrorFunction = @convention(block) (_ node: JSValue?) -> Void
  
  public typealias Parser = String
  public struct Parsers {
    /// An HTML parser.
    public static let html: Parser = "html"
    
    /// A XML parser.
    public static let xml: Parser = "xml"
  }
  
  @objc public class Verify: NSObject, Codable, VerifyJSExports {
    
    // MARK: Default values
    
    public static let defaultCheckArity: Bool = true
    public static let defaultCheckAttributes: Bool = false
    public static let defaultFullErrors: Bool = false
    public static let defaultFixMmultiscripts: Bool = true
    public static let defaultFixMtables: Bool = true
    
    // MARK: Properties
    
    dynamic public var checkArity: Bool
    dynamic public var checkAttributes: Bool
    dynamic public var fullErrors: Bool
    dynamic public var fixMmultiscripts: Bool
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
  
  dynamic public var parseAs: Parser
  dynamic public var forceReparse: Bool
  dynamic public var parseError: ErrorFunction?
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
    super.init()
  }
  
  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    parseAs = try container.decode(Parser.self, forKey: .parseAs)
    forceReparse = try container.decode(Bool.self, forKey: .forceReparse)
    parseError = nil
    verify = try container.decode(Verify.self, forKey: .verify)
    try super.init(from: decoder)
  }
  
  public override func encode(to encoder: Encoder) throws {
    try super.encode(to: encoder)
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(parseAs, forKey: .parseAs)
    try container.encode(forceReparse, forKey: .forceReparse)
    try container.encode(verify, forKey: .verify)
  }
  
}
