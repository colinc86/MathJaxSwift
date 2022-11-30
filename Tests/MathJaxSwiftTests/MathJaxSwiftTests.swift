import XCTest
@testable import MathJaxSwift

final class MathJaxSwiftTests: XCTestCase {
  
  static let texInput = "\\TeX{}"

  var mathjax: MathJax!
  
  override func setUp() async throws {
    mathjax = try MathJax()
  }
  
  func testBundle() throws {
    XCTAssertNotNil(mathjax)
    XCTAssertNoThrow(mathjax)
  }
  
  func testMetadata() throws {
    // Test that we can get the package metadata
    let metadata = try MathJax.metadata()
    XCTAssertNoThrow(metadata)
    
    // Make sure we know which version we're dealing with.
    XCTAssertEqual(metadata.version, Constants.expectedMathJaxVersion)
    
    // Make sure the URL is correct
    XCTAssertEqual(metadata.resolved.absoluteString, "https://registry.npmjs.org/mathjax-full/-/mathjax-full-\(metadata.version).tgz")
  }
  
}

extension MathJaxSwiftTests {
  
  static func loadString(fromFile fileName: String, withExtension fileExtension: String) -> String {
    let url = Bundle.module.url(forResource: fileName, withExtension: fileExtension)!
    return (try! String(contentsOf: url)).trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
}
