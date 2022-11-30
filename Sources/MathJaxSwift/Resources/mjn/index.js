#! /usr/bin/env node

const {mathjax} = require('mathjax-full/js/mathjax.js');
const {TeX} = require('mathjax-full/js/input/tex.js');
const {SVG} = require('mathjax-full/js/output/svg.js');
const {CHTML} = require('mathjax-full/js/output/chtml.js');
const {MathML} = require('mathjax-full/js/input/mathml.js');
const {AsciiMath} = require('mathjax-full/js/input/asciimath.js');
const {HTMLDocument} = require('mathjax-full/js/handlers/html/HTMLDocument.js');
const {liteAdaptor} = require('mathjax-full/js/adaptors/liteAdaptor.js');
const {STATE} = require('mathjax-full/js/core/MathItem.js');
const {RegisterHTMLHandler} = require('mathjax-full/js/handlers/html.js');
const {AssistiveMmlHandler} = require('mathjax-full/js/a11y/assistive-mml.js');
const {SerializedMmlVisitor} = require('mathjax-full/js/core/MmlTree/SerializedMmlVisitor.js');
const {AllPackages} = require('mathjax-full/js/input/tex/AllPackages.js');

const PACKAGES = AllPackages.sort().join(', ');
const FILTERED_PACKAGES = AllPackages.filter((name) => name !== 'bussproofs').sort().join(', ');

const CSS = [
  'svg a{fill:blue;stroke:blue}',
  '[data-mml-node="merror"]>g{fill:red;stroke:red}',
  '[data-mml-node="merror"]>rect[data-background]{fill:yellow;stroke:none}',
  '[data-frame],[data-line]{stroke-width:70px;fill:none}',
  '.mjx-dashed{stroke-dasharray:140}',
  '.mjx-dotted{stroke-linecap:round;stroke-dasharray:0,140}',
  'use[data-c]{stroke-width:3px}'
].join('');

/**
 * Converts TeX input strings to various output formats.
 */
export class Converter {
  
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
    return Converter.createCHTML(input, tex, inline, containerConfig, chtmlConfig);
  }
  
  /**
   * Converts a TeX input string to SVG.
   *
   * @param {string} input The TeX input string.
   * @param {boolean} inline Whether or not the TeX should be rendered inline.
   * @param {object} containerConfig The SVG container configuration.
   * @param {object} svgConfig The SVG output configuration.
   * @return {string} The SVG formatted string.
   */
  static tex2svg(input, inline, containerConfig, svgConfig) {
    const tex = new TeX({packages: PACKAGES.split(/\s*,\s*/)});
    return Converter.createSVG(input, tex, inline, containerConfig, svgConfig);
  }
  
  /**
   * Converts a TeX input string to MathML.
   *
   * @param {string} input The TeX input string.
   * @param {boolean} inline Whether or not the TeX should be rendered inline.
   * @return {string} The MathML formatted string.
   */
  static tex2mml(input, inline) {
    const tex = new TeX({packages: FILTERED_PACKAGES.split(/\s*,\s*/)});
    return Converter.createMML(input, tex, inline);
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
    return Converter.createCHTML(input, asciimath, inline, containerConfig, chtmlConfig);
  }
  
  /**
   * Converts an ASCIIMath input string to MathML.
   *
   * @param {string} input The ASCIIMath input string.
   * @param {boolean} inline Whether or not the ASCIIMath should be rendered inline.
   * @return {string} The MathML formatted string.
   */
  static am2mml(input, inline) {
    const asciimath = new AsciiMath();
    return Converter.createMML(input, asciimath, inline);
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
    return Converter.createCHTML(input, mml, inline, containerConfig, chtmlConfig);
  }
  
  /**
   * Converts a MathML input string to SVG.
   *
   * @param {string} input The MathML input string.
   * @param {boolean} inline Whether or not the MathML should be rendered inline.
   * @param {object} containerConfig The SVG container configuration.
   * @param {object} svgConfig The SVG output configuration.
   * @return {string} The SVG formatted string.
   */
  static mml2svg(input, inline, containerConfig, svgConfig) {
    const mml = new MathML();
    return Converter.createSVG(input, mml, inline, containerConfig, svgConfig);
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
  
  /**
   * Creates SVG data from an input string.
   *
   * @param {string} input The input string.
   * @param {object} inputJax The InputJax object.
   * @param {boolean} inline Whether or not the input should be rendered inline.
   * @param {object} containerConfig The SVG container configuration.
   * @param {object} svgConfig The SVG output configuration.
   * @return {string} The SVG formatted string.
   */
  static createSVG(input, inputJax, inline, containerConfig, svgConfig) {
    const svgContainer = JSON.parse(containerConfig);
    const adaptor = liteAdaptor();
    const handler = RegisterHTMLHandler(adaptor);
    if (svgContainer.assistiveMml) AssistiveMmlHandler(handler);
    const svg = new SVG(JSON.parse(svgConfig));
    const html = mathjax.document('', {InputJax: inputJax, OutputJax: svg});
    const node = html.convert(input || '', {
      display: !inline,
      em: svgContainer.em,
      ex: svgContainer.ex,
      containerWidth: svgContainer.width
    });
    
    if (svgContainer.css) {
      return adaptor.textContent(svg.styleSheet(html));
    } else {
      let html = (svgContainer.container ? adaptor.outerHTML(node) : adaptor.innerHTML(node));
      return svgContainer.styles ? html.replace(/<defs>/, `<defs><style>${CSS}</style>`) : html;
    }
  }
  
  /**
   * Creates MathML data from an input string.
   *
   * @param {string} input The input string.
   * @param {object} inputJax The InputJax object.
   * @param {boolean} inline Whether or not the input should be rendered inline.
   * @return {string} The MathML formatted string.
   */
  static createMML(input, inputJax, inline) {
    const html = new HTMLDocument('', liteAdaptor(), {InputJax: inputJax});
    const visitor = new SerializedMmlVisitor();
    const toMathML = (node => visitor.visitTree(node, html));
    return toMathML(html.convert(input || '', {display: !inline, end: STATE.CONVERT}));
  }
  
}
