//
//  ColumnPasteCommand.swift
//  XcodeColumnOpsExtension
//
//  Created by Tamas Lustyik on 2017. 03. 04..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Cocoa
import XcodeKit

enum ColumnPasteError: Error {
    case unrecognizedContent
}

class ColumnPasteCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation,
                 completionHandler: @escaping (Error?) -> Void ) {
        let pasteboard = NSPasteboard.general()

        guard
            let plainText = pasteboard.string(forType: NSPasteboardTypeString),
            pasteboard.data(forType: NSPasteboardTypeMultipleTextSelection) != nil
        else {
            completionHandler(ColumnPasteError.unrecognizedContent)
            return
        }
        
        let selections = plainText.components(separatedBy: .newlines)

        let columnPaste = ColumnPaste()
        
        let lines = (invocation.buffer.lines as [AnyObject]) as! [String]
        let cursorRange = invocation.buffer.selections.firstObject as! XCSourceTextRange
        let location = (line: cursorRange.start.line, column: cursorRange.start.column)

        let updatedLines = columnPaste.paste(selections, into: lines, at: location)
        let changedLines = Array(updatedLines[location.line ..< location.line + selections.count])
        let updatedRange = NSRange(location: location.line,
                                   length: min(selections.count, invocation.buffer.lines.count - location.line))
        invocation.buffer.lines.replaceObjects(in: updatedRange, withObjectsFrom: changedLines)
        
        completionHandler(nil)
    }
    
}
