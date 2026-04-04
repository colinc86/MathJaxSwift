#! /usr/bin/env node

// AsciiMath's legacy jax.js creates its MathJax object via:
//   MathJax = Object.assign(globalThis.MathJax||{}, require('...MathJax.js').MathJax)
// The HTML property is defined in MathJax.js, but jax.js accesses MathJax.HTML
// through this merged global copy. We need the legacy MathJax.js to load first
// so that its HTML property gets merged into the global copy.

const {mathjax} = require('@mathjax/src/js/mathjax.js');
const {liteAdaptor} = require('@mathjax/src/js/adaptors/liteAdaptor.js');
const {RegisterHTMLHandler} = require('@mathjax/src/js/handlers/html.js');
const {SerializedMmlVisitor} = require('@mathjax/src/js/core/MmlTree/SerializedMmlVisitor.js');
const {STATE} = require('@mathjax/src/js/core/MathItem.js');

const {TeX} = require('@mathjax/src/js/input/tex.js');
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

/**
 * Converts Tex and AsciiMath to MathML.
 */
module.exports = { MathMLConverter: class MathMLConverter {

  static tex2mml(input, conversionOptions, documentOptions, texOptions) {
    var loadPackages = texOptions.loadPackages || ['base'];
    delete texOptions.loadPackages;
    texOptions.packages = loadPackages;
    const tex = new TeX(texOptions);
    var output = [];
    for (let i = 0; i < input.length; i++) {
      output.push(MathMLConverter.createMML(input[i], tex, conversionOptions, documentOptions));
    }
    return output;
  }

  static am2mml(input, conversionOptions, documentOptions, asciimathOptions) {
    const asciimath = new AsciiMath(asciimathOptions);
    var output = [];
    for (let i = 0; i < input.length; i++) {
      output.push(MathMLConverter.createMML(input[i], asciimath, conversionOptions, documentOptions));
    }
    return output;
  }

  static createMML(input, inputJax, conversionOptions, documentOptions) {
    conversionOptions.end = STATE.CONVERT;
    documentOptions.InputJax = inputJax;

    const adaptor = liteAdaptor();
    RegisterHTMLHandler(adaptor);

    // Use mathjax.document() which properly initializes MathJax.HTML
    // (required by AsciiMath's legacy code)
    const html = mathjax.document('', documentOptions);
    const visitor = new SerializedMmlVisitor();
    const node = html.convert(input || '', conversionOptions);
    return visitor.visitTree(node, html);
  }

}};

