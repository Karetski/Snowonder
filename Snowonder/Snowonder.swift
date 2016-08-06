//
//  Snowonder.swift
//
//  Created by Alexey Karetski on 27.06.16.
//  Copyright © 2016 Alexey Karetski. All rights reserved.
//

import Cocoa

var sharedPlugin: Snowonder?

class Snowonder: NSObject {

    var bundle: NSBundle
    
    // MARK: - Initialization

    class func pluginDidLoad(bundle: NSBundle) {
        let allowedLoaders = bundle.objectForInfoDictionaryKey("me.delisa.XcodePluginBase.AllowedLoaders") as! Array<String>
        if allowedLoaders.contains(NSBundle.mainBundle().bundleIdentifier ?? "") {
            sharedPlugin = Snowonder(bundle: bundle)
        }
    }

    init(bundle: NSBundle) {
        self.bundle = bundle

        super.init()
        
        if (NSApp != nil && NSApp.mainMenu == nil) {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.applicationDidFinishLaunching), name: NSApplicationDidFinishLaunchingNotification, object: nil)
        } else {
            postInitialSetup(Constant.isLogNeeded)
        }
    }
    
    // MARK: - Notifications

    func applicationDidFinishLaunching() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NSApplicationDidFinishLaunchingNotification, object: nil)
        postInitialSetup(Constant.isLogNeeded)
    }

    // MARK: - Setup

    private func postInitialSetup(isLogNeeded: Bool) {
        self.configureMenu()
        
        if isLogNeeded {
            self.logSetup(withSuccess: true)
        }
    }
    
    private func configureMenu() {
        guard let mainMenu = NSApp.mainMenu, let editMenu = mainMenu.itemWithTitle("Edit"), let editSubmenu = editMenu.submenu else {
            self.logSetup(withSuccess: false)
            
            return
        }
        
        editSubmenu.addItem(NSMenuItem.separatorItem())
        let snowonderItem = NSMenuItem(title: Constant.MenuItem.Main.title, action: nil, keyEquivalent: "")
        editSubmenu.addItem(snowonderItem);
        
        let snowonderSubmenu = NSMenu(title: Constant.MenuItem.Main.title)
        
        let sortFileImport = NSMenuItem(title: Constant.MenuItem.SortFileImport.title, action: #selector(self.sortFileImportItemAction), keyEquivalent: Constant.MenuItem.SortFileImport.keyEquivalent)
        sortFileImport.keyEquivalentModifierMask = Int(Constant.MenuItem.SortFileImport.keyEquivalentModifierMask.rawValue)
        sortFileImport.target = self
        
        let settingsItem = NSMenuItem(title: Constant.MenuItem.Settings.title, action: #selector(self.settingsItemAction), keyEquivalent: "")
        settingsItem.target = self
        
        snowonderSubmenu.addItem(sortFileImport)
        snowonderSubmenu.addItem(NSMenuItem.separatorItem())
        snowonderSubmenu.addItem(settingsItem)
        
        snowonderItem.submenu = snowonderSubmenu
    }
    
    private func logSetup(withSuccess successful: Bool) {
        guard let name = bundle.objectForInfoDictionaryKey("CFBundleName"), let version = bundle.objectForInfoDictionaryKey("CFBundleShortVersionString") else {
            return
        }
        let status = successful ? "loaded successfully" : "failed to load"
        
        print("Plugin \(name) \(version) \(status)")
    }
    
    // MARK: - Menu item actions
    
    func sortFileImportItemAction() {
        SortingManager.sortFileImport()
    }
    
    func settingsItemAction() {
        NSAlert().runModal()
    }
}

