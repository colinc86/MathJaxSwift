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
    
    /// The name of the converter JS class.
    static let converterClass = "Converter"
    
    struct Modules {
      
      /// The name of the MathJax npm module.
      static let mathjax = "mathjax-full"
      
      /// The name of the mjn npm module.
      static let mjn = "mjn"
      
    }
    
    struct Functions {
      
      /// The name of the tex2svg function.
      static let tex2svg = "tex2svg"
      
      /// The name of the tex2chtml function.
      static let tex2chtml = "tex2chtml"
      
      /// The name of the tex2mml function.
      static let tex2mml = "tex2mml"
      
      /// The name of the am2chtml function.
      static let am2chtml = "am2chtml"
      
      /// The name of the am2mml function.
      static let am2mml = "am2mml"
      
      /// The name of the mml2chtml function.
      static let mml2chtml = "mml2chtml"
      
      /// The name of the mml2svg function.
      static let mml2svg = "mml2svg"
      
    }
    
  }
  
  struct Paths {
    
    /// The path to the mjn JS bundle.
    static let mjnBundleFile = "dist/mjn.bundle.js"
    
    /// The path to the mjn package-lock.json file.
    static let packageLockFile = "package-lock.json"
    
  }
  
  struct URLs {
    
    /// The URL of the mjn top-level directory.
    static let mjn = Bundle.module.url(forResource: Names.Modules.mjn, withExtension: nil)
    
    /// The URL of the JS bundle file.
    static let bundle = mjn?.appendingPathComponent(Paths.mjnBundleFile)
    
    /// The URL of the mjn package-lock.json file.
    static let packageLock = mjn?.appendingPathComponent(Paths.packageLockFile)
    
  }
  
}
