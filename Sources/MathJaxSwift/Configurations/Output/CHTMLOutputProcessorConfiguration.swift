//
//  CHTMLOutputProcessorConfiguration.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 11/29/22.
//

import Foundation

public class CHTMLOutputProcessorConfiguration: OutputProcessorConfiguration {
  
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
  public let matchFontHeight: Bool
  
  /// This is the URL to the location where the MathJax fonts are stored.
  ///
  /// You should include a complete URL to the location of the fonts you want to
  /// use.
  ///
  /// - Note: The default value is `"https://cdn.jsdelivr.net/npm/mathjax@3/es5/output/chtml/fonts/woff-v2"`.
  /// - SeeAlso: [CommonHTML Output Processor Options](https://docs.mathjax.org/en/latest/options/output/chtml.html#output-fonturl)
  public let fontURL: URL
  
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
  public let adaptiveCSS: Bool
  
  // MARK: Initializers
  
  public init(
    matchFontHeight: Bool = defaultMatchFontHeight,
    fontURL: URL = defaultFontURL,
    adaptiveCSS: Bool = defaultAdaptiveCSS,
    scale: Float = defaultScale,
    minScale: Float = defaultMinScale,
    mtextInheritFont: Bool = defaultMtextInheritFont,
    merrorInheritFont: Bool = defaultMerrorInheritFont,
    mtextFont: String = defaultMtextFont,
    merrorFont: String = defaultMerrorFont,
    unknownFamily: String = defaultUnknownFamily,
    mathmlSpacing: Bool = defaultMathmlSpacing,
    skipAttributes: [String: Bool] = defaultSkipAttributes,
    exFactor: Float = defaultExFactor,
    displayAlign: DisplayAlignment = defaultDisplayAlign,
    displayIndent: Float = defaultDisplayIndent
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
