//
//  LC_UIImagePickerViewController.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-15.
//  Copyright (c) 2013年 Like Say Developer ( https://github.com/titman/LCFramework / USE IN PROJECT http://www.likesay.com ).
//  All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "LC_UIImagePickerViewController.h"

@interface LC_UIImagePickerViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation LC_UIImagePickerViewController

-(void) dealloc
{
    self.imagePickFinishedBlock = nil;
    
    LC_SUPER_DEALLOC();
}

-(id) init
{
    LC_SUPER_INIT({
    
        self.delegate = self;
        self.allowsEditing = YES;

#if (TARGET_IPHONE_SIMULATOR)
        
#else
        //self.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
#endif
        
    });
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setPickerType:(LCImagePickerType)pickerType
{
    switch (pickerType) {
        case LCImagePickerTypePhotoLibrary:
            self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case LCImagePickerTypeCamera:
#if (TARGET_IPHONE_SIMULATOR)
            
#else
            self.sourceType = UIImagePickerControllerSourceTypeCamera;
#endif
            break;
        default:
            break;
    }
    
    _pickerType = pickerType;
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    NSMutableDictionary * dict= [NSMutableDictionary dictionaryWithDictionary:editingInfo];
    [dict setObject:image forKey:@"UIImagePickerControllerEditedImage"];
    [self imagePickerController:self didFinishPickingMediaWithInfo:dict];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (_pickerDelegate) {
        [_pickerDelegate imagePickerDidFinishedWithImageInfo:info picker:self];
    }
    
    if (self.imagePickFinishedBlock) {
        self.imagePickFinishedBlock(self,info);
    }
    
    NSLog(@"image info = %@",info);
    [self imagePickerControllerDidCancel:self];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissModalViewControllerAnimated:YES];
    }
}


@end
