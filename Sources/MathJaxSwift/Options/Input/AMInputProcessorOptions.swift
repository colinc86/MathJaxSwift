//
//  AMInputProcessorOptions.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 12/6/22.
//

import Foundation
import JavaScriptCore

@objc public protocol AMInputProcessorOptionsJSExports: JSExport {
  var fixphi: Bool { get set }
  var displaystyle: Bool { get set }
  var decimalsign: String { get set }
}

/// The options below control the operation of the [AsciiMath input processor](https://docs.mathjax.org/en/latest/basic/mathematics.html#asciimath-input)
/// that is run when you include `input/asciimath` in the in the load array of
/// the loader block of your MathJax configuration, or if you load a combined
/// component that includes the AsciiMath input jax (none currently do, since
/// the AsciiMath input has not been fully ported to version 3). They are listed
/// with their default values. To set any of these options, include an asciimath
/// section in your `MathJax` global object.
@objc public class AMInputProcessorOptions: InputProcessorOptions, AMInputProcessorOptionsJSExports {
  
  // MARK: Default values
  
  public static let defaultFixphi: Bool = true
  public static let defaultDisplaystyle: Bool = true
  public static let defaultDecimalsign: String = "."
  
  // MARK: Properties
  
  /// Determines whether MathJax will switch the Unicode values for `phi` and
  /// `varphi`.
  ///
  /// If set to `true` MathJax will use the TeX mapping, otherwise the Unicode
  /// mapping.
  ///
  /// - Note: The default value is `true`.
  /// - SeeAlso: [AsciiMath Input Processor Options](https://docs.mathjax.org/en/latest/options/input/asciimath.html#asciimath-fixphi)
  dynamic public var fixphi: Bool
  
  /// Determines whether operators like summation symbols will have their limits
  /// above and below the operators (true) or to their right (false).
  ///
  /// The former is how they would appear in displayed equations that are shown
  /// on their own lines, while the latter is better suited to in-line equations
  /// so that they don’t interfere with the line spacing so much.
  ///
  /// - Note: The default value is `true`.
  /// - SeeAlso: [AsciiMath Input Processor Options](https://docs.mathjax.org/en/latest/options/input/asciimath.html#asciimath-displaystyle)
  dynamic public var displaystyle: Bool
  
  /// This is the character to be used for decimal points in numbers.
  ///
  /// If you change this to `,`, then you need to be careful about entering
  /// points or intervals. E.g., use `(1, 2)` rather than `(1,2)` in that case.
  ///
  /// - Note: The default value is `"."`.
  /// - SeeAlso: [AsciiMath Input Processor Options](https://docs.mathjax.org/en/latest/options/input/asciimath.html#asciimath-decimalsign)
  dynamic public var decimalsign: String
  
  // MARK: Initializers
  
  public init(
    fixphi: Bool = defaultFixphi,
    displaystyle: Bool = defaultDisplaystyle,
    decimalsign: String = defaultDecimalsign
  ) {
    self.fixphi = fixphi
    self.displaystyle = displaystyle
    self.decimalsign = decimalsign
  }
  
}
