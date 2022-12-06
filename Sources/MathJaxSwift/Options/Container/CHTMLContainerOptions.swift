//
//  CHTMLContainerOptions.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 11/29/22.
//

import Foundation
import JavaScriptCore

@objc public protocol CHTMLContainerOptionsJSExports: JSExport {
  var em: Double { get set }
  var ex: Double { get set }
  var width: Double { get set }
  var css: Bool { get set }
  var assistiveMml: Bool { get set }
}

@objc public class CHTMLContainerOptions: ContainerOptions, CHTMLContainerOptionsJSExports {}
