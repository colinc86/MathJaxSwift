# MathJaxSwift

[![Tests](https://github.com/colinc86/MathJaxSwift/actions/workflows/swift.yml/badge.svg)](https://github.com/colinc86/MathJaxSwift/actions/workflows/swift.yml)

A Swift wrapper for the [MathJax](https://github.com/mathjax/MathJax) component library.

## Installation

Add the dependency to your package manifest file.

```swift
.package(url: "https://github.com/colinc86/MathJaxSwift", from: "3.2.2")
```

## Usage

Import the package, create a `MathJax` instance, and convert an input string to a supported output format.

```swift
import MathJaxSwift

do {
  let mathjax = try MathJax()
  let svg = try mathjax.tex2svg("\\text{Hello}, \\TeX{}!")
}
catch {
  print("MathJax error: \(error)")
}
```

The example above converts the TeX input to SVG data that renders to

![Hello, TeX!](/assets/images/hello_tex.png)

### Conversion Methods

`MathJaxSwift` implements the following conversion methods.

- [x] `tex2svg` - convert TeX to SVG
- [x] `tex2chtml` - convert TeX to HTML
- [x] `tex2mml` - convert TeX to MathML
- [x] `mml2svg` - convert MathML to SVG
- [x] `mml2chtml` - convert MathML to HTML
- [x] `am2chtml` - convert ASCIIMath to HTML
- [x] `am2mml` - convert ASCIIMath to MathML

Each of the methods are also available with `async` implementations.

```swift
func myMathMethod() async throws {
  let mml = try await mathjax.tex2mml("\\frac{2}{3}")
  print(mml)
}
```

Outputs

```xml
<math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
  <mfrac>
    <mn>2</mn>
    <mn>3</mn>
  </mfrac>
</math>
```

### MathJax Version

To check the version of MathJax that has been loaded, use the static `metadata() throws` method.

```swift
do {
  let metadata = try MathJax.metadata()
  print(metadata.version)
}
catch {
  print("Error getting MathJax version: \(error)") 
}
```

## Notes

`MathJaxSwift` wraps the MathJax TeX conversion process in convenient JS methods [described here](https://github.com/mathjax/MathJax-demos-node/tree/master/direct) and exposes them to Swift through the `JavaScriptCore` framework.

To get around the limitations of the `JSContext` class, the package uses [Webpack](https://webpack.js.org) to create a bundle file that can be evaluated by the context. The wrapper methods, MathJax, and Webpack dependencies are bundled together in an npm module called `mjn`. After making modifications to `index.js`, it should be rebuilt with `npm run build` which will create the `mjn.bundle.js` file.
