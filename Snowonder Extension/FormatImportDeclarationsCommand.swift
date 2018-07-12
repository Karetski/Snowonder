//
//  SourceEditorCommand.swift
//  Snowonder Extension
//
//  Created by Aliaksei Karetski on 19.06.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Foundation
import ImportArtisan
import Snowonder_Configuration
import XcodeKit

class FormatImportDeclarationsCommand: NSObject, XCSourceEditorCommand {
    let configurationManager = ConfigurationManager()!

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        var error: Error? = nil

        if let lines = invocation.buffer.lines as? [String] {
            do {
                let detector = ImportBlockDetector()
                let importBlock = try detector.importBlock(from: lines, using: configurationManager.linkedConfiguration.groups)
                let formatter = ImportBlockFormatter()
                let formattedImportLines = formatter.lines(for: importBlock, using: configurationManager.linkedConfiguration.operations)
                
                let bufferEditor = SourceTextBufferEditor(buffer: invocation.buffer)
                bufferEditor.replace(lines: importBlock.declarations, with: formattedImportLines, using: .top)
            } catch let catchedError {
                error = catchedError
            }
        }
        
        completionHandler(error)
    }
}
