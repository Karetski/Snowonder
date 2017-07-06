//
//  ImportBlock.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 26.06.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Foundation

public typealias ImportDeclarations = [String]
public typealias CategorizedImportDeclarations = [ImportCategory : ImportDeclarations]

public struct ImportBlock {
    
    /// Import categories that are acceptable for import block.
    public var categories: ImportCategories
    
    /// Import declarations that import block includes.
    public var declarations: ImportDeclarations
    /// Import declarations that import block includes grouped by a category.
    public var categorizedDeclarations: CategorizedImportDeclarations
    
    public init(categories: ImportCategories, declarations: ImportDeclarations, categorizedDeclarations: CategorizedImportDeclarations) {
        self.categories = categories
        self.declarations = declarations
        self.categorizedDeclarations = categorizedDeclarations
    }
}
