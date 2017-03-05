//
//  ColumnPaste.swift
//  XcodeColumnOps
//
//  Created by Tamas Lustyik on 2017. 03. 04..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Foundation

typealias PasteLocation = (line: NSInteger, column: NSInteger)

class ColumnPaste {
    
    func paste(_ strings: [String],
               into lines: [String],
               at location: PasteLocation) -> [String] {
        var updatedLines = lines
        
        // 1. extend with empty lines
        let newLineCount = strings.count - (lines.count - location.line)
        if newLineCount > 0 {
            if let lastLine = updatedLines.last, !lastLine.hasSuffix("\n") {
                updatedLines[updatedLines.count - 1] = lastLine.appending("\n")
            }
            updatedLines += Array<String>(repeating: "\n", count: max(0, newLineCount - 1))
            updatedLines.append("")
        }
        
        // 2. insert selection
        for s in 0 ..< strings.count {
            var line = updatedLines[location.line + s]
            let string = strings[s]
            
            // 2.a. apply padding
            let insertionIndex: String.CharacterView.Index
            
            if let newLineIndex = line.characters.index(of: "\n") {
                let distance = line.characters.distance(from: line.characters.startIndex, to: newLineIndex)
                if location.column > distance {
                    let padding = String(repeating: " ", count: location.column - distance)
                    line.characters.insert(contentsOf: padding.characters, at: newLineIndex)
                }
                insertionIndex = line.characters.index(line.characters.startIndex, offsetBy: location.column)
            } else if location.column >= line.characters.count {
                line += String(repeating: " ", count: location.column - line.characters.count)
                insertionIndex = line.characters.endIndex
            } else {
                insertionIndex = line.characters.index(line.characters.startIndex, offsetBy: location.column)
            }
            
            // 2.b. insert selection
            line.characters.insert(contentsOf: string.characters, at: insertionIndex)
            updatedLines[location.line + s] = line
        }
        
        return updatedLines
    }
    
}
