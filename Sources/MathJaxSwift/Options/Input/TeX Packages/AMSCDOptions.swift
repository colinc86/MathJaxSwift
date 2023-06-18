//
//  AMSCDOptions.swift
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

@objc internal protocol AMSCDOptionsExports: JSExport {
  var colspace: String { get set }
  var rowspace: String { get set }
  var harrowsize: String { get set }
  var varrowsize: String { get set }
  var hideHorizontalLabels: Bool { get set }
}

@objc public class AMSCDOptions: NSObject, Codable, AMSCDOptionsExports {
  
  // MARK: Types
  
  internal enum CodingKeys: CodingKey {
    case colspace
    case rowspace
    case harrowsize
    case varrowsize
    case hideHorizontalLabels
  }
  
  // MARK: Default values
  
  public static let defaultColspace: String = ""
  public static let defaultRowspace: String = ""
  public static let defaultHarrowsize: String = ""
  public static let defaultVarrowsize: String = ""
  public static let defaultHideHorizontalLabels: Bool = false
  
  // MARK: Properties
  
  dynamic public var colspace: String
  dynamic public var rowspace: String
  dynamic public var harrowsize: String
  dynamic public var varrowsize: String
  dynamic public var hideHorizontalLabels: Bool
  
  // MARK: Initializers
  
  public init(
    colspace: String = defaultColspace,
    rowspace: String = defaultRowspace,
    harrowsize: String = defaultHarrowsize,
    varrowsize: String = defaultVarrowsize,
    hideHorizontalLabels: Bool = defaultHideHorizontalLabels
  ) {
    self.colspace = colspace
    self.rowspace = rowspace
    self.harrowsize = harrowsize
    self.varrowsize = varrowsize
    self.hideHorizontalLabels = hideHorizontalLabels
  }
  
}
