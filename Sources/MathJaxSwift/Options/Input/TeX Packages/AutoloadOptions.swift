//
//  AutoloadOptions.swift
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

@objc internal protocol AutoloadOptionsExports: JSExport {
  var action: [String] { get set }
  var amscd: [[String]] { get set }
  var bbox: [String] { get set }
  var boldsymbol: [String] { get set }
  var braket: [String] { get set }
  var cancel: [String] { get set }
  var color: [String] { get set }
  var enclose: [String] { get set }
  var extpfeil: [String] { get set }
  var html: [String] { get set }
  var mhchem: [String] { get set }
  var newcommand: [String] { get set }
  var unicode: [String] { get set }
  var verb: [String] { get set }
}

@objc public class AutoloadOptions: NSObject, Codable, AutoloadOptionsExports {
  
  // MARK: Types
  
  internal enum CodingKeys: CodingKey {
    case action
    case amscd
    case bbox
    case boldsymbol
    case braket
    case cancel
    case color
    case enclose
    case extpfeil
    case html
    case mhchem
    case newcommand
    case unicode
    case verb
  }
  
  // MARK: Default values
  
  public static let defaultAction: [String] = ["toggle", "mathtip", "texttip"]
  public static let defaultAmscd: [[String]] = [[], ["CD"]]
  public static let defaultBbox: [String] = ["bbox"]
  public static let defaultBoldsymbol: [String] = ["boldsymbol"]
  public static let defaultBraket: [String] = ["bra", "ket", "braket", "set", "Bra", "Ket", "Braket", "Set", "ketbra", "Ketbra"]
  public static let defaultCancel: [String] = ["cancel", "bcancel", "xcancel", "cancelto"]
  public static let defaultColor: [String] = ["color", "definecolor", "textcolor", "colorbox", "fcolorbox"]
  public static let defaultEnclose: [String] = ["enclose"]
  public static let defaultExtpfeil: [String] = ["xtwoheadrightarrow", "xtwoheadleftarrow", "xmapsto", "xlongequal", "xtofrom", "Newextarrow"]
  public static let defaultHtml: [String] = ["href", "class", "style", "cssId"]
  public static let defaultMhchem: [String] = ["ce", "pu"]
  public static let defaultNewcommand: [String] = ["newcommand", "renewcommand", "newenvironment", "renewenvironment", "def", "let"]
  public static let defaultUnicode: [String] = ["unicode"]
  public static let defaultVerb: [String] = ["verb"]
  
  
  // MARK: Properties
  
  dynamic public var action: [String]
  dynamic public var amscd: [[String]]
  dynamic public var bbox: [String]
  dynamic public var boldsymbol: [String]
  dynamic public var braket: [String]
  dynamic public var cancel: [String]
  dynamic public var color: [String]
  dynamic public var enclose: [String]
  dynamic public var extpfeil: [String]
  dynamic public var html: [String]
  dynamic public var mhchem: [String]
  dynamic public var newcommand: [String]
  dynamic public var unicode: [String]
  dynamic public var verb: [String]
  
  
  
  // MARK: Initializers
  
  public init(
    action: [String] = defaultAction,
    amscd: [[String]] = defaultAmscd,
    bbox: [String] = defaultBbox,
    boldsymbol: [String] = defaultBoldsymbol,
    braket: [String] = defaultBraket,
    cancel: [String] = defaultCancel,
    color: [String] = defaultColor,
    enclose: [String] = defaultEnclose,
    extpfeil: [String] = defaultExtpfeil,
    html: [String] = defaultHtml,
    mhchem: [String] = defaultMhchem,
    newcommand: [String] = defaultNewcommand,
    unicode: [String] = defaultUnicode,
    verb: [String] = defaultVerb
  ) {
    self.action = action
    self.amscd = amscd
    self.bbox = bbox
    self.boldsymbol = boldsymbol
    self.braket = braket
    self.cancel = cancel
    self.color = color
    self.enclose = enclose
    self.extpfeil = extpfeil
    self.html = html
    self.mhchem = mhchem
    self.newcommand = newcommand
    self.unicode = unicode
    self.verb = verb
  }
  
}
