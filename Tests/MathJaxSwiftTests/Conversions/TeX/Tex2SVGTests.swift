import XCTest
@testable import MathJaxSwift

final class Tex2SVGTests: XCTestCase {
  
  let svgData = MathJaxSwiftTests.loadString(fromFile: "No Error/testSVG", withExtension: "svg")
  let svgErrorData = MathJaxSwiftTests.loadString(fromFile: "Error/testSVG", withExtension: "svg")
  let svgErrorDataNoErrors = MathJaxSwiftTests.loadString(fromFile: "Error/testSVGnoerrors", withExtension: "svg")
  var mathjax: MathJax!
  
  override func setUp() async throws {
    mathjax = try MathJax(preferredOutputFormat: .svg)
  }
  
  func testTex2SVGSync() throws {
    let output = try mathjax.tex2svg(MathJaxSwiftTests.texInput)
    XCTAssertEqual(output, svgData)
  }
  
  func testTex2SVGSyncNoError() throws {
    var error: Error?
    let output = mathjax.tex2svg(MathJaxSwiftTests.texInput, error: &error)
    XCTAssertEqual(output, svgData)
    XCTAssertNil(error)
  }
  
  func testTex2SVGSyncError() throws {
    var error: Error?
    let output = mathjax.tex2svg(MathJaxSwiftTests.texErrorInput, error: &error)
    XCTAssertEqual(output, svgErrorData)
    if let error = error as? MathJaxError {
      XCTAssertEqual(error, MathJaxError.conversionError(error: MathJaxSwiftTests.texErrorOutput))
    }
    else {
      XCTFail("Unknown error.")
    }
  }
  
  func testTex2SVGSyncErrorNoErrors() throws {
    var error: Error?
    let output = mathjax.tex2svg(
      MathJaxSwiftTests.texErrorInput,
      inputOptions: TeXInputProcessorOptions(
        loadPackages: [
          TeXInputProcessorOptions.Packages.base,
          TeXInputProcessorOptions.Packages.noerrors]),
      error: &error)
    XCTAssertEqual(output, svgErrorDataNoErrors)
    if let error = error as? MathJaxError {
      XCTAssertEqual(error, MathJaxError.conversionError(error: MathJaxSwiftTests.texErrorOutput))
    }
    else {
      XCTFail("Unknown error.")
    }
  }
  
  func testTex2SVGAsync() async throws {
    let output = try await mathjax.tex2svg(MathJaxSwiftTests.texInput)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, svgData)
  }
  
  func testTex2SVGError() {
    XCTAssertThrowsError(try mathjax.tex2svg(MathJaxSwiftTests.texErrorInput)) { error in
      guard let error = error as? MathJaxError else {
        XCTFail("Unknown error.")
        return
      }
      XCTAssertEqual(error, MathJaxError.conversionError(error: MathJaxSwiftTests.texErrorOutput))
    }
  }
  
  func testTex2SVGTime() {
    measure {
      let output = try? mathjax.tex2svg(MathJaxSwiftTests.texInput)
      XCTAssertNotNil(output)
    }
  }
  
}
