import XCTest
@testable import MathJaxSwift

final class MML2SVGTests: XCTestCase {
  
  let mmlData = MathJaxSwiftTests.loadString(fromFile: "No Error/testMML", withExtension: "xml")
  let svgData = MathJaxSwiftTests.loadString(fromFile: "No Error/testSVG", withExtension: "svg")
  var mathjax: MathJax!
  
  override func setUp() async throws {
    mathjax = try MathJax(preferredOutputFormat: .svg)
  }
  
  func testMML2SVGSync() throws {
    let output = try mathjax.mml2svg(mmlData)
    XCTAssertEqual(output, svgData)
  }
  
  func testMML2SVGAsync() async throws {
    let output = try await mathjax.mml2svg(mmlData)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, svgData)
  }
  
  func testMML2SVGTime() {
    measure {
      let output = try? mathjax.mml2svg(mmlData)
      XCTAssertNotNil(output)
    }
  }
  
}
