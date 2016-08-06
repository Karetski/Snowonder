//
//  XcodeComponents.h
//  Snowonder
//
//  Created by Alexey Karetski on 30.06.16.
//  Copyright © 2016 Alexey Karetski. All rights reserved.
//

#ifndef ImportSorter_XcodeComponents_h
#define ImportSorter_XcodeComponents_h

#import <Cocoa/Cocoa.h>

@interface DVTTextStorage : NSTextStorage

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)string withUndoManager:(id)undoManager;
- (NSRange)lineRangeForCharacterRange:(NSRange)range;
- (NSRange)characterRangeForLineRange:(NSRange)range;
- (void)indentCharacterRange:(NSRange)range undoManager:(id)undoManager;

@end


@interface IDESourceCodeDocument : NSDocument

@property(readonly) DVTTextStorage *textStorage;

@end


@interface IDEEditor : NSObject

@property(readonly) IDESourceCodeDocument *sourceCodeDocument;

@end


@class IDESourceCodeEditor;

@interface IDESourceCodeEditor : IDEEditor

@property (retain) NSTextView *textView;

- (IDESourceCodeDocument *)sourceCodeDocument;

@end


@interface IDEEditorContext : NSObject

@property(retain, nonatomic) IDEEditor *editor;

@end


@interface IDEEditorArea : NSObject

@property(retain, nonatomic) IDEEditorContext *lastActiveEditorContext;

@end


@interface IDEWorkspaceWindowController : NSObject

@property(readonly) IDEEditorArea *editorArea;

@end

#endif
