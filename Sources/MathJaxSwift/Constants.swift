//
//  Constants.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 11/29/22.
//

import Foundation

internal struct Constants {
  
  /// The version of MathJax that the package expects.
  static let expectedMathJaxVersion = "3.2.2"
  
  struct Names {
    
    /// The name of the MathJax npm module.
    static let mathJaxModuleName = "mathjax-full"
    
    /// The name of the mjn npm module.
    static let mjnModuleName = "mjn"
    
    /// The name of the converter JS class.
    static let converterClassName = "Converter"
    
    /// The name of the tex2svg function.
    static let tex2svgFunctionName = "tex2svg"
    
    /// The name of the tex2chtml function.
    static let tex2chtmlFunctionName = "tex2chtml"
    
    /// The name of the tex2mml function.
    static let tex2mmlFunctionName = "tex2mml"
    
  }
  
  struct Paths {
    
    /// The path to the mjn JS bundle.
    static let mjnBundleFilePath = "dist/mjn.bundle.js"
    
    /// The path to the mjn package-lock.json file.
    static let packageLockFilePath = "package-lock.json"
    
  }
  
  struct URLs {
    
    /// The URL of the mjn top-level directory.
    static let mjn = Bundle.module.url(forResource: Names.mjnModuleName, withExtension: nil)
    
    /// The URL of the JS bundle file.
    static let bundle = mjn?.appendingPathComponent(Paths.mjnBundleFilePath)
    
    /// The URL of the mjn package-lock.json file.
    static let packageLock = mjn?.appendingPathComponent(Paths.packageLockFilePath)
    
  }
  
}
