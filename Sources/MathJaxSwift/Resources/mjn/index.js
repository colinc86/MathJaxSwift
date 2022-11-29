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
  
  static tex2svg(input, inline, em, ex, width, css, styles, container, assistiveMml, svgConfig) {
    const adaptor = liteAdaptor();
    const handler = RegisterHTMLHandler(adaptor);
    if (assistiveMml) AssistiveMmlHandler(handler);
    const tex = new TeX({packages: PACKAGES.split(/\s*,\s*/)});
    const svg = new SVG(JSON.parse(svgConfig));
    const html = mathjax.document('', {InputJax: tex, OutputJax: svg});
    const node = html.convert(input || '', {
      display: !inline,
      em: em,
      ex: ex,
      containerWidth: width
    });
    
    if (css) {
      return adaptor.textContent(svg.styleSheet(html));
    } else {
      let html = (container ? adaptor.outerHTML(node) : adaptor.innerHTML(node));
      return styles ? html.replace(/<defs>/, `<defs><style>${CSS}</style>`) : html;
    }
  }
  
  static tex2chtml(input, inline, em, ex, width, css, assistiveMml, chtmlConfig) {
    const adaptor = liteAdaptor();
    const handler = RegisterHTMLHandler(adaptor);
    if (assistiveMml) AssistiveMmlHandler(handler);
    const tex = new TeX({packages: PACKAGES.split(/\s*,\s*/)});
    const chtml = new CHTML(JSON.parse(chtmlConfig));
    const html = mathjax.document('', {InputJax: tex, OutputJax: chtml});
    const node = html.convert(input || '', {
      display: !inline,
      em: em,
      ex: ex,
      containerWidth: width
    });

    if (css) {
      return adaptor.textContent(chtml.styleSheet(html));
    } else {
      return adaptor.outerHTML(node);
    }
  }
  
  static tex2mml(input, inline) {
    const tex = new TeX({packages: FILTERED_PACKAGES.split(/\s*,\s*/)});
    const html = new HTMLDocument('', liteAdaptor(), {InputJax: tex});
    const visitor = new SerializedMmlVisitor();
    const toMathML = (node => visitor.visitTree(node, html));
    return toMathML(html.convert(input || '', {display: !inline, end: STATE.CONVERT}));
  }
  
}
