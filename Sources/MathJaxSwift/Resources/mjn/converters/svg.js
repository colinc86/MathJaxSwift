#! /usr/bin/env node

const {mathjax} = require('@mathjax/src/js/mathjax.js');
const {SVG} = require('@mathjax/src/js/output/svg.js');
const {liteAdaptor} = require('@mathjax/src/js/adaptors/liteAdaptor.js');
const {RegisterHTMLHandler} = require('@mathjax/src/js/handlers/html.js');
const {AssistiveMmlHandler} = require('@mathjax/src/js/a11y/assistive-mml.js');

const {MathML} = require('@mathjax/src/js/input/mathml.js');
const {TeX} = require('@mathjax/src/js/input/tex.js');

// Font data (MJ4 requires explicit font configuration)
const {MathJaxNewcmFont} = require('@mathjax/mathjax-newcm-font/cjs/svg.js');

const {AsciiMath} = require('@mathjax/src/js/input/asciimath.js');

// Register all TeX extensions so webpack bundles them (replaces AllPackages)
require('@mathjax/src/js/input/tex/action/ActionConfiguration.js');
require('@mathjax/src/js/input/tex/ams/AmsConfiguration.js');
require('@mathjax/src/js/input/tex/amscd/AmsCdConfiguration.js');
require('@mathjax/src/js/input/tex/autoload/AutoloadConfiguration.js');
require('@mathjax/src/js/input/tex/base/BaseConfiguration.js');
require('@mathjax/src/js/input/tex/bbm/BbmConfiguration.js');
require('@mathjax/src/js/input/tex/bboldx/BboldxConfiguration.js');
require('@mathjax/src/js/input/tex/bbox/BboxConfiguration.js');
require('@mathjax/src/js/input/tex/begingroup/BegingroupConfiguration.js');
require('@mathjax/src/js/input/tex/boldsymbol/BoldsymbolConfiguration.js');
require('@mathjax/src/js/input/tex/braket/BraketConfiguration.js');
require('@mathjax/src/js/input/tex/bussproofs/BussproofsConfiguration.js');
require('@mathjax/src/js/input/tex/cancel/CancelConfiguration.js');
require('@mathjax/src/js/input/tex/cases/CasesConfiguration.js');
require('@mathjax/src/js/input/tex/centernot/CenternotConfiguration.js');
require('@mathjax/src/js/input/tex/color/ColorConfiguration.js');
require('@mathjax/src/js/input/tex/colortbl/ColortblConfiguration.js');
require('@mathjax/src/js/input/tex/colorv2/ColorV2Configuration.js');
require('@mathjax/src/js/input/tex/configmacros/ConfigMacrosConfiguration.js');
require('@mathjax/src/js/input/tex/dsfont/DsfontConfiguration.js');
require('@mathjax/src/js/input/tex/empheq/EmpheqConfiguration.js');
require('@mathjax/src/js/input/tex/enclose/EncloseConfiguration.js');
require('@mathjax/src/js/input/tex/extpfeil/ExtpfeilConfiguration.js');
require('@mathjax/src/js/input/tex/gensymb/GensymbConfiguration.js');
require('@mathjax/src/js/input/tex/html/HtmlConfiguration.js');
require('@mathjax/src/js/input/tex/mathtools/MathtoolsConfiguration.js');
require('@mathjax/src/js/input/tex/mhchem/MhchemConfiguration.js');
require('@mathjax/src/js/input/tex/newcommand/NewcommandConfiguration.js');
require('@mathjax/src/js/input/tex/noerrors/NoErrorsConfiguration.js');
require('@mathjax/src/js/input/tex/noundefined/NoUndefinedConfiguration.js');
require('@mathjax/src/js/input/tex/physics/PhysicsConfiguration.js');
require('@mathjax/src/js/input/tex/require/RequireConfiguration.js');
require('@mathjax/src/js/input/tex/setoptions/SetOptionsConfiguration.js');
require('@mathjax/src/js/input/tex/tagformat/TagFormatConfiguration.js');
require('@mathjax/src/js/input/tex/texhtml/TexHtmlConfiguration.js');
require('@mathjax/src/js/input/tex/textcomp/TextcompConfiguration.js');
require('@mathjax/src/js/input/tex/textmacros/TextMacrosConfiguration.js');
require('@mathjax/src/js/input/tex/unicode/UnicodeConfiguration.js');
require('@mathjax/src/js/input/tex/units/UnitsConfiguration.js');
require('@mathjax/src/js/input/tex/upgreek/UpgreekConfiguration.js');
require('@mathjax/src/js/input/tex/verb/VerbConfiguration.js');

const {loadDynamicFonts} = require('./dynamicFonts.js');

function buildCSS(blacker) {
  return [
    'svg a{fill:blue;stroke:blue}',
    '[data-mml-node="merror"]>g{fill:red;stroke:red}',
    '[data-mml-node="merror"]>rect[data-background]{fill:yellow;stroke:none}',
    '[data-frame],[data-line]{stroke-width:70px;fill:none}',
    '.mjx-dashed{stroke-dasharray:140}',
    '.mjx-dotted{stroke-linecap:round;stroke-dasharray:0,140}',
    'use[data-c]{stroke-width:' + (blacker || 3) + 'px}'
  ].join('');
}

/**
 * Converts TeX, MathML, and AsciiMath input to SVG.
 */
module.exports = { SVGConverter: class SVGConverter {

  static tex2svg(input, css, assistiveMml, container, styles, conversionOptions, documentOptions, texOptions, svgOptions) {
    var loadPackages = texOptions.loadPackages || ['base'];
    delete texOptions.loadPackages;
    texOptions.packages = loadPackages;
    const tex = new TeX(texOptions);
    var output = [];
    for (let i = 0; i < input.length; i++) {
      output.push(SVGConverter.createSVG(input[i], tex, css, assistiveMml, container, styles, conversionOptions, documentOptions, svgOptions));
    }
    return output;
  }

  static mml2svg(input, css, assistiveMml, container, styles, conversionOptions, documentOptions, mathmlOptions, svgOptions) {
    const mml = new MathML(mathmlOptions);
    var output = [];
    for (let i = 0; i < input.length; i++) {
      output.push(SVGConverter.createSVG(input[i], mml, css, assistiveMml, container, styles, conversionOptions, documentOptions, svgOptions));
    }
    return output;
  }

  static am2svg(input, css, assistiveMml, container, styles, conversionOptions, documentOptions, asciimathOptions, svgOptions) {
    const asciimath = new AsciiMath(asciimathOptions);
    var output = [];
    for (let i = 0; i < input.length; i++) {
      output.push(SVGConverter.createSVG(input[i], asciimath, css, assistiveMml, container, styles, conversionOptions, documentOptions, svgOptions));
    }
    return output;
  }

  static am2mml(input, conversionOptions, documentOptions, asciimathOptions) {
    const {SerializedMmlVisitor} = require('@mathjax/src/js/core/MmlTree/SerializedMmlVisitor.js');
    const {STATE} = require('@mathjax/src/js/core/MathItem.js');
    const asciimath = new AsciiMath(asciimathOptions);
    conversionOptions.end = STATE.CONVERT;
    documentOptions.InputJax = asciimath;
    const adaptor = liteAdaptor();
    RegisterHTMLHandler(adaptor);
    const html = mathjax.document('', documentOptions);
    const visitor = new SerializedMmlVisitor();
    var output = [];
    for (let i = 0; i < input.length; i++) {
      const node = html.convert(input[i] || '', conversionOptions);
      output.push(visitor.visitTree(node, html));
    }
    return output;
  }

  static createSVG(input, inputJax, css, assistiveMml, container, styles, conversionOptions, documentOptions, svgOptions) {
    const adaptor = liteAdaptor();
    const handler = RegisterHTMLHandler(adaptor);

    if (assistiveMml) AssistiveMmlHandler(handler);
    documentOptions.InputJax = inputJax;
    const outputJax = new SVG({...svgOptions, fontData: MathJaxNewcmFont});
    loadDynamicFonts(outputJax);
    documentOptions.OutputJax = outputJax;

    const html = mathjax.document('', documentOptions);
    const node = html.convert(input || '', conversionOptions);

    if (css) {
      return adaptor.textContent(outputJax.styleSheet(html));
    } else {
      let html = (container ? adaptor.outerHTML(node) : adaptor.innerHTML(node));
      return styles ? html.replace(/<defs>/, `<defs><style>${buildCSS(svgOptions.blacker)}</style>`) : html;
    }
  }

}};

