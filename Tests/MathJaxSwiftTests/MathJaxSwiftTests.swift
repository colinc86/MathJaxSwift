import XCTest
@testable import MathJaxSwift

final class MathJaxSwiftTests: XCTestCase {
  
  func testResource() throws {
    // Test that the URL exists
    let url = MathJaxSwift.base
    XCTAssertNotNil(url)
    
    let es5URL = MathJaxSwift.es5
    XCTAssertNotNil(es5URL)
    
    // Get a URL
    let texURL = es5URL?.appending(path: "tex-chtml.js")
    XCTAssertNotNil(texURL)
    
    // Load the resource
    let data = try Data(contentsOf: texURL!)
    XCTAssertNoThrow(data)
  }
  
  func testPackage() throws {
    // Test that we can get the package metadata
    let package = try MathJaxSwift.package()
    XCTAssertNoThrow(package)
    
    // The package name should not change, so let make sure that it equals
    // mathjax.
    XCTAssertEqual(package.name, "mathjax")
    
    // In an attempt to keep this version agnostic, lets only check to make sure
    // that we have something non-empty.
    XCTAssertFalse(package.version.isEmpty)
  }
  
}
