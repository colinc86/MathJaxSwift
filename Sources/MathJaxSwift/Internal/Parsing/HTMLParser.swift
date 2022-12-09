//
//  HTMLParser.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 12/9/22.
//

import Foundation

internal struct HTMLParser: Parser {
  
  static let shared = HTMLParser()
  
  static let errorRegex = #"\<mjx-merror\s+data-mjx-error=\".*\"\>"#
  
}
