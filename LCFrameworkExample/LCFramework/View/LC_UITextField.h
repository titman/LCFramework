//
//  LC_UITextField.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@class LC_UITextField;

typedef BOOL (^LCTextFieldShouldBeginEditingBlock) (LC_UITextField * textField);
typedef void (^LCTextFieldDidBeginEditingBlock) (LC_UITextField * textField);
typedef BOOL (^LCTextFieldShouldEndEditingBlock) (LC_UITextField * textField);
typedef void (^LCTextFieldDidEndEditingBlock) (LC_UITextField * textField);
typedef BOOL (^LCTextFieldShouldChangeCharactersBlock) (LC_UITextField * textField, NSRange range, NSString * replacementString);
typedef BOOL (^LCTextFieldShouldClearBlock) (LC_UITextField * textField);
typedef BOOL (^LCTextFieldShouldReturnBlock) (LC_UITextField * textField);



@interface LC_UITextField : UITextField

@property(nonatomic,copy) LCTextFieldShouldBeginEditingBlock shouldBeginEditingBlock;
@property(nonatomic,copy) LCTextFieldDidBeginEditingBlock didBeginEditingBlock;
@property(nonatomic,copy) LCTextFieldShouldEndEditingBlock shouldEndEditingBlock;
@property(nonatomic,copy) LCTextFieldDidEndEditingBlock didEndEditingBlock;
@property(nonatomic,copy) LCTextFieldShouldChangeCharactersBlock shouldChangeCharactersBlock;
@property(nonatomic,copy) LCTextFieldShouldClearBlock shouldClearBlock;
@property(nonatomic,copy) LCTextFieldShouldReturnBlock shouldReturnBlock;

@property(nonatomic,retain) UIColor * placeholderColor;
@property(nonatomic,assign) NSInteger maxLength;

@end
