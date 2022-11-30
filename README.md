# MathJaxSwift

[![Tests](https://github.com/colinc86/MathJaxSwift/actions/workflows/swift.yml/badge.svg)](https://github.com/colinc86/MathJaxSwift/actions/workflows/swift.yml)

A Swift wrapper for the [MathJax](https://github.com/mathjax/MathJax) component library.

`MathJaxSwift` wraps the MathJax conversion processes in convenient JS methods [described here](https://github.com/mathjax/MathJax-demos-node/tree/master/direct) and exposes them to Swift through the `JavaScriptCore` framework.

It implements the methods

- [x] `tex2svg` - convert TeX to SVG
- [x] `tex2chtml` - convert TeX to HTML
- [x] `tex2mml` - convert TeX to MathML
- [x] `mml2svg` - convert MathML to SVG
- [x] `mml2chtml` - convert MathML to HTML
- [x] `am2chtml` - convert ASCIIMath to HTML
- [x] `am2mml` - convert ASCIIMath to MathML

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

> The example above converts the TeX input to SVG data that renders the following PNG.

![Hello, TeX!](/assets/images/hello_tex.png)

### Threading

Each of the methods are also available with an `async` implementation. It is recommended that these methods are preferred over their synchronous counterparts whenever possible.

```swift
func myTeXMethod() async throws {
  let mml = try await mathjax.tex2mml("\\frac{2}{3}")
  print(mml)
}
```

> Outputs the following MathML.

```xml
<math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
  <mfrac>
    <mn>2</mn>
    <mn>3</mn>
  </mfrac>
</math>
```

See the [Performance](https://github.com/colinc86/MathJaxSwift#performance) section for more details.

### Block Rendering

Use the `inline` parameter to specify whether or not the input should be interpreted as inline text. Input is interpreted as `inline=false` by default which results in block output.

```swift
func myTeXMethod() async throws {
  let mml = try await mathjax.tex2mml("\\frac{2}{3}", inline: true)
  print(mml)
}
```

> Compare the following MathML output to the output of the previous example.

```xml
<math xmlns="http://www.w3.org/1998/Math/MathML">
  <mfrac>
    <mn>2</mn>
    <mn>3</mn>
  </mfrac>
</math>
```

### Configurations

All of the methods that output SVG and HTML each support two configurations passed as parameters; container and output configurations.

#### Container Configurations

To set parameters such as the font size, height, container width, etc., use either the `CHTMLContainerConfiguration` or `SVGContainerConfiguration` type.

For example, to set the font's size, create a container configuration and set the `em` and `ex` parameters.

```swift
let config = CHTMLContainerConfiguration(em: 24, ex: 12)
let html = try await mathjax.tex2chtml("\\text{Hello}, \\TeX{}!", containerConfig: config)
```

#### Output Processor Configurations

The MathJax HTML and SVG output processors are also configurable using the same method as above, but by setting the `outputConfig` parameter to one of `CHTMLOutputProcessorConfiguration` or `SVGOutputProcessorConfiguration`.

For more information on the types of properties that can be set on the processor configurations, see [MathJax's Output Processor Options](https://docs.mathjax.org/en/latest/options/output/chtml.html).

```swift
let containerConfig = CHTMLContainerConfiguration(em: 24, ex: 12)
let outputConfig = CHTMLOutputProcessorConfiguration(scale: 2, fontCache: .none)

let html = try await mathjax.tex2chtml(
  "\\text{Hello}, \\TeX{}!", 
  containerConfig: containerConfig, 
  outputConfig: outputConfig)
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

You can also use the returned metadata to check the MathJax node module's URL and its SHA-512.

## Notes

To get around the limitations of the `JSContext` class, the package uses [Webpack](https://webpack.js.org) to create a bundle file that can be evaluated by the context. The wrapper methods, MathJax, and Webpack dependencies are bundled together in an npm module called `mjn`. After making modifications to `index.js`, it should be rebuilt with `npm run build` which will recreate the `mjn.bundle.js` file.
