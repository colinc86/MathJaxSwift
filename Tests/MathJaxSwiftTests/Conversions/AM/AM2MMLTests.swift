import XCTest
@testable import MathJaxSwift

final class AM2MMLTests: XCTestCase {
  
  let mmlData = MathJaxSwiftTests.loadString(fromFile: "testAMMML", withExtension: "xml")
  var mathjax: MathJax!
  
  override func setUp() async throws {
    mathjax = try MathJax(preferredOutputFormat: .mml)
  }
  
  func testAM2MMLSync() throws {
    let output = try mathjax.am2mml(MathJaxSwiftTests.amInput)
    XCTAssertEqual(output, mmlData)
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
