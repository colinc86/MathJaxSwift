//
//  NPMPackage.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 11/26/22.
//

import Foundation

/// NPM package-lock.json metadata for extracting the mathjax-full version 
/// string.
internal struct NPMPackage: Codable {

  struct Dependency: Codable {
    let version: String
    let resolved: URL
    let integrity: String
  }
  
  let dependencies: [String: Metadata]
  
}
