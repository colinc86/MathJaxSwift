import XCTest
@testable import MathJaxSwift

final class HTMLParserTests: XCTestCase {

  let validData = MathJaxSwiftTests.loadString(fromFile: "No Error/testCHTML", withExtension: "html")
  let errorData = MathJaxSwiftTests.loadString(fromFile: "Error/testCHTML", withExtension: "html")

  func testValidateSuccess() throws {
    let result = try HTMLParser.shared.validate(validData)
    XCTAssertEqual(result, validData)
  }

  func testValidate() throws {
    XCTAssertThrowsError(try HTMLParser.shared.validate(errorData)) { error in
      guard let error = error as? MathJaxError else {
        XCTFail("Unknown error.")
        return
      }
      XCTAssertEqual(error, .conversionError(error: MathJaxSwiftTests.texErrorOutput))
    }
  }
  
}
