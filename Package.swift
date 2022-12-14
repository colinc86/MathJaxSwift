// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "MathJaxSwift",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
    .tvOS(.v13)
  ],
  products: [
    .library(
      name: "MathJaxSwift",
      targets: ["MathJaxSwift"])
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
      dependencies: ["MathJaxSwift"],
      resources: [
        .copy("Resources/Error"),
        .copy("Resources/No Error")
      ]),
  ]
)
