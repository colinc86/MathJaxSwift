#! /usr/bin/env node

const {mathjax} = require('@mathjax/src/js/mathjax.js');
const {CHTML} = require('@mathjax/src/js/output/chtml.js');
const {liteAdaptor} = require('@mathjax/src/js/adaptors/liteAdaptor.js');
const {RegisterHTMLHandler} = require('@mathjax/src/js/handlers/html.js');
const {AssistiveMmlHandler} = require('@mathjax/src/js/a11y/assistive-mml.js');

const {MathML} = require('@mathjax/src/js/input/mathml.js');
const {TeX} = require('@mathjax/src/js/input/tex.js');

// Font data (MJ4 requires explicit font configuration)
const {MathJaxNewcmFont} = require('@mathjax/mathjax-newcm-font/cjs/chtml.js');

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

/**
 * Converts TeX, MathML, and AsciiMath input to CommonHTML.
 */
module.exports = { CommonHTMLConverter: class CommonHTMLConverter {

  static tex2chtml(input, css, assistiveMml, conversionOptions, documentOptions, texOptions, chtmlOptions) {
    var loadPackages = texOptions.loadPackages || ['base'];
    delete texOptions.loadPackages;
    texOptions.packages = loadPackages;
    const tex = new TeX(texOptions);
    var output = [];
    for (let i = 0; i < input.length; i++) {
      output.push(CommonHTMLConverter.createCHTML(input[i], tex, css, assistiveMml, conversionOptions, documentOptions, chtmlOptions));
    }
    return output;
  }

  static mml2chtml(input, css, assistiveMml, conversionOptions, documentOptions, mathmlOptions, chtmlOptions) {
    const mml = new MathML(mathmlOptions);
    var output = [];
    for (let i = 0; i < input.length; i++) {
      output.push(CommonHTMLConverter.createCHTML(input[i], mml, css, assistiveMml, conversionOptions, documentOptions, chtmlOptions));
    }
    return output;
  }

  static am2chtml(input, css, assistiveMml, conversionOptions, documentOptions, asciimathOptions, chtmlOptions) {
    const asciimath = new AsciiMath(asciimathOptions);
    var output = [];
    for (let i = 0; i < input.length; i++) {
      output.push(CommonHTMLConverter.createCHTML(input[i], asciimath, css, assistiveMml, conversionOptions, documentOptions, chtmlOptions));
    }
    return output;
  }

  static createCHTML(input, inputJax, css, assistiveMml, conversionOptions, documentOptions, chtmlOptions) {
    const adaptor = liteAdaptor();
    const handler = RegisterHTMLHandler(adaptor);

    if (assistiveMml) AssistiveMmlHandler(handler);
    documentOptions.InputJax = inputJax;
    const outputJax = new CHTML({...chtmlOptions, fontData: MathJaxNewcmFont});
    loadDynamicFonts(outputJax);
    documentOptions.OutputJax = outputJax;

    const html = mathjax.document('', documentOptions);
    const node = html.convert(input || '', conversionOptions);

    if (css) {
      return adaptor.textContent(outputJax.styleSheet(html));
    } else {
      return adaptor.outerHTML(node);
    }
  }

}};

