//
//  ConversionOptions.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 12/6/22.
//

import Foundation
import JavaScriptCore

@objc public protocol ConversionOptionsExports: JSExport {
  var display: Bool { get set }
  var em: Double { get set }
  var ex: Double { get set }
  var containerWidth: Double { get set }
  var lineWidth: Double { get set }
  var scale: Double { get set }
}

@objc public class ConversionOptions: NSObject, Options, ConversionOptionsExports {
  
  // MARK: Default values
  
  public static let defaultDisplay: Bool = true
  public static let defaultEm: Double = 16
  public static let defaultEx: Double = 8
  public static let defaultLineWidth: Double = 100000
  public static let defaultScale: Double = 1
  
  // MARK: Properties
  
  /// A boolean specifying whether the math is in display-mode or not (for TeX
  /// input).
  ///
  /// - Note: The default value is `true`
  /// - SeeAlso: [Conversion Options](https://docs.mathjax.org/en/latest/web/typeset.html)
  dynamic public var display: Bool
  
  /// A number giving the number of pixels in an `em` for the surrounding font.
  ///
  /// - Note: The default value is `16`
  /// - SeeAlso: [Conversion Options](https://docs.mathjax.org/en/latest/web/typeset.html)
  dynamic public var em: Double
  
  /// A number giving the number of pixels in an `ex` for the surrounding font.
  ///
  /// - Note: The default value is `8`
  /// - SeeAlso: [Conversion Options](https://docs.mathjax.org/en/latest/web/typeset.html)
  dynamic public var ex: Double
  
  /// A number giving the width of the container, in pixels.
  ///
  /// - Note: The default value is `80 * ex`
  /// - SeeAlso: [Conversion Options](https://docs.mathjax.org/en/latest/web/typeset.html)
  dynamic public var containerWidth: Double
  
  /// A number giving the line-breaking width in em units. Default is a very
  /// large number (100000), so effectively no line breaking.
  ///
  /// - Note: The default value is `100000`
  /// - SeeAlso: [Conversion Options](https://docs.mathjax.org/en/latest/web/typeset.html)
  dynamic public var lineWidth: Double
  
  /// A number giving a scaling factor to apply to the resulting conversion.\
  ///
  /// - Note: The default value is `1`
  /// - SeeAlso: [Conversion Options](https://docs.mathjax.org/en/latest/web/typeset.html)
  dynamic public var scale: Double
  
  // MARK: Initializers
  
  public init(
    display: Bool = defaultDisplay,
    em: Double = defaultEm,
    ex: Double = defaultEx,
    containerWidth: Double? = nil,
    lineWidth: Double = defaultLineWidth,
    scale: Double = defaultScale
  ) {
    self.display = display
    self.em = em
    self.ex = ex
    self.containerWidth = containerWidth ?? (80 * ex)
    self.lineWidth = lineWidth
    self.scale = scale
  }
  
}
