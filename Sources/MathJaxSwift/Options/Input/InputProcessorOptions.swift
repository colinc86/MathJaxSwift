//
//  InputProcessorOptions.swift
//  MathJaxSwift
//
//  Created by Colin Campbell on 12/6/22.
//

import Foundation

/// There are no options that are common to all input jax, but a number of the
/// Document Options affect what portions of the document will be processed by
/// the input jax that scan the page for delimiters (i.e., TeX and AsciiMath).
/// In particular, the options that correspond to the version-2 options
/// `skipTags`, `includeTags`, and similar options for the various v2
/// pre-processors are now document-level options.
@objc public class InputProcessorOptions: NSObject, Codable {}
