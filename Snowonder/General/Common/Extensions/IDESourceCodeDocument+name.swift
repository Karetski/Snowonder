//
//  IDESourceCodeDocument+name.swift
//  Snowonder
//
//  Created by Alexey Karetski on 30.06.16.
//  Copyright © 2016 Alexey Karetski. All rights reserved.
//

extension IDESourceCodeDocument {
    
    func nameWithExtension() -> String? {
        return self.fileURL?.lastPathComponent
    }
    
    func name() -> String? {
        guard let nameWithExtension = self.nameWithExtension() else {
            return nil
        }
        
        return NSURL(string: nameWithExtension)?.URLByDeletingPathExtension?.absoluteString
    }
}