//
//  CHTMLContainerConfiguration.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 11/29/22.
//

import Foundation

public class CHTMLContainerConfiguration: Codable {
  
  // MARK: Types
  
  public enum ConfigurationError: Error {
    
    /// The configuration was unable to be encoded in to UTF-8 character data.
    case unableToEncodeConfiguration
  }
  
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
  
  init(
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

// MARK: Public methods

extension CHTMLContainerConfiguration {
  
  /// Gets a JSON representation of the receiver.
  ///
  /// - Returns: A JSON string.
  public func json() throws -> String {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.withoutEscapingSlashes]
    
    let data = try encoder.encode(self)
    guard let json = String(data: data, encoding: .utf8) else {
      throw ConfigurationError.unableToEncodeConfiguration
    }
    
    return json
  }
  
}


