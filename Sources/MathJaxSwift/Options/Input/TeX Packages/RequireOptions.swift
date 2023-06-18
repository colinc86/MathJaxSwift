//
//  RequireOptions.swift
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

@objc internal protocol RequireOptionsExports: JSExport {
  var allow: [String: Bool] { get set }
  var defaultAllow: Bool { get set }
}

@objc public class RequireOptions: NSObject, Codable, RequireOptionsExports {
  
  // MARK: Types
  
  internal enum CodingKeys: CodingKey {
    case allow
    case defaultAllow
  }
  
  // MARK: Default values
  
  public static let defaultAllow: [String: Bool] = [
    "base": false,
    "all-packages": false
  ]
  
  public static let defaultAllowValue: Bool = true
  
  // MARK: Properties
  
  dynamic public var allow: [String: Bool]
  dynamic public var defaultAllow: Bool
  
  // MARK: Initializers
  
  public init(
    allow: [String: Bool] = defaultAllow,
    defaultAllow: Bool = defaultAllowValue
  ) {
    self.allow = allow
    self.defaultAllow = defaultAllow
  }
  
}
