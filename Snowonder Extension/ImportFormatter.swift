//
//  ImportArtisan.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 27.06.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Foundation

class ImportFormatter {
    
    func lines(from importBlock: ImportBlock) -> [String] {
        let sortedCategorizedDeclarations = sorted(categorized: importBlock.categorizedDeclarations)
        let flatDeclarations = flat(categorized: sortedCategorizedDeclarations, using: importBlock.categories)
        
        return flatDeclarations
    }
    
    func sorted(categorized: CategorizedImportDeclarations) -> CategorizedImportDeclarations {
        // TODO: Find any way to transform this with map usage
        var sortedCategorized = CategorizedImportDeclarations()
        for (category, declarations) in categorized {
            sortedCategorized[category] = declarations.sorted(by: { $0.localizedCaseInsensitiveCompare($1) == category.sortingComparisonResult })
        }
        
        return sortedCategorized
    }
    
    func flat(categorized: CategorizedImportDeclarations, using categories: ImportCategories) -> ImportDeclarations {
        var flatDeclarations = ImportDeclarations()
        for category in categories {
            if let categoryDeclarations = categorized[category] {
                flatDeclarations.append(contentsOf: categoryDeclarations)
            }
        }
        
        return flatDeclarations
    }
}
