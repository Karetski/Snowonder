//
//  XcodeHelper.m
//  Snowonder
//
//  Created by Alexey Karetski on 30.06.16.
//  Copyright © 2016 Alexey Karetski. All rights reserved.
//

#import "XcodeHelper.h"

@implementation XcodeHelper

+ (IDESourceCodeEditor *)currentEditor {
    NSWindowController *currentWindowController = [[NSApp keyWindow] windowController];
    if ([currentWindowController isKindOfClass:NSClassFromString(@"IDEWorkspaceWindowController")]) {
        IDEWorkspaceWindowController *workspaceController = (IDEWorkspaceWindowController *)currentWindowController;
        IDEEditorArea *editorArea = [workspaceController editorArea];
        IDEEditorContext *editorContext = [editorArea lastActiveEditorContext];
        IDEEditor *editor = (IDEEditor *)[editorContext editor];

        if ([editor isKindOfClass:NSClassFromString(@"IDESourceCodeEditor")]) {
            return (IDESourceCodeEditor *)editor;
        }
    }
    return nil;
}

+ (IDESourceCodeDocument *)currentDocument {
    IDESourceCodeEditor *editor = [self currentEditor];
    if (editor) {
        return editor.sourceCodeDocument;
    }
    return nil;
}

+ (NSTextView *)currentSourceCodeView {
    IDESourceCodeEditor *editor = [self currentEditor];
    if (editor) {
        return editor.textView;
    }
    return nil;
}

@end
