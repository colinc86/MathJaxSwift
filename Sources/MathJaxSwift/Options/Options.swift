//
//  Options.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 12/5/22.
//

import Foundation

public protocol Options: Encodable {}

public enum OptionsError: Error {
  
  /// The configuration was unable to be encoded in to UTF-8 character data.
  case unableToEncodeUTF8String
}

// MARK: Public methods

extension Options {
  
  /// Gets a JSON representation of the receiver.
  ///
  /// - Returns: A JSON string.
  public func json() throws -> String {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.withoutEscapingSlashes]
    
    let data = try encoder.encode(self)
    guard let json = String(data: data, encoding: .utf8) else {
      throw OptionsError.unableToEncodeUTF8String
    }
    
    return json
  }
  
}
