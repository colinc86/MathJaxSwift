import XCTest
@testable import MathJaxSwift

final class SafeOptionsTests: XCTestCase {

  func testSafeOptionsAreCodable() throws {
    let allow = AllowOptions(URLs: AllowOptions.Allows.none, classes: AllowOptions.Allows.all)
    let protocols = SafeProtocols(javascript: true, data: true)
    let styles = SafeStyles(color: false, opacity: false)
    let options = SafeOptions(
      lengthMax: 5,
      classPattern: "^custom-",
      allowOptions: allow,
      safeProtocols: protocols,
      safeStyles: styles
    )

    let optionsData = try JSONEncoder().encode(options)
    XCTAssertNoThrow(optionsData)

    let decoded = try JSONDecoder().decode(SafeOptions.self, from: optionsData)
    XCTAssertNoThrow(decoded)
    XCTAssertEqual(decoded.lengthMax, 5)
    XCTAssertEqual(decoded.classPattern, "^custom-")
    XCTAssertEqual(decoded.allowOptions.URLs, AllowOptions.Allows.none)
    XCTAssertEqual(decoded.allowOptions.classes, AllowOptions.Allows.all)
    XCTAssertEqual(decoded.safeProtocols.javascript, true)
    XCTAssertEqual(decoded.safeProtocols.data, true)
    XCTAssertEqual(decoded.safeStyles.color, false)
    XCTAssertEqual(decoded.safeStyles.opacity, false)
  }

  func testSafeOptionsToDictionary() throws {
    let allow = AllowOptions(URLs: AllowOptions.Allows.none)
    let protocols = SafeProtocols(javascript: true)
    let options = SafeOptions(
      lengthMax: 5,
      allowOptions: allow,
      safeProtocols: protocols
    )

    let dict = try options.toDictionary()
    XCTAssertEqual(dict["lengthMax"] as? Int, 5)

    let allowDict = dict["allowOptions"] as? [String: Any]
    XCTAssertNotNil(allowDict)
    XCTAssertEqual(allowDict?["URLs"] as? String, "none")

    let protocolsDict = dict["safeProtocols"] as? [String: Any]
    XCTAssertNotNil(protocolsDict)
    XCTAssertEqual(protocolsDict?["javascript"] as? Bool, true)
  }

}
