//
//  Config.swift
//  ImportArtisan
//
//  Created by Aliaksei Karetski on 7/10/18.
//  Copyright © 2018 Karetski. All rights reserved.
//

struct Config : Codable {
    var groups: [ImportCategoriesGroup]
    var operations: [ImportBlockFormatter.Operation]
}
