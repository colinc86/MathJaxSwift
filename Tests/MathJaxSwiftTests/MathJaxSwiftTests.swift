import XCTest
@testable import MathJaxSwift

final class MathJaxSwiftTests: XCTestCase {
  
  static let texInput = "\\frac{2}{3}"
  static let amInput = "2/3"
  static let identityScript = #"""
function identity(argument) {
    console.log(argument.json())
    return argument;
}
"""#
  
  func testBundle() throws {
    let mathjax = try MathJax()
    XCTAssertNoThrow(mathjax)
  }
  
  func testBundleTime() {
    measure {
      _ = try! MathJax()
    }
  }
  
  func testBundle_CHTML() throws {
    let mathjax = try MathJax(preferredOutputFormat: .chtml)
    XCTAssertNoThrow(mathjax)
  }
  
  func testBundle_CHTMLTime() {
    measure {
      _ = try! MathJax(preferredOutputFormat: .chtml)
    }
  }
  
  func testBundle_MML() throws {
    let mathjax = try MathJax(preferredOutputFormat: .mml)
    XCTAssertNoThrow(mathjax)
  }
  
  func testBundle_MMLTime() {
    measure {
      _ = try! MathJax(preferredOutputFormat: .mml)
    }
  }
  
  func testBundle_SVG() throws {
    let mathjax = try MathJax(preferredOutputFormat: .svg)
    XCTAssertNoThrow(mathjax)
  }
  
  func testBundle_SVGTime() {
    measure {
      _ = try! MathJax(preferredOutputFormat: .svg)
    }
  }
  
  func testBundle_lazyLoad() throws {
    let mathjax = try MathJax(preferredOutputFormats: [])
    XCTAssertNoThrow(mathjax)
    
    // Can we still perform a conversion with the lazy loading?
    let svg = try mathjax.tex2svg(MathJaxSwiftTests.texInput)
    XCTAssertNoThrow(svg)
  }
  
  func testBundle_lazyLoadTime() {
    measure {
      _ = try! MathJax(preferredOutputFormats: [])
    }
  }
  
  func testMetadata() throws {
    // Test that we can get the package metadata
    let metadata = try MathJax.metadata()
    XCTAssertNoThrow(metadata)
    
    // Make sure we know which version we're dealing with.
    XCTAssertEqual(metadata.version, Constants.expectedMathJaxVersion)
    
    // Make sure the URL is correct
    XCTAssertEqual(metadata.resolved.absoluteString, "https://registry.npmjs.org/mathjax-full/-/mathjax-full-\(metadata.version).tgz")
  }
  
  func testInitTime() {
    measure {
      do {
        _ = try MathJax()
      }
      catch {}
    }
  }
  
}

// MARK: Helpers

extension MathJaxSwiftTests {
  
  /// Loads string data from a file.
  ///
  /// - Parameters:
  ///   - fileName: The file's name.
  ///   - fileExtension: The file's extension.
  /// - Returns: String data.
  static func loadString(fromFile fileName: String, withExtension fileExtension: String) -> String {
    let url = Bundle.module.url(forResource: fileName, withExtension: fileExtension)!
    return (try! String(contentsOf: url)).trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
}
