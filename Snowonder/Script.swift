//
//  Script.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 07.07.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Foundation

class Script {
    
    // MARK: - Common properties
    
    enum Extension: String {
        case scpt = "scpt"
        case scptd = "scptd"
        case appleScript = "applescript"
    }
    
    typealias Info = (bundle: Bundle, name: String, extension: Extension)
    
    var info: Info
    
    // MARK: - Initializers
    
    init(info: Info) {
        self.info = info
    }
    
    // MARK: - Executors
    
    func execute() {
        guard let scriptURL = info.bundle.url(forResource: info.name, withExtension: info.extension.rawValue) else {
            return
        }
        
        switch info.extension {
        case .scpt, .scptd, .appleScript:
            executeAppleScript(with: scriptURL)
        }
    }
    
    private func executeAppleScript(with url: URL) {
        if let script = NSAppleScript(contentsOf: url, error: nil) {
            script.executeAndReturnError(nil)
        }
    }
}
