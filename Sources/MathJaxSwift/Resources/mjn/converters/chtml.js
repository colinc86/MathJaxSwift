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

const PACKAGES = AllPackages.sort().join(', ');

/**
 * Converts TeX, MathML, and AsciiMath input to CommonHTML.
 */
export class CommonHTMLConverter {
  
  /**
   * Converts a TeX input string to CommonHTML.
   *
   * @param {string} input The TeX input string.
   * @param {boolean} inline Whether or not the TeX should be rendered inline.
   * @param {object} containerConfig The CommonHTML container configuration.
   * @param {object} chtmlConfig The CommonHTML output configuration.
   * @return {string} The CommonHTML formatted string.
   */
  static tex2chtml(input, inline, containerConfig, chtmlConfig) {
    const tex = new TeX({packages: PACKAGES.split(/\s*,\s*/)});
    return CommonHTMLConverter.createCHTML(input, tex, inline, containerConfig, chtmlConfig);
  }
  
  /**
   * Converts a MathML input string to CommonHTML.
   *
   * @param {string} input The MathML input string.
   * @param {boolean} inline Whether or not the MathML should be rendered inline.
   * @param {object} containerConfig The CommonHTML container configuration.
   * @param {object} chtmlConfig The CommonHTML output configuration.
   * @return {string} The CommonHTML formatted string.
   */
  static mml2chtml(input, inline, containerConfig, chtmlConfig) {
    const mml = new MathML();
    return CommonHTMLConverter.createCHTML(input, mml, inline, containerConfig, chtmlConfig);
  }
  
  /**
   * Converts an ASCIIMath input string to CommonHTML.
   *
   * @param {string} input The ASCIIMath input string.
   * @param {boolean} inline Whether or not the ASCIIMath should be rendered inline.
   * @param {object} containerConfig The CommonHTML container configuration.
   * @param {object} chtmlConfig The CommonHTML output configuration.
   * @return {string} The CommonHTML formatted string.
   */
  static am2chtml(input, inline, containerConfig, chtmlConfig) {
    const asciimath = new AsciiMath();
    return CommonHTMLConverter.createCHTML(input, asciimath, inline, containerConfig, chtmlConfig);
  }
  
  /**
   * Creates CommonHTML data from an input string.
   *
   * @param {string} input The input string.
   * @param {object} inputJax The InputJax object.
   * @param {boolean} inline Whether or not the input should be rendered inline.
   * @param {object} containerConfig The CommonHTML container configuration.
   * @param {object} svgConfig The CommonHTML output configuration.
   * @return {string} The CommonHTML formatted string.
   */
  static createCHTML(input, inputJax, inline, containerConfig, chtmlConfig) {
    const chtmlContainer = JSON.parse(containerConfig);
    const adaptor = liteAdaptor({fontSize: chtmlContainer.em});
    const handler = RegisterHTMLHandler(adaptor);
    if (chtmlContainer.assistiveMml) AssistiveMmlHandler(handler);
    const chtml = new CHTML(JSON.parse(chtmlConfig));
    const html = mathjax.document('', {InputJax: inputJax, OutputJax: chtml});
    const node = html.convert(input || '', {
      display: !inline,
      em: chtmlContainer.em,
      ex: chtmlContainer.ex,
      containerWidth: chtmlContainer.width
    });
    
    if (chtmlContainer.css) {
      return adaptor.textContent(chtml.styleSheet(html));
    } else {
      return adaptor.outerHTML(node);
    }
  }
  
}
