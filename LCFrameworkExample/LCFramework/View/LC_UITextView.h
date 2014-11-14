//
//  LC_UITextView.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-9.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@class LC_UITextView;

typedef void (^LCTextViewDidBeginEditing)(LC_UITextView * textView);
typedef void (^LCTextViewChanged)(LC_UITextView * textView);
typedef void (^LCTextViewDidEndEditing)(LC_UITextView * textView);

@interface LC_UITextView : UITextView

@property(nonatomic,assign) float placeholderLabelOffsetY;
@property(nonatomic,retain) NSString * placeholder;
@property(nonatomic,copy) LCTextViewDidBeginEditing beginEditing;
@property(nonatomic,copy) LCTextViewChanged changed;
@property(nonatomic,copy) LCTextViewDidEndEditing endEditing;

@end
