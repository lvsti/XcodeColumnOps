//
//  BlockPaste.swift
//  XcodeBlockPaste
//
//  Created by Tamas Lustyik on 2017. 03. 04..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Foundation

typealias PasteLocation = (line: NSInteger, column: NSInteger)

class BlockPaste {
    
    func paste(_ selections: [String],
               into lines: [String],
               at location: PasteLocation) -> [String] {
        return lines
    }
    
}
