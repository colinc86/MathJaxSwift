#! /usr/bin/env node

const {HTMLDocument} = require('mathjax-full/js/handlers/html/HTMLDocument.js');
const {liteAdaptor} = require('mathjax-full/js/adaptors/liteAdaptor.js');
const {SerializedMmlVisitor} = require('mathjax-full/js/core/MmlTree/SerializedMmlVisitor.js');
const {STATE} = require('mathjax-full/js/core/MathItem.js');

const {AsciiMath} = require('mathjax-full/js/input/asciimath.js');
const {TeX} = require('mathjax-full/js/input/tex.js');

const {AllPackages} = require('mathjax-full/js/input/tex/AllPackages.js');

const PACKAGES = AllPackages.sort().join(', ');
const FILTERED_PACKAGES = AllPackages.filter((name) => name !== 'bussproofs').sort().join(', ');

/**
 * Converts Tex and AsciiMath to MathML.
 */
export class MathMLConverter {
  
  /**
   * Converts a TeX input string to MathML.
   *
   * @param {string} input The TeX input string.
   * @param {object} conversionOptions The MathJax conversion options.
   * @param {object} documentOptions The math document options.
   * @param {object} texOptions The TeX input options.
   * @return {string} The MathML formatted string.
   */
  static tex2mml(input, conversionOptions, documentOptions, texOptions) {
    const tex = new TeX(texOptions);
    return MathMLConverter.createMML(input, tex, conversionOptions, documentOptions);
  }
  
  /**
   * Converts an ASCIIMath input string to MathML.
   *
   * @param {string} input The ASCIIMath input string.
   * @param {object} conversionOptions The MathJax conversion options.
   * @param {object} documentOptions The math document options.
   * @param {object} asciimathOptions The ASCIIMath input options.
   * @return {string} The MathML formatted string.
   */
  static am2mml(input, conversionOptions, documentOptions, asciimathOptions) {
    const asciimath = new AsciiMath(asciimathOptions);
    return MathMLConverter.createMML(input, asciimath, conversionOptions, documentOptions);
  }
  
  /**
   * Creates MathML data from an input string.
   *
   * @param {string} input The input string.
   * @param {object} inputJax The InputJax object.
   * @param {object} conversionOptions The MathJax conversion options.
   * @param {object} documentOptions The math document options.
   * @return {string} The MathML formatted string.
   */
  static createMML(input, inputJax, conversionOptions, documentOptions) {
    conversionOptions.end = STATE.CONVERT;
    documentOptions.InputJax = inputJax;
    
    const adaptor = liteAdaptor();
    const html = new HTMLDocument('', adaptor, documentOptions);
    const visitor = new SerializedMmlVisitor();
    const toMathML = (node => visitor.visitTree(node, html));
    return toMathML(html.convert(input || '', conversionOptions));
  }
  
}
