import XCTest
@testable import MathJaxSwift

final class AM2SpeechTests: XCTestCase {

  var mathjax: MathJax!

  override func setUp() async throws {
    mathjax = try MathJax(preferredOutputFormats: [.mml, .speech])
  }

  func testAM2SpeechSync() throws {
    let output = try mathjax.am2speech(MathJaxSwiftTests.amInput)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, "two thirds")
  }

  func testAM2SpeechSyncBulk() throws {
    let output = try mathjax.am2speech([MathJaxSwiftTests.amInput, MathJaxSwiftTests.amInput])
    XCTAssertNoThrow(output)
    XCTAssertEqual(output.count, 2)
    XCTAssertEqual(output[0].value, "two thirds")
    XCTAssertEqual(output[1].value, "two thirds")
  }

  func testAM2SpeechAsync() async throws {
    let output = try await mathjax.am2speech(MathJaxSwiftTests.amInput)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, "two thirds")
  }

  func testAM2SpeechTime() {
    measure {
      let output = try? mathjax.am2speech(MathJaxSwiftTests.amInput)
      XCTAssertNotNil(output)
    }
  }

}
