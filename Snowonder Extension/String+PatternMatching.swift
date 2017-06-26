//
//  String+PatternMatching.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 19.06.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Foundation

extension String {
    func matches(pattern: String) -> Bool {
        guard let regularExpression = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return false
        }

        let matchingStrings = regularExpression.matches(in: self, range: NSMakeRange(0, characters.count))
        return !matchingStrings.isEmpty
    }
}
