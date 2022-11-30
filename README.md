# MathJaxSwift

Converts and renders math expressions in Swift using [MathJax](https://github.com/mathjax/MathJax) and the [JavaScriptCore](https://developer.apple.com/documentation/javascriptcore) framework.

[![Tests](https://github.com/colinc86/MathJaxSwift/actions/workflows/swift.yml/badge.svg)](https://github.com/colinc86/MathJaxSwift/actions/workflows/swift.yml)

`MathJaxSwift` wraps the MathJax conversion processes in convenient JavaScript methods [described here](https://github.com/mathjax/MathJax-demos-node/tree/master/direct) and exposes them to Swift through the `JavaScriptCore` framework.

It implements the following methods

- [x] `tex2svg` - [TeX](https://tug.org) to SVG
- [x] `tex2chtml` - TeX to HTML
- [x] `tex2mml` - TeX to [MathML](https://www.w3.org/TR/MathML/)
- [x] `mml2svg` - MathML to SVG
- [x] `mml2chtml` - MathML to HTML
- [x] `am2chtml` - [AsciiMath](http://asciimath.org) to HTML
- [x] `am2mml` - AsciiMath to MathML

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

### Threading and Memory

Initializing an instance of `MathJax` should not be performed on the main queue to prevent blocking of the UI. You should also attempt to keep a single reference to an instance and submit your function calls to it instead of creating a new `MathJax` instance each time you need to convert.

> An example of what to do: 

```swift
import MathJaxSwift

class MyModel {
  let mathjax: MathJax
  
  init() throws {
    mathjax = try MathJax()
  }
  
  func convertTex(_ input: String) async throws -> String {
    return try await mathjax.tex2chtml(input)
  }
}
```

> An example of what _not_ to do: 

```swift
import MathJaxSwift

class MyModel {
  init() {}
  
  func convertTex(_ input: String) async throws -> String {
    let mathjax = try MathJax()
    return try await mathjax.tex2chtml(input)
  }
}
```

Each of the methods are also available with an `async` implementation. It is recommended that these methods are used over their synchronous counterparts wherever possible.

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

All of the methods that output SVG and HTML each support configurations passed as parameters; container and output configurations.

#### Container Configurations

To set parameters such as the font size, height, container width, etc., use either the `CHTMLContainerConfiguration` or `SVGContainerConfiguration` type.

For example, to set the font's size, create a container configuration and set the `em` and `ex` parameters.

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

To get around the limitations of the `JSContext` class, the package uses [Webpack](https://webpack.js.org) to create a bundle file that can be evaluated by the context. The wrapper methods, MathJax, and Webpack dependencies are bundled together in an npm module called `mjn`. 

`mjn`'s main entry point is `index.js` which houses the `Converter` class and conversion functions that utilize MathJax. The file is packed with Webpack and placed in to the `mjn/dist/mjn.bundle.js` file. `mjn.bundle.js` is loaded by the Swift package's module and evaluated by a JavaScript context to expose the functions.

After making modifications to `index.js`, it should be rebuilt with `npm run build` executed in the `mjn` directory which will recreate the `mjn.bundle.js` file.
