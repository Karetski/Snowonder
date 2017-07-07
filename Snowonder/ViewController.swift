//
//  ViewController.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 19.06.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    // MARK: - Constant values
    
    private struct Constant {
        
        struct ScriptInfo {
            
            static let openSystemPreferencesExtensions: Script.Info = (Bundle.main, "open_system_preferences_extensions", .scpt)
        }
    }
    
    // MARK: - Controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Action handlers
    
    @IBAction func enableExtensionButtonAction(_ sender: NSButton) {
        Script(info: Constant.ScriptInfo.openSystemPreferencesExtensions).execute()
    }
    
    @IBAction func setupKeybindingsButtonAction(_ sender: NSButton) {
    }
}
