//
//  PackageLock.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 11/29/22.
//

import Foundation

/// NPM package-lock.json metadata for extracting the mathjax-full version
/// string.
internal struct PackageLock: Codable {
  
  /// The package-lock file's dependencies.
  let packages: [String: MathJax.Metadata]
  
}
