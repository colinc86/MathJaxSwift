import XCTest
@testable import MathJaxSwift

final class ContainerConfigurationTests: XCTestCase {
  
  func testCHTMLContainerJSON() throws {
    let json = try CHTMLContainerConfiguration().json()
    XCTAssertNoThrow(json)
    XCTAssertFalse(json.isEmpty)
  }
  
  func testSVGContainerJSON() throws {
    let json = try SVGContainerConfiguration().json()
    XCTAssertNoThrow(json)
    XCTAssertFalse(json.isEmpty)
  }
  
}
