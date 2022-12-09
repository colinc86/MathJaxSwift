import XCTest
@testable import MathJaxSwift

final class Tex2SVGTests: XCTestCase {
  
  let svgData = MathJaxSwiftTests.loadString(fromFile: "No Error/testSVG", withExtension: "svg")
  var mathjax: MathJax!
  
  override func setUp() async throws {
    mathjax = try MathJax(preferredOutputFormat: .svg)
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
  
  func testTex2SVGError() {
    XCTAssertThrowsError(try mathjax.tex2svg(MathJaxSwiftTests.texErrorInput)) { error in
      guard let error = error as? MJError else {
        XCTFail("Unknown error.")
        return
      }
      XCTAssertEqual(error, MJError.conversionError(error: MathJaxSwiftTests.texErrorOutput))
    }
  }
  
  func testTex2SVGTime() {
    measure {
      let output = try? mathjax.tex2svg(MathJaxSwiftTests.texInput)
      XCTAssertNotNil(output)
    }
  }
  
}
