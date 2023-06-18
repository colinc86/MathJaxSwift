import XCTest
@testable import MathJaxSwift

final class Tex2SVGTests: XCTestCase {
  
  let svgData = MathJaxSwiftTests.loadString(fromFile: "No Error/testSVG", withExtension: "svg")
  let svgTagData = MathJaxSwiftTests.loadString(fromFile: "No Error/testSVGTag", withExtension: "svg")
  let svgErrorData = MathJaxSwiftTests.loadString(fromFile: "Error/testSVG", withExtension: "svg")
  let svgErrorDataNoErrors = MathJaxSwiftTests.loadString(fromFile: "Error/testSVGnoerrors", withExtension: "svg")
  var mathjax: MathJax!
  
  override func setUp() async throws {
    mathjax = try MathJax(preferredOutputFormat: .svg)
  }
  
  func testTex2SVGSync() throws {
    let documentOptions = DocumentOptions(font: DocumentOptions.Fonts.tex)
    let output = try mathjax.tex2svg(MathJaxSwiftTests.texInput, documentOptions: documentOptions)
    print(output)
    print("asdfasdfasdf\n\n\n\n")
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
  
  func testTex2SVGTags() async throws {
    let input = """
\\begin{equation}
  E = mc^2 \\tag{1}
\\end{equation}
"""

    let options = TeXInputProcessorOptions(loadPackages: TeXInputProcessorOptions.Packages.all, tags: TeXInputProcessorOptions.Tags.ams)
    let output = try await mathjax.tex2svg(input, inputOptions: options)
    XCTAssertEqual(output, svgTagData)
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
