import XCTest
@testable import MathJaxSwift

final class OutputProcessorOptionsTests: XCTestCase {
  
  func testCHTMLOutputJSON() throws {
    let json = try CHTMLOutputProcessorOptions().json()
    XCTAssertNoThrow(json)
    XCTAssertFalse(json.isEmpty)
  }
  
  func testSVGOutputJSON() throws {
    let json = try SVGOutputProcessorOptions().json()
    print(json)
    XCTAssertNoThrow(json)
    XCTAssertFalse(json.isEmpty)
  }
  
}
