//
//  Text.swift
//  XcodeColumnOps
//
//  Created by Tamas Lustyik on 2017. 03. 05..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Foundation

protocol TextPosition {
    var line: Int { get }
    var column: Int { get }
}

extension Equatable where Self: TextPosition {}

func ==(lhs: TextPosition, rhs: TextPosition) -> Bool {
    return lhs.line == rhs.line && lhs.column == rhs.column
}

protocol TextRange {
    var start: TextPosition { get }
    var end: TextPosition { get }
}

extension Equatable where Self: TextRange {}

func ==(lhs: TextRange, rhs: TextRange) -> Bool {
    return lhs.start == rhs.start && lhs.end == rhs.end
}
