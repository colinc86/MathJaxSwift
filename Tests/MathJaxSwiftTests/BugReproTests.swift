import XCTest
@testable import MathJaxSwift

final class BugReproTests: XCTestCase {

  // MARK: - blacker property

  func testBlacker_default() throws {
    let opts = SVGOutputProcessorOptions()
    XCTAssertEqual(opts.blacker, 3)
  }

  func testBlacker_custom() throws {
    let opts = SVGOutputProcessorOptions(blacker: 5)
    XCTAssertEqual(opts.blacker, 5)
    let dict = try opts.toDictionary()
    XCTAssertEqual(dict["blacker"] as? Int, 5)
  }

  func testBlacker_perRender() throws {
    let mj = try MathJax(preferredOutputFormat: .svg)
    let svg3 = try mj.tex2svg("x^2", outputOptions: SVGOutputProcessorOptions())
    let svg5 = try mj.tex2svg("x^2", outputOptions: SVGOutputProcessorOptions(blacker: 5))
    let svg1 = try mj.tex2svg("x^2", outputOptions: SVGOutputProcessorOptions(blacker: 1))
    XCTAssertTrue(svg3.contains("stroke-width:3px"))
    XCTAssertTrue(svg5.contains("stroke-width:5px"))
    XCTAssertTrue(svg1.contains("stroke-width:1px"))
  }

  // MARK: - displayIndent type (String)

  func testDisplayIndent_isString() throws {
    let opts = SVGOutputProcessorOptions(displayIndent: "1em")
    XCTAssertEqual(opts.displayIndent, "1em")
    let dict = try opts.toDictionary()
    XCTAssertEqual(dict["displayIndent"] as? String, "1em")
  }

  // MARK: - displayAlign "right" no longer crashes

  func testDisplayAlign_right_noStyles() throws {
    let mathjax = try MathJax(preferredOutputFormat: .svg)
    let opts = SVGOutputProcessorOptions(displayAlign: "right")
    let result = try mathjax.tex2svg("\\frac{2}{3}", styles: false, outputOptions: opts)
    XCTAssertGreaterThan(result.count, 0, "displayAlign right + styles:false should produce output")
  }

  func testDisplayAlign_right_withStyles() throws {
    let mathjax = try MathJax(preferredOutputFormat: .svg)
    let opts = SVGOutputProcessorOptions(displayAlign: "right")
    let result = try mathjax.tex2svg("\\frac{2}{3}", styles: true, outputOptions: opts)
    XCTAssertGreaterThan(result.count, 0, "displayAlign right + styles:true should produce output")
  }

  func testDisplayAlign_left() throws {
    let mathjax = try MathJax(preferredOutputFormat: .svg)
    let opts = SVGOutputProcessorOptions(displayAlign: "left")
    let result = try mathjax.tex2svg("\\frac{2}{3}", styles: false, outputOptions: opts)
    XCTAssertGreaterThan(result.count, 0, "displayAlign left should produce output")
  }

  // MARK: - Dynamic font variants on sequential calls

  func testSequentialDynamicFontVariants() throws {
    let mj = try MathJax(preferredOutputFormat: .svg)

    // Warm up with a base-font expression
    let baseline = try mj.tex2svg("x^2")
    XCTAssertGreaterThan(baseline.count, 100)

    // Each of these needs dynamic font data and must work on the same instance
    let cases: [(String, String)] = [
      ("\\textsf{Hello}", "sans-serif text"),
      ("\\texttt{Hello}", "monospace text"),
      ("\\mathcal{ABC}", "calligraphic"),
      ("\\mathfrak{ABC}", "fraktur"),
      ("\\mathbb{R}", "double-struck"),
      ("\\mathscr{L}", "script"),
      ("\\text{Ü}", "accented"),
      ("\\alpha + \\beta", "greek"),
      ("\\textsf{World}", "sans-serif again"),
    ]

    for (input, label) in cases {
      let result = try mj.tex2svg(input)
      XCTAssertGreaterThan(result.count, 100, "\(label) should produce SVG output")
    }
  }
}
