//
//  SourceEditorCommand.swift
//  XcodeExtension
//
//  Created by Aliaksei Karetski on 15.06.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        print("Test")
        
        completionHandler(nil)
    }
    
}
