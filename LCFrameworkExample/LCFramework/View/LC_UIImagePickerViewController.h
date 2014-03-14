//
//  LC_UIImagePickerViewController.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-15.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@class LC_UIImagePickerViewController;

typedef NS_ENUM(NSInteger, LCImagePickerType) {
    LCImagePickerTypePhotoLibrary,
    LCImagePickerTypeCamera
};

typedef void (^LCImagePickerFinishedBlock)( LC_UIImagePickerViewController * req ,NSDictionary * imageInfo);

#pragma mark -

@protocol LCUIImagePickerViewControllerDelegate <NSObject>

@optional
-(void) imagePickerDidFinishedWithImageInfo:(NSDictionary *)imageInfo picker:(LC_UIImagePickerViewController *)picker;

@end

#pragma mark -

@interface LC_UIImagePickerViewController : UIImagePickerController

@property (nonatomic, assign) id<LCUIImagePickerViewControllerDelegate> pickerDelegate;

@property (nonatomic, assign) LCImagePickerType pickerType;

@property (nonatomic, copy) LCImagePickerFinishedBlock imagePickFinishedBlock;

@end
