//
//  Dictionary+MapValues.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 05.07.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func mapValues<T>(_ transform: (Key, Value) -> T) -> [Key : T] {
        var transformed: [Key : T] = [:]
        forEach { transformed[$0] = transform($0, $1) }
        return transformed
    }
}
