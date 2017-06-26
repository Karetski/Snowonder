//
//  ImportCategory.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 19.06.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Foundation

typealias ImportCategories = [ImportCategory]

struct ImportCategory : Hashable {
    /// Title of import category
    var title: String
    
    /// Pattern used to match import declaration to category
    var declarationPattern: String
    
    /// ComparisonResult used to sort import declarations in scope of category
    var sortingComparisonResult: ComparisonResult
    
    var hashValue: Int {
        return title.hashValue ^ declarationPattern.hashValue ^ sortingComparisonResult.hashValue
    }
}

func ==(lhs: ImportCategory, rhs: ImportCategory) -> Bool {
    return lhs.title == rhs.title && lhs.declarationPattern == rhs.declarationPattern && lhs.sortingComparisonResult == rhs.sortingComparisonResult
}
