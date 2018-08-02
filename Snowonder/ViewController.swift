//
//  ViewController.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 19.06.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import Cocoa
import Snowonder_Configuration

class ViewController: NSViewController {

    // MARK: - Constant values
    
    private enum Constant {
        enum Font {
            static let linkedConfigurationPreviewText = NSFont(name: "Menlo", size: 12)
        }

        enum ScriptInfo {
            static let openSystemPreferencesExtensions: Script.Info = (Bundle.main, "open_system_preferences_extensions", .scpt)
        }
        
        enum URL {
            static let gitHub = Foundation.URL(string: "https://github.com/Karetski/Snowonder")
        }
    }

    // MARK: - Outlet properties
    
    @IBOutlet weak var linkedConfigurationTitleLabel: NSTextField!
    @IBOutlet var linkedConfigurationPreviewText: NSTextView!

    // MARK: - Controller lifecycle

    override func viewWillAppear() {
        super.viewWillAppear()

        updateAppearance()
        updateData()
    }
    
    // MARK: - Action handlers

    @IBAction func gitHubButtonAction(_ sender: NSButton) {
        if let url = Constant.URL.gitHub {
            NSWorkspace.shared.open(url)
        }
    }

    @IBAction func enableExtensionButtonAction(_ sender: NSButton) {
        Script(info: Constant.ScriptInfo.openSystemPreferencesExtensions).execute()
    }
    
    @IBAction func selectConfigButtonAction(_ sender: NSButton) {
        let openPanel = NSOpenPanel()
        openPanel.canChooseFiles = true
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.allowedFileTypes = ["json"]

        openPanel.begin { [weak self] (response) in
            guard let strongSelf = self,
                response.rawValue == NSFileHandlingPanelOKButton,
                let url = openPanel.urls.first else {
                    return
            }

            do {
                try ConfigurationManager.default.linkConfiguration(withTitle: url.lastPathComponent, at: url)
                strongSelf.updateData()
            } catch let error as ConfigurationManager.Error {
                switch error {
                case .decoderFailure:
                    NSAlert.showWithTitle("Unable to parse!", message: "Your configuration file is broken.", style: .critical)
                case .incorrectURL:
                    NSAlert.showWithTitle("Unable to open!", style: .critical)
                }
            } catch {
                NSAlert.showWithTitle("Unexpected error!", style: .critical)
            }
        }
    }

    @IBAction func resetConfigButtonAction(_ sender: NSButton) {
        ConfigurationManager.default.resetLinkedConfiguration()
        updateData()
    }

    // MARK: - Updates

    func updateAppearance() {
        linkedConfigurationPreviewText.font = Constant.Font.linkedConfigurationPreviewText
    }

    func updateData() {
        linkedConfigurationTitleLabel.stringValue = ConfigurationManager.default.linkedConfigurationTitle
        linkedConfigurationPreviewText.string = ConfigurationManager.default.linkedConfigurationJSON
    }
}

private extension NSAlert {
    static func showWithTitle(_ title: String? = nil, message: String? = nil, style: NSAlert.Style = .informational) {
        let alert = NSAlert()
        if let title = title {
            alert.messageText = title
        }
        if let message = message {
            alert.informativeText = message
        }
        alert.alertStyle = style
        alert.runModal()
    }
}
