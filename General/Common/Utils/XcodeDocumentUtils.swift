//
//  XcodeDocumentUtils.swift
//  Snowonder
//
//  Created by Alexey on 01.08.16.
//  Copyright © 2016 Alexey Karetski. All rights reserved.
//

import Foundation

class XcodeDocumentUtils {
    
    // MARK: - IDESourceCodeDocument names
    
    class func nameWithExtension(of document: IDESourceCodeDocument) -> String? {
        return document.fileURL?.lastPathComponent
    }
    
    class func name(of document: IDESourceCodeDocument) -> String? {
        guard let nameWithExtension = self.nameWithExtension(of: document) else {
            return nil
        }
        
        return NSURL(string: nameWithExtension)?.URLByDeletingPathExtension?.absoluteString
    }
    
    // MARK: - IDESourceCodeDocument type
    
    enum Type {
        case Undefined
        case Swift
        case ObjectiveC
    }
    
    class func type(of document: IDESourceCodeDocument) -> Type {
        var sourceCodeType: Type = .Undefined
        
        guard let fileURL = document.fileURL, let pathExtension = fileURL.pathExtension else {
            return sourceCodeType
        }
        
        if ["swift"].contains(pathExtension) {
            sourceCodeType = .Swift
        } else if ["h", "m", "mm"].contains(pathExtension) {
            sourceCodeType = .ObjectiveC
        }
        
        return sourceCodeType
    }
}