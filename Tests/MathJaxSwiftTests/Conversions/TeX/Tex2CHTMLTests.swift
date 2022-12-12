import XCTest
@testable import MathJaxSwift

final class Tex2CHTMLTests: XCTestCase {
  
  let chtmlData = MathJaxSwiftTests.loadString(fromFile: "No Error/testCHTML", withExtension: "html")
  let chtmlErrorData = MathJaxSwiftTests.loadString(fromFile: "Error/testCHTML", withExtension: "html")
  let chtmlErrorDataNoErrors = MathJaxSwiftTests.loadString(fromFile: "Error/testCHTMLnoerrors", withExtension: "html")
  var mathjax: MathJax!
  
  override func setUp() async throws {
    mathjax = try MathJax(preferredOutputFormat: .chtml)
  }
  
  func testTex2CHTMLSync() throws {
    let output = try mathjax.tex2chtml(MathJaxSwiftTests.texInput)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, chtmlData)
  }
  
  func testTex2CHTMLSyncNoError() throws {
    var error: Error?
    let output = mathjax.tex2chtml(MathJaxSwiftTests.texInput, error: &error)
    XCTAssertEqual(output, chtmlData)
    XCTAssertNil(error)
  }
  
  func testTex2CHTMLSyncError() throws {
    var error: Error?
    let output = mathjax.tex2chtml(MathJaxSwiftTests.texErrorInput, error: &error)
    XCTAssertEqual(output, chtmlErrorData)
    if let error = error as? MathJaxError {
      XCTAssertEqual(error, MathJaxError.conversionError(error: MathJaxSwiftTests.texErrorOutput))
    }
    else {
      XCTFail("Unknown error.")
    }
  }
  
  func testTex2CHTMLSyncErrorNoErrors() throws {
    var error: Error?
    let output = mathjax.tex2chtml(
      MathJaxSwiftTests.texErrorInput,
      inputOptions: TexInputProcessorOptions(
        loadPackages: [
          TexInputProcessorOptions.Packages.base,
          TexInputProcessorOptions.Packages.noerrors]),
      error: &error)
    XCTAssertEqual(output, chtmlErrorDataNoErrors)
    if let error = error as? MathJaxError {
      XCTAssertEqual(error, MathJaxError.conversionError(error: MathJaxSwiftTests.texErrorOutput))
    }
    else {
      XCTFail("Unknown error.")
    }
  }
  
  func testTex2CHTMLAsync() async throws {
    let output = try await mathjax.tex2chtml(MathJaxSwiftTests.texInput)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, chtmlData)
  }
  
  func testTex2CHTMLError() {
    XCTAssertThrowsError(try mathjax.tex2chtml(MathJaxSwiftTests.texErrorInput)) { error in
      guard let error = error as? MathJaxError else {
        XCTFail("Unknown error.")
        return
      }
      XCTAssertEqual(error, MathJaxError.conversionError(error: MathJaxSwiftTests.texErrorOutput))
    }
  }
  
  func testTex2CHTMLTime() {
    measure {
      let output = try? mathjax.tex2chtml(MathJaxSwiftTests.texInput)
      XCTAssertNotNil(output)
    }
  }
  
}
