#! /usr/bin/env node

const {mathjax} = require('mathjax-full/js/mathjax.js');
const {SVG} = require('mathjax-full/js/output/svg.js');
const {liteAdaptor} = require('mathjax-full/js/adaptors/liteAdaptor.js');
const {RegisterHTMLHandler} = require('mathjax-full/js/handlers/html.js');
const {AssistiveMmlHandler} = require('mathjax-full/js/a11y/assistive-mml.js');

const {MathML} = require('mathjax-full/js/input/mathml.js');
const {TeX} = require('mathjax-full/js/input/tex.js');

const {AllPackages} = require('mathjax-full/js/input/tex/AllPackages.js');

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
 * Converts TeX and MathML input to SVG.
 */
export class SVGConverter {
  
  /**
   * Converts a TeX input string to SVG.
   *
   * @param {string} input The TeX input strings.
   * @param {boolean} css Whether the documents CSS should be output.
   * @param {boolean} assistiveMml Whether to include assistive MathML output.
   * @param {boolean} container Whether the document's outer HTML should be returned.
   * @param {boolean} styles Whether CSS styles should be included.
   * @param {object} conversionOptions The MathJax conversion options.
   * @param {object} documentOptions The math document options.
   * @param {object} texOptions The TeX input options.
   * @param {object} svgOptions The SVG output configuration.
   * @return {string} The SVG formatted strings.
   */
  static tex2svg(input, css, assistiveMml, container, styles, conversionOptions, documentOptions, texOptions, svgOptions) {
    texOptions.packages = AllPackages.filter((name) => (texOptions.loadPackages.includes(name) || (name === 'base')));
    const tex = new TeX(texOptions);
    var output = [];
    for (let i = 0; i < input.length; i++) {
      output.push(SVGConverter.createSVG(input[i], tex, css, assistiveMml, container, styles, conversionOptions, documentOptions, svgOptions));
    }
    return output;
  }
  
  /**
   * Converts a MathML input string to SVG.
   *
   * @param {string} input The MathML input string.
   * @param {boolean} css Whether the documents CSS should be output.
   * @param {boolean} assistiveMml Whether to include assistive MathML output.
   * @param {boolean} container Whether the document's outer HTML should be returned.
   * @param {boolean} styles Whether CSS styles should be included.
   * @param {object} conversionOptions The MathJax conversion options.
   * @param {object} documentOptions The math document options.
   * @param {object} mathmlOptions The MathML input options.
   * @param {object} svgOptions The SVG output configuration.
   * @return {string} The SVG formatted string.
   */
  static mml2svg(input, css, assistiveMml, container, styles, conversionOptions, documentOptions, mathmlOptions, svgOptions) {
    const mml = new MathML(mathmlOptions);
    var output = [];
    for (let i = 0; i < input.length; i++) {
      output.push(SVGConverter.createSVG(input[i], mml, css, assistiveMml, container, styles, conversionOptions, documentOptions, svgOptions));
    }
    return output;
  }
  
  /**
   * Creates SVG data from an input string.
   *
   * @param {string} input The input string.
   * @param {object} inputJax The InputJax object.
   * @param {boolean} css Whether the documents CSS should be output.
   * @param {boolean} assistiveMml Whether to include assistive MathML output.
   * @param {boolean} container Whether the document's outer HTML should be returned.
   * @param {boolean} styles Whether CSS styles should be included.
   * @param {object} conversionOptions The MathJax conversion options.
   * @param {object} documentOptions The math document options.
   * @param {object} svgOptions The SVG output configuration.
   * @return {string} The SVG formatted string.
   */
  static createSVG(input, inputJax, css, assistiveMml, container, styles, conversionOptions, documentOptions, svgOptions) {
    const adaptor = liteAdaptor();
    const handler = RegisterHTMLHandler(adaptor);
    
    if (assistiveMml) AssistiveMmlHandler(handler);
    documentOptions.InputJax = inputJax;
    documentOptions.OutputJax = new SVG(svgOptions);
    
    const html = mathjax.document('', documentOptions);
    const node = html.convert(input || '', conversionOptions);
    
    if (css) {
      return adaptor.textContent(svg.styleSheet(html));
    } else {
      let html = (container ? adaptor.outerHTML(node) : adaptor.innerHTML(node));
      return styles ? html.replace(/<defs>/, `<defs><style>${CSS}</style>`) : html;
    }
  }
  
}
