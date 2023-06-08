//
//  SafeOptions.swift
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

@objc internal protocol SafeOptionsExports: JSExport {
  var lengthMax: Int { get set }
  var scriptsizemultiplierRange: [Double] { get set }
  var scriptlevelRange: [Double] { get set }
  var classPattern: String { get set }
  var idPattern: String { get set }
  var dataPattern: String { get set }
  var allowOptions: AllowOptions { get set }
  var safeProtocols: SafeProtocols { get set }
  var safeStyles: SafeStyles { get set }
}

@objc public class SafeOptions: NSObject, Codable, SafeOptionsExports {
  
  // MARK: Types
  
  internal enum CodingKeys: CodingKey {
    case lengthMax
    case scriptsizemultiplierRange
    case scriptlevelRange
    case classPattern
    case idPattern
    case dataPattern
    case allowOptions
    case safeProtocols
    case safeStyles
  }
  
  // MARK: Default values
  
  public static let defaultLengthMax: Int = 3
  public static let defaultScriptsizemultiplierRange: [Double] = [0.6, 1]
  public static let defaultScriptlevelRange: [Double] = [-2.0, 2.0]
  public static let defaultClassPattern: String = "^mjx-[-a-zA-Z0-9_.]+$"
  public static let defaultIDPattern: String = "^mjx-[-a-zA-Z0-9_.]+$"
  public static let defaultDataPattern: String = "^data-mjx-"
  public static let defaultAllowOptions: AllowOptions = AllowOptions()
  public static let defaultSafeProtocols: SafeProtocols = SafeProtocols()
  public static let defaultSafeStyles: SafeStyles = SafeStyles()
  
  // MARK: Properties
  
  dynamic public var lengthMax: Int
  dynamic public var scriptsizemultiplierRange: [Double]
  dynamic public var scriptlevelRange: [Double]
  dynamic public var classPattern: String
  dynamic public var idPattern: String
  dynamic public var dataPattern: String
  dynamic public var allowOptions: AllowOptions
  dynamic public var safeProtocols: SafeProtocols
  dynamic public var safeStyles: SafeStyles
  
  // MARK: Initializers
  
  public init(
    lengthMax: Int = defaultLengthMax,
    scriptsizemultiplierRange: [Double] = defaultScriptsizemultiplierRange,
    scriptlevelRange: [Double] = defaultScriptlevelRange,
    classPattern: String = defaultClassPattern,
    idPattern: String = defaultIDPattern,
    dataPattern: String = defaultDataPattern,
    allowOptions: AllowOptions = defaultAllowOptions,
    safeProtocols: SafeProtocols = defaultSafeProtocols,
    safeStyles: SafeStyles = defaultSafeStyles
  ) {
    self.lengthMax = lengthMax
    self.scriptsizemultiplierRange = scriptsizemultiplierRange
    self.scriptlevelRange = scriptlevelRange
    self.classPattern = classPattern
    self.idPattern = idPattern
    self.dataPattern = dataPattern
    self.allowOptions = allowOptions
    self.safeProtocols = safeProtocols
    self.safeStyles = safeStyles
  }
  
}
