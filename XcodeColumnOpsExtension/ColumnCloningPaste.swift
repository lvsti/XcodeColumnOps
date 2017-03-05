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
    /// in each line that the selection spans
    func paste(_ string: String,
               into lines: [String],
               selectedRanges: [TextRange]) -> (lines: [String], selectedRanges: [TextRange]) {
        guard selectedRanges.count > 0 else {
            preconditionFailure("selectedRanges must not be empty")
        }
        
        var updatedLines = lines
        let sanitizedString = string.components(separatedBy: .newlines).first!

        let column = selectedRanges.first!.start.column
        let firstLine = selectedRanges.first!.start.line
        let lastLine = selectedRanges.last!.end.line
        
        for i in firstLine ... lastLine {
            var line = updatedLines[i]
            
            // apply padding
            let insertionIndex: String.CharacterView.Index
            
            if let newLineIndex = line.characters.index(of: "\n") {
                let newLineOffset = line.characters.distance(from: line.characters.startIndex, to: newLineIndex)
                if column > newLineOffset {
                    let padding = String(repeating: " ", count: column - newLineOffset)
                    line.characters.insert(contentsOf: padding.characters, at: newLineIndex)
                }
                insertionIndex = line.characters.index(line.characters.startIndex, offsetBy: column)
            } else if column >= line.characters.count {
                line += String(repeating: " ", count: column - line.characters.count)
                insertionIndex = line.characters.endIndex
            } else {
                insertionIndex = line.characters.index(line.characters.startIndex, offsetBy: column)
            }
            
            // 2.b. insert selection
            line.characters.insert(contentsOf: sanitizedString.characters, at: insertionIndex)
            updatedLines[i] = line
        }
        
        let pos = TextPosition(line: firstLine, column: column)

        return (updatedLines, [TextRange(start: pos, end: pos)])
    }
    
}
