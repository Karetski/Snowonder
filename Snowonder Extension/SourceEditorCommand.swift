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
        var error: Error? = nil
        
        if let lines = invocation.buffer.lines as? [String] {
            do {
                let detector = ImportDetector()
                let importBlock = try detector.importBlock(from: lines)
                
                let formatter = ImportFormatter()
                let formattedImportLines = formatter.lines(from: importBlock)
                
                print(formattedImportLines)
            } catch let catchedError {
                error = catchedError
            }
        }
        
        completionHandler(error)
    }
    
}
