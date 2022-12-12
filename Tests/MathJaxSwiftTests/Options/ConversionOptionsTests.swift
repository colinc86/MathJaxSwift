import JavaScriptCore
import XCTest
@testable import MathJaxSwift

final class ConversionOptionsTests: XCTestCase {
  
  func testConversionOptionsIdentity() throws {
    let context = JSContext()
    XCTAssertNotNil(context)
    
    context?.setObject(ConversionOptions.self, forKeyedSubscript: "ConversionOptions" as NSString)
    XCTAssertNil(context?.exception)
    
    context?.evaluateScript(MathJaxSwiftTests.identityScript)
    XCTAssertNil(context?.exception)
    
    let inputOptions = ConversionOptions()
    let createOptions = context?.objectForKeyedSubscript("identity")
    XCTAssertNotNil(createOptions)
    
    let outputOptions = createOptions?.call(withArguments: [inputOptions])
    XCTAssertNil(context?.exception)
    XCTAssertNotNil(outputOptions)
    XCTAssertTrue(outputOptions?.isObject == true)
    
    let obj = outputOptions?.toObjectOf(ConversionOptions.self) as? ConversionOptions
    XCTAssertEqual(inputOptions, obj)
  }
  
  func testConversionOptionsAreCodable() throws {
    let options = ConversionOptions(
      display: true,
      em: 100,
      ex: 1,
      containerWidth: -100,
      lineWidth: 99.9,
      scale: 2.0)
    let optionsData = try JSONEncoder().encode(options)
    XCTAssertNoThrow(optionsData)
    
    let decodedOptions = try JSONDecoder().decode(ConversionOptions.self, from: optionsData)
    XCTAssertNoThrow(decodedOptions)
    XCTAssertEqual(options.display, decodedOptions.display)
    XCTAssertEqual(options.em, decodedOptions.em)
    XCTAssertEqual(options.ex, decodedOptions.ex)
    XCTAssertEqual(options.containerWidth, decodedOptions.containerWidth)
    XCTAssertEqual(options.lineWidth, decodedOptions.lineWidth)
    XCTAssertEqual(options.scale, decodedOptions.scale)
  }
  
}
