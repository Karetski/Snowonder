//
//  SourceEditorCommand.swift
//  Snowonder Extension
//
//  Created by Aliaksei Karetski on 19.06.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        if let lines = invocation.buffer.lines as? [String] {
            let importCategories = ImportCategoriesBuilder.buildCategories(using: lines)
        }
        
        completionHandler(nil)
    }
    
}
