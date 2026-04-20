#! /usr/bin/env node

const {AllPackages} = require('mathjax-full/js/input/tex/AllPackages.js');

export function normalizeTeXOptions(texOptions) {
  const options = {...texOptions};
  const loadPackages = options.loadPackages || [];
  options.packages = AllPackages.filter((name) => (loadPackages.includes(name) || (name === 'base')));
  delete options.loadPackages;

  if (typeof options.digits === 'string' && options.digits.length > 0) {
    options.digits = new RegExp(options.digits);
  }

  return options;
}
