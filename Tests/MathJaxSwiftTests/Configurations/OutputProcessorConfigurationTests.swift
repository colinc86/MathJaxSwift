import XCTest
@testable import MathJaxSwift

final class OutputProcessorConfigurationTests: XCTestCase {
  
  func testCHTMLOutputJSON() throws {
    let json = try CHTMLOutputProcessorConfiguration().json()
    XCTAssertNoThrow(json)
    XCTAssertFalse(json.isEmpty)
  }
  
  func testSVGOutputJSON() throws {
    let json = try SVGOutputProcessorConfiguration().json()
    XCTAssertNoThrow(json)
    XCTAssertFalse(json.isEmpty)
  }
  
}
