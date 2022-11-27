# MathJaxSwift

A SPM wrapper for the [MathJax](https://github.com/mathjax/MathJax) repository.

## Installation

Add the dependency to your package manifest file.

```swift
.package(url: "https://github.com/colinc86/MathJaxSwift", from: "3.2.2")
```

## Usage

Import the package and use the properties to access the package contents.

```swift
import MathJaxSwift

// The base path
if let base = MathJaxSwift.base {
  print(base)
}

// The es5 path
if let es5 = MathJaxSwift.es5 {
  print(es5)
}

do {
  // The MathJax npm package's metadata
  if let package = try MathJaxSwift.package() {
    print(package.version)
  }
}
catch {
  print("Error getting package metadata: \(error)")
}
```

### The `main` File

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
