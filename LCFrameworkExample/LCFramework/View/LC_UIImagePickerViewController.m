//
//  LC_UIImagePickerViewController.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-15.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
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
