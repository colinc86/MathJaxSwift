//
//  SVGContainerOptions.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 11/29/22.
//

import Foundation

@objc public class SVGContainerOptions: ContainerOptions {
  
  // MARK: Default values
  
  public static let defaultStyles: Bool = true
  public static let defaultContainer: Bool = true
  
  // MARK: Properties
  
  /// Whether the CSS for a stand-alone image should be included.
  dynamic public var styles: Bool
  
  /// Whether the `<mjx-container>` element should be included.
  dynamic public var container: Bool
  
  // MARK: Initializers
  
  public init(
    styles: Bool = defaultStyles,
    container: Bool = defaultContainer,
    em: Double = defaultEm,
    ex: Double = defaultEx,
    width: Double = defaultWidth,
    css: Bool = defaultCSS,
    assistiveMml: Bool = defaultAssistiveMml
  ) {
    self.styles = styles
    self.container = container
    super.init(
      em: em,
      ex: ex,
      width: width,
      css: css,
      assistiveMml: assistiveMml)
  }
  
  public override func json() -> String {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
    
    guard let data = try? encoder.encode(self) else {
      return "{}"
    }
    
    guard let jsonString = String(data: data, encoding: .utf8) else {
      return "{}"
    }
    
    return jsonString
  }
  
}
