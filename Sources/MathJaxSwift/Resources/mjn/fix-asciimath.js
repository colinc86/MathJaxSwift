#!/usr/bin/env node

// Post-build fix for MJ4 AsciiMath/webpack compatibility.
//
// MJ4's AsciiMath legacy shim.js does:
//   MathJax = Object.assign(global.MathJax||{}, require('./MathJax.js').MathJax)
//
// In webpack, this 'MathJax' variable becomes local to the shim's module
// wrapper. The legacy jax.js accesses 'MathJax.HTML.getScript' as a free
// variable, but in webpack's module system it resolves to a different scope
// where HTML isn't set.
//
// Fix: after the shim's Object.assign, explicitly copy HTML from the legacy
// MathJax module onto the local MathJax variable.

const fs = require('fs');
const path = require('path');

const bundles = ['chtml.bundle.js', 'mml.bundle.js', 'svg.bundle.js'];

for (const name of bundles) {
  const filePath = path.join(__dirname, 'dist', name);
  if (!fs.existsSync(filePath)) continue;

  let content = fs.readFileSync(filePath, 'utf8');

  // Match: MathJax=Object.assign(X.g.MathJax||{},X(NNNN).Y)
  // where X is the webpack require function, Y is the export name (may be minified)
  const pattern = /MathJax=Object\.assign\((\w+)\.g\.MathJax\|\|\{\},\1\((\d+)\)\.(\w+)\)/;
  const match = content.match(pattern);

  if (match) {
    const requireFn = match[1];
    const moduleId = match[2];
    const exportName = match[3];
    // Set HTML on the local MathJax AND propagate to webpack's global so that
    // jax.js (which accesses MathJax from the global scope) can find it.
    const replacement = match[0] +
      `,MathJax.HTML=MathJax.HTML||${requireFn}(${moduleId}).${exportName}.HTML` +
      `,${requireFn}.g.MathJax=MathJax`;
    content = content.replace(match[0], replacement);
    fs.writeFileSync(filePath, content);
    console.log(`Fixed AsciiMath in ${name} (module ${moduleId})`);
  } else {
    console.log(`No AsciiMath shim found in ${name} (skipped)`);
  }
}
