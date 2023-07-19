import XCTest
@testable import MathJaxSwift

final class AM2CHTMLTests: XCTestCase {
  
  let chtmlData = MathJaxSwiftTests.loadString(fromFile: "No Error/testAMCHTML", withExtension: "html")
  var mathjax: MathJax!
  
  override func setUp() async throws {
    mathjax = try MathJax(preferredOutputFormat: .chtml)
  }
  
  func testAM2CHTMLSync() throws {
    let output = try mathjax.am2chtml(MathJaxSwiftTests.amInput)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, chtmlData)
  }
  
  func testAM2CHTMLSyncBulk() throws {
    let output = try mathjax.am2chtml([MathJaxSwiftTests.amInput, MathJaxSwiftTests.amInput])
    XCTAssertNoThrow(output)
    XCTAssertEqual(output.count, 2)
    XCTAssertEqual(output[0].value, chtmlData)
    XCTAssertEqual(output[1].value, chtmlData)
  }
  
  func testAM2CHTMLSyncError() throws {
    var error: Error?
    let output = mathjax.am2chtml(MathJaxSwiftTests.amInput, error: &error)
    XCTAssertEqual(output, chtmlData)
    XCTAssertNil(error)
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
