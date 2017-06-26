//
//  ImportBlock.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 26.06.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Foundation

enum ImportBlockError: Error {
    case declarationsNotFound
}

typealias ImportDeclarations = [String]
typealias CategorizedImportDeclarations = [ImportCategory : ImportDeclarations]

class ImportBlock {
    /// Import categories that are acceptable for import block.
    var categories: ImportCategories
    
    /// Import declarations that import block includes.
    var declarations: ImportDeclarations
    /// Import declarations that import block includes grouped by a category.
    var categorizedDeclarations: CategorizedImportDeclarations
    
    /// Creates new import block based on `lines` parameter.
    ///
    /// - Parameters:
    ///   - lines: Lines used to detect import declarations.
    ///   - detector: Detector used to construct import block.
    /// - Throws: Error
    init(lines: [String], detector: ImportDetector = ImportDetector()) throws {
        let categories = detector.categories(from: lines)
        let declarations = detector.declarations(from: lines, using: categories)
        let categorizedDeclarations = detector.categorizedDeclarations(from: lines, using: categories)
        
        guard !categories.isEmpty && !declarations.isEmpty && !categorizedDeclarations.isEmpty else {
            throw ImportBlockError.declarationsNotFound
        }
        
        self.categories = categories
        self.declarations = declarations
        self.categorizedDeclarations = categorizedDeclarations
    }
}
