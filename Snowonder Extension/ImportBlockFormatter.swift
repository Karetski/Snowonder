//
//  ImportArtisan.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 27.06.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Foundation

class ImportBlockFormatter {
    enum Option {
        case sort
        case separate
    }
    
    typealias Options = Set<Option>
    
    var options: Options
    
    init(options: Options) {
        self.options = options
    }
    
    func lines(from importBlock: ImportBlock) -> [String] {
        let sorted = self.sorted(categorized: importBlock.categorizedDeclarations)
        let flat = self.flat(categorized: sorted, using: importBlock.categories)
        
        return flat
    }
    
    private func sorted(categorized: CategorizedImportDeclarations) -> CategorizedImportDeclarations {
        guard options.contains(.sort) else {
            return categorized
        }
        
        // TODO: Find any way to transform this with map usage
        var sortedCategorized = CategorizedImportDeclarations()
        for (category, declarations) in categorized {
            sortedCategorized[category] = declarations.sorted(by: { $0.localizedCaseInsensitiveCompare($1) == category.sortingComparisonResult })
        }
        
        return sortedCategorized
    }
    
    private func flat(categorized: CategorizedImportDeclarations, using categories: ImportCategories) -> ImportDeclarations {
        var flatDeclarations = ImportDeclarations()
        for category in categories {
            if let categoryDeclarations = categorized[category] {
                flatDeclarations.append(contentsOf: categoryDeclarations)
                if options.contains(.separate) {
                    flatDeclarations.append("\n")
                }
            }
        }
        
        return flatDeclarations
    }
}
