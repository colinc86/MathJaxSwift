import JavaScriptCore
import XCTest
@testable import MathJaxSwift

final class ContainerOptionsTests: XCTestCase {
  
  func testCHTMLContainerOptionsIdentity() throws {
    let context = JSContext()
    XCTAssertNotNil(context)
    
    context?.setObject(CHTMLContainerOptions.self, forKeyedSubscript: "CHTMLContainerOptions" as NSString)
    XCTAssertNil(context?.exception)
    
    context?.evaluateScript(MathJaxSwiftTests.identityScript)
    XCTAssertNil(context?.exception)
    
    let inputOptions = CHTMLContainerOptions(em: 1000.0)
    let createOptions = context?.objectForKeyedSubscript("identity")
    XCTAssertNotNil(createOptions)
    
    let outputOptions = createOptions?.call(withArguments: [inputOptions])
    XCTAssertNil(context?.exception)
    XCTAssertNotNil(outputOptions)
    XCTAssertTrue(outputOptions?.isObject == true)
    
    let obj = outputOptions?.toObjectOf(CHTMLContainerOptions.self) as? CHTMLContainerOptions
    XCTAssertEqual(inputOptions, obj)
  }
  
  func testSVGContainerOptionsIdentity() throws {
    let context = JSContext()
    XCTAssertNotNil(context)
    
    context?.setObject(SVGContainerOptions.self, forKeyedSubscript: "SVGContainerOptions" as NSString)
    XCTAssertNil(context?.exception)
    
    context?.evaluateScript(MathJaxSwiftTests.identityScript)
    XCTAssertNil(context?.exception)
    
    let inputOptions = SVGContainerOptions(em: 1000.0)
    let createOptions = context?.objectForKeyedSubscript("identity")
    XCTAssertNotNil(createOptions)
    
    let outputOptions = createOptions?.call(withArguments: [inputOptions])
    XCTAssertNotNil(outputOptions)
    XCTAssertTrue(outputOptions?.isObject == true)
    
    let obj = outputOptions?.toObjectOf(SVGContainerOptions.self) as? SVGContainerOptions
    XCTAssertEqual(inputOptions, obj)
  }
  
}
