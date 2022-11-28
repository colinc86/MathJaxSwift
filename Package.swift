// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "MathJaxSwift",
  platforms: [
    .macOS(.v13)
  ],
  products: [
    .library(
      name: "MathJaxSwift",
      targets: ["MathJaxSwift"]),
  ],
  targets: [
    .target(
      name: "MathJaxSwift",
      dependencies: [],
      resources: [
        .copy("Resources/mjn")
      ]),
    .testTarget(
      name: "MathJaxSwiftTests",
      dependencies: ["MathJaxSwift"]),
  ]
)
