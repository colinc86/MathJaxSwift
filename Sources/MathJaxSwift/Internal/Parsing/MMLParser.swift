//
//  MMLParser.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 12/9/22.
//

import Foundation

internal struct MMLParser: Parser {
  
  static let shared = MMLParser()
  
  static let errorRegex = #"\<merror\s+data-mjx-error=\".*\"\>"#
  
}
