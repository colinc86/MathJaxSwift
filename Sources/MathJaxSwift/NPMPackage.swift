//
//  NPMPackage.swift
//  
//
//  Created by Colin Campbell on 11/26/22.
//

import Foundation

/// NPM package metadata.
///
/// For more information see https://docs.npmjs.com/cli/v9/configuring-npm/package-json
public struct NPMPackage: Codable {
  
  public let name: String?
  public let version: String?
  public let description: String?
  public let keywords: [String]?
  public let devDependencies: [String: String]?
  public let maintainers: [String]?
  public let bugs: [String: String]?
  public let license: String?
  public let repository: [String: String]?
  public let main: String?
  public let files: [String]?
  public let scripts: [String: String]?
  
}
