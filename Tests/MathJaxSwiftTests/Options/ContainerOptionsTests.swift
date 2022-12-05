import XCTest
@testable import MathJaxSwift

final class ContainerOptionsTests: XCTestCase {
  
  func testCHTMLContainerJSON() throws {
    let json = try CHTMLContainerOptions().json()
    XCTAssertNoThrow(json)
    XCTAssertFalse(json.isEmpty)
  }
  
  func testSVGContainerJSON() throws {
    let json = try SVGContainerOptions().json()
    XCTAssertNoThrow(json)
    XCTAssertFalse(json.isEmpty)
  }
  
}
