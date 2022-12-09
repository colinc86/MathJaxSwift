import XCTest
@testable import MathJaxSwift

final class MML2CHTMLTests: XCTestCase {
  
  let mmlData = MathJaxSwiftTests.loadString(fromFile: "No Error/testMML", withExtension: "xml")
  let chtmlData = MathJaxSwiftTests.loadString(fromFile: "No Error/testCHTML", withExtension: "html")
  var mathjax: MathJax!
  
  override func setUp() async throws {
    mathjax = try MathJax(preferredOutputFormat: .chtml)
  }
  
  func testMML2CHTMLSync() throws {
    let output = try mathjax.mml2chtml(mmlData)
    XCTAssertEqual(output, chtmlData)
  }
  
  func testMML2CHTMLAsync() async throws {
    let output = try await mathjax.mml2chtml(mmlData)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, chtmlData)
  }
  
  func testMML2CHTMLTime() {
    measure {
      let output = try? mathjax.mml2chtml(mmlData)
      XCTAssertNotNil(output)
    }
  }
  
}
