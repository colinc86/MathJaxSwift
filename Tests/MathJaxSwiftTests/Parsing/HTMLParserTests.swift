import XCTest
@testable import MathJaxSwift

final class HTMLParserTests: XCTestCase {
  
  let errorData = MathJaxSwiftTests.loadString(fromFile: "Error/testCHTML", withExtension: "html")
  
  func testValidate() throws {
    XCTAssertThrowsError(try HTMLParser.shared.validate(errorData)) { error in
      guard let error = error as? MJError else {
        XCTFail("Unknown error.")
        return
      }
      XCTAssertEqual(error, .conversionError(error: MathJaxSwiftTests.texErrorOutput))
    }
  }
  
}
