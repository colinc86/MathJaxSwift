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
    
    struct JSModules {
      
      static let chtml = "chtml"
      
      static let mml = "mml"
      
      static let svg = "svg"
    }
    
    struct Classes {
      
      /// The name of the CommonHTML converter.
      static let chtmlConverter = "CommonHTMLConverter"
      
      /// The name of the MathML converter.
      static let mmlConverter = "MathMLConverter"
      
      /// The name of the SVG converter.
      static let svgConverter = "SVGConverter"
    }
    
  }
  
  struct Paths {
    
    /// The path to the chtml.js bundle.
    static let chtmlBundleFile = "dist/chtml.bundle.js"
    
    /// The path to the mml.js bundle.
    static let mmlBundleFile = "dist/mml.bundle.js"
    
    /// The path to the svg.js bundle.
    static let svgBundleFile = "dist/svg.bundle.js"
    
    /// The path to the mjn package-lock.json file.
    static let packageLockFile = "package-lock.json"
    
  }
  
  struct URLs {
    
    /// The URL of the mjn top-level directory.
    static let mjn = Bundle.module.url(forResource: Names.Modules.mjn, withExtension: nil)
    
    /// The URL of the chtml bundle file.
    static let chtmlBundle = mjn?.appendingPathComponent(Paths.chtmlBundleFile)
    
    /// The URL of the mml bundle file.
    static let mmlBundle = mjn?.appendingPathComponent(Paths.mmlBundleFile)
    
    /// The URL of the svg bundle file.
    static let svgBundle = mjn?.appendingPathComponent(Paths.svgBundleFile)
    
    /// The URL of the mjn package-lock.json file.
    static let packageLock = mjn?.appendingPathComponent(Paths.packageLockFile)
    
  }
  
}
