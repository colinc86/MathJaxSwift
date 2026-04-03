#!/usr/bin/env node

// Builds the speech bundle:
// 1. Bundle xmldom + wgxpath with webpack (they use CommonJS internal requires)
// 2. Concatenate with SRE's pre-built lib/sre.js and our wrapper

const fs = require('fs');
const path = require('path');
const webpack = require('webpack');

const outPath = path.join(__dirname, 'dist', 'speech.bundle.js');

// Step 1: Bundle xmldom + wgxpath with webpack
const depsEntryPath = path.join(__dirname, 'dist', '_speech_deps_entry.js');
fs.writeFileSync(depsEntryPath, `
  module.exports = {
    xmldom: require('@xmldom/xmldom'),
    wgxpath: require('wicked-good-xpath')
  };
`);

const compiler = webpack({
  entry: depsEntryPath,
  output: {
    path: path.join(__dirname, 'dist'),
    filename: '_speech_deps.js',
    library: '_speechDeps',
    libraryTarget: 'var'
  },
  mode: 'production'
});

compiler.run((err, stats) => {
  if (err) { console.error(err); process.exit(1); }
  if (stats.hasErrors()) { console.error(stats.compilation.errors); process.exit(1); }

  const depsContent = fs.readFileSync(path.join(__dirname, 'dist', '_speech_deps.js'), 'utf8');
  const sreContent = fs.readFileSync(require.resolve('speech-rule-engine/lib/sre.js'), 'utf8');

  // Read mathmaps JSON that SRE needs during init
  const baseJson = fs.readFileSync(require.resolve('speech-rule-engine/lib/mathmaps/base.json'), 'utf8');
  const enJson = fs.readFileSync(require.resolve('speech-rule-engine/lib/mathmaps/en.json'), 'utf8');
  // Also load other common locales
  const deJson = fs.readFileSync(require.resolve('speech-rule-engine/lib/mathmaps/de.json'), 'utf8');
  const frJson = fs.readFileSync(require.resolve('speech-rule-engine/lib/mathmaps/fr.json'), 'utf8');
  const esJson = fs.readFileSync(require.resolve('speech-rule-engine/lib/mathmaps/es.json'), 'utf8');

  const bundle = `// Speech bundle for MathJaxSwift - MathML to speech via SRE
// Polyfills for JSContext
if (typeof process === 'undefined') { var process = {env:{}}; }
if (typeof global === 'undefined') { var global = (typeof globalThis !== 'undefined') ? globalThis : this; }

// Timer polyfill with deferred queue - SRE uses setTimeout to sequence initialization
var _timerQueue = [];
var _timerCounter = 1;
if (typeof setTimeout === 'undefined') {
  var setTimeout = function(fn, ms) { var id = _timerCounter++; _timerQueue.push({id:id, fn:fn}); return id; };
}
if (typeof clearTimeout === 'undefined') { var clearTimeout = function(id) { _timerQueue = _timerQueue.filter(function(t){ return t.id !== id; }); }; }
if (typeof setInterval === 'undefined') { var setInterval = function(fn, ms) { fn(); return 0; }; }
if (typeof clearInterval === 'undefined') { var clearInterval = function() {}; }

// Flush function - processes all queued timer callbacks
function _flushTimers() {
  var maxIter = 1000;
  while (_timerQueue.length > 0 && maxIter-- > 0) {
    var batch = _timerQueue.splice(0);
    for (var i = 0; i < batch.length; i++) { try { batch[i].fn(); } catch(e) {} }
  }
}

// Dependencies (xmldom, wgxpath) - webpack-bundled
${depsContent}

// Inline mathmaps data for SRE's fs.readFileSync calls
var _mathmaps = {};
_mathmaps['base.json'] = ${JSON.stringify(baseJson)};
_mathmaps['en.json'] = ${JSON.stringify(enJson)};
_mathmaps['de.json'] = ${JSON.stringify(deJson)};
_mathmaps['fr.json'] = ${JSON.stringify(frJson)};
_mathmaps['es.json'] = ${JSON.stringify(esJson)};

// fs polyfill that serves mathmaps from inline data
var _fsPolyfill = {
  readFileSync: function(path, encoding) {
    for (var key in _mathmaps) {
      if (path.indexOf(key) !== -1) return _mathmaps[key];
    }
    return '';
  },
  readFile: function(path, encoding, cb) {
    var result = _fsPolyfill.readFileSync(path, encoding);
    if (typeof cb === 'function') cb(null, result);
    else if (typeof encoding === 'function') encoding(null, result);
  },
  existsSync: function() { return false; },
  readdirSync: function() { return []; }
};

// Require shim for SRE's eval("require")
var require = (function() {
  var d = (typeof _speechDeps !== 'undefined') ? _speechDeps : {};
  var cache = {
    '@xmldom/xmldom': d.xmldom || null,
    'wicked-good-xpath': d.wgxpath || null,
    'fs': _fsPolyfill,
    'commander': {Command:function(){var c={};c.option=function(){return c};c.parse=function(){return c};c.opts=function(){return {}};return c}}
  };
  return function(n) { return cache[n] !== undefined ? cache[n] : null; };
})();
require.resolve = function(n) { return n; };

// SRE (self-contained UMD bundle with inline locale data)
${sreContent}

// Flush any deferred timer callbacks from SRE init
_flushTimers();

// Speech Converter wrapper
var speech = (function() {
  var sre = (typeof SRE !== 'undefined') ? SRE : null;

  var _ready = false;
  var _error = null;

  if (sre) {
    try {
      sre.setupEngine({locale: 'en', domain: 'mathspeak', modality: 'speech'});
      sre.engineReady().then(function() { _ready = true; }).catch(function(e) { _error = e ? (e.message || String(e)) : 'unknown'; });
    } catch(e) {
      _error = 'Init error: ' + (e.message || e);
    }
  } else {
    _error = 'SRE not loaded';
  }

  return {
    SpeechConverter: {
      isReady: function() { return _ready; },
      getError: function() { return _error; },
      getDebug: function() { try { return JSON.stringify(sre.engineSetup()); } catch(e) { return 'error: ' + e.message; } },
      configure: function(locale, domain, style) {
        _ready = false; _error = null;
        sre.setupEngine({ locale: locale || 'en', domain: domain || 'mathspeak', style: style || 'default', modality: 'speech' });
        sre.engineReady().then(function() { _ready = true; }).catch(function(e) { _error = e ? (e.message || String(e)) : 'unknown'; });
      },
      toSpeech: function(input) {
        var output = [];
        for (var i = 0; i < input.length; i++) {
          try { output.push(sre.toSpeech(input[i])); }
          catch(e) { output.push('ERROR: ' + (e.message || e)); }
        }
        return output;
      }
    }
  };
})();
`;

  fs.writeFileSync(outPath, bundle);
  console.log('Speech bundle written to', outPath, '(' + (bundle.length / 1024).toFixed(0) + ' KB)');

  // Cleanup
  try { fs.unlinkSync(depsEntryPath); } catch(e) {}
  try { fs.unlinkSync(path.join(__dirname, 'dist', '_speech_deps.js')); } catch(e) {}
  try { fs.unlinkSync(path.join(__dirname, 'dist', '_speech_deps.js.LICENSE.txt')); } catch(e) {}
});
