//
//  ImportCategoriesBuilder.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 19.06.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Foundation

class ImportCategoriesBuilder {
    
    private struct Constant {
        
        static let availableSets: [ImportCategorySet] = [swiftSet, objcSet]
        
        static let swiftSet: ImportCategorySet = [ImportCategory(title: "Swift", declarationPattern: "^import .*", sortingComparisonResult: .orderedAscending)]
        static let objcSet: ImportCategorySet = [ImportCategory(title: "Frameworks", declarationPattern: "^#import <.*>", sortingComparisonResult: .orderedAscending),
                                                ImportCategory(title: "Headers", declarationPattern: "^#import \".*\"", sortingComparisonResult: .orderedAscending)]
    }
    
    static func buildCategories(using lines: [String]) -> ImportCategorySet {
        for line in lines {
            for importCategorySet in Constant.availableSets {
                for importCategory in importCategorySet {
                    if line.matches(pattern: importCategory.declarationPattern) {
                        return importCategorySet
                    }
                }
            }
        }
        
        return []
    }
}
