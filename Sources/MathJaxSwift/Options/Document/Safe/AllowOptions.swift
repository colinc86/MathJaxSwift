//
//  AllowOptions.swift
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

@objc internal protocol AllowOptionsExports: JSExport {
  var URLs: AllowOptions.Allow { get set }
  var classes: AllowOptions.Allow { get set }
  var cssIDs: AllowOptions.Allow { get set }
  var styles: AllowOptions.Allow { get set }
}

@objc public class AllowOptions: NSObject, Codable, AllowOptionsExports {
  
  // MARK: Types
  
  internal enum CodingKeys: CodingKey {
    case URLs
    case classes
    case cssIDs
    case styles
  }
  
  public typealias Allow = String
  public struct Allows {
    public static let all: Allow = "all"
    public static let safe: Allow = "safe"
    public static let none: Allow = "none"
  }
  
  // MARK: Default values
  
  public static let defaultURLs: AllowOptions.Allow = Allows.safe
  public static let defaultClasses: AllowOptions.Allow = Allows.safe
  public static let defaultCSSIDs: AllowOptions.Allow = Allows.safe
  public static let defaultStyles: AllowOptions.Allow = Allows.safe
  
  // MARK: Properties
  
  dynamic public var URLs: AllowOptions.Allow
  dynamic public var classes: AllowOptions.Allow
  dynamic public var cssIDs: AllowOptions.Allow
  dynamic public var styles: AllowOptions.Allow
  
  // MARK: Initializers
  
  public init(
    URLs: AllowOptions.Allow = defaultURLs,
    classes: AllowOptions.Allow = defaultClasses,
    cssIDs: AllowOptions.Allow = defaultCSSIDs,
    styles: AllowOptions.Allow = defaultStyles
  ) {
    self.URLs = URLs
    self.classes = classes
    self.cssIDs = cssIDs
    self.styles = styles
  }
  
}
