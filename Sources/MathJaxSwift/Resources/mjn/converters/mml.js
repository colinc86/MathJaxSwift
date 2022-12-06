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
    const tex = new TeX(JSON.parse(JSON.stringify(texOptions)));
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
    const asciimath = new AsciiMath(JSON.parse(JSON.stringify(asciimathOptions)));
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
    const adaptor = liteAdaptor();
    const html = new HTMLDocument('', adaptor, {
      InputJax: inputJax,
      skipHtmlTags: documentOptions.skipHtmlTags,
      includeHtmlTags: documentOptions.includeHtmlTags,
      ignoreHtmlClass: documentOptions.ignoreHtmlClass,
      processHtmlClass: documentOptions.processHtmlClass
    });
    
    const visitor = new SerializedMmlVisitor();
    const toMathML = (node => visitor.visitTree(node, html));
    return toMathML(html.convert(input || '', {
      display: conversionOptions.display,
      em: conversionOptions.em,
      ex: conversionOptions.ex,
      containerWidth: conversionOptions.containerWidth,
      lineWidth: conversionOptions.lineWidth,
      scale: conversionOptions.scale,
      end: STATE.CONVERT
    }));
  }
  
}
