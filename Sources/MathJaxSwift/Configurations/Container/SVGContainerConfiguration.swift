//
//  SVGContainerConfiguration.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 11/29/22.
//

import Foundation

public class SVGContainerConfiguration: CHTMLContainerConfiguration {
  
  // MARK: Types
  
  private enum CodingKeys: CodingKey {
    case styles
    case container
  }
  
  // MARK: Default values
  
  public static let defaultStyles: Bool = true
  public static let defaultContainer: Bool = true
  
  // MARK: Properties
  
  /// Whether the CSS for a stand-alone image should be included.
  public let styles: Bool
  
  /// Whether the `<mjx-container>` element should be included.
  public let container: Bool
  
  // MARK: Initializers
  
  public init(
    styles: Bool = defaultStyles,
    container: Bool = defaultContainer,
    em: Float = defaultEm,
    ex: Float = defaultEx,
    width: Float = defaultWidth,
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
  
  public required init(from decoder: Decoder) throws {
    let jsonContainer = try decoder.container(keyedBy: CodingKeys.self)
    styles = try jsonContainer.decode(Bool.self, forKey: .styles)
    container = try jsonContainer.decode(Bool.self, forKey: .container)
    try super.init(from: decoder)
  }
  
}
