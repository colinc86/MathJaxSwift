//
//  SetOptions.swift
//  MathJaxSwift
//
//  Copyright (c) 2023 Colin Campbell
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//

import Foundation
import JavaScriptCore

@objc internal protocol SetOptionsExports: JSExport {
  var filterPackage: SetOptions.FilterPackage? { get set }
  var filterOption: SetOptions.FilterOption? { get set }
  var filterValue: SetOptions.FilterValue? { get set }
  var allowPackageDefault: Bool { get set }
  var allowOptionsDefault: Bool { get set }
}

@objc public class SetOptions: NSObject, Codable, SetOptionsExports {
  
  // MARK: Types
  
  internal enum CodingKeys: CodingKey {
    case allowPackageDefault
    case allowOptionsDefault
  }
  
  public typealias FilterPackage = @convention(block) (_ texParser: JSValue?, _ extensionName: String) -> Bool
  public typealias FilterOption = @convention(block) (_ texParser: JSValue?, _ packageName: String, _ optionName: String) -> Bool
  public typealias FilterValue = @convention(block) (_ texParser: JSValue?, _ packageName: String, _ optionName: String, _ newOptionValue: JSValue?) -> Bool
  
  // MARK: Default values
  
  public static let defaultFilterPackage: FilterPackage? = nil
  public static let defaultFilterOption: FilterOption? = nil
  public static let defaultFilterValue: FilterValue? = nil
  public static let defaultAllowPackageDefault: Bool = true
  public static let defaultAllowOptionsDefault: Bool = true
  
  // MARK: Properties
  
  dynamic public var filterPackage: FilterPackage?
  dynamic public var filterOption: FilterOption?
  dynamic public var filterValue: FilterValue?
  dynamic public var allowPackageDefault: Bool
  dynamic public var allowOptionsDefault: Bool
  
  // MARK: Initializers
  
  public init(
    filterPackage: SetOptions.FilterPackage? = defaultFilterPackage,
    filterOption: SetOptions.FilterOption? = defaultFilterOption,
    filterValue: SetOptions.FilterValue? = defaultFilterValue,
    allowPackageDefault: Bool = defaultAllowPackageDefault,
    allowOptionsDefault: Bool = defaultAllowOptionsDefault
  ) {
    self.filterPackage = filterPackage
    self.filterOption = filterOption
    self.filterValue = filterValue
    self.allowPackageDefault = allowPackageDefault
    self.allowOptionsDefault = allowOptionsDefault
  }
  
  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    allowPackageDefault = try container.decode(Bool.self, forKey: .allowPackageDefault)
    allowOptionsDefault = try container.decode(Bool.self, forKey: .allowOptionsDefault)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(allowPackageDefault, forKey: .allowPackageDefault)
    try container.encode(allowOptionsDefault, forKey: .allowOptionsDefault)
  }
  
}
