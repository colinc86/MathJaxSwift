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
    
    let inputOptions = TeXInputProcessorOptions()
    let createOptions = context?.objectForKeyedSubscript("identity")
    XCTAssertNotNil(createOptions)
    
    let outputOptions = createOptions?.call(withArguments: [inputOptions])
    XCTAssertNotNil(outputOptions)
    XCTAssertTrue(outputOptions?.isObject == true)
    
    let obj = outputOptions?.toObjectOf(TeXInputProcessorOptions.self) as? TeXInputProcessorOptions
    XCTAssertEqual(inputOptions, obj)
  }
  
  func testTeXInputProcessorOptionsAreCodable() throws {
    let options = TeXInputProcessorOptions(loadPackages: ["test"])
    let optionsData = try JSONEncoder().encode(options)
    XCTAssertNoThrow(optionsData)
    
    let decodedOptions = try JSONDecoder().decode(TeXInputProcessorOptions.self, from: optionsData)
    XCTAssertNoThrow(decodedOptions)
    XCTAssertEqual(options.loadPackages, decodedOptions.loadPackages)
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
  
  func testMathMLInputProcessorOptionsAreCodable() throws {
    let options = MMLInputProcessorOptions(parseAs: MMLInputProcessorOptions.Parsers.xml, forceReparse: true, parseError: nil, verify: MMLInputProcessorOptions.Verify())
    let optionsData = try JSONEncoder().encode(options)
    XCTAssertNoThrow(optionsData)
    
    let decodedOptions = try JSONDecoder().decode(MMLInputProcessorOptions.self, from: optionsData)
    XCTAssertNoThrow(decodedOptions)
    XCTAssertEqual(options.parseAs, decodedOptions.parseAs)
    XCTAssertEqual(options.forceReparse, decodedOptions.forceReparse)
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
  
  func testMathMLValidInputProcessorOptionsAreCodable() throws {
    let options = MMLInputProcessorOptions.Verify(checkArity: true, checkAttributes: true, fullErrors: true, fixMmultiscripts: true, fixMtables: true)
    let optionsData = try JSONEncoder().encode(options)
    XCTAssertNoThrow(optionsData)
    
    let decodedOptions = try JSONDecoder().decode(MMLInputProcessorOptions.Verify.self, from: optionsData)
    XCTAssertNoThrow(decodedOptions)
    XCTAssertEqual(options.checkArity, decodedOptions.checkArity)
    XCTAssertEqual(options.checkAttributes, decodedOptions.checkAttributes)
    XCTAssertEqual(options.fullErrors, decodedOptions.fullErrors)
    XCTAssertEqual(options.fixMmultiscripts, decodedOptions.fixMmultiscripts)
    XCTAssertEqual(options.fixMtables, decodedOptions.fixMtables)
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
  
  func testASCIIMathInputProcessorOptionsAreCodable() throws {
    let options = AMInputProcessorOptions(fixphi: true, displaystyle: true, decimalsign: "test")
    let optionsData = try JSONEncoder().encode(options)
    XCTAssertNoThrow(optionsData)
    
    let decodedOptions = try JSONDecoder().decode(AMInputProcessorOptions.self, from: optionsData)
    XCTAssertNoThrow(decodedOptions)
    XCTAssertEqual(options.fixphi, decodedOptions.fixphi)
    XCTAssertEqual(options.displaystyle, decodedOptions.displaystyle)
    XCTAssertEqual(options.decimalsign, decodedOptions.decimalsign)
  }
  
}
