//
//  AMSOptions.swift
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

@objc internal protocol AMSOptionsExports: JSExport {
  var multilineWidth: String { get set }
  var multilineIndent: String { get set }
}

@objc public class AMSOptions: NSObject, Codable, AMSOptionsExports {
  
  // MARK: Types
  
  internal enum CodingKeys: CodingKey {
    case multilineWidth
    case multilineIndent
  }
  
  // MARK: Default values
  
  public static let defaultMultilineWidth: String = "100%"
  public static let defaultMultilineIndent: String = "1em"
  
  // MARK: Properties
  
  dynamic public var multilineWidth: String
  dynamic public var multilineIndent: String
  
  // MARK: Initializers
  
  public init(
    multilineWidth: String = defaultMultilineWidth,
    multilineIndent: String = defaultMultilineIndent
  ) {
    self.multilineWidth = multilineWidth
    self.multilineIndent = multilineIndent
  }
  
}
