//
//  Constants.swift
//  MathJaxSwift
//
//  Copyright (c) 2023 Colin Campbell
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
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
      static let mathjax = "node_modules/mathjax-full"
      
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
