//
//  ImportArtisan.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 27.06.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

open class ImportBlockFormatter {
    
    // MARK: - Common properties
    
    public enum Operation : String, Codable, CaseIterable {
        case trimWhitespaces
        case uniqueDeclarations
        case sortDeclarations
        case separateCategories
    }
    
    // MARK: - Initializers

    public init() { }
    
    // MARK: - Formatter
    
    /// Constructs import declarations lines from provided `importBlock` using the `operations`. The order of provided operations defines the way how they will be invoked.
    ///
    /// - Parameter importBlock: Source import declarations block.
    /// - Parameter operations: Formatting operations.
    /// - Returns: Constructed lines.
    open func lines(for importBlock: ImportBlock, using operations: [Operation]) -> [String] {
        return importBlock.categorizedDeclarations
            .applyingOperations(operations, accordingTo: importBlock.group)
            .flatDeclarations(accordingTo: importBlock.group)
    }
}

private extension Dictionary where Key == ImportCategory, Value == ImportDeclarations {

    // MARK: - Operations

    func applyingOperations(_ operations: [ImportBlockFormatter.Operation], accordingTo group: ImportCategoriesGroup) -> CategorizedImportDeclarations {
        return operations.reduce(self) { $0.applyingOperation($1, accordingTo: group) }
    }

    func applyingOperation(_ operation: ImportBlockFormatter.Operation, accordingTo group: ImportCategoriesGroup) -> CategorizedImportDeclarations {
        switch operation {
        case .trimWhitespaces:
            return trimmingWhitespaces()
        case .uniqueDeclarations:
            return uniqueDeclarations()
        case .sortDeclarations:
            return sortedDeclarations()
        case .separateCategories:
            return separatingCategories(accordingTo: group)
        }
    }
    
    func trimmingWhitespaces() -> CategorizedImportDeclarations {
        return mapValues { $0.map { $0.trimmingCharacters(in: .whitespaces) } }
    }
    
    func uniqueDeclarations() -> CategorizedImportDeclarations {
        return mapValues { $0.reduce([]) { $0.contains($1) ? $0 : $0 + [$1] } }
    }
    
    func sortedDeclarations() -> CategorizedImportDeclarations {
        return mapValues { (category, declarations) -> ImportDeclarations in
            return declarations.sorted(
                by: Comparator(
                    chain: category.sortingRulesChain.map { $0.comparator }
                )
            )
        }
    }
    
    func separatingCategories(accordingTo group: ImportCategoriesGroup) -> CategorizedImportDeclarations {
        guard let lastNotEmpty = group.filter({ !(self[$0]?.isEmpty ?? true) }).last else {
            return self
        }
        
        return mapValues { ($0 != lastNotEmpty && !$1.isEmpty) ? $1 + ["\n"] : $1 }
    }

    // MARK: - Flattening
    
    func flatDeclarations(accordingTo group: ImportCategoriesGroup) -> ImportDeclarations {
        var flatDeclarations = ImportDeclarations()
        group.forEach { (category) in
            if let categoryDeclarations = self[category], !categoryDeclarations.isEmpty {
                flatDeclarations.append(contentsOf: categoryDeclarations)
            }
        }
        
        return flatDeclarations
    }
}
