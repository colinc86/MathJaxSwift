#! /usr/bin/env -S node -r esm

function convertAsync(input) {
  return new Promise((resolve, reject) => {
    require('mathjax').init({
      loader: {load: ['input/tex', 'output/svg']}
    }).then((MathJax) => {
      const svg = MathJax.tex2svg(input, {display: true});
      resolve(MathJax.startup.adaptor.outerHTML(svg));
    }).catch((err) => reject(err.message) );
  });
}

function convertSync(input) {
  return require('synchronized-promise')(convertAsync)(input);
}

//let output = convertSync('\\frac{1}{x^2-1}');
//console.log(output);
