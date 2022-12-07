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
  
}
