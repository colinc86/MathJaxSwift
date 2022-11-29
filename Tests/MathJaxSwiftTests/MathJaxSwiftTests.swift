import XCTest
@testable import MathJaxSwift

final class MathJaxSwiftTests: XCTestCase {
  
  static func loadString(fromFile fileName: String, withExtension fileExtension: String) -> String {
    let url = Bundle.module.url(forResource: fileName, withExtension: fileExtension)!
    return (try! String(contentsOf: url)).trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  let mathJaxVersion = "3.2.2"
  let texInput = "\\TeX{}"
  let texSVGOutput = loadString(fromFile: "tex2svg", withExtension: "svg")
  let texCHTMLOutput = loadString(fromFile: "tex2chtml", withExtension: "html")
  let texMMLOutput = loadString(fromFile: "tex2mml", withExtension: "xml")
  var mathjax: MathJax!
  
  override func setUp() async throws {
    mathjax = try MathJax()
  }
  
  func testBundle() throws {
    XCTAssertNotNil(mathjax)
    XCTAssertNoThrow(mathjax)
  }
  
  func testMetadata() throws {
    // Test that we can get the package metadata
    let metadata = try MathJax.metadata()
    XCTAssertNoThrow(metadata)
    
    // Make sure we know which version we're dealing with.
    XCTAssertEqual(metadata.version, mathJaxVersion)
    
    // Make sure the URL is correct
    XCTAssertEqual(metadata.resolved.absoluteString, "https://registry.npmjs.org/mathjax-full/-/mathjax-full-\(metadata.version).tgz")
  }
  
  func testTex2SVGSync() throws {
    let output = try mathjax.tex2svg(texInput)
    XCTAssertEqual(output, texSVGOutput)
  }
  
  func testTex2SVGAsync() async throws {
    let output = try await mathjax.tex2svg(texInput)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, texSVGOutput)
  }
  
  func testTex2SVGTime() {
    measure {
      let output = try? mathjax.tex2svg(texInput)
      XCTAssertNotNil(output)
    }
  }
  
  func testTex2CHTMLSync() throws {
    let output = try mathjax.tex2chtml(texInput)
    XCTAssertEqual(output, texCHTMLOutput)
  }
  
  func testTex2CHTMLAsync() async throws {
    let output = try await mathjax.tex2chtml(texInput)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, texCHTMLOutput)
  }
  
  func testTex2CHTMLTime() {
    measure {
      let output = try? mathjax.tex2chtml(texInput)
      XCTAssertNotNil(output)
    }
  }
  
  func testTex2MMLSync() throws {
    let output = try mathjax.tex2mml(texInput)
    XCTAssertEqual(output, texMMLOutput)
  }
  
  func testTex2MMLAsync() async throws {
    let output = try await mathjax.tex2mml(texInput)
    XCTAssertNoThrow(output)
    XCTAssertEqual(output, texMMLOutput)
  }
  
  func testTex2MMLTime() {
    measure {
      let output = try? mathjax.tex2mml(texInput)
      XCTAssertNotNil(output)
    }
  }
  
}
