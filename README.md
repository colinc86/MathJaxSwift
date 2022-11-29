# MathJaxSwift

A SPM wrapper for the [MathJax](https://github.com/mathjax/MathJax) package.

## Installation

Add the dependency to your package manifest file.

```swift
.package(url: "https://github.com/colinc86/MathJaxSwift", from: "3.2.2")
```

## Usage

Import the package, create a `MathJax` instance, and convert some TeX.

```swift
import MathJaxSwift

do {
  let mathjax = try MathJax()
  let input = "Hello, \\TeX{}!"
  
  // Get SVG output
  let svg = try mathjax.tex2svg(input)
  
  // Get HTML output
  let html = try mathjax.tex2chtml(input)
  
  // Get MathML output
  let mathml = try mathjax.tex2mml(input)
}
catch {
  print("MathJax error: \(error)")
}
```

Each of the conversion methods are also available with `async` implementations.

To check the `mathjax-full` npm module's package information that the Swift package is using, use the static `metadata() throws` method.

```swift
do {
  let metadata = try MathJax.metadata()
  print(metadata.version)
}
catch {
  print("Error getting MathJax version: \(error)") 
}
```

### Notes

`MathJaxSwift` wraps the MathJax TeX conversion process in convenient JS methods [described here](https://github.com/mathjax/MathJax-demos-node/tree/master/direct) and exposes them to Swift through the `JavaScriptCore` framework.

To get around the limitations of the `JSContext` class, the package uses [Webpack](https://webpack.js.org) to create a bundle file that can be evaluated by the context. The wrapper methods, MathJax, and Webpack dependencies are bundled together in an npm module called `mjn`. After making modifications to `index.js`, it should be rebuilt with `npm run build` which will create the `mjn.bundle.js` file.
