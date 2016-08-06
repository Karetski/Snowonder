//
//  ImportSorter.swift
//  Snowonder
//
//  Created by Alexey Karetski on 30.06.16.
//  Copyright © 2016 Alexey Karetski. All rights reserved.
//

import Cocoa

protocol ImportSorter {
    var sourceCodeView: NSTextView { get set }
    var sourceCodeDocumentName: String { get set }
    var importDeclarationPrefix: String { get set }
    var classCategoryLabelPrefix: String { get set }
    
    init(textView: NSTextView, documentName: String)
    
    func sort()
    
    func importDeclarations() -> [String]
    func insertSorted(importDeclarations: String)
}

extension ImportSorter {
    
    func importDeclarations() -> [String] {
        guard let sourceString = self.sourceCodeView.textStorage?.string else {
            return []
        }
        
        var importDeclarationsArray = [String]()
        
        sourceString.enumerateLines { (line, stop) in
            if line.hasPrefix(self.importDeclarationPrefix) {
                importDeclarationsArray.append("\(line)\n")
            }
        }
        
        return importDeclarationsArray
    }
    
    func insertSorted(importDeclarations: String) {
        var firstDeletionRange: NSRange?
        
        for importDeclaration in self.importDeclarations() {
            if let _ = firstDeletionRange {
                self.sourceCodeView.removeString(importDeclaration)
            } else {
                firstDeletionRange = self.sourceCodeView.removeString(importDeclaration)
            }
        }
        
        if let firstDeletionRange = firstDeletionRange {
            self.sourceCodeView.insertText(importDeclarations, replacementRange: NSMakeRange(firstDeletionRange.location, 0))
        }
    }
    
    // MARK: - Insert sorted with cleaning
    
    func oldInsertSorted(importDeclarations: String) {
        let replacementRange = self.replacementRange()
        self.sourceCodeView.insertText(importDeclarations, replacementRange: replacementRange)
    }
    
    func replacementRange() -> NSRange {
        var replaceLength = 0
        var replaceBeginLocation = 0
        var replaceEndLocation = 0
        var hasSetBeginLocation = false
        
        guard let sourceString = self.sourceCodeView.textStorage?.string else {
            return NSRange()
        }
        
        let sourceNSString = sourceString as NSString
        var range = NSMakeRange(0, sourceNSString.length)
        
        var importDeclarationsArray = [String]()
        
        while range.length > 0 {
            let subRange = sourceNSString.lineRangeForRange(NSMakeRange(range.location, 0))
            
            let line = sourceNSString.substringWithRange(subRange)
            
            if line.hasPrefix(self.importDeclarationPrefix) || line.hasPrefix(self.classCategoryLabelPrefix) {
                importDeclarationsArray.append(line)
                if !hasSetBeginLocation {
                    hasSetBeginLocation = true
                    replaceBeginLocation = subRange.location
                }
                replaceEndLocation = subRange.location + subRange.length
            }
            
            range.location = NSMaxRange(subRange)
            range.length -= subRange.length
        }
        
        replaceLength = max(replaceEndLocation - replaceBeginLocation, 0)
        
        return NSMakeRange(replaceBeginLocation, replaceLength)
    }
}