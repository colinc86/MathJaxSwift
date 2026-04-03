//
//  TagFormatOptions.swift
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

@objc internal protocol TagFormatOptionsExports: JSExport {
  var number: TagFormatOptions.NumberFunction? { get set }
  var tag: TagFormatOptions.NumberFunction? { get set }
  var id: TagFormatOptions.NumberFunction? { get set }
  var url: TagFormatOptions.UrlFunction? { get set }
}

@objc public class TagFormatOptions: NSObject, Codable, TagFormatOptionsExports {
  
  // MARK: Types
  
  public typealias NumberFunction = @convention(block) (_ number: Int) -> String
  public typealias UrlFunction = @convention(block) (_ number: Int, _ base: String) -> String
  
  // MARK: Default values
  
  public static let defaultNumber: NumberFunction? = nil
  public static let defaultTag: NumberFunction? = nil
  public static let defaultID: NumberFunction? = nil
  public static let defaultURL: UrlFunction? = nil
  
  // MARK: Properties
  
  dynamic public var number: NumberFunction?
  dynamic public var tag: NumberFunction?
  dynamic public var id: NumberFunction?
  dynamic public var url: UrlFunction?
  
  // MARK: Initializers
  
  public init(
    number: NumberFunction? = defaultNumber,
    tag: NumberFunction? = defaultTag,
    id: NumberFunction? = defaultID,
    url: UrlFunction? = defaultURL
  ) {
    self.number = number
    self.tag = tag
    self.id = id
    self.url = url
  }
  
  public required init(from decoder: Decoder) throws {}
  
  public func encode(to encoder: Encoder) throws {}
  
}
