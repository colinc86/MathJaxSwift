# MathJaxSwift

[![Unit Tests](https://github.com/colinc86/MathJaxSwift/actions/workflows/swift.yml/badge.svg)](https://github.com/colinc86/MathJaxSwift/actions/workflows/swift.yml) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fcolinc86%2FMathJaxSwift%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/colinc86/MathJaxSwift) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fcolinc86%2FMathJaxSwift%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/colinc86/MathJaxSwift) ![MathJax Version](https://img.shields.io/badge/MathJax-3.2.2-green)

<a href="https://www.mathjax.org">
    <img title="Powered by MathJax"
    src="https://www.mathjax.org/badge/badge.gif"
    border="0" alt="Powered by MathJax" />
</a>

`MathJaxSwift` converts and renders math expressions in Swift by incorporating [MathJax](https://github.com/mathjax/MathJax)[^1] source code and using the [JavaScriptCore](https://developer.apple.com/documentation/javascriptcore) framework. It wraps the MathJax conversion processes in convenient JavaScript methods [described here](https://github.com/mathjax/MathJax-demos-node/tree/master/direct) and exposes them to Swift _without_ using `WebKit`.

[^1]: `MathJaxSwift` is not affiliated with [MathJax](https://github.com/mathjax/MathJax) or any of its related entities.

- [Installation](#📦-installation)
- [Usage](#🎛️-usage)
  - [Available Methods](#🧰-available-methods)
  - [Threading and Memory](#🧵-threading-and-memory)
    - [Preferred Output Formats](#preferred-output-formats)
  - [Options](#⚙️-options)
    - [Document Options](#document-options)
    - [Conversion Options](#conversion-options)
    - [Processor Options](#processor-options)
  - [Error Handling](#🚨-error-handling)
  - [MathJax Version](#♾️-mathjax-version)
- [Notes](#📓-notes)

## 📦 Installation

Add the dependency to your package manifest file.

```swift
.package(url: "https://github.com/colinc86/MathJaxSwift", from: "3.2.2")
```

## 🎛️ Usage

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
>
> <img alt="Hello, Tex!" src="./assets/images/hello_tex.png" width=200px, height=auto>

### 🧰 Available Methods

MathJaxSwift implements the following methods to convert [TeX](https://tug.org), [MathML](https://www.w3.org/TR/MathML/), and [AsciiMath](http://asciimath.org) to CommonHTML, MathML and SVG data.

| Method      | Input Format                            | Output Format |
| :---------- | :-------------------------------------- | :------------ |
| `tex2chtml` | TeX                                     | cHTML         |
| `tex2mml`   | TeX                                     | MathML        |
| `tex2svg`   | TeX                                     | SVG           |
| `mml2chtml` | MathML                                  | cHTML         |
| `mml2svg`   | MathML                                  | SVG           |
| `am2chtml`  | AsciiMath                               | cHTML         |
| `am2mml`    | AsciiMath                               | MathML        |

### 🧵 Threading and Memory

Initializing an instance of `MathJax` should not be performed on the main queue to prevent blocking of the UI. You should also attempt to keep a single reference to an instance and submit your function calls to it instead of creating a new `MathJax` instance each time you need to convert.

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

Each of the methods are also available with an `async` implementation.

```swift
func myAsyncMethod() async throws {
  let mml = try await mathjax.tex2mml("\\frac{2}{3}")
  print(mml)
}
```

```xml
<math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
  <mfrac>
    <mn>2</mn>
    <mn>3</mn>
  </mfrac>
</math>
```

You can specify which queue to execute on when calling async methods. The instance will use the `.global()` queue by default.

```swift
func myAsyncMethod() async throws {
  let mml = try await mathjax.tex2mml("\\frac{2}{3}", queue: myQueue)
}
```

#### Preferred Output Formats

MathJaxSwift loads all of the necessary JavaScript in to its context to run all of the conversion methods. In the case that you only want to utilize a subset of the package's output formats, you can instruct the `MathJax` instance to only initialize with your preferred output formats.

```swift
do {
  // Save some time and don't load the SVG output format.
  let mathjax = try MathJax(preferredOutputFormats: [.chtml, .mml])
}
catch {
  print("Error initializing MathJax: \(error)")
}
```

The benefit of this approach is that, instead of loading all of the necessary JavaScript in to the instance's context upon initialization, it loads the preferred output formats immediately, and then lazily loads any JavaScript in the future that may be required to execute a conversion method.

```swift
do {
  // We _think_ we only need CommonHTML, so save some time by only loading that
  // output format.
  let mathjax = try MathJax(preferredOutputFormat: .chtml)
  
  // It's ok to call `tex2mml` even though we set our preferred output format to
  // `chtml`!
  let mml = try mathjax.tex2mml("\\text{Hello}, \\TeX{}!")
}
catch {
  print("MathJax error: \(error)")
}
```

See the [Notes](https://github.com/colinc86/MathJaxSwift#notes) section for more details.

### ⚙️ Options

#### Document Options

Document options let you control the document created by MathJax. They apply to every conversion method and let you specify MathJax document-specific options. 

```swift
// Add to the `skipHtmlTags` array.
var docOptions = DocumentOptions()
docOptions.skipHtmlTags.append("example")

// Process the input using the new options
let output = try! tex2chtml("\\text{Hello, }$\\LaTeX$\\text{!}", documentOptions: docOptions)
```

#### Conversion Options

These options, as with document options, apply to to every conversion method. Although, the options' `display` property only pertains to methods that take TeX input. They let you set input conversion options such as `em` and `ex` sizes, container and line widths, and `scale`.

```swift
// Process the TeX input as a block instead of inline
let convOptions = ConversionOptions(display: true)
let output = try! tex2chtml("\\text{Hello, }$\\LaTeX$\\text{!}", conversionOptions: convOptions)
```

#### Processor Options

The input and output of each of the conversion methods is configurable through various processor options. For example, if you are calling the `tex2svg` conversion method, then you can configure the input and output with `TexInputProcessorOptions` and `SVGOutputProcessorOptions`, respectively.

```swift
let inputOptions = TexInputProcessorOptions(processEscapes: true)
let outputOptions = SVGOutputProcessorOptions(displayIndent: 0.5)
let svg = try! mathjax.tex2svg("\\text{Hello, }\\LaTeX\\text{!}", inputOptions: inputOptions, outputOptions: outputOptions)
```

### 🚨 Error Handling

Each of the conversion methods are throwing methods, but you can also catch errors from MathJax using options.

```swift
let documentOptions = DocumentOptions { doc, math, err in
  // Do something with the compile error...
}, typesetError: { doc, math, err in
  // Do something with the typeset error...
}

let inputOptions = TexInputProcessorOptions { jax, err in
  // Do something with the TeX format error...
}
```

### ♾️ MathJax Version

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

## 📓 Notes

To get around the limitations of the `JSContext` class, the package uses [Webpack](https://webpack.js.org) to create bundle files that can be evaluated by the context. The wrapper methods, MathJax, and Webpack dependencies are bundled together in an npm module called `mjn`. 

`mjn`'s main entry point is `index.js` which exposes the converter classes and functions that utilize MathJax. The files are packed with Webpack and placed in to the `mjn/dist/` directory. `chtml.bundle.js`, `mml.bundle.js`, and `svg.bundle.js` files are loaded by the Swift package's module and evaluated by a JavaScript context to expose the functions.

After making modifications to `index.js`, it should be rebuilt with `npm run build` executed in the `mjn` directory which will recreate the bundle files.
