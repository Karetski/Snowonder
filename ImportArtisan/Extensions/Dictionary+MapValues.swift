//
//  Dictionary+MapValues.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 05.07.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

extension Dictionary {
    func mapValues<T>(_ transform: (Key, Value) -> T) -> [Key : T] {
        var transformed: [Key : T] = [:]
        for (key, value) in self {
            transformed[key] = transform(key, value)
        }
        return transformed
    }
}
