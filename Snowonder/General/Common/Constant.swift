//
//  Constants.swift
//  Snowonder
//
//  Created by Alexey Karetski on 28.06.16.
//  Copyright © 2016 Alexey Karetski. All rights reserved.
//

import Cocoa

struct Constant {
    static let isLogNeeded = true
    
    struct MenuItem {
        struct Main {
            static let title = "Snowonder"
        }
        
        struct SortFileImport {
            static let title = "Sort File Import"
            static let keyEquivalent = "s"
            static let keyEquivalentModifierMask = NSEventModifierFlags.ControlKeyMask
        }
        
        struct Settings {
            static let title = "Settings"
        }
    }
    
    struct Sorting {
        struct ObjectiveC {
            static let importDeclarationPrefix = "#import"
            static let classCategoryLabelPrefix = "// - "
            
            static let frameworkLibraryPattern = "#import <.*>"
        }
    }
}

