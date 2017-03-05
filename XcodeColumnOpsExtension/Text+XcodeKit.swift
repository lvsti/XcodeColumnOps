//
//  Text+XcodeKit.swift
//  XcodeColumnOps
//
//  Created by Tamas Lustyik on 2017. 03. 05..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import XcodeKit

extension TextPosition {
    init(xcPosition: XCSourceTextPosition) {
        self.line = xcPosition.line
        self.column = xcPosition.column
    }
}

extension XCSourceTextPosition {
    init(textPosition: TextPosition) {
        self.line = textPosition.line
        self.column = textPosition.column
    }
}

extension TextRange {
    init(xcRange: XCSourceTextRange) {
        self.start = TextPosition(xcPosition: xcRange.start)
        self.end = TextPosition(xcPosition: xcRange.end)
    }
}

extension XCSourceTextRange {
    init(textRange: TextRange) {
        self.start = XCSourceTextPosition(textPosition: textRange.start)
        self.end = XCSourceTextPosition(textPosition: textRange.end)
    }
}
