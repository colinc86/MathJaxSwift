import XCTest
@testable import MathJaxSwift

final class SVGParserTests: XCTestCase {

  let validData = MathJaxSwiftTests.loadString(fromFile: "No Error/testSVG", withExtension: "svg")
  let errorData = MathJaxSwiftTests.loadString(fromFile: "Error/testSVG", withExtension: "svg")

  func testValidateSuccess() throws {
    let result = try SVGParser.shared.validate(validData)
    XCTAssertEqual(result, validData)
  }

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
