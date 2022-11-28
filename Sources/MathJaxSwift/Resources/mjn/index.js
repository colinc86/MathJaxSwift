#! /usr/bin/env node

const {mathjax} = require('mathjax-full/js/mathjax.js');
const {TeX} = require('mathjax-full/js/input/tex.js');
const {SVG} = require('mathjax-full/js/output/svg.js');
const {liteAdaptor} = require('mathjax-full/js/adaptors/liteAdaptor.js');
const {RegisterHTMLHandler} = require('mathjax-full/js/handlers/html.js');
const {AssistiveMmlHandler} = require('mathjax-full/js/a11y/assistive-mml.js');
const {AllPackages} = require('mathjax-full/js/input/tex/AllPackages.js');

const PACKAGES = AllPackages.sort().join(', ');
const CSS = [
  'svg a{fill:blue;stroke:blue}',
  '[data-mml-node="merror"]>g{fill:red;stroke:red}',
  '[data-mml-node="merror"]>rect[data-background]{fill:yellow;stroke:none}',
  '[data-frame],[data-line]{stroke-width:70px;fill:none}',
  '.mjx-dashed{stroke-dasharray:140}',
  '.mjx-dotted{stroke-linecap:round;stroke-dasharray:0,140}',
  'use[data-c]{stroke-width:3px}'
].join('');

export class Converter {
  
  static tex2svg(input, inline = false, em = 16, ex = 8, width = 80 * 16, css = false, styles = true, container = false, fontCache = true, assistiveMml = false) {
    //  Create DOM adaptor and register it for HTML documents
    const adaptor = liteAdaptor();
    const handler = RegisterHTMLHandler(adaptor);
    if (assistiveMml) AssistiveMmlHandler(handler);
    
    //  Create input and output jax and a document using them on the content from the HTML file
    const tex = new TeX({packages: PACKAGES.split(/\s*,\s*/)});
    const svg = new SVG({fontCache: (fontCache ? 'local' : 'none')});
    const html = mathjax.document('', {InputJax: tex, OutputJax: svg});
    
    //  Typeset the math from the command line
    const node = html.convert(input || '', {
      display: !inline,
      em: em,
      ex: ex,
      containerWidth: width
    });
    
    // Typeset the math and output the HTML
    if (css) {
      return adaptor.textContent(svg.styleSheet(html));
    } else {
      let html = (container ? adaptor.outerHTML(node) : adaptor.innerHTML(node));
      return styles ? html.replace(/<defs>/, `<defs><style>${CSS}</style>`) : html;
    }
  }
  
}
