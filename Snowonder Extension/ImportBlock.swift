//
//  ImportBlock.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 26.06.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Foundation

typealias ImportDeclarations = [String]
typealias CategorizedImportDeclarations = [ImportCategory : ImportDeclarations]

struct ImportBlock {
    /// Import categories that are acceptable for import block.
    var categories: ImportCategories
    
    /// Import declarations that import block includes.
    var declarations: ImportDeclarations
    /// Import declarations that import block includes grouped by a category.
    var categorizedDeclarations: CategorizedImportDeclarations
    
    init(categories: ImportCategories, declarations: ImportDeclarations, categorizedDeclarations: CategorizedImportDeclarations) {
        self.categories = categories
        self.declarations = declarations
        self.categorizedDeclarations = categorizedDeclarations
    }
}
