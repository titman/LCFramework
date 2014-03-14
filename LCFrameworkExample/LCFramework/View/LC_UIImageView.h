//
//  LC_UIImageView.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

#pragma mark -

@interface LC_ImageCache : NSObject

+ (LC_ImageCache *) sharedInstance;

- (BOOL)hasCachedForURL:(NSString *)url;
- (UIImage *)imageForURL:(NSString *)url;

- (void)saveImage:(UIImage *)image forURL:(NSString *)url;
- (void)saveData:(NSData *)data forURL:(NSString *)url;
- (void)deleteImageForURL:(NSString *)url;
- (void)deleteAllImages;

@end

#pragma mark -

@interface LC_UIImageView : UIImageView

@property (nonatomic, assign) BOOL							gray;			// 是否变为灰色
@property (nonatomic, assign) BOOL							round;			// 是否裁剪为圆型
@property (nonatomic, assign) BOOL							strech;			// 是否裁剪为圆型
@property (nonatomic, assign) UIEdgeInsets					strechInsets;	// 是否裁剪为圆型
@property (nonatomic, assign) BOOL							loading;
@property (nonatomic, assign) BOOL							loaded;
@property (nonatomic, assign) BOOL                          showIndicator;  // 是否显示菊花
@property (nonatomic, assign) BOOL                          autoRotate;
@property (nonatomic, retain) LC_UIActivityIndicatorView *	indicator;
@property (nonatomic, assign) UIActivityIndicatorViewStyle	indicatorStyle;
@property (nonatomic, retain) NSString *					loadedURL;

@property (nonatomic, assign) NSString *					url;
@property (nonatomic, assign) NSString *					file;
@property (nonatomic, assign) NSString *					resource;

@property (nonatomic, assign) UIImage * placeHolderImage;

- (void)GET:(NSString *)url useCache:(BOOL)useCache;
- (void)GET:(NSString *)url useCache:(BOOL)useCache placeHolder:(UIImage *)defaultImage;

- (void)clear;

@end
