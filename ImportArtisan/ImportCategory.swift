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

    // MARK: - Sorting

//    public var sortingRulesChain: [SortingRule]

    public enum SortingRule : Codable, Hashable {
        case alphabetically(isAscending: Bool)
        case length(isAscending: Bool)

        public var comparator: Comparator<String> {
            switch self {
            case .alphabetically(let isAscending):
                return Comparator(isAscending: isAscending) { $0 }
            case .length(let isAscending):
                return Comparator(isAscending: isAscending) { $0.count }
            }
        }

        // MARK: Codable

        public enum Key: CodingKey {
            case alphabeticallyIsAscending
            case lengthIsAscending
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Key.self)

            if let isAscending = try? container.decode(Bool.self, forKey: .alphabeticallyIsAscending) {
                self = .alphabetically(isAscending: isAscending)
            } else if let isAscending = try? container.decode(Bool.self, forKey: .lengthIsAscending) {
                self = .length(isAscending: isAscending)
            } else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Cannot initialize"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: Key.self)
            switch self {
            case .alphabetically(let isAscending):
                try container.encode(isAscending, forKey: .alphabeticallyIsAscending)
            case .length(let isAscending):
                try container.encode(isAscending, forKey: .lengthIsAscending)
            }
        }
    }
}
