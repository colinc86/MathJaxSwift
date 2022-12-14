import JavaScriptCore
import XCTest
@testable import MathJaxSwift

final class OutputProcessorOptionsTests: XCTestCase {
  
  func testCHTMLOutputProcessorIdentity() throws {
    let context = JSContext()
    XCTAssertNotNil(context)
    
    context?.setObject(CHTMLOutputProcessorOptions.self, forKeyedSubscript: "CHTMLOutputProcessorOptions" as NSString)
    XCTAssertNil(context?.exception)
    
    context?.evaluateScript(MathJaxSwiftTests.identityScript)
    XCTAssertNil(context?.exception)
    
    let inputOptions = CHTMLOutputProcessorOptions(mtextFont: "test")
    let createOptions = context?.objectForKeyedSubscript("identity")
    XCTAssertNotNil(createOptions)
    
    let outputOptions = createOptions?.call(withArguments: [inputOptions])
    XCTAssertNotNil(outputOptions)
    XCTAssertTrue(outputOptions?.isObject == true)
    
    let obj = outputOptions?.toObjectOf(CHTMLOutputProcessorOptions.self) as? CHTMLOutputProcessorOptions
    XCTAssertEqual(inputOptions, obj)
  }
  
  func testCHTMLOutputProcessorOptionsAreCodable() throws {
    let options = CHTMLOutputProcessorOptions(matchFontHeight: true)
    let optionsData = try JSONEncoder().encode(options)
    XCTAssertNoThrow(optionsData)
    
    let decodedOptions = try JSONDecoder().decode(CHTMLOutputProcessorOptions.self, from: optionsData)
    XCTAssertNoThrow(decodedOptions)
    XCTAssertEqual(options.matchFontHeight, decodedOptions.matchFontHeight)
  }
  
  func testSVGOutputProcessorIdentity() throws {
    let context = JSContext()
    XCTAssertNotNil(context)
    
    context?.setObject(SVGOutputProcessorOptions.self, forKeyedSubscript: "SVGOutputProcessorOptions" as NSString)
    XCTAssertNil(context?.exception)
    
    context?.evaluateScript(MathJaxSwiftTests.identityScript)
    XCTAssertNil(context?.exception)
    
    let inputOptions = SVGOutputProcessorOptions(mtextFont: "test")
    let createOptions = context?.objectForKeyedSubscript("identity")
    XCTAssertNotNil(createOptions)
    
    let outputOptions = createOptions?.call(withArguments: [inputOptions])
    XCTAssertNotNil(outputOptions)
    XCTAssertTrue(outputOptions?.isObject == true)
    
    let obj = outputOptions?.toObjectOf(SVGOutputProcessorOptions.self) as? SVGOutputProcessorOptions
    XCTAssertEqual(inputOptions, obj)
  }
  
  func testSVGOutputProcessorOptionsAreCodable() throws {
    let options = SVGOutputProcessorOptions(fontCache: SVGOutputProcessorOptions.FontCaches.local)
    let optionsData = try JSONEncoder().encode(options)
    XCTAssertNoThrow(optionsData)
    
    let decodedOptions = try JSONDecoder().decode(SVGOutputProcessorOptions.self, from: optionsData)
    XCTAssertNoThrow(decodedOptions)
    XCTAssertEqual(options.fontCache, decodedOptions.fontCache)
  }
  
}
