//
//  LC_UIImagePickerViewController.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-15.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    if (IOS7_OR_LATER)
    {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            if (!granted) {
                [LC_UIAlertView showMessage:LC_LO(@"相机使用权限未开启，请在手机设置中开启权限（设置-隐私-相机）") cancelTitle:LC_LO(@"我知道了")];
                
            }
            
        }];
    }

}

-(void) setPickerType:(LCImagePickerType)pickerType
{
    switch (pickerType) {
        case LCImagePickerTypePhotoLibrary:
            
            if ([[self class] isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                
                self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            
            break;
        case LCImagePickerTypeCamera:
#if (TARGET_IPHONE_SIMULATOR)
            
#else
            if ([[self class] isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                
                self.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
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
    //UIImageWriteToSavedPhotosAlbum([info objectForKey:@"UIImagePickerControllerEditedImage"] ? [info objectForKey:@"UIImagePickerControllerEditedImage"] : [info objectForKey:@"UIImagePickerControllerOriginalImage"], nil, nil,nil);
    
    INFO(@"[LC_UIImagePickerViewController] Image info = %@",info);
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        if (_pickerDelegate) {
            [_pickerDelegate imagePickerDidFinishedWithImageInfo:info picker:self];
        }
        
        if (self.imagePickFinishedBlock) {
            self.imagePickFinishedBlock(self,info);
        }
    }];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
