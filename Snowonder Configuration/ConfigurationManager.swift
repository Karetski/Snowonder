//
//  ConfigurationManager.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 7/10/18.
//  Copyright © 2018 Karetski. All rights reserved.
//

import Foundation
import ImportArtisan

private enum Constant {
    enum Configuration {
        enum Default {
            static let title = "Default.json"
            static let groups: [ImportCategoriesGroup] = [swiftGroup, objcGroup]
            static let operations = ImportBlockFormatter.Operation.allCases
        }

        static let swiftGroup: ImportCategoriesGroup = [
            ImportCategory(title: "Framework", declarationPattern: "^\\s*(import) +.*.", sortingRulesChain: [.alphabetically(isAscending: true)]),
            ImportCategory(title: "Testable", declarationPattern: "^\\s*(@testable \\s*import) +.*.", sortingRulesChain: [.alphabetically(isAscending: true)])
        ]
        static let objcGroup: ImportCategoriesGroup = [
            ImportCategory(title: "Module", declarationPattern: "^\\s*(@import) +.*.", sortingRulesChain: [.alphabetically(isAscending: true)]),
            ImportCategory(title: "Global", declarationPattern: "^\\s*(#import) \\s*<.*>.*", sortingRulesChain: [.alphabetically(isAscending: true)]),
            ImportCategory(title: "Global Include", declarationPattern: "^\\s*(#include) \\s*<.*>.*", sortingRulesChain: [.alphabetically(isAscending: true)]),
            ImportCategory(title: "Local", declarationPattern: "^\\s*(#import) \\s*\".*\".*", sortingRulesChain: [.alphabetically(isAscending: true)]),
            ImportCategory(title: "Local Include", declarationPattern: "^\\s*(#include) \\s*\".*\".*", sortingRulesChain: [.alphabetically(isAscending: true)])
        ]
    }

    enum Key {
        static let linkedConfigurationTitle = "linkedConfigurationTitle"
        static let linkedConfiguration = "linkedConfiguration"
    }
}

public struct Configuration : Codable {
    public var groups: [ImportCategoriesGroup]
    public var operations: [ImportBlockFormatter.Operation]

    public static var `default`: Configuration {
        return Configuration(
            groups: Constant.Configuration.Default.groups,
            operations: Constant.Configuration.Default.operations
        )
    }
}

public class ConfigurationManager {
    public enum Error : Swift.Error {
        case incorrectURL
        case decoderFailure
    }

    public var linkedConfigurationTitle: String {
        get {
            guard let linkedConfigurationTitle = storage.string(forKey: Constant.Key.linkedConfigurationTitle) else {
                return Constant.Configuration.Default.title
            }
            return linkedConfigurationTitle
        }
        set {
            storage.set(newValue, forKey: Constant.Key.linkedConfigurationTitle)
        }
    }

    public private(set) var linkedConfiguration: Configuration {
        get {
            guard let configurationWrapper = storage.decode(Configuration.self, forKey: Constant.Key.linkedConfiguration, using: decoder) else {
                return .default
            }
            return configurationWrapper
        }
        set {
            try? storage.encode(newValue, forKey: Constant.Key.linkedConfiguration, using: encoder)
        }
    }

    public var linkedConfigurationJSON: String {
        encoder.outputFormatting = .prettyPrinted

        defer {
            encoder.outputFormatting = []
        }

        guard let configurationData = try? encoder.encode(linkedConfiguration),
            let configurationJSON = String(data: configurationData, encoding: .utf8) else {
                return ""
        }

        return configurationJSON
    }

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private let storage: UserDefaults

    public init?(suiteName: String = "group.com.Karetski.Snowonder") {
        guard let storage = UserDefaults(suiteName: suiteName) else {
            return nil
        }
        self.storage = storage
    }

    public func linkConfiguration(withTitle title: String, at url: URL) throws {
        guard let data = FileManager.default.contents(atPath: url.path) else {
            throw Error.incorrectURL
        }

        guard let configuration = try? decoder.decode(Configuration.self, from: data) else {
            throw Error.decoderFailure
        }

        linkedConfigurationTitle = title
        linkedConfiguration = configuration
    }

    public func resetLinkedConfiguration() {
        storage.set(nil, forKey: Constant.Key.linkedConfigurationTitle)
        storage.set(nil, forKey: Constant.Key.linkedConfiguration)
    }
}
