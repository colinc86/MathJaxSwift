//
//  SafeStyles.swift
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

@objc internal protocol SafeStylesExports: JSExport {
  var color: Bool { get set }
  var backgroundColor: Bool { get set }
  var border: Bool { get set }
  var cursor: Bool { get set }
  var margin: Bool { get set }
  var padding: Bool { get set }
  var textShadow: Bool { get set }
  var fontFamily: Bool { get set }
  var fontSize: Bool { get set }
  var fontStyle: Bool { get set }
  var fontWeight: Bool { get set }
  var opacity: Bool { get set }
  var outline: Bool { get set }
}

@objc public class SafeStyles: NSObject, Codable, SafeStylesExports {
  
  // MARK: Types
  
  internal enum CodingKeys: CodingKey {
    case color
    case backgroundColor
    case border
    case cursor
    case margin
    case padding
    case textShadow
    case fontFamily
    case fontSize
    case fontStyle
    case fontWeight
    case opacity
    case outline
  }
  
  // MARK: Default values
  
  public static let  defaultColor: Bool = true
  public static let  defaultBackgroundColor: Bool = true
  public static let  defaultBorder: Bool = true
  public static let  defaultCursor: Bool = true
  public static let  defaultMargin: Bool = true
  public static let  defaultPadding: Bool = true
  public static let  defaultTextShadow: Bool = true
  public static let  defaultFontFamily: Bool = true
  public static let  defaultFontSize: Bool = true
  public static let  defaultFontStyle: Bool = true
  public static let  defaultFontWeight: Bool = true
  public static let  defaultOpacity: Bool = true
  public static let  defaultOutline: Bool = true
  
  // MARK: Properties
  
  dynamic public var color: Bool
  dynamic public var backgroundColor: Bool
  dynamic public var border: Bool
  dynamic public var cursor: Bool
  dynamic public var margin: Bool
  dynamic public var padding: Bool
  dynamic public var textShadow: Bool
  dynamic public var fontFamily: Bool
  dynamic public var fontSize: Bool
  dynamic public var fontStyle: Bool
  dynamic public var fontWeight: Bool
  dynamic public var opacity: Bool
  dynamic public var outline: Bool
  
  // MARK: Initializers
  
  public init(
    color: Bool = defaultColor,
    backgroundColor: Bool = defaultBackgroundColor,
    border: Bool = defaultBorder,
    cursor: Bool = defaultCursor,
    margin: Bool = defaultMargin,
    padding: Bool = defaultPadding,
    textShadow: Bool = defaultTextShadow,
    fontFamily: Bool = defaultFontFamily,
    fontSize: Bool = defaultFontSize,
    fontStyle: Bool = defaultFontStyle,
    fontWeight: Bool = defaultFontWeight,
    opacity: Bool = defaultOpacity,
    outline: Bool = defaultOutline
  ) {
    self.color = color
    self.backgroundColor = backgroundColor
    self.border = border
    self.cursor = cursor
    self.margin = margin
    self.padding = padding
    self.textShadow = textShadow
    self.fontFamily = fontFamily
    self.fontSize = fontSize
    self.fontStyle = fontStyle
    self.fontWeight = fontWeight
    self.opacity = opacity
    self.outline = outline
  }
  
}
