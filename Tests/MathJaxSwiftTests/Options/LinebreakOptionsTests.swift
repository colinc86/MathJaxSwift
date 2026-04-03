import JavaScriptCore
import XCTest
@testable import MathJaxSwift

final class LinebreakOptionsTests: XCTestCase {

  func testLinebreakOptionsAreCodable() throws {
    let options = LinebreakOptions(inline: true, width: "50em", lineleading: ".5em")
    let optionsData = try JSONEncoder().encode(options)
    XCTAssertNoThrow(optionsData)

    let decodedOptions = try JSONDecoder().decode(LinebreakOptions.self, from: optionsData)
    XCTAssertNoThrow(decodedOptions)
    XCTAssertEqual(options.inline, decodedOptions.inline)
    XCTAssertEqual(options.width, decodedOptions.width)
    XCTAssertEqual(options.lineleading, decodedOptions.lineleading)
  }

  func testLinebreakOptionsJSExportIdentity() throws {
    let context = JSContext()
    XCTAssertNotNil(context)

    context?.setObject(LinebreakOptions.self, forKeyedSubscript: "LinebreakOptions" as NSString)
    XCTAssertNil(context?.exception)

    context?.evaluateScript(MathJaxSwiftTests.identityScript)
    XCTAssertNil(context?.exception)

    let inputOptions = LinebreakOptions(inline: true, width: "50em", lineleading: ".5em")
    let createOptions = context?.objectForKeyedSubscript("identity")
    XCTAssertNotNil(createOptions)

    let outputOptions = createOptions?.call(withArguments: [inputOptions])
    XCTAssertNotNil(outputOptions)
    XCTAssertTrue(outputOptions?.isObject == true)

    let obj = outputOptions?.toObjectOf(LinebreakOptions.self) as? LinebreakOptions
    XCTAssertEqual(inputOptions, obj)
  }

  func testLinebreakOptionsToDictionary() throws {
    let options = LinebreakOptions(inline: true, width: "50em", lineleading: ".5em")
    let dict = try options.toDictionary()
    XCTAssertEqual(dict["inline"] as? Bool, true)
    XCTAssertEqual(dict["width"] as? String, "50em")
    XCTAssertEqual(dict["lineleading"] as? String, ".5em")
  }

}
