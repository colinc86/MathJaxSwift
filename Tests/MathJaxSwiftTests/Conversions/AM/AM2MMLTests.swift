import XCTest
@testable import MathJaxSwift

final class AM2MMLTests: XCTestCase {
  
  let mmlData = MathJaxSwiftTests.loadString(fromFile: "No Error/testAMMML", withExtension: "xml")
  var mathjax: MathJax!
  
  override func setUp() async throws {
    mathjax = try MathJax(preferredOutputFormat: .mml)
  }
  
  func testAM2MMLSync() throws {
    let output = try mathjax.am2mml(MathJaxSwiftTests.amInput)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, mmlData)
  }
  
  func testAM2MMLSyncBulk() throws {
    let output = try mathjax.am2mml([MathJaxSwiftTests.amInput, MathJaxSwiftTests.amInput])
    XCTAssertNoThrow(output)
    XCTAssertEqual(output.count, 2)
    XCTAssertEqual(output[0].value, mmlData)
    XCTAssertEqual(output[1].value, mmlData)
  }
  
  func testAM2MMLSyncError() throws {
    var error: Error?
    let output = mathjax.am2mml(MathJaxSwiftTests.amInput, error: &error)
    XCTAssertEqual(output, mmlData)
    XCTAssertNil(error)
  }
  
  func testAM2MMLAsync() async throws {
    let output = try await mathjax.am2mml(MathJaxSwiftTests.amInput)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, mmlData)
  }
  
  func testAM2MMLTime() {
    measure {
      let output = try? mathjax.am2mml(MathJaxSwiftTests.amInput)
      XCTAssertNotNil(output)
    }
  }
  
}
