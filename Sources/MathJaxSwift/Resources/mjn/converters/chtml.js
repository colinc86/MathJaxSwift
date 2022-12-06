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

//const PACKAGES = AllPackages.sort().join(', ');

/**
 * Converts TeX, MathML, and AsciiMath input to CommonHTML.
 */
export class CommonHTMLConverter {
  
  /**
   * Converts a TeX input string to CommonHTML.
   *
   * @param {string} input The TeX input string.
   * @param {boolean} inline Whether or not the TeX should be rendered inline.
   * @param {object} containerOptions The CommonHTML container options.
   * @param {object} texOptions The TeX input options.
   * @param {object} chtmlOptions The CommonHTML output options.
   * @return {string} The CommonHTML formatted string.
   */
  static tex2chtml(input, inline, containerOptions, texOptions, chtmlOptions) {
    const tex = new TeX(JSON.parse(JSON.stringify(texOptions)));
    return CommonHTMLConverter.createCHTML(input, tex, inline, containerOptions, chtmlOptions);
  }
  
  /**
   * Converts a MathML input string to CommonHTML.
   *
   * @param {string} input The MathML input string.
   * @param {boolean} inline Whether or not the MathML should be rendered inline.
   * @param {object} containerOptions The CommonHTML container options.
   * @param {object} mathmlOptions The MathML input options.
   * @param {object} chtmlOptions The CommonHTML output options.
   * @return {string} The CommonHTML formatted string.
   */
  static mml2chtml(input, inline, containerOptions, mathmlOptions, chtmlOptions) {
    const mml = new MathML(JSON.parse(JSON.stringify(mathmlOptions)));
    return CommonHTMLConverter.createCHTML(input, mml, inline, containerOptions, chtmlOptions);
  }
  
  /**
   * Converts an ASCIIMath input string to CommonHTML.
   *
   * @param {string} input The ASCIIMath input string.
   * @param {boolean} inline Whether or not the ASCIIMath should be rendered inline.
   * @param {object} containerOptions The CommonHTML container options.
   * @param {object} asciimathOptions The ASCIIMath input options.
   * @param {object} chtmlOptions The CommonHTML output options.
   * @return {string} The CommonHTML formatted string.
   */
  static am2chtml(input, inline, containerOptions, asciimathOptions, chtmlOptions) {
    const asciimath = new AsciiMath(JSON.parse(JSON.stringify(asciimathOptions)));
    return CommonHTMLConverter.createCHTML(input, asciimath, inline, containerOptions, chtmlOptions);
  }
  
  /**
   * Creates CommonHTML data from an input string.
   *
   * @param {string} input The input string.
   * @param {object} inputJax The InputJax object.
   * @param {boolean} inline Whether or not the input should be rendered inline.
   * @param {object} containerOptions The CommonHTML container options.
   * @param {object} chtmlOptions The CommonHTML output options.
   * @return {string} The CommonHTML formatted string.
   */
  static createCHTML(input, inputJax, inline, containerOptions, chtmlOptions) {
    const adaptor = liteAdaptor({fontSize: containerOptions.em});
    const handler = RegisterHTMLHandler(adaptor);
    if (containerOptions.assistiveMml) AssistiveMmlHandler(handler);
    const chtml = new CHTML(JSON.parse(JSON.stringify(chtmlOptions)));
    const html = mathjax.document('', {InputJax: inputJax, OutputJax: chtml});
    const node = html.convert(input || '', {
      display: !inline,
      em: containerOptions.em,
      ex: containerOptions.ex,
      containerWidth: containerOptions.width
    });
    
    if (containerOptions.css) {
      return adaptor.textContent(chtml.styleSheet(html));
    } else {
      return adaptor.outerHTML(node);
    }
  }
  
}
