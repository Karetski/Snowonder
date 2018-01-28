//
//  ImportDetector.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 19.06.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Foundation

public enum ImportBlockDetectorError: Error {
    case notFound
}

open class ImportBlockDetector {
    
    // MARK: - Constant values
    
    private struct Constant { // TODO: Init these values from JSON on detector init.
        static let availableImportCategories: [ImportCategories] = [swiftSet, objcSet]
        
        static let swiftSet: ImportCategories = [ImportCategory(title: "Framework", declarationPattern: "^\\s*(import) +.*.", sortingComparisonResult: .orderedAscending),
                                                 ImportCategory(title: "Testable", declarationPattern: "^\\s*(@testable \\s*import) +.*.", sortingComparisonResult: .orderedAscending)]
        static let objcSet: ImportCategories = [ImportCategory(title: "Module", declarationPattern: "^\\s*(@import) +.*.", sortingComparisonResult: .orderedAscending),
                                                ImportCategory(title: "Global", declarationPattern: "^\\s*(#import) \\s*<.*>.*", sortingComparisonResult: .orderedAscending),
                                                ImportCategory(title: "Global Include", declarationPattern: "^\\s*(#include) \\s*<.*>.*", sortingComparisonResult: .orderedAscending),
                                                ImportCategory(title: "Local", declarationPattern: "^\\s*(#import) \\s*\".*\".*", sortingComparisonResult: .orderedAscending),
                                                ImportCategory(title: "Local Include", declarationPattern: "^\\s*(#include) \\s*\".*\".*", sortingComparisonResult: .orderedAscending)]
    }
    
    // MARK: - Initializers
    
    public init() { }
    
    // MARK: - Detection functions
    
    /// Creates new import block based on `lines` parameter.
    ///
    /// - Parameters:
    ///   - lines: Lines used to detect import declarations.
    /// - Throws: Error if import declarations can't be found.
    open func importBlock(from lines: [String]) throws -> ImportBlock {
        let categories = self.categories(from: lines)
        let declarations = self.declarations(from: lines, using: categories)
        let categorizedDeclarations = self.categorizedDeclarations(from: lines, using: categories) // TODO: Think if we can use already found declaration lines here
        
        guard !categories.isEmpty && !declarations.isEmpty && !categorizedDeclarations.isEmpty else {
            throw ImportBlockDetectorError.notFound
        }
        
        return .init(categories: categories, declarations: declarations, categorizedDeclarations: categorizedDeclarations)
    }
    
    /// Constructs import categories based on `lines` parameter.
    ///
    /// - Parameter lines: Lines used to construct import categories.
    /// - Returns: Constructed import declarations based on `lines` parameter.
    open func categories(from lines: [String]) -> ImportCategories {
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
    open func declarations(from lines: [String], using categories: ImportCategories) -> ImportDeclarations {
        return lines.filter { (line) -> Bool in
            var matches = false
            
            for category in categories {
                matches = line.matches(pattern: category.declarationPattern)
                if matches {
                    break
                }
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
    open func categorizedDeclarations(from lines: [String], using categories: ImportCategories) -> CategorizedImportDeclarations {
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
