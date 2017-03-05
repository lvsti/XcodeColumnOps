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
        
        let strings = plainText.components(separatedBy: .newlines)

        let columnPaste = ColumnPaste()
        
        let lines = (invocation.buffer.lines as [AnyObject]) as! [String]
        let cursorRange = invocation.buffer.selections.firstObject as! XCSourceTextRange
        let position = TextPosition(xcPosition: cursorRange.start)

        let updatedLines = columnPaste.paste(strings, into: lines, at: position)
        let changedLines = Array(updatedLines[position.line ..< position.line + strings.count])
        let updatedRange = NSRange(location: position.line,
                                   length: min(strings.count, invocation.buffer.lines.count - position.line))
        invocation.buffer.lines.replaceObjects(in: updatedRange, withObjectsFrom: changedLines)
        
        completionHandler(nil)
    }
    
}
