//
//  SVGOutputProcessorOptions.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 11/29/22.
//

import Foundation

public class SVGOutputProcessorOptions: OutputProcessorOptions {
  
  // MARK: Types
  
  public enum FontCache: String, Codable {
    
    /// No font cache should be used.
    case none
    
    /// The local font cache should be used.
    case local
    
    /// The global font cache should be used.
    case global
  }
  
  // MARK: Default values
  
  public static let defaultFontCache: FontCache = .local
  public static let defaultInternalSpeechTitles: Bool = true
  
  // MARK: Properties
  
  /// This setting determines how the SVG output jax manages characters that
  /// appear multiple times in an equation or on a page.
  ///
  /// The SVG processor uses SVG paths to display the characters in your math
  /// expressions, and when a character is used more than once, it is possible
  /// to reuse the same path description; this can save space in the SVG image,
  /// as the paths can be quite complex. When set to `local`, MathJax will cache
  /// font paths on an express-by-expression (each expression has its own cache
  /// within the SVG image itself), which makes the SVG self-contained, but
  /// still allows for some savings if characters are repeated. When set to
  /// `global`, a single cache is used for all paths on the page; this gives the
  /// most savings, but makes the images dependent on other elements of the
  /// page. When set to `none`, no caching is done and explicit paths are used
  /// for every character in the expression.
  ///
  /// - Note: The default value is `local`.
  /// - SeeAlso: [SVG Output Processor Options](https://docs.mathjax.org/en/latest/options/output/svg.html#output-fontcache)
  public let fontCache: FontCache
  
  /// This tells the SVG output jax whether to put speech text into `<title>`
  /// elements within the SVG (when set to `true`), or to use an aria-label
  /// attribute instead.
  ///
  /// Neither of these control whether speech strings are generated (that is
  /// handled by the [Semantic-Enrich Extension Options](https://docs.mathjax.org/en/latest/options/accessibility.html#semantic-enrich-options)
  /// settings); this setting only tells what to do with a speech string when it
  /// has been generated or included as an attribute on the root MathML element.
  ///
  /// - Note: The default value is `true`.
  /// - SeeAlso: [CommonHTML Output Processor Options](https://docs.mathjax.org/en/latest/options/output/chtml.html#output-internalspeechtitles)
  public let internalSpeechTitles: Bool
  
  // MARK: Initializers
  
  public init(
    fontCache: FontCache = defaultFontCache,
    internalSpeechTitles: Bool = defaultInternalSpeechTitles,
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
    self.fontCache = fontCache
    self.internalSpeechTitles = internalSpeechTitles
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
