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
    
    // MARK: - Common properties
    
    /// Import categories group that is acceptable to this import block.
    public var group: ImportCategoriesGroup
    
    /// Import declarations that import block includes.
    public var declarations: ImportDeclarations
    /// Import declarations that import block includes grouped by a category.
    public var categorizedDeclarations: CategorizedImportDeclarations
    
    // MARK: - Initializers
    
    /// Initializes import declarations block based on parameters.
    ///
    /// - Parameters:
    ///   - group: Import categories group that is acceptable for import block.
    ///   - declarations: Import declarations that import block includes.
    ///   - categorizedDeclarations: Import declarations that import block includes grouped by a category.
    public init(group: ImportCategoriesGroup, declarations: ImportDeclarations, categorizedDeclarations: CategorizedImportDeclarations) {
        self.group = group
        self.declarations = declarations
        self.categorizedDeclarations = categorizedDeclarations
    }
}
