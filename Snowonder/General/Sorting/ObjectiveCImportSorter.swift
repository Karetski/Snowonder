//
//  ObjectiveCImportSorter.swift
//  Snowonder
//
//  Created by Alexey Karetski on 30.06.16.
//  Copyright © 2016 Alexey Karetski. All rights reserved.
//

import Cocoa

class ObjectiveCImportSorter: NSObject, ImportSorter {
    var sourceCodeView: NSTextView
    var sourceCodeDocumentName: String
    var importDeclarationPrefix: String
    var classCategoryLabelPrefix: String
    
    enum ImportCategory: Int {
        case Framework
        case SelfHeader
        case Other
        
        static let count: Int = {
            var max: Int = 0
            while let _ = ImportCategory(rawValue: max) {
                max += 1
            }
            return max
        }()
    }
    
    required init(textView: NSTextView, documentName: String) {
        self.sourceCodeView = textView
        self.sourceCodeDocumentName = documentName
        self.importDeclarationPrefix = Constant.Sorting.ObjectiveC.importDeclarationPrefix
        self.classCategoryLabelPrefix = Constant.Sorting.ObjectiveC.classCategoryLabelPrefix
        
        super.init()
    }
    
    func sort() {
        let importDeclarations = self.importDeclarations()
        let sortedImportDeclarations = self.sortImportDeclarations(importDeclarations)
        
        var importDeclarationsToReplace = String()
        for importDeclaration in sortedImportDeclarations {
            importDeclarationsToReplace += importDeclaration
        }
        
        self.insertSorted(importDeclarationsToReplace)
    }
    
    func sortImportDeclarations(importDeclarations: [String]) -> [String] {
        var sortedDeclarations = [String]()
        
        var categorizedDeclarations = [ImportCategory: [String]]()
        
        for importDeclaration in importDeclarations {
            let importCategory = self.importCategory(for: importDeclaration)
            
            if let declarationsByCategory = categorizedDeclarations[importCategory] {
                categorizedDeclarations[importCategory] = declarationsByCategory + [importDeclaration]
            } else {
                categorizedDeclarations[importCategory] = [importDeclaration]
            }
        }
        
        var lastLineImportFound = false
        
        for categoryRawValue in 0...ImportCategory.count - 1 {
            guard let importCategory = ImportCategory(rawValue: categoryRawValue), let declarationsByCategory = categorizedDeclarations[importCategory] else {
                continue
            }
            
            let sortedDeclarationsByCategory = declarationsByCategory.sort({ $0.localizedCaseInsensitiveCompare($1) == .OrderedAscending })
            
            if sortedDeclarationsByCategory.count != 0 {
                sortedDeclarations.append("\n") // New line separator
            }
            
            for importDeclaration in sortedDeclarationsByCategory {
                
                if let _ = importDeclaration.rangeOfString("\n") {
                    sortedDeclarations.append(importDeclaration)
                } else {
                    sortedDeclarations.append("\(importDeclaration)\n")
                    lastLineImportFound = true
                }
            }
        }
        
        let settingWithoutCategoryLabels = true // TODO: Remove when settings will be added
        if (settingWithoutCategoryLabels) {
            sortedDeclarations.removeFirst()
        }
        
        if let lastImport = sortedDeclarations.last where lastLineImportFound {
            sortedDeclarations.removeLast()
            
            let lastImportWithoutNewLine = lastImport.stringByReplacingOccurrencesOfString("\n", withString: "")
            sortedDeclarations.append(lastImportWithoutNewLine)
        }
        
        return sortedDeclarations.count != 0 ? sortedDeclarations : importDeclarations
    }
    
    func importCategory(for importDeclaration: String) -> ImportCategory {
        var category: ImportCategory = .Other
        
        let selfHeaderPattern = "#import \"\(self.sourceCodeDocumentName).h\""
        
        if importDeclaration.matches(selfHeaderPattern) {
            category = .SelfHeader
        } else if importDeclaration.matches(Constant.Sorting.ObjectiveC.frameworkLibraryPattern) {
            category = .Framework
        }
        
        return category
    }
}
