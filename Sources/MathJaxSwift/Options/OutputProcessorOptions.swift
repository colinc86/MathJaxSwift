//
//  OutputProcessorOptions.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 11/29/22.
//

import Foundation

public class OutputProcessorOptions: Options {
  
  // MARK: Types
  
  public enum DisplayAlignment: String, Codable {
    
    /// Align content left.
    case left
    
    /// Align content center.
    case center
    
    /// Align content right.
    case right
  }
  
  // MARK: Default values
  
  public static let defaultScale: Double = 1
  public static let defaultMinScale: Double = 0.5
  public static let defaultMtextInheritFont: Bool = false
  public static let defaultMerrorInheritFont: Bool = false
  public static let defaultMtextFont: String = ""
  public static let defaultMerrorFont: String = "serif"
  public static let defaultUnknownFamily: String = "serif"
  public static let defaultMathmlSpacing: Bool = false
  public static let defaultSkipAttributes: [String: Bool] = [:]
  public static let defaultExFactor: Double = 0.5
  public static let defaultDisplayAlign: DisplayAlignment = .center
  public static let defaultDisplayIndent: Double = 0
  
  // MARK: Properties
  
  /// The scaling factor for math compaired to the surrounding text.
  ///
  /// The _CommonHTML_ output processor tries to match the ex-size of the
  /// mathematics with that of the text where it is placed, but you may want to
  /// adjust the results using this scaling factor. The user can also adjust
  /// this value using the contextual menu item associated with the typeset
  /// mathematics.
  ///
  /// - Note: The default value is `1`.
  /// - SeeAlso: [Output Processor Options](https://docs.mathjax.org/en/latest/options/output/index.html#output-scale)
  dynamic public var scale: Double
  
  /// This gives a minimum scale factor for the scaling used by MathJax to match
  /// the equation to the surrounding text.
  ///
  /// This will prevent MathJax from making the mathematics too small.
  ///
  /// - Note: The default value is `0.5`.
  /// - SeeAlso: [Output Processor Options](https://docs.mathjax.org/en/latest/options/output/index.html#output-minscale)
  dynamic public var minScale: Double
  
  /// This setting controls whether `<mtext>` elements will be typeset using the
  /// math fonts or the font of the surrounding text.
  ///
  /// When `false`, the [mtextFont](https://docs.mathjax.org/en/latest/options/output/index.html#output-mtextfont)
  /// will be used, unless it is blank, in which case math fonts will be used,
  /// as they are for other token elements; when `true`, the font will be
  /// inherited from the surrounding text, when possible, depending on the
  /// `mathvariant` for the element (some math variants, such as `fraktur` can’t
  /// be inherited from the surroundings).
  ///
  /// - Note: The default value is `false`.
  /// - SeeAlso: [Output Processor Options](https://docs.mathjax.org/en/latest/options/output/index.html#output-mtextinheritfont)
  dynamic public var mtextInheritFont: Bool
  
  /// This setting controls whether the text for `<merror>` elements will be
  /// typeset using the math fonts or the font of the surrounding text.
  ///
  /// When `false`, the [merrorFont](https://docs.mathjax.org/en/latest/options/output/index.html#output-merrorfont)
  /// will be used; when `true`, the font will be inherited from the surrounding
  /// text, when possible, depending on the `mathvariant` for the element (some
  /// math variants, such as `fraktur` can’t be inherited from the
  /// surroundings).
  ///
  /// - Note: The default value is `false`.
  /// - SeeAlso: [Output Processor Options](https://docs.mathjax.org/en/latest/options/output/index.html#output-merrorinheritfont)
  dynamic public var merrorInheritFont: Bool
  
  /// This specifies the font family to use for `<mtext>` elements when
  /// [mtextInheritFont](https://docs.mathjax.org/en/latest/options/output/index.html#output-mtextinheritfont)
  /// is `false` (and is ignored if it is `true`).
  ///
  /// It can be a comma-separated list of font-family names. If it is empty,
  /// then the math fonts are used, as they are with other token elements.
  ///
  /// - Note: The default value is `""`.
  /// - SeeAlso: [Output Processor Options](https://docs.mathjax.org/en/latest/options/output/index.html#output-mtextfont)
  dynamic public var mtextFont: String
  
  /// This specifies the font family to use for `<merror>` elements when
  /// [merrorInheritFont](https://docs.mathjax.org/en/latest/options/output/index.html#output-mtextinheritfont)
  /// is `false` (and is ignored if it is `true`).
  ///
  /// It can be a comma-separated list of font-family names. If it is empty,
  /// then the math fonts are used, as they are with other token elements.
  ///
  /// - Note: The default value is `"serif"`.
  /// - SeeAlso: [Output Processor Options](https://docs.mathjax.org/en/latest/options/output/index.html#output-merrorfont)
  dynamic public var merrorFont: String
  
  /// This specifies the font family to use for characters that are not found in
  /// the MathJax math fonts.
  ///
  /// For exmaple, if you enter unicode characters directly, these may not be in
  /// MathJax’s font, and so they will be taken from the font specified here.
  ///
  /// - Note: The default value is `"serif"`.
  /// - SeeAlso: [Output Processor Options](https://docs.mathjax.org/en/latest/options/output/index.html#output-unknownfamily)
  dynamic public var unknownFamily: String
  
  /// This specifies whether to use TeX spacing or MathML spacing when
  /// typesetting the math.
  ///
  /// When `true`, MathML spacing rules are used; when `false`, the TeX rules
  /// are used.
  ///
  /// - Note: The default value is `false`.
  /// - SeeAlso: [Output Processor Options](https://docs.mathjax.org/en/latest/options/output/index.html#output-mathmlspacing)
  dynamic public var mathmlSpacing: Bool
  
  /// This object gives a list of non-standard attributes (e.g., RFDa
  /// attributes) that will *not* be transferred from MathML element to their
  /// corresponding DOM elements in the typeset output.
  ///
  /// For example, with
  ///
  /// ```
  /// skipAttributes: {
  ///   data-my-attr: true
  /// }
  /// ```
  ///
  /// a MathML element like `<mi data-my-attr="some data">x</mi>` will not have
  /// the `data-my-attr` attribute on the `<mjx-mi>` element created by the
  /// CommonHTML output processor to represent the `<mi>` element (normally, any
  /// non-standard attributes are retained in the output).
  ///
  /// - Note: The default value is `{}`.
  /// - SeeAlso: [Output Processor Options](https://docs.mathjax.org/en/latest/options/output/index.html#output-skipattributes)
  dynamic public var skipAttributes: [String: Bool]
  
  /// This is the size of an ex in comparison to 1 em that is to be used when
  /// the ex-size can’t be determined (e.g., when running in a Node application,
  /// where the size of DOM elements can’t be determined).
  dynamic public var exFactor: Double
  
  /// This determines how displayed equations will be aligned (left, center, or
  /// right).
  ///
  /// - Note: The default value is `center`.
  /// - SeeAlso: [Output Processor Options](https://docs.mathjax.org/en/latest/options/output/index.html#output-displayalign)
  dynamic public var displayAlign: DisplayAlignment
  
  /// This gives the amount of indentation that should be used for displayed
  /// equations.
  ///
  /// A value of `1em`, for example, would introduce an extra 1 em of space from
  /// whichever margin the equation is aligned to, or an offset from the center
  /// position if the expression is centered.
  ///
  /// - Note: The default value is `0`. Negative values are allowed.
  /// - SeeAlso: [Output Processor Options](https://docs.mathjax.org/en/latest/options/output/index.html#output-displayindent)
  dynamic public var displayIndent: Double
  
  // MARK: Initializers
  
  init(
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
    displayAlign: DisplayAlignment = defaultDisplayAlign,
    displayIndent: Double = defaultDisplayIndent
  ) {
    self.scale = scale
    self.minScale = minScale
    self.mtextInheritFont = mtextInheritFont
    self.merrorInheritFont = merrorInheritFont
    self.mtextFont = mtextFont
    self.merrorFont = merrorFont
    self.unknownFamily = unknownFamily
    self.mathmlSpacing = mathmlSpacing
    self.skipAttributes = skipAttributes
    self.exFactor = exFactor
    self.displayAlign = displayAlign
    self.displayIndent = displayIndent
  }
  
}


