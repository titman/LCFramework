//
//  LC_UITextField.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UITextField.h"


@interface LC_UITextFieldHandle : NSObject<UITextFieldDelegate>

@property(nonatomic,assign) LC_UITextField * textField;
@property(nonatomic,assign) NSInteger maxLength;

@end

@implementation LC_UITextFieldHandle

- (BOOL)textFieldShouldBeginEditing:(LC_UITextField *)textField
{
    if (textField.shouldBeginEditingBlock) {
        return textField.shouldBeginEditingBlock((LC_UITextField *)textField);
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(LC_UITextField *)textField
{
    if (textField.didBeginEditingBlock) {
        textField.didBeginEditingBlock((LC_UITextField *)textField);
    }
}

- (BOOL)textFieldShouldEndEditing:(LC_UITextField *)textField
{
    if (textField.shouldEndEditingBlock) {
        return textField.shouldEndEditingBlock((LC_UITextField *)textField);
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(LC_UITextField *)textField
{
    if (textField.didEndEditingBlock) {
        textField.didEndEditingBlock((LC_UITextField *)textField);
    }
}

- (BOOL)textField:(LC_UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.shouldChangeCharactersBlock) {
        return textField.shouldChangeCharactersBlock((LC_UITextField *)textField, range, string);
    }
    
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    if (self.maxLength == 0) {
        return YES;
    }
    
//    NSString * new = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    NSInteger res = self.maxLength - [new length];
//    if(res >= 0)
//    {
//        return YES;
//    }
//    else
//    {
//        NSRange rg = {0,[string length]+res};
//        if (rg.length>0)
//        {
//            NSString * s = [string substringWithRange:rg];
//            [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:s]];
//        }
//        return NO;
//    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(LC_UITextField *)textField
{
    if (textField.shouldClearBlock) {
        return textField.shouldClearBlock((LC_UITextField *)textField);
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(LC_UITextField *)textField
{
    if (textField.shouldReturnBlock) {
        return textField.shouldReturnBlock((LC_UITextField *)textField);
    }
    
    return YES;
}


@end

@interface LC_UITextField ()<UITextFieldDelegate>

@property(nonatomic,retain) LC_UITextFieldHandle * handle;

@end

@implementation LC_UITextField

-(void) dealloc
{
    [_handle release];
    
    self.shouldBeginEditingBlock = nil;
    self.didBeginEditingBlock = nil;
    self.shouldEndEditingBlock = nil;
    self.didEndEditingBlock = nil;
    self.shouldChangeCharactersBlock = nil;
    self.shouldClearBlock = nil;
    self.shouldReturnBlock = nil;
    
    self.placeholderColor = nil;
    
    LC_SUPER_DEALLOC();
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self initSelf];
    }
    return self;
}

-(id) init
{
    LC_SUPER_INIT({
        
        [self initSelf];
    })
}

-(void) initSelf
{
    self.handle = [[[LC_UITextFieldHandle alloc] init] autorelease];
    self.handle.maxLength = self.maxLength;
    self.delegate = self.handle;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

-(void) setMaxLength:(NSInteger)maxLength
{
    _maxLength = maxLength;
    self.handle.maxLength = self.maxLength;
}


@end
