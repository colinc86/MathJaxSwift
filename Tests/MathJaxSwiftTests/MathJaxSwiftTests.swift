import XCTest
@testable import MathJaxSwift

final class MathJaxSwiftTests: XCTestCase {
  
  func testResource() throws {
    // Test that the URL exists
    let url = MathJax.base
    XCTAssertNotNil(url)
    
    // Get a URL
    let texURL = url?.appending(components: "es5", "tex-chtml.js")
    XCTAssertNotNil(texURL)
    
    // Load the resource
    let data = try Data(contentsOf: texURL!)
    XCTAssertNoThrow(data)
  }
  
  func testPackage() throws {
    // Test that we can get the package metadata
    let package = try MathJax.package()
    XCTAssertNoThrow(package)
    
    // The package name should not change, so let make sure that it equals
    // mathjax.
    XCTAssertEqual(package.name, "mathjax-full")
    
    // In an attempt to keep this version agnostic, lets only check to make sure
    // that we have something non-empty.
    XCTAssertFalse(package.version?.isEmpty ?? true)
  }
  
  func testConvert() async throws {
    let emptyOutput = try MathJax().convert(input: "")
    print(test)
  }
  
}
