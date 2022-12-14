import XCTest
@testable import MathJaxSwift

final class SVGParserTests: XCTestCase {
  
  let errorData = MathJaxSwiftTests.loadString(fromFile: "Error/testSVG", withExtension: "svg")
  
  func testValidate() throws {
    XCTAssertThrowsError(try SVGParser.shared.validate(errorData)) { error in
      guard let error = error as? MathJaxError else {
        XCTFail("Unknown error.")
        return
      }
      XCTAssertEqual(error, .conversionError(error: MathJaxSwiftTests.texErrorOutput))
    }
  }
  
}
