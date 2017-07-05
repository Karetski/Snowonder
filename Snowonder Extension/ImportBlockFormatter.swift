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
    
    /// Formatting options, used to define what optimizations should be done.
    var options: Options
    
    /// Creates new instance with formatting `options`.
    ///
    /// - Parameter options: Formatting options.
    init(options: Options) {
        self.options = options
    }
    
    func lines(from importBlock: ImportBlock) -> [String] {
        return importBlock.categorizedDeclarations
            .sorted(with: options)
            .flat(with: options, using: importBlock.categories)
    }
}

private extension Dictionary where Key == ImportCategory, Value == ImportDeclarations {
    
    func sorted(with options: ImportBlockFormatter.Options) -> CategorizedImportDeclarations {
        guard options.contains(.sort) else {
            return self
        }
        
        return mapValues { (category, declarations) -> ImportDeclarations in
            return declarations.sorted { $0.localizedCaseInsensitiveCompare($1) == category.sortingComparisonResult }
        }
    }
    
    func flat(with options: ImportBlockFormatter.Options, using categories: ImportCategories) -> ImportDeclarations {
        var flatDeclarations = ImportDeclarations()
        
        categories.forEach { (category) in
            if let categoryDeclarations = self[category], !categoryDeclarations.isEmpty {
                flatDeclarations.append(contentsOf: categoryDeclarations)
            }
        }
        
        return flatDeclarations
    }
}
