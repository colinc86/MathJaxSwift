import XCTest
@testable import MathJaxSwift

final class Tex2CHTMLTests: XCTestCase {
  
  let chtmlData = MathJaxSwiftTests.loadString(fromFile: "testCHTML", withExtension: "html")
  var mathjax: MathJax!
  
  override func setUp() async throws {
    mathjax = try MathJax()
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
  
  func testTex2CHTMLTime() {
    measure {
      let output = try? mathjax.tex2chtml(MathJaxSwiftTests.texInput)
      XCTAssertNotNil(output)
    }
  }
  
}
