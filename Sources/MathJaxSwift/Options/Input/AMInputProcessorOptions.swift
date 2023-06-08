//
//  AMInputProcessorOptions.swift
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

@objc internal protocol AMInputProcessorOptionsJSExports: JSExport {
  var fixphi: Bool { get set }
  var displaystyle: Bool { get set }
  var decimalsign: String { get set }
}

@objc public class AMInputProcessorOptions: InputProcessorOptions, AMInputProcessorOptionsJSExports {
  
  // MARK: Types
  
  internal enum CodingKeys: CodingKey {
    case fixphi
    case displaystyle
    case decimalsign
  }
  
  // MARK: Default values
  
  public static let defaultFixphi: Bool = true
  public static let defaultDisplaystyle: Bool = true
  public static let defaultDecimalsign: String = "."
  
  // MARK: Properties
  
  dynamic public var fixphi: Bool
  dynamic public var displaystyle: Bool
  dynamic public var decimalsign: String
  
  // MARK: Initializers
  
  public init(
    fixphi: Bool = defaultFixphi,
    displaystyle: Bool = defaultDisplaystyle,
    decimalsign: String = defaultDecimalsign
  ) {
    self.fixphi = fixphi
    self.displaystyle = displaystyle
    self.decimalsign = decimalsign
    super.init()
  }
  
  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    fixphi = try container.decode(Bool.self, forKey: .fixphi)
    displaystyle = try container.decode(Bool.self, forKey: .displaystyle)
    decimalsign = try container.decode(String.self, forKey: .decimalsign)
    try super.init(from: decoder)
  }
  
  public override func encode(to encoder: Encoder) throws {
    try super.encode(to: encoder)
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(fixphi, forKey: .fixphi)
    try container.encode(displaystyle, forKey: .displaystyle)
    try container.encode(decimalsign, forKey: .decimalsign)
  }
  
}
