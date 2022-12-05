//
//  ContainerOptions.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 12/5/22.
//

import Foundation
import JavaScriptCore

@objc protocol ContainerOptionsJSExports: JSExport {
  var em: Double
  var ex: Double
}

public class ContainerOptions: Options {
  
  // MARK: Default values
  
  public static let defaultEm: Double = 16
  public static let defaultEx: Double = 8
  public static let defaultWidth: Double = 80 * 16
  public static let defaultCSS: Bool = false
  public static let defaultAssistiveMml: Bool = false
  
  // MARK: Properties
  
  /// The em-size in pixels.
  dynamic public var em: Double
  
  /// The ex-size in pixels.
  dynamic public var ex: Double
  
  /// The width of the container in pixels.
  dynamic public var width: Double
  
  /// Whether the required CSS is output instead.
  dynamic public var css: Bool
  
  /// Whether to include assistive MathML output.
  dynamic public var assistiveMml: Bool
  
  // MARK: Initializers
  
  public init(
    em: Double = defaultEm,
    ex: Double = defaultEx,
    width: Double = defaultWidth,
    css: Bool = defaultCSS,
    assistiveMml: Bool = defaultAssistiveMml
  ) {
    self.em = em
    self.ex = ex
    self.width = width
    self.css = css
    self.assistiveMml = assistiveMml
  }
  
}
