import XCTest
@testable import MathJaxSwift

final class MMLParserTests: XCTestCase {
  
  let errorData = MathJaxSwiftTests.loadString(fromFile: "Error/testMML", withExtension: "xml")
  
  func testValidate() throws {
    XCTAssertThrowsError(try MMLParser.shared.validate(errorData)) { error in
      guard let error = error as? MJError else {
        XCTFail("Unknown error.")
        return
      }
      XCTAssertEqual(error, .conversionError(error: MathJaxSwiftTests.texErrorOutput))
    }
  }
  
}
