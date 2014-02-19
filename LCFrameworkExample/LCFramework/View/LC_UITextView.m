//
//  LC_UITextView.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-9.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UITextView.h"

@implementation LC_UITextView

-(void) dealloc
{
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
    [self observeNotification:UITextViewTextDidBeginEditingNotification];
    [self observeNotification:UITextViewTextDidChangeNotification];
    [self observeNotification:UITextViewTextDidEndEditingNotification];

}

-(void) handleNotification:(NSNotification *)notification
{
    if ([notification is:UITextViewTextDidBeginEditingNotification]) {
        
        if (self.beginEditing) {
            self.beginEditing(notification.object);
        }
        
    }else if([notification is:UITextViewTextDidChangeNotification]){
        
        if (self.changed) {
            self.changed(notification.object);
        }
        
    }else if ([notification is:UITextViewTextDidEndEditingNotification]){
        
        if (self.endEditing) {
            self.endEditing(notification.object);
        }
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
