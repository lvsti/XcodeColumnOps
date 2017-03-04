//
//  SourceEditorCommand.swift
//  XcodeBlockPasteExtension
//
//  Created by Tamas Lustyik on 2017. 03. 04..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation,
                 completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        completionHandler(nil)
    }
    
}
