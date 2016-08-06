//
//  SortingManager.swift
//  Snowonder
//
//  Created by Alexey Karetski on 29.06.16.
//  Copyright © 2016 Alexey Karetski. All rights reserved.
//

import Cocoa

class SortingManager {
    
    class func sortFileImport() {
        guard let document = XcodeHelper.currentDocument(), let textView = XcodeHelper.currentSourceCodeView(), let documentName = XcodeDocumentUtils.name(of: document) else {
            return
        }
        
        switch XcodeDocumentUtils.type(of: document) {
        case .Swift:
            print("Swift")
        case .ObjectiveC:
            if XcodeDocumentUtils.type(of: document) != .ObjectiveC {
                return
            }
            
            let sorter = ObjectiveCImportSorter(textView: textView, documentName: documentName)
            sorter.sort()
        case .Undefined:
            print("Undefined")
        }
    }
}