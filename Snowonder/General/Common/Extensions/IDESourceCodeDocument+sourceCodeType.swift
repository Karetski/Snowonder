//
//  IDESourceCodeDocument+sourceCodeType.swift
//  Snowonder
//
//  Created by Alexey Karetski on 30.06.16.
//  Copyright © 2016 Alexey Karetski. All rights reserved.
//

extension IDESourceCodeDocument {
    
    enum Type {
        case Undefined
        case Swift
        case ObjectiveC
    }
    
    func type() -> Type {
        var sourceCodeType: Type = .Undefined
        
        guard let fileURL = self.fileURL, let pathExtension = fileURL.pathExtension else {
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