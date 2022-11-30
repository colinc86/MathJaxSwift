import XCTest
@testable import MathJaxSwift

final class Tex2SVGTests: XCTestCase {
  
  let svgData = MathJaxSwiftTests.loadString(fromFile: "testSVG", withExtension: "svg")
  var mathjax: MathJax!
  
  override func setUp() async throws {
    mathjax = try MathJax()
  }
  
  func testTex2SVGSync() throws {
    let output = try mathjax.tex2svg(MathJaxSwiftTests.texInput)
    XCTAssertEqual(output, svgData)
  }
  
  func testTex2SVGAsync() async throws {
    let output = try await mathjax.tex2svg(MathJaxSwiftTests.texInput)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, svgData)
  }
  
  func testTex2SVGTime() {
    measure {
      let output = try? mathjax.tex2svg(MathJaxSwiftTests.texInput)
      XCTAssertNotNil(output)
    }
  }
  
}
