//
//  DocumentOptions.swift
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

@objc internal protocol MenuOptionsSettingsExports: JSExport {
  var texHints: Bool { get set }
  var semantics: Bool { get set }
  var zoom: MenuOptionsSettings.Zoom { get set }
  var zscale: String { get set }
  var renderer: MenuOptionsSettings.Renderer { get set }
  var alt: Bool { get set }
  var cmd: Bool { get set }
  var ctrl: Bool { get set }
  var shift: Bool { get set }
  var scale: Double { get set }
  var inTabOrder: Bool { get set }
  var assistiveMml: Bool { get set }
  var collapsible: Bool { get set }
  var explorer: Bool { get set }
}

/// See [Accessibility Extension Options](https://docs.mathjax.org/en/latest/options/accessibility.html)
@objc public class MenuOptionsSettings: NSObject, Codable, MenuOptionsSettingsExports {
  
  // MARK: Types
  
  internal enum CodingKeys: CodingKey {
    case texHints
    case semantics
    case zoom
    case zscale
    case renderer
    case alt
    case cmd
    case ctrl
    case shift
    case scale
    case inTabOrder
    case assistiveMml
    case collapsible
    case explorer
  }
  
  public typealias Zoom = String
  public struct Zooms {
    public static let none: Zoom = "NoZoom"
    public static let click: Zoom = "Click"
    public static let doubleClick: Zoom = "DoubleClick"
  }
  
  public typealias Renderer = String
  public struct Renderers {
    public static let chtml: Renderer = "CHTML"
    public static let svg: Zoom = "SVG"
  }
  
  // MARK: Default values
  
  public static let defaulttexHints: Bool = true
  public static let defaultsemantics: Bool = false
  public static let defaultzoom: MenuOptionsSettings.Zoom = Zooms.none
  public static let defaultzscale: String = "200%"
  public static let defaultrenderer: MenuOptionsSettings.Renderer = Renderers.chtml
  public static let defaultalt: Bool = false
  public static let defaultcmd: Bool = false
  public static let defaultctrl: Bool = false
  public static let defaultshift: Bool = false
  public static let defaultscale: Double = 1.0
  public static let defaultinTabOrder: Bool = true
  public static let defaultassistiveMml: Bool = true
  public static let defaultcollapsible: Bool = false
  public static let defaultexplorer: Bool = false
  
  // MARK: Properties
  
  dynamic public var texHints: Bool
  dynamic public var semantics: Bool
  dynamic public var zoom: MenuOptionsSettings.Zoom
  dynamic public var zscale: String
  dynamic public var renderer: MenuOptionsSettings.Renderer
  dynamic public var alt: Bool
  dynamic public var cmd: Bool
  dynamic public var ctrl: Bool
  dynamic public var shift: Bool
  dynamic public var scale: Double
  dynamic public var inTabOrder: Bool
  dynamic public var assistiveMml: Bool
  dynamic public var collapsible: Bool
  dynamic public var explorer: Bool
  
  
  
  // MARK: Initializers
  
  public init(
    texHints: Bool = defaulttexHints,
    semantics: Bool = defaultsemantics,
    zoom: MenuOptionsSettings.Zoom = defaultzoom,
    zscale: String = defaultzscale,
    renderer: MenuOptionsSettings.Renderer = defaultrenderer,
    alt: Bool = defaultalt,
    cmd: Bool = defaultcmd,
    ctrl: Bool = defaultctrl,
    shift: Bool = defaultshift,
    scale: Double = defaultscale,
    inTabOrder: Bool = defaultinTabOrder,
    assistiveMml: Bool = defaultassistiveMml,
    collapsible: Bool = defaultcollapsible,
    explorer: Bool = defaultexplorer
  ) {
    self.texHints = texHints
    self.semantics = semantics
    self.zoom = zoom
    self.zscale = zscale
    self.renderer = renderer
    self.alt = alt
    self.cmd = cmd
    self.ctrl = ctrl
    self.shift = shift
    self.scale = scale
    self.inTabOrder = inTabOrder
    self.assistiveMml = assistiveMml
    self.collapsible = collapsible
    self.explorer = explorer
    
  }
  
}
