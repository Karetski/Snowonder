//
//  NSTextView+removeString.swift
//  Snowonder
//
//  Created by Alexey on 06.08.16.
//  Copyright © 2016 Alexey Karetski. All rights reserved.
//

import Foundation

extension NSTextView {
    
    func removeString(string: String) -> NSRange? {
        guard let selfString = self.textStorage?.string else {
            return nil
        }
        
        let selfNSString = selfString as NSString
        let rangeToRemove = selfNSString.rangeOfString(string)
        self.insertText("", replacementRange: rangeToRemove)
        
        return rangeToRemove
    }
}