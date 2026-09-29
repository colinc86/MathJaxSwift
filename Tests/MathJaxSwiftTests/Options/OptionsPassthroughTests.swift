import XCTest
@testable import MathJaxSwift

/// Tests that verify options are actually passed through to MathJax and affect output.
final class OptionsPassthroughTests: XCTestCase {

  // MARK: - toDictionary() unit tests

  func testConversionOptionsToDictionary() throws {
    let options = ConversionOptions(display: false, em: 32, ex: 16, containerWidth: 500, lineWidth: 80, scale: 2.0)
    let dict = try options.toDictionary()
    XCTAssertEqual(dict["display"] as? Bool, false)
    XCTAssertEqual(dict["em"] as? Double, 32)
    XCTAssertEqual(dict["ex"] as? Double, 16)
    XCTAssertEqual(dict["containerWidth"] as? Double, 500)
    XCTAssertEqual(dict["lineWidth"] as? Double, 80)
    XCTAssertEqual(dict["scale"] as? Double, 2.0)
  }

  func testTeXOptionsToDictionary() throws {
    let options = TeXInputProcessorOptions(
      loadPackages: [TeXInputProcessorOptions.Packages.base, TeXInputProcessorOptions.Packages.ams],
      tags: TeXInputProcessorOptions.Tags.ams
    )
    let dict = try options.toDictionary()
    XCTAssertEqual(dict["tags"] as? String, "ams")
    let packages = dict["loadPackages"] as? [String]
    XCTAssertNotNil(packages)
    XCTAssertTrue(packages?.contains("base") == true)
    XCTAssertTrue(packages?.contains("ams") == true)
  }

  func testNestedOptionsToDictionary() throws {
    let ams = AMSOptions(multilineWidth: "100%")
    let options = TeXInputProcessorOptions(ams: ams)
    let dict = try options.toDictionary()
    let amsDict = dict["ams"] as? [String: Any]
    XCTAssertNotNil(amsDict)
    XCTAssertEqual(amsDict?["multilineWidth"] as? String, "100%")
  }

  func testURLSerializesToString() throws {
    let url = URL(string: "https://example.com/fonts")!
    let options = CHTMLOutputProcessorOptions(fontURL: url)
    let dict = try options.toDictionary()
    XCTAssertEqual(dict["fontURL"] as? String, "https://example.com/fonts")
  }

  func testOutputProcessorOptionsToDictionary() throws {
    let options = SVGOutputProcessorOptions(
      fontCache: SVGOutputProcessorOptions.FontCaches.none,
      internalSpeechTitles: false,
      displayAlign: OutputProcessorOptions.DisplayAlignments.left
    )
    let dict = try options.toDictionary()
    XCTAssertEqual(dict["fontCache"] as? String, "none")
    XCTAssertEqual(dict["internalSpeechTitles"] as? Bool, false)
    XCTAssertEqual(dict["displayAlign"] as? String, "left")
  }

  // MARK: - Integration tests proving options reach MathJax

  func testDisplayFalseProducesInlineMath() throws {
    let mathjax = try MathJax(preferredOutputFormat: .mml)

    let blockOutput = try mathjax.tex2mml("x^2")
    let inlineOutput = try mathjax.tex2mml(
      "x^2",
      conversionOptions: ConversionOptions(display: false)
    )

    // Block math has display="block", inline does not
    XCTAssertTrue(blockOutput.contains("display=\"block\""), "Block output should contain display=\"block\"")
    XCTAssertFalse(inlineOutput.contains("display=\"block\""), "Inline output should not contain display=\"block\"")
  }

  func testDefaultDigitsDoNotConsumeFollowingCharacter() throws {
    // The default `digits` pattern reaches MathJax, so an unescaped `.` in it
    // would swallow the character after a number (e.g. the `}` in `x^{2}`).
    let mathjax = try MathJax(preferredOutputFormat: .svg)
    for input in ["x^{2}", "a^{10}", "a_{n-1}", "\\sum_{i=1}^n x_i", "\\left( \\sum_{i=1}^n a_i \\right)^2", "3.14", "1{,}000"] {
      XCTAssertNoThrow(try mathjax.tex2svg(input), "Failed to convert \(input)")
    }
  }

  func testDefaultDigitsMatchesMathJaxDefault() {
    XCTAssertEqual(
      TeXInputProcessorOptions.defaultDigits,
      #"^(?:[0-9]+(?:\{,\}[0-9]{3})*(?:\.[0-9]*)?|\.[0-9]+)"#
    )
  }

  func testSVGFontCacheNoneChangesOutput() throws {
    let mathjax = try MathJax(preferredOutputFormat: .svg)

    let defaultOutput = try mathjax.tex2svg("x^2")
    let noCacheOutput = try mathjax.tex2svg(
      "x^2",
      outputOptions: SVGOutputProcessorOptions(fontCache: SVGOutputProcessorOptions.FontCaches.none)
    )

    // With fontCache "none", glyphs are inlined rather than referenced via <use>
    XCTAssertNotEqual(defaultOutput, noCacheOutput, "fontCache 'none' should produce different SVG output")
  }

  func testOutputOptionsWithLinebreaksToDictionary() throws {
    let linebreaks = LinebreakOptions(inline: true, width: "50em", lineleading: ".5em")
    let options = SVGOutputProcessorOptions(linebreaks: linebreaks)
    let dict = try options.toDictionary()

    let linebreaksDict = dict["linebreaks"] as? [String: Any]
    XCTAssertNotNil(linebreaksDict)
    XCTAssertEqual(linebreaksDict?["inline"] as? Bool, true)
    XCTAssertEqual(linebreaksDict?["width"] as? String, "50em")
    XCTAssertEqual(linebreaksDict?["lineleading"] as? String, ".5em")
  }

  func testAMOptionsToDictionary() throws {
    let options = AMInputProcessorOptions(delimiters: [["$", "$"], ["~", "~"]])
    let dict = try options.toDictionary()

    let delimiters = dict["delimiters"] as? [[String]]
    XCTAssertNotNil(delimiters)
    XCTAssertEqual(delimiters?.count, 2)
    XCTAssertEqual(delimiters?[0], ["$", "$"])
    XCTAssertEqual(delimiters?[1], ["~", "~"])
  }

}
