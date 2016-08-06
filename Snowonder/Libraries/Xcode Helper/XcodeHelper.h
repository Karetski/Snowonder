//
//  XcodeHelper.h
//  Snowonder
//
//  Created by Alexey Karetski on 30.06.16.
//  Copyright © 2016 Alexey Karetski. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XcodeComponents.h"

@interface XcodeHelper : NSObject

+ (IDESourceCodeEditor *)currentEditor;
+ (IDESourceCodeDocument *)currentDocument;
+ (NSTextView *)currentSourceCodeView;

@end
