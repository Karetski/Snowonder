//
//  UserDefaults+Codable.swift
//  Snowonder Configuration
//
//  Created by Aliaksei Karetski on 7/12/18.
//  Copyright © 2018 Karetski. All rights reserved.
//

import Foundation

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
