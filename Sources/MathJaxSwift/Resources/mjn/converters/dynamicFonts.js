/**
 * Pre-loads all dynamic font files for both SVG and CHTML output.
 *
 * MathJax may lazy-load font data for characters outside the base set (e.g.,
 * accented Latin characters like umlauts). In a headless JSContext, the async
 * retry mechanism used for lazy loading doesn't work, so we set up a
 * synchronous loader and pre-load any available dynamic font files at bundle
 * time.
 */

const {mathjax} = require('mathjax-full/js/mathjax.js');

// Set asyncLoad to a no-op since all files are loaded via webpack
mathjax.asyncLoad = function(name) {};

/**
 * Installs all pre-loaded dynamic font data into an output jax's font instance.
 *
 * @param {object} outputJax The MathJax output jax (SVG or CHTML).
 */
export function loadDynamicFonts(outputJax) {
  if (Object.keys(outputJax.font.constructor.dynamicFiles || {}).length > 0) {
    outputJax.font.loadDynamicFilesSync();
  }
}
