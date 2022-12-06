import JavaScriptCore
import XCTest
@testable import MathJaxSwift

final class InputProcessorOptionsTests: XCTestCase {
  
  func testTeXInputProcessorIdentity() throws {
    let context = JSContext()
    XCTAssertNotNil(context)
    
    context?.setObject(TeXInputProcessorOptions.self, forKeyedSubscript: "TeXInputProcessorOptions" as NSString)
    XCTAssertNil(context?.exception)
    
    context?.evaluateScript(MathJaxSwiftTests.identityScript)
    XCTAssertNil(context?.exception)
    
    let inputOptions = TeXInputProcessorOptions(packages: ["test"])
    let createOptions = context?.objectForKeyedSubscript("identity")
    XCTAssertNotNil(createOptions)
    
    let outputOptions = createOptions?.call(withArguments: [inputOptions])
    XCTAssertNotNil(outputOptions)
    XCTAssertTrue(outputOptions?.isObject == true)
    
    let obj = outputOptions?.toObjectOf(TeXInputProcessorOptions.self) as? TeXInputProcessorOptions
    XCTAssertEqual(inputOptions, obj)
  }
  
  func testMathMLInputProcessorIdentity() throws {
    let context = JSContext()
    XCTAssertNotNil(context)
    
    context?.setObject(MathMLInputProcessorOptions.self, forKeyedSubscript: "MathMLInputProcessorOptions" as NSString)
    XCTAssertNil(context?.exception)
    
    context?.evaluateScript(MathJaxSwiftTests.identityScript)
    XCTAssertNil(context?.exception)
    
    let inputOptions = MathMLInputProcessorOptions()
    let createOptions = context?.objectForKeyedSubscript("identity")
    XCTAssertNotNil(createOptions)
    
    let outputOptions = createOptions?.call(withArguments: [inputOptions])
    XCTAssertNotNil(outputOptions)
    XCTAssertTrue(outputOptions?.isObject == true)
    
    let obj = outputOptions?.toObjectOf(MathMLInputProcessorOptions.self) as? MathMLInputProcessorOptions
    XCTAssertEqual(inputOptions, obj)
  }
  
  func testMathMLValidInputProcessorIdentity() throws {
    let context = JSContext()
    XCTAssertNotNil(context)
    
    context?.setObject(MathMLInputProcessorOptions.Verify.self, forKeyedSubscript: "Verify" as NSString)
    XCTAssertNil(context?.exception)
    
    context?.evaluateScript(MathJaxSwiftTests.identityScript)
    XCTAssertNil(context?.exception)
    
    let inputOptions = MathMLInputProcessorOptions.Verify()
    let createOptions = context?.objectForKeyedSubscript("identity")
    XCTAssertNotNil(createOptions)
    
    let outputOptions = createOptions?.call(withArguments: [inputOptions])
    XCTAssertNotNil(outputOptions)
    XCTAssertTrue(outputOptions?.isObject == true)
    
    let obj = outputOptions?.toObjectOf(MathMLInputProcessorOptions.Verify.self) as? MathMLInputProcessorOptions.Verify
    XCTAssertEqual(inputOptions, obj)
  }
  
}
