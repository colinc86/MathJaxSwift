import XCTest
@testable import MathJaxSwift

final class SRELocaleTests: XCTestCase {

  func testDefaultLocale_english() throws {
    let mj = try MathJax(preferredOutputFormat: .speech)
    let result = try mj.tex2speech("x^2 + y^2 = z^2")
    XCTAssertTrue(result.lowercased().contains("squared"))
  }

  func testLocale_german() throws {
    let mj = try MathJax(preferredOutputFormat: .speech)
    let docOpts = DocumentOptions()
    docOpts.sre = SREOptions(locale: "de")
    let result = try mj.tex2speech("x^2 + y^2 = z^2", documentOptions: docOpts)
    XCTAssertTrue(result.contains("Quadrat"), "German should contain 'Quadrat'")
  }

  func testLocale_french() throws {
    let mj = try MathJax(preferredOutputFormat: .speech)
    let docOpts = DocumentOptions()
    docOpts.sre = SREOptions(locale: "fr")
    let result = try mj.tex2speech("x^2 + y^2 = z^2", documentOptions: docOpts)
    XCTAssertTrue(result.contains("carré"), "French should contain 'carré'")
  }

  func testLocale_spanish() throws {
    let mj = try MathJax(preferredOutputFormat: .speech)
    let docOpts = DocumentOptions()
    docOpts.sre = SREOptions(locale: "es")
    let result = try mj.tex2speech("x^2 + y^2 = z^2", documentOptions: docOpts)
    XCTAssertTrue(result.contains("cuadrado"), "Spanish should contain 'cuadrado'")
  }

  func testLocale_switchBetween() throws {
    let mj = try MathJax(preferredOutputFormat: .speech)
    let input = "x^2"

    let en = try mj.tex2speech(input)
    let deOpts = DocumentOptions()
    deOpts.sre = SREOptions(locale: "de")
    let de = try mj.tex2speech(input, documentOptions: deOpts)
    let en2 = try mj.tex2speech(input)

    XCTAssertNotEqual(en, de, "English and German should differ")
    XCTAssertEqual(en, en2, "Switching back should produce same result")
  }

  func testLocale_mml2speech_direct() throws {
    let mj = try MathJax(preferredOutputFormat: .speech)
    let mml = try mj.tex2mml("x^2")
    let enResult = try mj.mml2speech(mml)
    let deResult = try mj.mml2speech(mml, sreOptions: SREOptions(locale: "de"))
    XCTAssertNotEqual(enResult, deResult)
  }

  func testSREOptions_style() throws {
    let mj = try MathJax(preferredOutputFormat: .speech)
    let input = "\\frac{x^2 + 1}{y - 3}"

    let defaultOpts = DocumentOptions()
    defaultOpts.sre = SREOptions(style: "default")
    let verbose = try mj.tex2speech(input, documentOptions: defaultOpts)

    let briefOpts = DocumentOptions()
    briefOpts.sre = SREOptions(style: "brief")
    let brief = try mj.tex2speech(input, documentOptions: briefOpts)

    XCTAssertNotEqual(verbose, brief, "Default and brief styles should differ")
  }
}
