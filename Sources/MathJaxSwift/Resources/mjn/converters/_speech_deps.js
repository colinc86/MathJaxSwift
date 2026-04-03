
var xmldom = require('@xmldom/xmldom');
var wgxpath = require('wicked-good-xpath');

// Export to global scope for SRE's eval("require") to find
var _mc = {
  '@xmldom/xmldom': xmldom,
  'wicked-good-xpath': wgxpath,
  'fs': null,
  'commander': {Command:function(){var c={};c.option=function(){return c};c.parse=function(){return c};c.opts=function(){return {}};return c}}
};

if (typeof globalThis !== 'undefined') {
  globalThis.__speechDeps = _mc;
} else {
  this.__speechDeps = _mc;
}
