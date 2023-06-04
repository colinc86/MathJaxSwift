//
//  SREOptions.swift
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

@objc internal protocol SREOptionsExports: JSExport {
  var domain: String { get set }
  var style: String { get set }
  var locale: String { get set }
  var subiso: String { get set }
  var markup: SREOptions.Markup { get set }
  var modality: SREOptions.Modality { get set }
  var speech: SREOptions.Speech { get set }
  var pprint: Bool { get set }
  var structure: String? { get set }
  var json: URL? { get set }
  var xpath: URL? { get set }
  var rate: Double { get set }
  var strict: Bool { get set }
  var mode: String { get set }
}

@objc public class SREOptions: NSObject, Codable, SREOptionsExports {
  
  // MARK: Types
  
  internal enum CodingKeys: CodingKey {
    case domain
    case style
    case locale
    case subiso
    case markup
    case modality
    case speech
    case pprint
    case structure
    case json
    case xpath
    case rate
    case strict
    case mode
  }
  
  public typealias Markup = String
  public struct Markups {
    public static let none = Markup("none")
    public static let ssml = Markup("ssml")
    public static let sable = Markup("sable")
    public static let voicexml = Markup("voicexml")
    public static let acss = Markup("acss")
    public static let ssml_step = Markup("ssml_step")
  }
  
  public typealias Modality = String
  public struct Modalities {
    public static let speech = Modality("speech")
    public static let braille = Modality("braille")
    public static let prefix = Modality("prefix")
    public static let summary = Modality("summary")
  }
  
  public typealias Speech = String
  public struct TypeOfSpeech {
    public static let none = Speech("none")
    public static let shallow = Speech("shallow")
    public static let deep = Speech("deep")
  }
  
  public typealias Mode = String
  public struct Modes {
    public static let sync = Mode("sync")
    public static let async = Mode("async")
    public static let http = Mode("http")
  }
  
  // MARK: Default values
  
  public static let defaultDomain: String = "mathspeak"
  public static let defaultStyle: String = "default"
  public static let defaultLocale: String = "en"
  public static let defaultSubiso: String = ""
  public static let defaultMarkup: Markup = Markups.none
  public static let defaultModality: Modality = Modalities.speech
  public static let defaultSpeech: Speech = TypeOfSpeech.none
  public static let defaultPPrint: Bool = true
  public static let defaultStructure: String? = nil
  public static let defaultJSON: URL? = nil
  public static let defaultXPath: URL? = nil
  public static let defaultRate: Double = 1.0
  public static let defaultStrict: Bool = false
  public static let defaultMode: String = Modes.async
  
  // MARK: Properties
  
  dynamic public var domain: String
  dynamic public var style: String
  dynamic public var locale: String
  dynamic public var subiso: String
  dynamic public var markup: Markup
  dynamic public var modality: Modality
  dynamic public var speech: Speech
  dynamic public var pprint: Bool
  dynamic public var structure: String?
  dynamic public var json: URL?
  dynamic public var xpath: URL?
  dynamic public var rate: Double
  dynamic public var strict: Bool
  dynamic public var mode: String
  
  // MARK: Initializers
  
  public init(
    domain: String = defaultDomain,
    style: String = defaultStyle,
    locale: String = defaultLocale,
    subiso: String = defaultSubiso,
    markup: Markup = defaultMarkup,
    modality: Modality = defaultModality,
    speech: Speech = defaultSpeech,
    pprint: Bool = defaultPPrint,
    structure: String? = defaultStructure,
    json: URL? = defaultJSON,
    xpath: URL? = defaultXPath,
    rate: Double = defaultRate,
    strict: Bool = defaultStrict,
    mode: String = defaultMode
  ) {
    self.domain = domain
    self.style = style
    self.locale = locale
    self.subiso = subiso
    self.markup = markup
    self.modality = modality
    self.speech = speech
    self.pprint = pprint
    self.structure = structure
    self.json = json
    self.xpath = xpath
    self.rate = rate
    self.strict = strict
    self.mode = mode
  }
  
}
