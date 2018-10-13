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
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        do {
            guard let lines = invocation.buffer.lines as? [String] else {
                completionHandler(nil)
                return
            }

            let detector = ImportBlockDetector()
            let importBlock = try detector.importBlock(from: lines, using: ConfigurationManager.default.linkedConfiguration.groups)
            let formatter = ImportBlockFormatter()
            let formattedImportLines = formatter.lines(for: importBlock, using: ConfigurationManager.default.linkedConfiguration.operations)

            let bufferEditor = SourceTextBufferEditor(buffer: invocation.buffer)
            bufferEditor.replace(lines: importBlock.declarations, with: formattedImportLines, using: .top)
        } catch let error {
            completionHandler(error)
        }
    }
}
