import XCTest
@testable import MathJaxSwift

final class MML2SpeechTests: XCTestCase {

  var mathjax: MathJax!

  override func setUp() async throws {
    mathjax = try MathJax(preferredOutputFormats: [.mml, .speech])
  }

  func testMML2SpeechSync() throws {
    let mml = try mathjax.tex2mml(MathJaxSwiftTests.texInput)
    let output = try mathjax.mml2speech(mml)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, "two thirds")
  }

  func testMML2SpeechSyncBulk() throws {
    let mml = try mathjax.tex2mml(MathJaxSwiftTests.texInput)
    let output = try mathjax.mml2speech([mml, mml])
    XCTAssertNoThrow(output)
    XCTAssertEqual(output.count, 2)
    XCTAssertEqual(output[0].value, "two thirds")
    XCTAssertEqual(output[1].value, "two thirds")
  }

  func testMML2SpeechAsync() async throws {
    let mml = try await mathjax.tex2mml(MathJaxSwiftTests.texInput)
    let output = try await mathjax.mml2speech(mml)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, "two thirds")
  }

  func testMML2SpeechDirectMML() throws {
    let mml = "<math><msqrt><mn>2</mn></msqrt></math>"
    let output = try mathjax.mml2speech(mml)
    XCTAssertFalse(output.isEmpty)
    XCTAssertTrue(output.lowercased().contains("root") || output.lowercased().contains("square"))
  }

  func testMML2SpeechTime() {
    let mml = try! mathjax.tex2mml(MathJaxSwiftTests.texInput)
    measure {
      let output = try? mathjax.mml2speech(mml)
      XCTAssertNotNil(output)
    }
  }

}
