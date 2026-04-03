import XCTest
@testable import MathJaxSwift

final class AM2SVGTests: XCTestCase {

  var mathjax: MathJax!

  override func setUp() async throws {
    mathjax = try MathJax(preferredOutputFormat: .svg)
  }

  func testAM2SVGSync() throws {
    let output = try mathjax.am2svg(MathJaxSwiftTests.amInput)
    XCTAssertNoThrow(output)
    XCTAssertTrue(output.contains("<svg"))
    XCTAssertTrue(output.contains("</svg>"))
  }

  func testAM2SVGSyncBulk() throws {
    let output = try mathjax.am2svg([MathJaxSwiftTests.amInput, MathJaxSwiftTests.amInput])
    XCTAssertNoThrow(output)
    XCTAssertEqual(output.count, 2)
    XCTAssertEqual(output[0].value, output[1].value)
    XCTAssertTrue(output[0].value.contains("<svg"))
  }

  func testAM2SVGSyncError() throws {
    var error: Error?
    let output = mathjax.am2svg(MathJaxSwiftTests.amInput, error: &error)
    XCTAssertFalse(output.isEmpty)
    XCTAssertNil(error)
  }

  func testAM2SVGAsync() async throws {
    let output = try await mathjax.am2svg(MathJaxSwiftTests.amInput)
    XCTAssertNoThrow(output)
    XCTAssertTrue(output.contains("<svg"))
    XCTAssertTrue(output.contains("</svg>"))
  }

  func testAM2SVGTime() {
    measure {
      let output = try? mathjax.am2svg(MathJaxSwiftTests.amInput)
      XCTAssertNotNil(output)
    }
  }

}
