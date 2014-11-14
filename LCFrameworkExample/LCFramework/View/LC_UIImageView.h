//
//  LC_UIImageView.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

#pragma mark -

@interface LC_ImageCache : NSObject

@property(nonatomic,readonly) LC_MemoryCache * memoryCache;
@property(nonatomic,readonly) LC_FileCache * fileCache;

- (BOOL)hasCachedForURL:(NSString *)url;
- (UIImage *)imageForURL:(NSString *)url;
- (NSString *)urlForImage:(UIImage *)image;

- (void)saveImage:(UIImage *)image forURL:(NSString *)url;
- (void)saveData:(NSData *)data forURL:(NSString *)url;
- (void)deleteImageForURL:(NSString *)url;
- (void)deleteAllImages;

@end

#pragma mark -

typedef void (^LCImageViewLoadFinishedBlock)(id imageView);
typedef void (^LCImageViewDownloadProgressUpdatedBlock)(float percent);

@interface LC_UIImageView : UIImageView

@property (nonatomic, assign) BOOL							gray;			// 是否变为灰色
@property (nonatomic, assign) BOOL							round;			// 是否裁剪为圆型
@property (nonatomic, assign) BOOL							strech;			// 是否裁剪为圆型
@property (nonatomic, assign) UIEdgeInsets					strechInsets;	// 是否裁剪为圆型
@property (nonatomic, assign) BOOL                          blur;           // 是否变为模糊
@property (nonatomic, assign) BOOL                          autoClip;       // 自动裁剪至适合

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

@property (nonatomic, retain) UIColor * imageTintColor;

@property (nonatomic, assign) UIImage * placeHolderImage;

@property (nonatomic, copy) LCImageViewLoadFinishedBlock loadImageFinishedBlock;
@property (nonatomic, copy) LCImageViewDownloadProgressUpdatedBlock downloadProgressUpdateBlock;

+ (instancetype)imageViewWithImage:(UIImage *)image;

- (void)GET:(NSString *)url useCache:(BOOL)useCache;
- (void)GET:(NSString *)url useCache:(BOOL)useCache placeHolder:(UIImage *)defaultImage;

- (void)clear;


+(NSString *) currentWebImageCache;

@end
