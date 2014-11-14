//
//  LC_UITextView.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-9.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UITextView.h"

@interface LC_UITextView ()
{
    LC_UILabel * _placeholderLabel;
}

@end

@implementation LC_UITextView

-(void) dealloc
{
    self.placeholder = nil;
    self.beginEditing = nil;
    self.endEditing = nil;
    self.changed = nil;
    
    [self unobserveAllNotifications];
    
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
    });
}

-(void) initSelf
{
    _placeholderLabel = LC_UILabel.view;
    _placeholderLabel.frame = CGRectMake(5, 0, self.viewFrameWidth - 10, self.viewFrameHeight);
    _placeholderLabel.text = self.placeholder;
    _placeholderLabel.userInteractionEnabled = NO;
    _placeholderLabel.textColor = [UIColor lightGrayColor];
    _placeholderLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_placeholderLabel];
    
    
    [self observeNotification:UITextViewTextDidBeginEditingNotification object:self];
    [self observeNotification:UITextViewTextDidChangeNotification object:self];
    [self observeNotification:UITextViewTextDidEndEditingNotification object:self];
}

-(void) setPlaceholder:(NSString *)placeholder
{
    [_placeholder release];
    _placeholder = [placeholder retain];
    
    _placeholderLabel.text = placeholder;
    
    if (self.text.length == 0) {
        [self _setPlaceholderText:self.placeholder];
    }else{
        [self _setPlaceholderText:@""];
    }
}

-(void) setText:(NSString *)text
{
    [super setText:text];
    
    if (text.length == 0) {
        [self _setPlaceholderText:self.placeholder];
    }else{
        [self _setPlaceholderText:@""];
    }
}

-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _placeholderLabel.frame = CGRectMake(5, 0, self.viewFrameWidth - 10, self.viewFrameHeight);
}

#pragma mark -

-(void) handleNotification:(NSNotification *)notification
{
    if ([notification is:UITextViewTextDidBeginEditingNotification]) {
        
        if (notification.object != self) {
            return;
        }
        
        if (self.beginEditing) {
            self.beginEditing(self);
        }
        
    }else if([notification is:UITextViewTextDidChangeNotification]){

        if (notification.object != self) {
            return;
        }
        
        if (self.text.length == 0) {
            [self _setPlaceholderText:self.placeholder];
        }else{
            [self _setPlaceholderText:@""];
        }
        
        if (self.changed) {
            self.changed(self);
        }
        
    }else if ([notification is:UITextViewTextDidEndEditingNotification]){
        
        if (notification.object != self) {
            return;
        }
        
        if (self.endEditing) {
            self.endEditing(self);
        }
        
    }
}

-(void) _setPlaceholderText:(NSString *)text
{
    if (self.placeholderLabelOffsetY) {
        
        _placeholderLabel.viewFrameY = self.placeholderLabelOffsetY;
    }
    
//    CGSize size = [text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.viewFrameWidth - 10, self.viewFrameHeight)];
//    _placeholderLabel.frame = CGRectMake(5, 0, size.width, size.height);
    _placeholderLabel.text = text;
}


@end
