import JavaScriptCore
import XCTest
@testable import MathJaxSwift

final class InputProcessorOptionsTests: XCTestCase {
  
  func testTeXInputProcessorIdentity() throws {
    let context = JSContext()
    XCTAssertNotNil(context)
    
    context?.setObject(TexInputProcessorOptions.self, forKeyedSubscript: "TeXInputProcessorOptions" as NSString)
    XCTAssertNil(context?.exception)
    
    context?.evaluateScript(MathJaxSwiftTests.identityScript)
    XCTAssertNil(context?.exception)
    
    let inputOptions = TexInputProcessorOptions(packages: ["test"])
    let createOptions = context?.objectForKeyedSubscript("identity")
    XCTAssertNotNil(createOptions)
    
    let outputOptions = createOptions?.call(withArguments: [inputOptions])
    XCTAssertNotNil(outputOptions)
    XCTAssertTrue(outputOptions?.isObject == true)
    
    let obj = outputOptions?.toObjectOf(TexInputProcessorOptions.self) as? TexInputProcessorOptions
    XCTAssertEqual(inputOptions, obj)
  }
  
  func testMathMLInputProcessorIdentity() throws {
    let context = JSContext()
    XCTAssertNotNil(context)
    
    context?.setObject(MMLInputProcessorOptions.self, forKeyedSubscript: "MathMLInputProcessorOptions" as NSString)
    XCTAssertNil(context?.exception)
    
    context?.evaluateScript(MathJaxSwiftTests.identityScript)
    XCTAssertNil(context?.exception)
    
    let inputOptions = MMLInputProcessorOptions()
    let createOptions = context?.objectForKeyedSubscript("identity")
    XCTAssertNotNil(createOptions)
    
    let outputOptions = createOptions?.call(withArguments: [inputOptions])
    XCTAssertNotNil(outputOptions)
    XCTAssertTrue(outputOptions?.isObject == true)
    
    let obj = outputOptions?.toObjectOf(MMLInputProcessorOptions.self) as? MMLInputProcessorOptions
    XCTAssertEqual(inputOptions, obj)
  }
  
  func testMathMLValidInputProcessorIdentity() throws {
    let context = JSContext()
    XCTAssertNotNil(context)
    
    context?.setObject(MMLInputProcessorOptions.Verify.self, forKeyedSubscript: "Verify" as NSString)
    XCTAssertNil(context?.exception)
    
    context?.evaluateScript(MathJaxSwiftTests.identityScript)
    XCTAssertNil(context?.exception)
    
    let inputOptions = MMLInputProcessorOptions.Verify()
    let createOptions = context?.objectForKeyedSubscript("identity")
    XCTAssertNotNil(createOptions)
    
    let outputOptions = createOptions?.call(withArguments: [inputOptions])
    XCTAssertNotNil(outputOptions)
    XCTAssertTrue(outputOptions?.isObject == true)
    
    let obj = outputOptions?.toObjectOf(MMLInputProcessorOptions.Verify.self) as? MMLInputProcessorOptions.Verify
    XCTAssertEqual(inputOptions, obj)
  }
  
  func testASCIIMathInputProcessorIdentity() throws {
    let context = JSContext()
    XCTAssertNotNil(context)
    
    context?.setObject(AMInputProcessorOptions.self, forKeyedSubscript: "AMInputProcessorOptions" as NSString)
    XCTAssertNil(context?.exception)
    
    context?.evaluateScript(MathJaxSwiftTests.identityScript)
    XCTAssertNil(context?.exception)
    
    let inputOptions = AMInputProcessorOptions(decimalsign: "-")
    let createOptions = context?.objectForKeyedSubscript("identity")
    XCTAssertNotNil(createOptions)
    
    let outputOptions = createOptions?.call(withArguments: [inputOptions])
    XCTAssertNotNil(outputOptions)
    XCTAssertTrue(outputOptions?.isObject == true)
    
    let obj = outputOptions?.toObjectOf(AMInputProcessorOptions.self) as? AMInputProcessorOptions
    XCTAssertEqual(inputOptions, obj)
  }
  
}
