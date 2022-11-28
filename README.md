# MathJaxSwift

A SPM wrapper for the [MathJax](https://github.com/mathjax/MathJax) repository.

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
  let input = "Hello, $\\TeX{}$!"
  
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

```swift
import MathJaxSwift

// The base path
if let base = MathJax.base {
  print(base)
}

// The es5 path
if let es5 = MathJax.base?.appending(path: "es5") {
  print(es5)
}

do {
  // The MathJax npm package's metadata
  if let package = try MathJax.package() {
    print(package.version)
  }
}
catch {
  print("Error getting package metadata: \(error)")
}
```

### Converting TeX

Use the package metadata and base path to get the URL to the package's `main` file.

```swift
do {
  let package = try MathJaxSwift.package()
  if let main = MathJaxSwift.base?.appending(path: package.main) {
    print(main)
  }
}
catch {
  print("Error getting package metadata: \(error)")
}
```
