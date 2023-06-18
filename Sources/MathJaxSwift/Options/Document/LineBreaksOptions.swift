//
//  LineBreaksOptions.swift
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

@objc internal protocol LineBreaksOptionsExports: JSExport {
  var inline: Bool { get set }
  var width: String { get set }
  var lineleading: Double { get set }
}

@objc public class LineBreaksOptions: NSObject, Codable, LineBreaksOptionsExports {
  
  // MARK: Types
  
  internal enum CodingKeys: CodingKey {
    case inline
    case width
    case lineleading
  }
  
  // MARK: Default values
  
  public static let defaultInline: Bool = true
  public static let defaultWidth: String = "100%"
  public static let defaultLineleading: Double = 0.2
  
  // MARK: Properties
  
  dynamic public var inline: Bool
  dynamic public var width: String
  dynamic public var lineleading: Double
  
  // MARK: Initializers
  
  public init(
    inline: Bool = defaultInline,
    width: String = defaultWidth,
    lineleading: Double = defaultLineleading
  ) {
    self.inline = inline
    self.width = width
    self.lineleading = lineleading
  }
  
}
