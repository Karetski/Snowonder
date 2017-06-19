//
//  String+matchesPattern.swift
//  Snowonder
//
//  Created by Alexey Karetski on 30.06.16.
//  Copyright © 2016 Alexey Karetski. All rights reserved.
//

import Foundation

extension String {
    func matches(pattern: String) -> Bool {
        var matches = false
        do {
            let regularExpression = try NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
            let matchStrings = regularExpression.matchesInString(self, options: [], range: NSMakeRange(0, self.characters.count))
            matches = matchStrings.count != 0
        } catch let error as NSError {
            print("Error: \(error) " + "description \(error.localizedDescription)")
        }
        return matches
    }
}