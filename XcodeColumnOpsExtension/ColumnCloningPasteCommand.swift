//
//  ColumnCloningPasteCommand.swift
//  XcodeColumnOps
//
//  Created by Tamas Lustyik on 2017. 03. 05..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Cocoa
import XcodeKit

enum ColumnCloningPasteError: Error {
    case unrecognizedContent
    case invalidSelection
}


class ColumnCloningPasteCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation,
                 completionHandler: @escaping (Error?) -> Void ) {
        let pasteboard = NSPasteboard.general()

        guard
            let plainText = pasteboard.string(forType: NSPasteboardTypeString),
            let string = plainText.components(separatedBy: .newlines).first
        else {
            completionHandler(ColumnCloningPasteError.unrecognizedContent)
            return
        }

        let selectionRanges = (invocation.buffer.selections as [AnyObject]) as! [XCSourceTextRange]
        
        guard
            let firstLine = selectionRanges.first?.start.line,
            let lastLine = selectionRanges.last?.end.line
        else {
            completionHandler(ColumnCloningPasteError.invalidSelection)
            return
        }

        let lines = (invocation.buffer.lines as [AnyObject]) as! [String]
        let selectedRanges = selectionRanges.map { TextRange(xcRange: $0) }

        let columnCloningPaste = ColumnCloningPaste()
        let (updatedLines, updatedSelection) = columnCloningPaste.paste(string, into: lines, selectedRanges: selectedRanges)
        
        let changedLines = Array(updatedLines[firstLine ... lastLine])
        let updatedRange = NSRange(location: firstLine, length: lastLine - firstLine + 1)
        invocation.buffer.lines.replaceObjects(in: updatedRange, withObjectsFrom: changedLines)
        invocation.buffer.selections.removeAllObjects()
        invocation.buffer.selections.addObjects(from: updatedSelection.map { XCSourceTextRange(textRange: $0) })
        
        completionHandler(nil)
    }
    
}
