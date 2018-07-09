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

class FormatImportDeclarationsCommand: NSObject, XCSourceEditorCommand {

    private struct Constant { // TODO: Init these values from JSON on detector init. #13
        static let allGroups: [ImportCategoriesGroup] = [swiftGroup, objcGroup]

        static let swiftGroup: ImportCategoriesGroup = [
            ImportCategory(title: "Framework", declarationPattern: "^\\s*(import) +.*.", sortingRulesChain: [.alphabetically(isAscending: true)]),
            ImportCategory(title: "Testable", declarationPattern: "^\\s*(@testable \\s*import) +.*.", sortingRulesChain: [.alphabetically(isAscending: true)])
        ]
        static let objcGroup: ImportCategoriesGroup = [
            ImportCategory(title: "Module", declarationPattern: "^\\s*(@import) +.*.", sortingRulesChain: [.alphabetically(isAscending: true)]),
            ImportCategory(title: "Global", declarationPattern: "^\\s*(#import) \\s*<.*>.*", sortingRulesChain: [.alphabetically(isAscending: true)]),
            ImportCategory(title: "Global Include", declarationPattern: "^\\s*(#include) \\s*<.*>.*", sortingRulesChain: [.alphabetically(isAscending: true)]),
            ImportCategory(title: "Local", declarationPattern: "^\\s*(#import) \\s*\".*\".*", sortingRulesChain: [.alphabetically(isAscending: true)]),
            ImportCategory(title: "Local Include", declarationPattern: "^\\s*(#include) \\s*\".*\".*", sortingRulesChain: [.alphabetically(isAscending: true)])
        ]
    }
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        var error: Error? = nil

        if let lines = invocation.buffer.lines as? [String] {
            do {
                let detector = ImportBlockDetector()
                let importBlock = try detector.importBlock(from: lines, using: Constant.allGroups)
                let formatter = ImportBlockFormatter()
                let formattedImportLines = formatter.lines(for: importBlock, using: ImportBlockFormatter.Operation.all)
                
                let bufferEditor = SourceTextBufferEditor(buffer: invocation.buffer)
                bufferEditor.replace(lines: importBlock.declarations, with: formattedImportLines, using: .top)
            } catch let catchedError {
                error = catchedError
            }
        }
        
        completionHandler(error)
    }
}
