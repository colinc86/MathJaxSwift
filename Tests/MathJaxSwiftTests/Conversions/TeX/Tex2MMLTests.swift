import XCTest
@testable import MathJaxSwift

final class Tex2MMLTests: XCTestCase {
  
  let mmlData = MathJaxSwiftTests.loadString(fromFile: "No Error/testMML", withExtension: "xml")
  let mmlErrorData = MathJaxSwiftTests.loadString(fromFile: "Error/testMML", withExtension: "xml")
  let mmlErrorDataNoErrors = MathJaxSwiftTests.loadString(fromFile: "Error/testMMLnoerrors", withExtension: "xml")
  var mathjax: MathJax!
  
  override func setUp() async throws {
    mathjax = try MathJax(preferredOutputFormat: .mml)
  }
  
  func testTex2MMLSync() throws {
    let output = try mathjax.tex2mml(MathJaxSwiftTests.texInput)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, mmlData)
  }
  
  func testTex2MMLSyncNoError() throws {
    var error: Error?
    let output = mathjax.tex2mml(MathJaxSwiftTests.texInput, error: &error)
    XCTAssertEqual(output, mmlData)
    XCTAssertNil(error)
  }
  
  func testTex2MMLSyncError() throws {
    var error: Error?
    let output = mathjax.tex2mml(MathJaxSwiftTests.texErrorInput, error: &error)
    XCTAssertEqual(output, mmlErrorData)
    if let error = error as? MathJaxError {
      XCTAssertEqual(error, MathJaxError.conversionError(error: MathJaxSwiftTests.texErrorOutput))
    }
    else {
      XCTFail("Unknown error.")
    }
  }
  
  func testTex2MMLSyncErrorNoErrors() throws {
    var error: Error?
    let output = mathjax.tex2mml(
      MathJaxSwiftTests.texErrorInput,
      inputOptions: TexInputProcessorOptions(
        loadPackages: [
          TexInputProcessorOptions.Packages.base,
          TexInputProcessorOptions.Packages.noerrors]),
      error: &error)
    XCTAssertEqual(output, mmlErrorDataNoErrors)
    if let error = error as? MathJaxError {
      XCTAssertEqual(error, MathJaxError.conversionError(error: MathJaxSwiftTests.texErrorOutput))
    }
    else {
      XCTFail("Unknown error.")
    }
  }
  
  func testTex2MMLAsync() async throws {
    let output = try await mathjax.tex2mml(MathJaxSwiftTests.texInput)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, mmlData)
  }
  
  func testTex2MMLError() {
    XCTAssertThrowsError(try mathjax.tex2mml(MathJaxSwiftTests.texErrorInput)) { error in
      guard let error = error as? MathJaxError else {
        XCTFail("Unknown error.")
        return
      }
      XCTAssertEqual(error, MathJaxError.conversionError(error: MathJaxSwiftTests.texErrorOutput))
    }
  }
  
  func testTex2MMLTime() {
    measure {
      let output = try? mathjax.tex2mml(MathJaxSwiftTests.texInput)
      XCTAssertNotNil(output)
    }
  }
  
}
