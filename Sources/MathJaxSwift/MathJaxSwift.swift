import Foundation

/// A wrapper for the MathJax repo.
public struct MathJaxSwift {
  
  // MARK: Types
  
  /// An error thrown by the `MathJaxSwift` package.
  public enum MathJaxSwiftError: Error {
    
    /// The npm package file was missing.
    case missingPackageFile
  }
  
  // MARK: Private properties
  
  /// The MathJax directory name.
  private static let mathJaxDirectoryName = "MathJax"
  
  /// The relative path to the npm package file.
  private static let packageFilePath = "package.json"
  
  // MARK: Public properties
  
  /// The URL of the MathJax top-level directory.
  public static let base = Bundle.module.url(
    forResource: mathJaxDirectoryName,
    withExtension: nil)
  
  /// The URL of the es5 directory.
  public static let es5 = base?.appending(path: "es5")
  
  // MARK: Public methods
  
  /// The MathJax npm package metadata.
  public static func package() throws -> NPMPackage {
    guard let packageURL = base?.appending(path: packageFilePath) else {
      throw MathJaxSwiftError.missingPackageFile
    }
    return try JSONDecoder().decode(
      NPMPackage.self,
      from: try Data(contentsOf: packageURL))
  }
  
}
