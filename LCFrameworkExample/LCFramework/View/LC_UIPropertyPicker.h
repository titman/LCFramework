//
//  LC_UIPropertyPicker.h
//  LCFramework
//
//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//

#import <UIKit/UIKit.h>

typedef void (^LCPropertyPickerSelectedBlock) (NSString * value ,int index);

@interface LC_UIPropertyPicker : UIView

@property(nonatomic,assign) UIToolbar * toolbar;
@property(nonatomic,assign) UIPickerView * picker;
@property(nonatomic,assign) LC_UIButton * sureButton;
@property(nonatomic,assign) LC_UIButton * cancelButton;

@property(nonatomic,retain) NSArray * propertyArray;
@property(nonatomic,copy) LCPropertyPickerSelectedBlock selectedAction;

-(id)initWithPropertArray:(NSArray *)propertyArray;

-(void) show;

-(void) hide;

@end
