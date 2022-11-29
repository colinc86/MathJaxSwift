#! /usr/bin/env node

const {mathjax} = require('mathjax-full/js/mathjax.js');
const {TeX} = require('mathjax-full/js/input/tex.js');
const {SVG} = require('mathjax-full/js/output/svg.js');
const {CHTML} = require('mathjax-full/js/output/chtml.js');
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
  
  static tex2chtml(input, inline = false, em = 16, ex = 8, width = 80 * 16, css = false, assistiveMml = false, fontURL = 'https://cdn.jsdelivr.net/npm/mathjax@3/es5/output/chtml/fonts/woff-v2') {
    //  Create DOM adaptor and register it for HTML documents
    const adaptor = liteAdaptor();
    const handler = RegisterHTMLHandler(adaptor);
    if (assistiveMml) AssistiveMmlHandler(handler);
    
    //  Create input and output jax and a document using them on the content from the HTML file
    const tex = new TeX({packages: PACKAGES.split(/\s*,\s*/)});
    const chtml = new CHTML({fontURL: fontURL});
    const html = mathjax.document('', {InputJax: tex, OutputJax: chtml});
    
    //  Typeset the math from the command line
    const node = html.convert(input || '', {
      display: !inline,
      em: em,
      ex: ex,
      containerWidth: width
    });
    
    //  If the --css option was specified, output the CSS,
    //  Otherwise, typeset the math and output the HTML
    if (css) {
      return adaptor.textContent(chtml.styleSheet(html));
    } else {
      return adaptor.outerHTML(node);
    }
  }
  
  static tex2mml(input, inline = false) {
    //  Create the input jax
    const tex = new TeX({packages: FILTERED_PACKAGES.split(/\s*,\s*/)});
    
    //  Create an HTML document using a LiteDocument and the input jax
    const html = new HTMLDocument('', liteAdaptor(), {InputJax: tex});
    
    //  Create a MathML serializer
    const visitor = new SerializedMmlVisitor();
    const toMathML = (node => visitor.visitTree(node, html));
    
    //  Convert the math from the command line to serialzied MathML
    return toMathML(html.convert(input || '', {display: !inline, end: STATE.CONVERT}));
  }
  
}
