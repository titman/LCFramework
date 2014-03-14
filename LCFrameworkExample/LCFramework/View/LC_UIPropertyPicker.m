//
//  LC_UIPropertyPicker.m
//  LCFramework
//
//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//

#import "LC_UIPropertyPicker.h"

@interface LC_UIPropertyPicker ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    BOOL _added;
    
    UIButton * _cancelTopButton;
}

@end

@implementation LC_UIPropertyPicker

-(void) dealloc
{
    self.selectedAction = nil;
    
    [_propertyArray release];
    
    LC_SUPER_DEALLOC();
}

- (id)initWithPropertArray:(NSArray *)propertyArray
{
    self = [super initWithFrame:CGRectMake(0, 0, LC_DEVICE_WIDTH, LC_DEVICE_HEIGHT+20)];
    if (self) {
        
        [self initSelf:CGRectMake(0, 0, LC_DEVICE_WIDTH, LC_DEVICE_HEIGHT+20)];
        self.propertyArray = propertyArray;
        
    }
    return self;
}

-(id) init
{
    self = [super initWithFrame:CGRectMake(0, 0, LC_DEVICE_WIDTH, LC_DEVICE_HEIGHT+20)];
    if (self) {
        
        [self initSelf:CGRectMake(0, 0, LC_DEVICE_WIDTH, LC_DEVICE_HEIGHT+20)];
    }
    return self;
}

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSelf:frame];
    }
    return self;
}

-(void) initSelf:(CGRect)frame
{
    _cancelTopButton = [LC_UIButton buttonWithType:UIButtonTypeCustom];
    _cancelTopButton.frame = CGRectMake(0, 0, 320, frame.size.height);
    [_cancelTopButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelTopButton];
    
    
    self.picker = [[UIPickerView alloc] init];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    self.picker.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.picker];
    [self.picker release];
    
    
    self.picker.frame = CGRectMake(0, self.viewFrameHeight-_picker.viewFrameHeight, self.viewFrameWidth, _picker.viewFrameHeight);
    
    self.toolbar = LC_AUTORELEASE([[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 42)]);
    _toolbar.backgroundColor = [UIColor colorWithRed:248./255. green:248./255. blue:248./255. alpha:1];
    [self addSubview:_toolbar];
    
    
    self.cancelButton = LC_AUTORELEASE([[LC_UIButton alloc] init]);
    self.cancelButton.frame = CGRectMake(0, 0, 61, 42);
    self.cancelButton.title = @"取消";
    self.cancelButton.titleFont = [UIFont systemFontOfSize:15];
    self.cancelButton.titleColor = LC_COLOR_W_RGB(51, 51, 51, 1);
    [self.cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.toolbar addSubview:self.cancelButton];
    
    
    self.sureButton = LC_AUTORELEASE([[LC_UIButton alloc] init]);
    self.sureButton.frame = CGRectMake(frame.size.width-61, 0, 61, 42);
    self.sureButton.title = @"确定";
    self.sureButton.titleFont = [UIFont systemFontOfSize:15];
    self.sureButton.titleColor = LC_COLOR_W_RGB(51, 51, 51, 1);
    [self.sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.toolbar addSubview:self.sureButton];
}

-(void) setPropertyArray:(NSArray *)propertyArray
{
    if (propertyArray != _propertyArray) {
        [_propertyArray release];
        _propertyArray = [propertyArray retain];
    }
    
    [self.picker reloadAllComponents];
}

- (void) show
{
    if (_added) {
        return;
    }
    
    _added = YES;
    
    UIView * keyWindow = LC_KEYWINDOW;
    
    self.alpha = 0;
    
    self.frame = CGRectMake(0, 0, keyWindow.viewFrameWidth, keyWindow.viewFrameHeight);
    self.picker.frame = CGRectMake(0, self.viewFrameHeight-self.picker.viewFrameHeight, self.viewFrameWidth, self.picker.viewFrameHeight);
    self.toolbar.frame = CGRectMake(0, keyWindow.viewFrameHeight-self.picker.viewFrameHeight-self.toolbar.viewFrameHeight, self.viewFrameWidth, self.toolbar.viewFrameHeight);
    _cancelTopButton.frame = CGRectMake(0, 0, keyWindow.viewFrameWidth, self.toolbar.viewFrameY);
    [keyWindow addSubview:self];
    
    LC_FAST_ANIMATIONS(0.25, ^{
        
        self.alpha = 1;

    });
}

-(void) hide
{
    if (!_added) {
        return;
    }
    
    LC_FAST_ANIMATIONS_F(0.25, ^{
    
        self.alpha = 0;
    
    }, ^(BOOL isFinished){
        
        _added = NO;
        [self removeFromSuperview];
    });
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.propertyArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.propertyArray[row];
}

-(void) cancelAction
{
    [self hide];
}

-(void) sureAction
{
    if (self.selectedAction) {
        
        int selectRow = [self.picker selectedRowInComponent:0];
        self.selectedAction(self.propertyArray[selectRow],selectRow);
    }
    
    [self hide];
}


@end
