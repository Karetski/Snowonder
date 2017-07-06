//
//  SourceEditorCommand.swift
//  Snowonder Extension
//
//  Created by Aliaksei Karetski on 19.06.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Foundation
import ImportArtisan
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        var error: Error? = nil
        
        if let lines = invocation.buffer.lines as? [String] {
            do {
                let detector = ImportBlockDetector()
                let importBlock = try detector.importBlock(from: lines)
                
                let formatter = ImportBlockFormatter(options: [.separateCategories, .sortDeclarations])
                let formattedImportLines = formatter.lines(from: importBlock)
                
                let bufferEditor = SourceTextBufferEditor(buffer: invocation.buffer)
                bufferEditor.replace(lines: importBlock.declarations, with: formattedImportLines, using: .top)
            } catch let catchedError {
                error = catchedError
            }
        }
        
        completionHandler(error)
    }
    
}
