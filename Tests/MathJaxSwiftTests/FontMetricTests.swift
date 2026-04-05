import XCTest
@testable import MathJaxSwift

final class FontMetricTests: XCTestCase {

  func testUnknownCharWidth_affectsViewBox() throws {
    let mj = try MathJax(preferredOutputFormat: .svg)

    let wide = SVGOutputProcessorOptions(unknownCharWidth: 0.8, mtextFont: "serif")
    let narrow = SVGOutputProcessorOptions(unknownCharWidth: 0.4, mtextFont: "serif")
    let defaultOpts = SVGOutputProcessorOptions(mtextFont: "serif")

    let wideResult = try mj.tex2svg("\\text{Hello}", styles: false, outputOptions: wide)
    let narrowResult = try mj.tex2svg("\\text{Hello}", styles: false, outputOptions: narrow)
    let defaultResult = try mj.tex2svg("\\text{Hello}", styles: false, outputOptions: defaultOpts)

    print("Wide (0.8em): \(wideResult.prefix(200))")
    print("Narrow (0.4em): \(narrowResult.prefix(200))")
    print("Default (0.6em): \(defaultResult.prefix(200))")

    // Extract viewBox width from SVG
    func viewBoxWidth(_ svg: String) -> Double? {
      guard let range = svg.range(of: #"viewBox="[^"]+""#, options: .regularExpression) else { return nil }
      let vb = String(svg[range]).replacingOccurrences(of: "viewBox=\"", with: "").replacingOccurrences(of: "\"", with: "")
      let parts = vb.split(separator: " ")
      return parts.count >= 3 ? Double(parts[2]) : nil
    }

    let wideWidth = viewBoxWidth(wideResult)
    let narrowWidth = viewBoxWidth(narrowResult)
    let defaultWidth = viewBoxWidth(defaultResult)

    XCTAssertNotNil(wideWidth)
    XCTAssertNotNil(narrowWidth)
    XCTAssertNotNil(defaultWidth)
    XCTAssertGreaterThan(wideWidth!, narrowWidth!, "Wider char estimate should produce wider viewBox")
    XCTAssertGreaterThan(defaultWidth!, narrowWidth!, "Default 0.6 should be wider than 0.4")
    XCTAssertGreaterThan(wideWidth!, defaultWidth!, "0.8 should be wider than default 0.6")
  }

  func testDefaultValues() throws {
    let opts = SVGOutputProcessorOptions()
    XCTAssertEqual(opts.unknownCharWidth, 0.6)
    XCTAssertEqual(opts.unknownCharHeight, 0.8)
    XCTAssertEqual(opts.cjkCharWidth, 1.0)
  }

  func testSerialization() throws {
    let opts = SVGOutputProcessorOptions(unknownCharWidth: 0.5, unknownCharHeight: 0.9, cjkCharWidth: 1.2)
    let dict = try opts.toDictionary()
    XCTAssertEqual(dict["unknownCharWidth"] as? Double, 0.5)
    XCTAssertEqual(dict["unknownCharHeight"] as? Double, 0.9)
    XCTAssertEqual(dict["cjkCharWidth"] as? Double, 1.2)
  }
}
