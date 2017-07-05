//
//  SourceTextBufferEditor.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 05.07.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Foundation
import XcodeKit

class SourceTextBufferEditor {
    
    enum ReplacementPosition {
        case top
        case bottom
    }
    
    private(set) var buffer: XCSourceTextBuffer
    
    init(buffer: XCSourceTextBuffer) {
        self.buffer = buffer
    }
    
    func replace(_ oldLines: [String], to newLines: [String], from replacementPosition: ReplacementPosition) {
        guard let firstOldElement = oldLines.first, let lastOldElement = oldLines.last else {
            return
        }
        
        let replacementStartIndex: Int
        
        switch replacementPosition {
        case .top:
            replacementStartIndex = buffer.lines.index(of: firstOldElement)
        case .bottom:
            replacementStartIndex = buffer.lines.index(of: lastOldElement)
        }
        
        guard replacementStartIndex != NSNotFound else {
            return
        }
        
        let indexSet = IndexSet(integersIn:replacementStartIndex..<replacementStartIndex+newLines.count)
        
        buffer.lines.removeObjects(in: oldLines)
        buffer.lines.insert(newLines, at: indexSet)
    }
}
