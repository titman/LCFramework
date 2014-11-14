//
//  LC_CMDInput.m
//  LCFramework
//
//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_CMDInput.h"
#import "LC_CMDAnalysis.h"

@interface LC_CMDInput ()<UITextFieldDelegate>
{
    UITextField * textField;
}

@end

@implementation LC_CMDInput

- (id)init
{
    self = [super init];
    if (self) {

        self.frame = CGRectMake(0, 0, 280, 40);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
        self.layer.cornerRadius = 6.0f;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 2.0f;
        
        textField = [[LC_UITextField alloc] initWithFrame:LC_RECT_CREATE(0, 0, 280-4, 40-4)];
        textField.backgroundColor = [UIColor clearColor];
        textField.textColor = [UIColor whiteColor];
        textField.clearsOnBeginEditing = YES;
        textField.font = [UIFont systemFontOfSize:14];
        textField.returnKeyType = UIReturnKeySend;
        textField.delegate = self;
        textField.textAlignment = UITextAlignmentCenter;
        textField.text = @"Input cmd.";
        [self addSubview:textField];
        LC_RELEASE(textField);
    }
    return self;
}

-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    textField.frame = CGRectMake(2, 2, frame.size.width - 4, frame.size.height - 4);
}

- (BOOL)textFieldShouldReturn:(UITextField *)_textField
{
    [textField resignFirstResponder];
    
    CMDLog(@"CMD - %@",[textField.text lowercaseString]);
    
    NSString * info = [LC_CMDAnalysis analysisCommand:[textField.text lowercaseString]];
    
    if (!LC_NSSTRING_IS_INVALID(info)) {
        CMDLog(@"\n[\n%@\n]\n",info);
    }
    
    
    return YES;
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
