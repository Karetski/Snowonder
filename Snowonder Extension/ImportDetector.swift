//
//  ImportCategoriesBuilder.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 19.06.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Foundation

class ImportDetector {
    private struct Constant {
        static let availableImportCategories: [ImportCategories] = [swiftSet, objcSet]
        
        static let swiftSet: ImportCategories = [ImportCategory(title: "Swift", declarationPattern: "^import .*", sortingComparisonResult: .orderedAscending)]
        static let objcSet: ImportCategories = [ImportCategory(title: "Frameworks", declarationPattern: "^#import <.*>", sortingComparisonResult: .orderedAscending),
                                                 ImportCategory(title: "Headers", declarationPattern: "^#import \".*\"", sortingComparisonResult: .orderedAscending)]
    }
    
    func categories(from lines: [String]) -> ImportCategories {
        for line in lines {
            for importCategories in Constant.availableImportCategories {
                for importCategory in importCategories {
                    if line.matches(pattern: importCategory.declarationPattern) {
                        return importCategories
                    }
                }
            }
        }
        
        return []
    }
    
    func declarations(from lines: [String], using categories: ImportCategories) -> ImportDeclarations {
        return lines.filter { (line) -> Bool in
            var matches = false
            
            for category in categories {
                matches = line.matches(pattern: category.declarationPattern)
            }
            
            return matches
        }
    }
    
    func categorizedDeclarations(from lines: [String], using importCategories: ImportCategories) -> CategorizedImportDeclarations {
        var categorizedDeclarations = CategorizedImportDeclarations()
        
        for line in lines {
            for importCategory in importCategories {
                if line.matches(pattern: importCategory.declarationPattern) {
                    if let _ = categorizedDeclarations[importCategory] {
                        categorizedDeclarations[importCategory]!.append(line)
                    } else {
                        categorizedDeclarations[importCategory] = [line]
                    }
                }
            }
        }
        
        return categorizedDeclarations
    }
}
