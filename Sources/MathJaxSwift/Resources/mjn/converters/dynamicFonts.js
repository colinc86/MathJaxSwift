/**
 * Pre-loads all dynamic font files for both SVG and CHTML output.
 *
 * MathJax may lazy-load font data for characters outside the base set (e.g.,
 * accented Latin characters like umlauts). In a headless JSContext, the async
 * retry mechanism used for lazy loading doesn't work, so we set up a
 * synchronous loader and pre-load any available dynamic font files at bundle
 * time.
 */

const {mathjax} = require('@mathjax/src/js/mathjax.js');

// Pre-load all SVG dynamic font files (registers setup functions)
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/accents.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/accents-b-i.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/arabic.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/arrows.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/braille.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/braille-d.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/calligraphic.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/cherokee.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/cyrillic.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/cyrillic-ss.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/devanagari.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/double-struck.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/fraktur.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/greek.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/greek-ss.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/hebrew.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/latin.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/latin-b.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/latin-bi.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/latin-i.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/marrows.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/math.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/monospace.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/monospace-ex.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/monospace-l.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/mshapes.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/phonetics.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/phonetics-ss.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/PUA.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/sans-serif.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/sans-serif-b.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/sans-serif-bi.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/sans-serif-ex.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/sans-serif-i.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/sans-serif-r.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/script.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/shapes.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/symbols.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/symbols-b-i.js');
require('@mathjax/mathjax-newcm-font/cjs/svg/dynamic/variants.js');

// Pre-load all CHTML dynamic font files
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/accents.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/accents-b-i.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/arabic.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/arrows.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/braille.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/braille-d.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/calligraphic.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/cherokee.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/cyrillic.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/cyrillic-ss.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/devanagari.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/double-struck.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/fraktur.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/greek.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/greek-ss.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/hebrew.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/latin.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/latin-b.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/latin-bi.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/latin-i.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/marrows.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/math.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/monospace.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/monospace-ex.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/monospace-l.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/mshapes.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/phonetics.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/phonetics-ss.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/PUA.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/sans-serif.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/sans-serif-b.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/sans-serif-bi.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/sans-serif-ex.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/sans-serif-i.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/sans-serif-r.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/script.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/shapes.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/symbols.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/symbols-b-i.js');
require('@mathjax/mathjax-newcm-font/cjs/chtml/dynamic/variants.js');

// Set asyncLoad to a no-op since all files are loaded via webpack.
// MJ4 checks asyncIsSynchronous before calling loadDynamicFilesSync.
mathjax.asyncLoad = function(name) {};
mathjax.asyncIsSynchronous = true;

/**
 * Installs all pre-loaded dynamic font data into an output jax's font instance.
 *
 * @param {object} outputJax The MathJax output jax (SVG or CHTML).
 */
module.exports.loadDynamicFonts = function loadDynamicFonts(outputJax) {
  if (Object.keys(outputJax.font.constructor.dynamicFiles || {}).length > 0) {
    outputJax.font.loadDynamicFilesSync();
  }
};
