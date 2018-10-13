//
//  ImportDetector.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 19.06.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

open class ImportBlockDetector {

    public enum Error : Swift.Error {
        case notFound
    }
    
    // MARK: - Initializers
    
    public init() { }
    
    // MARK: - Detection functions
    
    /// Creates new import block based on `lines` parameter.
    ///
    /// - Parameters:
    ///   - lines: Lines used to detect import declarations.
    /// - Throws: `ImportBlockDetector.Error.notFound` if import declarations can't be found.
    open func importBlock(from lines: [String], using availableGroups: [ImportCategoriesGroup]) throws -> ImportBlock {
        let group = self.group(for: lines, using: availableGroups)

        guard !group.isEmpty else {
            throw Error.notFound
        }

        let declarations = self.declarations(from: lines, using: group)
        let categorizedDeclarations = self.categorizedDeclarations(from: declarations, using: group)
        
        return .init(group: group, declarations: declarations, categorizedDeclarations: categorizedDeclarations)
    }
    
    /// Constructs import categories based on `lines` parameter.
    ///
    /// - Parameter lines: Lines used to construct import categories.
    /// - Returns: Constructed import declarations based on `lines` parameter.
    open func group(for lines: [String], using availableGroups: [ImportCategoriesGroup]) -> ImportCategoriesGroup {
        for line in lines {
            for group in availableGroups {
                for category in group {
                    if line.matches(pattern: category.declarationPattern) {
                        return group
                    }
                }
            }
        }

        return .init()
    }
    
    /// Detects import declarations based on `lines` parameter using import categories `group`.
    ///
    /// - Parameters:
    ///   - lines: Lines used to detect import declarations.
    ///   - group: Import categories group used to detect import declarations.
    /// - Returns: Detected import declarations.
    open func declarations(from lines: [String], using group: ImportCategoriesGroup) -> ImportDeclarations {
        return lines.filter { (line) -> Bool in
            var matches = false
            
            for category in group {
                matches = line.matches(pattern: category.declarationPattern)
                if matches {
                    break
                }
            }
            
            return matches
        }
    }

    /// Detects import declarations based on `lines` parameter and groupes it by import category using `group` parameter.
    ///
    /// - Parameters:
    ///   - lines: Lines used to detect and categorize import declarations.
    ///   - group: Import categories group used to detect and categorize import declarations.
    /// - Returns: Grouped by category import declarations.
    open func categorizedDeclarations(from lines: [String], using group: ImportCategoriesGroup) -> CategorizedImportDeclarations {
        var categorizedDeclarations = CategorizedImportDeclarations()
        
        for line in lines {
            for category in group {
                if line.matches(pattern: category.declarationPattern) {
                    if let _ = categorizedDeclarations[category] {
                        categorizedDeclarations[category]!.append(line)
                    } else {
                        categorizedDeclarations[category] = [line]
                    }
                }
            }
        }
        
        return categorizedDeclarations
    }
}
