//
//  ColumnCloningPaste.swift
//  XcodeColumnOps
//
//  Created by Tamas Lustyik on 2017. 03. 05..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Foundation


class ColumnCloningPaste {

    /// Pastes `string` at the start column of the current selection
    /// in each line of the current selection
    func paste(_ string: String,
               into lines: [String],
               selectedRanges: [TextRange]) -> (lines: [String], selectedRanges: [TextRange]) {
        return (lines, selectedRanges)
    }
    
}
