//
//  ContainerOptions.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 12/5/22.
//

import Foundation

public class ContainerOptions: Options {
  
  // MARK: Default values
  
  public static let defaultEm: Float = 16
  public static let defaultEx: Float = 8
  public static let defaultWidth: Float = 80 * 16
  public static let defaultCSS: Bool = false
  public static let defaultAssistiveMml: Bool = false
  
  // MARK: Properties
  
  /// The em-size in pixels.
  public let em: Float
  
  /// The ex-size in pixels.
  public let ex: Float
  
  /// The width of the container in pixels.
  public let width: Float
  
  /// Whether the required CSS is output instead.
  public let css: Bool
  
  /// Whether to include assistive MathML output.
  public let assistiveMml: Bool
  
  // MARK: Initializers
  
  public init(
    em: Float = defaultEm,
    ex: Float = defaultEx,
    width: Float = defaultWidth,
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
