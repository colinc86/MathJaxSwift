#! /usr/bin/env node

const {mathjax} = require('mathjax-full/js/mathjax.js');
const {CHTML} = require('mathjax-full/js/output/chtml.js');
const {liteAdaptor} = require('mathjax-full/js/adaptors/liteAdaptor.js');
const {RegisterHTMLHandler} = require('mathjax-full/js/handlers/html.js');
const {AssistiveMmlHandler} = require('mathjax-full/js/a11y/assistive-mml.js');

const {AsciiMath} = require('mathjax-full/js/input/asciimath.js');
const {MathML} = require('mathjax-full/js/input/mathml.js');
const {TeX} = require('mathjax-full/js/input/tex.js');

const {AllPackages} = require('mathjax-full/js/input/tex/AllPackages.js');

/**
 * Converts TeX, MathML, and AsciiMath input to CommonHTML.
 */
export class CommonHTMLConverter {
  
  /**
   * Converts a TeX input string to CommonHTML.
   *
   * @param {string} input The TeX input string.
   * @param {boolean} css Whether the documents CSS should be output.
   * @param {boolean} assistiveMml Whether to include assistive MathML output.
   * @param {object} conversionOptions The MathJax conversion options.
   * @param {object} documentOptions The math document options.
   * @param {object} texOptions The TeX input options.
   * @param {object} chtmlOptions The CommonHTML output options.
   * @return {string} The CommonHTML formatted string.
   */
  static tex2chtml(input, css, assistiveMml, conversionOptions, documentOptions, texOptions, chtmlOptions) {
    texOptions.packages = AllPackages.filter((name) => (texOptions.loadPackages.includes(name) || (name === 'base')));
    const tex = new TeX(texOptions);
    var output = [];
    for (let i = 0; i < input.length; i++) {
      output.push(CommonHTMLConverter.createCHTML(input[i], tex, css, assistiveMml, conversionOptions, documentOptions, chtmlOptions));
    }
    return output;
  }
  
  /**
   * Converts a MathML input string to CommonHTML.
   *
   * @param {string} input The MathML input string.
   * @param {boolean} css Whether the document's CSS should be output.
   * @param {boolean} assistiveMml Whether to include assistive MathML output.
   * @param {object} conversionOptions The MathJax conversion options.
   * @param {object} documentOptions The math document options.
   * @param {object} mathmlOptions The MathML input options.
   * @param {object} chtmlOptions The CommonHTML output options.
   * @return {string} The CommonHTML formatted string.
   */
  static mml2chtml(input, css, assistiveMml, conversionOptions, documentOptions, mathmlOptions, chtmlOptions) {
    const mml = new MathML(mathmlOptions);
    var output = [];
    for (let i = 0; i < input.length; i++) {
      output.push(CommonHTMLConverter.createCHTML(input[i], mml, css, assistiveMml, conversionOptions, documentOptions, chtmlOptions));
    }
    return output;
  }
  
  /**
   * Converts an ASCIIMath input string to CommonHTML.
   *
   * @param {string} input The ASCIIMath input string.
   * @param {boolean} css Whether the document's CSS should be output.
   * @param {boolean} assistiveMml Whether to include assistive MathML output.
   * @param {object} conversionOptions The MathJax conversion options.
   * @param {object} documentOptions The math document options.
   * @param {object} asciimathOptions The ASCIIMath input options.
   * @param {object} chtmlOptions The CommonHTML output options.
   * @return {string} The CommonHTML formatted string.
   */
  static am2chtml(input, css, assistiveMml, conversionOptions, documentOptions, asciimathOptions, chtmlOptions) {
    const asciimath = new AsciiMath(asciimathOptions);
    var output = [];
    for (let i = 0; i < input.length; i++) {
      output.push(CommonHTMLConverter.createCHTML(input[i], asciimath, css, assistiveMml, conversionOptions, documentOptions, chtmlOptions));
    }
    return output;
  }
  
  /**
   * Creates CommonHTML data from an input string.
   *
   * @param {string} input The input string.
   * @param {object} inputJax The InputJax object.
   * @param {boolean} css Whether the document's CSS should be output.
   * @param {boolean} assistiveMml Whether to include assistive MathML output.
   * @param {object} conversionOptions The MathJax conversion options.
   * @param {object} documentOptions The math document options.
   * @param {object} chtmlOptions The CommonHTML output options.
   * @return {string} The CommonHTML formatted string.
   */
  static createCHTML(input, inputJax, css, assistiveMml, conversionOptions, documentOptions, chtmlOptions) {
    const adaptor = liteAdaptor();
    const handler = RegisterHTMLHandler(adaptor);
    
    if (assistiveMml) AssistiveMmlHandler(handler);
    documentOptions.InputJax = inputJax;
    documentOptions.OutputJax = new CHTML(chtmlOptions);
    
    const html = mathjax.document('', documentOptions);
    const node = html.convert(input || '', conversionOptions);
    
    if (css) {
      return adaptor.textContent(chtml.styleSheet(html));
    } else {
      return adaptor.outerHTML(node);
    }
  }
  
}
