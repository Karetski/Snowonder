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
            static let title = "Default"
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

    enum Manager {
        static let suiteName = "group.com.Karetski.Snowonder"

        enum Key {
            static let linkedConfigurationTitle = "linkedConfigurationTitle"
            static let linkedConfiguration = "linkedConfiguration"
        }
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
    enum Error : Swift.Error {
        case incorrectURL
        case decoderFailure
    }

    private let storage = UserDefaults(suiteName: Constant.Manager.suiteName)!

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    var linkedConfigurationTitle: String  {
        get {
            guard let linkedConfigurationTitle = storage.string(forKey: Constant.Manager.Key.linkedConfigurationTitle) else {
                return Constant.Configuration.Default.title
            }
            return linkedConfigurationTitle
        }
        set {
            storage.set(newValue, forKey: Constant.Manager.Key.linkedConfigurationTitle)
        }
    }

    public private(set) var linkedConfiguration: Configuration {
        get {
            guard let configurationWrapper = storage.decode(Configuration.self, forKey: Constant.Manager.Key.linkedConfiguration, using: decoder) else {
                return .default
            }
            return configurationWrapper
        }
        set {
            try? storage.encode(newValue, forKey: Constant.Manager.Key.linkedConfiguration, using: encoder)
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
        storage.set(nil, forKey: Constant.Manager.Key.linkedConfiguration)
    }
}

extension UserDefaults {
    func encode<Item : Codable>(_ item: Item, forKey key: String, using encoder: JSONEncoder) throws {
        let data = try encoder.encode(item)
        set(data, forKey: key)
    }

    func decode<Item : Codable>(_ type: Item.Type, forKey key: String, using decoder: JSONDecoder) -> Item? {
        guard let data = data(forKey: key) else {
            return nil
        }

        return try? decoder.decode(type, from: data)
    }
}
