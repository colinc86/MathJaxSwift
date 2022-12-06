//
//  CHTMLOutputProcessorOptions.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 11/29/22.
//

import Foundation
import JavaScriptCore

@objc public protocol CHTMLOutputProcessorOptionsJSExports: JSExport {
  var matchFontHeight: Bool { get set }
  var fontURL: URL { get set }
  var adaptiveCSS: Bool { get set }
  var scale: Double { get set }
  var minScale: Double { get set }
  var mtextInheritFont: Bool { get set }
  var merrorInheritFont: Bool { get set }
  var mtextFont: String { get set }
  var merrorFont: String { get set }
  var unknownFamily: String { get set }
  var mathmlSpacing: Bool { get set }
  var skipAttributes: [String: Bool] { get set }
  var exFactor: Double { get set }
  var displayAlign: String { get set }
  var displayIndent: Double { get set }
}

@objc public class CHTMLOutputProcessorOptions: OutputProcessorOptions, CHTMLOutputProcessorOptionsJSExports {
  
  // MARK: Default values
  
  public static let defaultMatchFontHeight: Bool = true
  public static let defaultFontURL: URL = URL(string: "https://cdn.jsdelivr.net/npm/mathjax@3/es5/output/chtml/fonts/woff-v2")!
  public static let defaultAdaptiveCSS: Bool = true
  
  // MARK: Properties
  
  /// This setting controls whether MathJax will scale the mathematics so that
  /// the ex-height of the math fonts matches the ex-height of the surrounding
  /// fonts.
  ///
  /// This makes the math match the surroundings better, but if the surrounding
  /// font does not have its ex-height set properly (and not all fonts do), it
  /// can cause the math to _not_ match the surrounding text. While this will
  /// make the lower-case letters match the surrounding fonts, the upper case
  /// letters may not match (that would require the font height and ex-height to
  /// have the same ratio in the surrounding text as in the math fonts, which is
  /// unlikely).
  ///
  /// - Note: The default value is `true`.
  /// - SeeAlso: [CommonHTML Output Processor Options](https://docs.mathjax.org/en/latest/options/output/chtml.html#output-matchfontheight)
  dynamic public var matchFontHeight: Bool
  
  /// This is the URL to the location where the MathJax fonts are stored.
  ///
  /// You should include a complete URL to the location of the fonts you want to
  /// use.
  ///
  /// - Note: The default value is `"https://cdn.jsdelivr.net/npm/mathjax@3/es5/output/chtml/fonts/woff-v2"`.
  /// - SeeAlso: [CommonHTML Output Processor Options](https://docs.mathjax.org/en/latest/options/output/chtml.html#output-fonturl)
  dynamic public var fontURL: URL
  
  /// This setting controls how the CommonHTML output jax handles the CSS styles
  /// that it generates.
  ///
  /// When true, this means that only the CSS needed for the math that has been
  /// processed on the page so far is generated. When false, the CSS needed for
  /// all elements and all characters in the MathJax font are generated. This is
  /// an extremely large amount of CSS, and that can have an effect on the
  /// performance of your page, so it is best to leave this as `true`. You can
  /// reset the information about what CSS is needed by using the command
  ///
  /// - Note: The default value is `true`.
  /// - SeeAlso: [CommonHTML Output Processor Options](https://docs.mathjax.org/en/latest/options/output/chtml.html#output-adaptivecss)
  dynamic public var adaptiveCSS: Bool
  
  // MARK: Initializers
  
  public init(
    matchFontHeight: Bool = defaultMatchFontHeight,
    fontURL: URL = defaultFontURL,
    adaptiveCSS: Bool = defaultAdaptiveCSS,
    scale: Double = defaultScale,
    minScale: Double = defaultMinScale,
    mtextInheritFont: Bool = defaultMtextInheritFont,
    merrorInheritFont: Bool = defaultMerrorInheritFont,
    mtextFont: String = defaultMtextFont,
    merrorFont: String = defaultMerrorFont,
    unknownFamily: String = defaultUnknownFamily,
    mathmlSpacing: Bool = defaultMathmlSpacing,
    skipAttributes: [String: Bool] = defaultSkipAttributes,
    exFactor: Double = defaultExFactor,
    displayAlign: String = defaultDisplayAlign,
    displayIndent: Double = defaultDisplayIndent
  ) {
    self.matchFontHeight = matchFontHeight
    self.fontURL = fontURL
    self.adaptiveCSS = adaptiveCSS
    super.init(
      scale: scale,
      minScale: minScale,
      mtextInheritFont: mtextInheritFont,
      merrorInheritFont: merrorInheritFont,
      mtextFont: mtextFont,
      merrorFont: merrorFont,
      unknownFamily: unknownFamily,
      mathmlSpacing: mathmlSpacing,
      skipAttributes: skipAttributes,
      exFactor: exFactor,
      displayAlign: displayAlign,
      displayIndent: displayIndent
    )
  }
  
}
