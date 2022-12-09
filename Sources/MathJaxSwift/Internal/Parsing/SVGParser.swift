//
//  SVGParser.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 12/9/22.
//

import Foundation

internal struct SVGParser: Parser {
  
  static let shared = SVGParser()
  
  static let errorRegex = #"\<\w+\s+(data-mml-node=\"merror\"|data-mjx-error=\".*\")\s+(data-mml-node=\"merror\"|data-mjx-error=\".*\")\>"#
  
}
