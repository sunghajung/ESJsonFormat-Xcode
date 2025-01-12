//
//  ESDialogController.m
//  ESJsonFormat
//
//  Created by 尹桥印 on 15/6/26.
//  Copyright (c) 2015年 EnjoySR. All rights reserved.
//

#import "ESDialogController.h"

@interface ESDialogController ()<NSWindowDelegate,NSTextFieldDelegate>
@property (weak) IBOutlet NSTextField *msgLabel;
@property (weak) IBOutlet NSTextField *classNameField;

@end

@implementation ESDialogController

- (void)windowDidLoad {
    [super windowDidLoad];
    self.classNameField.delegate = self;
    self.window.delegate = self;
    self.msgLabel.stringValue = self.msg;
    self.classNameField.stringValue = self.className;
    [self.classNameField becomeFirstResponder];
}

-(void)setDataWithMsg:(NSString *)msg defaultClassName:(NSString *)className useDefault:(void (^)(NSString *))useDefaultBlock enter:(void (^)(NSString *))enterBlock{
    self.msg = msg;
    self.className = className;
    self.useDefaultBlock = useDefaultBlock;
    self.enterBlock = enterBlock;
}
- (IBAction)useDefaultBtnClick:(NSButton *)sender {
    if (self.useDefaultBlock) {
        self.useDefaultBlock(self.className);
    }
    [self close];
}

- (IBAction)enterBtnClick:(NSButton *)sender {
    if (self.enterBlock) {
        self.enterBlock(self.classNameField.stringValue);
    }
    [self close];
}

-(void)windowWillClose:(NSNotification *)notification{
    [NSApp stopModal];
    [NSApp endSheet:[self window]];
    [[self window] orderOut:nil];
}


#pragma mark - nstextfiled delegate

-(void)controlTextDidEndEditing:(NSNotification *)notification{
    if ( [[[notification userInfo] objectForKey:@"NSTextMovement"] intValue] == NSReturnTextMovement){
        [self enterBtnClick:nil];
    }
}


@end
