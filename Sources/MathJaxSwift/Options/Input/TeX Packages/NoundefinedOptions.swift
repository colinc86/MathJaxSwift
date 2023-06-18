//
//  NoundefinedOptions.swift
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

@objc internal protocol NoundefinedOptionsExports: JSExport {
  var color: String { get set }
  var background: String { get set }
  var size: String { get set }
}

@objc public class NoundefinedOptions: NSObject, Codable, NoundefinedOptionsExports {
  
  // MARK: Types
  
  internal enum CodingKeys: CodingKey {
    case color
    case background
    case size
  }
  
  // MARK: Default values
  
  public static let defaultColor: String = "red"
  public static let defaultBackground: String = ""
  public static let defaultSize: String = ""
  
  // MARK: Properties
  
  dynamic public var color: String
  dynamic public var background: String
  dynamic public var size: String
  
  // MARK: Initializers
  
  public init(
    color: String = defaultColor,
    background: String = defaultBackground,
    size: String = defaultSize
  ) {
    self.color = color
    self.background = background
    self.size = size
  }
  
}
