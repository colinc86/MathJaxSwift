//
//  A11YOptions.swift
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

@objc internal protocol A11YOptionsExports: JSExport {
  var speech: Bool { get set }
  var braille: Bool { get set }
  var subtitles: Bool { get set }
  var viewBraille: Bool { get set }
  var backgroundColor: A11YOptions.Color { get set }
  var backgroundOpacity: Double { get set }
  var foregroundColor: A11YOptions.Color { get set }
  var foregroundOpacity: Double { get set }
  var highlight: A11YOptions.Highlight { get set }
  var flame: Bool { get set }
  var hover: Bool { get set }
  var treeColoring: Bool { get set }
  var magnification: String { get set }
  var magnify: String { get set }
  var keyMagnifier: Bool { get set }
  var mouseMagnifier: Bool { get set }
  var align: String { get set }
  var infoType: Bool { get set }
  var infoRole: Bool { get set }
  var infoPrefix: Bool { get set }
}

@objc public class A11YOptions: NSObject, Codable, A11YOptionsExports {
  
  // MARK: Types
  
  internal enum CodingKeys: CodingKey {
    case speech
    case braille
    case subtitles
    case viewBraille
    case backgroundColor
    case backgroundOpacity
    case foregroundColor
    case foregroundOpacity
    case highlight
    case flame
    case hover
    case treeColoring
    case magnification
    case magnify
    case keyMagnifier
    case mouseMagnifier
    case align
    case infoType
    case infoRole
    case infoPrefix
  }
  
  public typealias Color = String
  public struct Colors {
    public static let blue = Color("Blue")
    public static let red = Color("Red")
    public static let green = Color("Green")
    public static let yellow = Color("Yellow")
    public static let cyan = Color("Cyan")
    public static let magenta = Color("Magenta")
    public static let white = Color("White")
    public static let black = Color("Black")
  }
  
  public typealias Highlight = String
  public struct Highlights {
    public static let none = Highlight("None")
    public static let flame = Highlight("Flame")
    public static let hover = Highlight("Hover")
  }
  
  public typealias Magnification = String
  public struct Magnifications {
    public static let none = Magnification("None")
    public static let mouse = Magnification("Mouse")
    public static let keyboard = Magnification("Keyboard")
  }
  
  // MARK: Default values
  
  public static let defaultSpeech: Bool = true
  public static let defaultBraille: Bool = true
  public static let defaultSubtitles: Bool = true
  public static let defaultViewBraille: Bool = false
  public static let defaultBackgroundColor: Color = Colors.blue
  public static let defaultBackgroundOpacity: Double = 0.2
  public static let defaultForegroundColor: Color = Colors.black
  public static let defaultForegroundOpacity: Double = 1.0
  public static let defaultHighlight: A11YOptions.Highlight = Highlights.none
  public static let defaultFlame: Bool = false
  public static let defaultHover: Bool = false
  public static let defaultTreeColoring: Bool = false
  public static let defaultMagnification: Magnification = Magnifications.none
  public static let defaultMagnify: String = "400%"
  public static let defaultKeyMagnifier: Bool = false
  public static let defaultMouseMagnifier: Bool = false
  public static let defaultAlign: String = "top"
  public static let defaultInfoType: Bool = false
  public static let defaultInfoRole: Bool = false
  public static let defaultInfoPrefix: Bool = false
  
  // MARK: Properties
  
  dynamic public var speech: Bool
  dynamic public var braille: Bool
  dynamic public var subtitles: Bool
  dynamic public var viewBraille: Bool
  dynamic public var backgroundColor: Color
  dynamic public var backgroundOpacity: Double
  dynamic public var foregroundColor: Color
  dynamic public var foregroundOpacity: Double
  dynamic public var highlight: Highlight
  dynamic public var flame: Bool
  dynamic public var hover: Bool
  dynamic public var treeColoring: Bool
  dynamic public var magnification: String
  dynamic public var magnify: String
  dynamic public var keyMagnifier: Bool
  dynamic public var mouseMagnifier: Bool
  dynamic public var align: String
  dynamic public var infoType: Bool
  dynamic public var infoRole: Bool
  dynamic public var infoPrefix: Bool
  
  // MARK: Initializers
  
  public init(
    speech: Bool = defaultSpeech,
    braille: Bool = defaultBraille,
    subtitles: Bool = defaultSubtitles,
    viewBraille: Bool = defaultViewBraille,
    backgroundColor: Color = defaultBackgroundColor,
    backgroundOpacity: Double = defaultBackgroundOpacity,
    foregroundColor: Color = defaultForegroundColor,
    foregroundOpacity: Double = defaultForegroundOpacity,
    highlight: String = defaultHighlight,
    flame: Bool = defaultFlame,
    hover: Bool = defaultHover,
    treeColoring: Bool = defaultTreeColoring,
    magnification: String = defaultMagnification,
    magnify: String = defaultMagnify,
    keyMagnifier: Bool = defaultKeyMagnifier,
    mouseMagnifier: Bool = defaultMouseMagnifier,
    align: String = defaultAlign,
    infoType: Bool = defaultInfoType,
    infoRole: Bool = defaultInfoRole,
    infoPrefix: Bool = defaultInfoPrefix
  ) {
    self.speech = speech
    self.braille = braille
    self.subtitles = subtitles
    self.viewBraille = viewBraille
    self.backgroundColor = backgroundColor
    self.backgroundOpacity = backgroundOpacity
    self.foregroundColor = foregroundColor
    self.foregroundOpacity = foregroundOpacity
    self.highlight = highlight
    self.flame = flame
    self.hover = hover
    self.treeColoring = treeColoring
    self.magnification = magnification
    self.magnify = magnify
    self.keyMagnifier = keyMagnifier
    self.mouseMagnifier = mouseMagnifier
    self.align = align
    self.infoType = infoType
    self.infoRole = infoRole
    self.infoPrefix = infoPrefix
  }
  
}
