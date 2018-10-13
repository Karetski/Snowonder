//
//  SourceTextBufferModifier.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 05.07.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Foundation
import XcodeKit

class SourceTextBufferEditor {
    
    private(set) var buffer: XCSourceTextBuffer
    
    init(buffer: XCSourceTextBuffer) {
        self.buffer = buffer
    }
    
    enum ReplacementOption {
        case top
        case bottom
    }
    
    func replace(lines: [String], with newLines: [String], using option: ReplacementOption) {
        let replacementStartIndex: Int = {
            switch option {
            case .top:
                return buffer.lines.index(of: lines.first ?? "")
            case .bottom:
                return buffer.lines.index(of: lines.last ?? "")
            }
        }()
        
        guard replacementStartIndex != NSNotFound else {
            return // TODO: Throw error instead
        }
        
        let newLinesIndexSet = IndexSet(integersIn: replacementStartIndex ..< replacementStartIndex + newLines.count)
        buffer.lines.removeObjects(in: lines)
        buffer.lines.insert(newLines, at: newLinesIndexSet)
    }
}
