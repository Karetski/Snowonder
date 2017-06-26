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
    
    /// Constructs import categories based on `lines` parameter.
    ///
    /// - Parameter lines: Lines used to construct import categories.
    /// - Returns: Constructed import declarations based on `lines` parameter.
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
    
    /// Detects import declarations based on `lines` parameter using import `categories`.
    ///
    /// - Parameters:
    ///   - lines: Lines used to detect import declarations.
    ///   - categories: Import categories used to detect import declarations.
    /// - Returns: Detected import declarations.
    func declarations(from lines: [String], using categories: ImportCategories) -> ImportDeclarations {
        return lines.filter { (line) -> Bool in
            var matches = false
            
            for category in categories {
                matches = line.matches(pattern: category.declarationPattern)
            }
            
            return matches
        }
    }
    
    /// Detects import declarations based on `lines` parameter using import `categories` and groupes it by import category.
    ///
    /// - Parameters:
    ///   - lines: Lines used to detect import declarations.
    ///   - importCategories: Import categories used to detect import declarations.
    /// - Returns: Detected and grouped import declarations.
    func categorizedDeclarations(from lines: [String], using categories: ImportCategories) -> CategorizedImportDeclarations {
        var categorizedDeclarations = CategorizedImportDeclarations()
        
        for line in lines {
            for category in categories {
                if line.matches(pattern: category.declarationPattern) {
                    if let _ = categorizedDeclarations[category] {
                        categorizedDeclarations[category]!.append(line)
                    } else {
                        categorizedDeclarations[category] = [line]
                    }
                }
            }
        }
        
        return categorizedDeclarations
    }
}
