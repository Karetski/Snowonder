//
//  ImportCategory.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 19.06.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Foundation

/// Import categories that are grouped by some rule.
public typealias ImportCategoriesGroup = [ImportCategory]

public struct ImportCategory : Hashable {
    
    // MARK: - Common properties
    
    /// Title of import category.
    public var title: String
    
    /// Pattern used to match import declaration to category.
    public var declarationPattern: String
    
    /// ComparisonResult used to sort import declarations in scope of category.
    public var sortingComparisonResult: ComparisonResult
    
    // MARK: - Hashable
    
    public var hashValue: Int {
        return title.hashValue ^ declarationPattern.hashValue ^ sortingComparisonResult.hashValue
    }
}

// MARK: - Equitable

public func ==(lhs: ImportCategory, rhs: ImportCategory) -> Bool {
    return lhs.title == rhs.title && lhs.declarationPattern == rhs.declarationPattern && lhs.sortingComparisonResult == rhs.sortingComparisonResult
}
