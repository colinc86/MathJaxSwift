import XCTest
@testable import MathJaxSwift

final class Tex2SpeechTests: XCTestCase {

  var mathjax: MathJax!

  override func setUp() async throws {
    mathjax = try MathJax(preferredOutputFormats: [.mml, .speech])
  }

  func testTex2SpeechSync() throws {
    let output = try mathjax.tex2speech(MathJaxSwiftTests.texInput)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, "two thirds")
  }

  func testTex2SpeechSyncBulk() throws {
    let output = try mathjax.tex2speech([MathJaxSwiftTests.texInput, MathJaxSwiftTests.texInput])
    XCTAssertNoThrow(output)
    XCTAssertEqual(output.count, 2)
    XCTAssertEqual(output[0].value, "two thirds")
    XCTAssertEqual(output[1].value, "two thirds")
  }

  func testTex2SpeechAsync() async throws {
    let output = try await mathjax.tex2speech(MathJaxSwiftTests.texInput)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, "two thirds")
  }

  func testTex2SpeechError() {
    XCTAssertThrowsError(try mathjax.tex2speech(MathJaxSwiftTests.texErrorInput)) { error in
      guard let error = error as? MathJaxError else {
        XCTFail("Unknown error.")
        return
      }
      XCTAssertEqual(error, MathJaxError.conversionError(error: MathJaxSwiftTests.texErrorOutput))
    }
  }

  func testTex2SpeechExpressions() throws {
    let output = try mathjax.tex2speech("x^2 + y^2 = z^2")
    XCTAssertEqual(output, "x squared plus y squared equals z squared")
  }

  func testTex2SpeechTime() {
    measure {
      let output = try? mathjax.tex2speech(MathJaxSwiftTests.texInput)
      XCTAssertNotNil(output)
    }
  }

}
