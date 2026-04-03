//
//  SafeProtocols.swift
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

@objc internal protocol SafeProtocolsExports: JSExport {
  var http: Bool { get set }
  var https: Bool { get set }
  var file: Bool { get set }
  var javascript: Bool { get set }
  var data: Bool { get set }
}

@objc public class SafeProtocols: NSObject, Codable, SafeProtocolsExports {
  
  // MARK: Types
  
  internal enum CodingKeys: CodingKey {
    case http
    case https
    case file
    case javascript
    case data
  }
  
  // MARK: Default values
  
  public static let defaultHTTP: Bool = true
  public static let defaultHTTPS: Bool = true
  public static let defaultFile: Bool = true
  public static let defaultJavascript: Bool = false
  public static let defaultData: Bool = false
  
  // MARK: Properties
  
  dynamic public var http: Bool
  dynamic public var https: Bool
  dynamic public var file: Bool
  dynamic public var javascript: Bool
  dynamic public var data: Bool
  
  // MARK: Initializers
  
  public init(
    http: Bool = defaultHTTP,
    https: Bool = defaultHTTPS,
    file: Bool = defaultFile,
    javascript: Bool = defaultJavascript,
    data: Bool = defaultData
  ) {
    self.http = http
    self.https = https
    self.file = file
    self.javascript = javascript
    self.data = data
  }
  
}
