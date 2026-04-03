//
//  ConversionOptions.swift
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

@objc internal protocol ConversionOptionsExports: JSExport {
  var display: Bool { get set }
  var em: Double { get set }
  var ex: Double { get set }
  var containerWidth: Double { get set }
  var lineWidth: Double { get set }
  var scale: Double { get set }
}

@objc public class ConversionOptions: NSObject, Codable, ConversionOptionsExports {
  
  // MARK: Default values
  
  public static let defaultDisplay: Bool = true
  public static let defaultEm: Double = 16
  public static let defaultEx: Double = 8
  public static let defaultLineWidth: Double = 100000
  public static let defaultScale: Double = 1
  
  // MARK: Properties
  
  dynamic public var display: Bool
  dynamic public var em: Double
  dynamic public var ex: Double
  dynamic public var containerWidth: Double
  dynamic public var lineWidth: Double
  dynamic public var scale: Double
  
  // MARK: Initializers
  
  public init(
    display: Bool = defaultDisplay,
    em: Double = defaultEm,
    ex: Double = defaultEx,
    containerWidth: Double? = nil,
    lineWidth: Double = defaultLineWidth,
    scale: Double = defaultScale
  ) {
    self.display = display
    self.em = em
    self.ex = ex
    self.containerWidth = containerWidth ?? (80 * ex)
    self.lineWidth = lineWidth
    self.scale = scale
  }
  
}
