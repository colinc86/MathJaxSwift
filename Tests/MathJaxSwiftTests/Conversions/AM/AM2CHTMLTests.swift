import XCTest
@testable import MathJaxSwift

final class AM2CHTMLTests: XCTestCase {
  
  let chtmlData = MathJaxSwiftTests.loadString(fromFile: "testAMCHTML", withExtension: "html")
  var mathjax: MathJax!
  
  override func setUp() async throws {
    mathjax = try MathJax()
  }
  
  func testAM2CHTMLSync() throws {
    let output = try mathjax.am2chtml(MathJaxSwiftTests.amInput)
    XCTAssertEqual(output, chtmlData)
  }
  
  func testAM2CHTMLAsync() async throws {
    let output = try await mathjax.am2chtml(MathJaxSwiftTests.amInput)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, chtmlData)
  }
  
  func testAM2CHTMLTime() {
    measure {
      let output = try? mathjax.am2chtml(MathJaxSwiftTests.amInput)
      XCTAssertNotNil(output)
    }
  }
  
}
