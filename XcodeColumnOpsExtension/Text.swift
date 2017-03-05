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

protocol TextRange {
    var start: TextPosition { get }
    var end: TextPosition { get }
}
