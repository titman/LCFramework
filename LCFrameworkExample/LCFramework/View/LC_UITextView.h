//
//  LC_UITextView.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-9.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@class LC_UITextView;

typedef void (^TextViewDidBeginEditing)(LC_UITextView * textView);
typedef void (^TextViewChanged)(LC_UITextView * textView);
typedef void (^TextViewDidEndEditing)(LC_UITextView * textView);

@interface LC_UITextView : UITextView

@property(nonatomic,copy) TextViewDidBeginEditing beginEditing;
@property(nonatomic,copy) TextViewChanged changed;
@property(nonatomic,copy) TextViewDidEndEditing endEditing;

@end
