import XCTest
@testable import MathJaxSwift

final class Tex2MMLTests: XCTestCase {
  
  let mmlData = MathJaxSwiftTests.loadString(fromFile: "No Error/testMML", withExtension: "xml")
  var mathjax: MathJax!
  
  override func setUp() async throws {
    mathjax = try MathJax(preferredOutputFormat: .mml)
  }
  
  func testTex2MMLSync() throws {
    let output = try mathjax.tex2mml(MathJaxSwiftTests.texInput)
    XCTAssertEqual(output, mmlData)
  }
  
  func testTex2MMLAsync() async throws {
    let output = try await mathjax.tex2mml(MathJaxSwiftTests.texInput)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, mmlData)
  }
  
  func testTex2MMLError() {
    XCTAssertThrowsError(try mathjax.tex2mml(MathJaxSwiftTests.texErrorInput)) { error in
      guard let error = error as? MJError else {
        XCTFail("Unknown error.")
        return
      }
      XCTAssertEqual(error, MJError.conversionError(error: MathJaxSwiftTests.texErrorOutput))
    }
  }
  
  func testTex2MMLTime() {
    measure {
      let output = try? mathjax.tex2mml(MathJaxSwiftTests.texInput)
      XCTAssertNotNil(output)
    }
  }
  
}
