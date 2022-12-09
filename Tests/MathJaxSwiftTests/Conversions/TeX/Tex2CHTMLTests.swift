import XCTest
@testable import MathJaxSwift

final class Tex2CHTMLTests: XCTestCase {
  
  let chtmlData = MathJaxSwiftTests.loadString(fromFile: "No Error/testCHTML", withExtension: "html")
  var mathjax: MathJax!
  
  override func setUp() async throws {
    mathjax = try MathJax(preferredOutputFormat: .chtml)
  }
  
  func testTex2CHTMLSync() throws {
    let output = try mathjax.tex2chtml(MathJaxSwiftTests.texInput)
    XCTAssertEqual(output, chtmlData)
  }
  
  func testTex2CHTMLAsync() async throws {
    let output = try await mathjax.tex2chtml(MathJaxSwiftTests.texInput)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, chtmlData)
  }
  
  func testTex2CHTMLError() {
    XCTAssertThrowsError(try mathjax.tex2chtml(MathJaxSwiftTests.texErrorInput)) { error in
      guard let error = error as? MJError else {
        XCTFail("Unknown error.")
        return
      }
      XCTAssertEqual(error, MJError.conversionError(error: MathJaxSwiftTests.texErrorOutput))
    }
  }
  
  func testTex2CHTMLTime() {
    measure {
      let output = try? mathjax.tex2chtml(MathJaxSwiftTests.texInput)
      XCTAssertNotNil(output)
    }
  }
  
}
