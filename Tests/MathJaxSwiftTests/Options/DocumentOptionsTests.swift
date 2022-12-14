import JavaScriptCore
import XCTest
@testable import MathJaxSwift

final class DocumentOptionsTests: XCTestCase {
  
  func testDocumentOptionsIdentity() throws {
    let context = JSContext()
    XCTAssertNotNil(context)
    
    context?.setObject(DocumentOptions.self, forKeyedSubscript: "DocumentOptions" as NSString)
    XCTAssertNil(context?.exception)
    
    context?.evaluateScript(MathJaxSwiftTests.identityScript)
    XCTAssertNil(context?.exception)
    
    let inputOptions = DocumentOptions()
    let createOptions = context?.objectForKeyedSubscript("identity")
    XCTAssertNotNil(createOptions)
    
    let outputOptions = createOptions?.call(withArguments: [inputOptions])
    XCTAssertNil(context?.exception)
    XCTAssertNotNil(outputOptions)
    XCTAssertTrue(outputOptions?.isObject == true)
    
    let obj = outputOptions?.toObjectOf(DocumentOptions.self) as? DocumentOptions
    XCTAssertEqual(inputOptions, obj)
  }
  
  func testDocumentOptionsAreCodable() throws {
    let options = DocumentOptions(
      skipHtmlTags: ["test"],
      includeHtmlTags: ["test": "test"],
      ignoreHtmlClass: "test",
      processHtmlClass: "test",
      compileError: nil,
      typesetError: nil)
    let optionsData = try JSONEncoder().encode(options)
    XCTAssertNoThrow(optionsData)
    
    let decodedOptions = try JSONDecoder().decode(DocumentOptions.self, from: optionsData)
    XCTAssertNoThrow(decodedOptions)
    XCTAssertEqual(options.skipHtmlTags, decodedOptions.skipHtmlTags)
    XCTAssertEqual(options.includeHtmlTags, decodedOptions.includeHtmlTags)
    XCTAssertEqual(options.ignoreHtmlClass, decodedOptions.ignoreHtmlClass)
    XCTAssertEqual(options.processHtmlClass, decodedOptions.processHtmlClass)
  }
  
}
