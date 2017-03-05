//
//  Text.swift
//  XcodeColumnOps
//
//  Created by Tamas Lustyik on 2017. 03. 05..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Foundation

struct TextPosition {
    var line: Int
    var column: Int
}

extension TextPosition: Equatable {
    static func ==(lhs: TextPosition, rhs: TextPosition) -> Bool {
        return lhs.line == rhs.line && lhs.column == rhs.column
    }
}

struct TextRange {
    var start: TextPosition
    var end: TextPosition
}

extension TextRange: Equatable {
    static func ==(lhs: TextRange, rhs: TextRange) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.end
    }
}

