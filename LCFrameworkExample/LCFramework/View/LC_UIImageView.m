//
//  LC_UIImageView.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UIImageView.h"

typedef void (^LCUIImageViewClipFinishBlock) ();

@interface LC_ImageCache()
{
	LC_MemoryCache *	_memoryCache;
	LC_FileCache *		_fileCache;
}
@end

#pragma mark -

@implementation LC_ImageCache

- (id)init
{
	self = [super init];
	if ( self )
	{
		_memoryCache = [[LC_MemoryCache alloc] init];
		_memoryCache.clearWhenMemoryLow = YES;
		_fileCache = [[LC_FileCache alloc] init];
		_fileCache.cachePath = LC_NSSTRING_FORMAT(@"%@/LC_Images/",[LC_Sanbox libCachePath]);
		_fileCache.cacheUser = @"";
	}
	return self;
}

- (void)dealloc
{
	[_memoryCache release];
	[_fileCache release];
	
    [super dealloc];
}

- (BOOL)hasCachedForURL:(NSString *)string
{
	NSString * cacheKey = [string MD5];
	
	BOOL flag = [_memoryCache hasObjectForKey:cacheKey];
    
	if ( NO == flag )
	{
		flag = [_fileCache hasObjectForKey:cacheKey];
	}
	
	return flag;
}

- (UIImage *)imageForURL:(NSString *)string
{
	NSString *	cacheKey = [string MD5];
	UIImage *	image = nil;
    
	NSObject * object = [_memoryCache objectForKey:cacheKey];
	if ( object && [object isKindOfClass:[UIImage class]] )
	{
		image = (UIImage *)object;
	}
    
	if ( nil == image )
	{
		NSString * fullPath = [_fileCache fileNameForKey:cacheKey];
		if ( fullPath )
		{
			image = [UIImage imageWithContentsOfFile:fullPath];
            
			UIImage * cachedImage = (UIImage *)[_memoryCache objectForKey:cacheKey];
			if ( nil == cachedImage && image != cachedImage )
			{
				[_memoryCache setObject:image forKey:cacheKey];
			}
		}
	}
    
	return image;
}

- (NSString *)urlForImage:(UIImage *)image
{
    return @"";
}


- (void)saveImage:(UIImage *)image forURL:(NSString *)string
{
	NSString * cacheKey = [string MD5];
	UIImage * cachedImage = (UIImage *)[_memoryCache objectForKey:cacheKey];
    
	if ( nil == cachedImage && image != cachedImage )
	{
		[_memoryCache setObject:image forKey:cacheKey];
	}
}

- (void)saveData:(NSData *)data forURL:(NSString *)string
{
	NSString * cacheKey = [string MD5];
	[_fileCache setObject:data forKey:cacheKey];
}

- (void)deleteImageForURL:(NSString *)string
{
	NSString * cacheKey = [string MD5];
	
	[_memoryCache removeObjectForKey:cacheKey];
	[_fileCache removeObjectForKey:cacheKey];
}

- (void)deleteAllImages
{
	[_memoryCache removeAllObjects];
	[_fileCache removeAllObjects];
}

@end

@implementation LC_UIImageView

@synthesize gray = _gray;
@synthesize round = _round;
@synthesize strech = _strech;
@synthesize strechInsets = _strechInsets;
@synthesize loading = _loading;
@synthesize indicator = _indicator;
@dynamic indicatorStyle;
@synthesize loadedURL = _loadedURL;
@synthesize loaded	= _loaded;
@synthesize showIndicator = _showIndicator;

@synthesize url;
@synthesize file;
@synthesize resource;

- (id)init
{
	self = [super init];
	if ( self )
	{
		[self initSelf];
	}
	return self;
}

+ (instancetype)imageViewWithImage:(UIImage *)image
{
    return [[[LC_UIImageView alloc] initWithImage:image] autorelease];
}

- (id)initWithImage:(UIImage *)image
{
	self = [super initWithImage:image];
	if ( self )
	{
		[self initSelf];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if ( self )
	{
		[self initSelf];
	}
	return self;
}

- (void)initSelf
{
    self.hidden = NO;
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    self.layer.opaque = YES;
    self.contentMode = UIViewContentModeScaleToFill;
    
    self.showIndicator = NO;
    self.autoClip = YES;
    self.autoRotate = NO;
    
    _loading = NO;
    _loaded	 = NO;
    
    _gray = NO;
    _round = NO;
    _strech = NO;
    _strechInsets = UIEdgeInsetsZero;
}

- (void)GET:(NSString *)string useCache:(BOOL)useCache
{
	[self GET:string useCache:useCache placeHolder:nil];
}

- (void)GET:(NSString *)string useCache:(BOOL)useCache placeHolder:(UIImage *)defaultImage
{
	if ( nil == string || 0 == string.length )
	{
		[self changeImage:nil];
		return;
	}
    
	if ( NO == [string hasPrefix:@"http://"] && NO == [string hasPrefix:@"https://"])
	{
		string = [NSString stringWithFormat:@"http://%@", string];
	}
    
	if ( [self requestingURL:string] )
		return;
    
    
	[self cancelRequests];
    
	self.loading	= NO;
	self.loadedURL	= string;
	self.loaded		= NO;
    
	if ( useCache && [[LC_ImageCache LCInstance] hasCachedForURL:string] )
	{
		UIImage * image = [[LC_ImageCache LCInstance] imageForURL:string];
		
		if ( image )
		{
			[self changeImage:image];
			
			self.loaded = YES;
            
            //Load finished
			return;
		}
	}
    
    [self changeImage:defaultImage];
	
    NSString * md5String = [string MD5];
    NSString * filePath = [[LC_ImageCache LCInstance].fileCache.cachePath stringByAppendingString:LC_NSSTRING_FORMAT(@"/%@",md5String)];

    LC_HTTPRequest * request = self.GET(string).SAVE(filePath).TIMEOUT(30);
    
    request.downloadProgressDelegate = self;
}

-(void) setShowIndicator:(BOOL)showIndicator
{
    if (_indicator) {
        self.indicator.hidden = showIndicator;
    }
    
    _showIndicator = showIndicator;
}

- (void)setUrl:(NSString *)string
{
	[self GET:string useCache:YES];
}

- (void)setFile:(NSString *)path
{
	UIImage * image = [UIImage imageWithContentsOfFile:path];
    
	if ( image )
	{
		[self changeImage:image];
	}
	else
	{
		[self changeImage:nil];
	}
}

- (void)setResource:(NSString *)string
{
	UIImage * image = [UIImage imageNamed:string useCache:NO];
    
	if ( image )
	{
		[self changeImage:image];
	}
	else
	{
		[self changeImage:nil];
	}
}

- (void)setImage:(UIImage *)image
{
	[self changeImage:image];
}

- (void)changeImage:(UIImage *)image
{
    
	if ( nil == image )
	{
		[self cancelRequests];
		
		self.loading = NO;
		
		[super setImage:nil];
		[super setNeedsDisplay];
		return;
	}
    
	if ( image != self.image )
	{
		[self cancelRequests];
        
		if ( self.round )
		{
			image = [image rounded];
		}
        
		if ( self.gray )
		{
			image = [image grayscale];
		}
		
		if ( self.strech )
		{
			if ( NO == UIEdgeInsetsEqualToEdgeInsets(_strechInsets, UIEdgeInsetsZero) )
			{
				image = [image stretched:_strechInsets];
			}
			else
			{
				image = [image stretched];
			}
		}
        
        if ( self.blur ) {
            
            image = [image blurValue:10];
        }
        
        if (self.imageTintColor) {
            
            image = [image imageWithTintColor:self.imageTintColor];
        }
        
        if (self.autoRotate) {
         
            CGAffineTransform transform = self.transform;
            UIImageOrientation orientation = image.imageOrientation;
            switch ( orientation )
            {
                case UIImageOrientationDown:           // EXIF = 3
                case UIImageOrientationDownMirrored:   // EXIF = 4
                    transform = CGAffineTransformRotate(transform, M_PI);
                    break;
                    
                case UIImageOrientationLeft:           // EXIF = 6
                case UIImageOrientationLeftMirrored:   // EXIF = 5
                    transform = CGAffineTransformRotate(transform, M_PI_2);
                    break;
                    
                case UIImageOrientationRight:          // EXIF = 8
                case UIImageOrientationRightMirrored:  // EXIF = 7
                    transform = CGAffineTransformRotate(transform, -M_PI_2);
                    break;
                case UIImageOrientationUp:
                case UIImageOrientationUpMirrored:
                    break;
            }
            
            self.transform =  transform;
            
        }
        
        
        [super setImage:image];
	}
	
	[self setNeedsDisplay];
}

-(void) setBlur:(BOOL)blur
{
    _blur = blur;
    
    [self changeImage:self.image];
}

-(void) safeSetImage:(UIImage *)image
{
    CGSize origImageSize = [image size];
    
    if (image.size.width < self.viewFrameWidth * 2 && image.size.height < self.viewFrameHeight * 2) {
        
        [super setImage:image];
        return;
    }
    
    [LC_GCD dispatchAsync:LC_GCD_PRIORITY_DEFAULT block:^{
       
        CGRect newRect;
        newRect.origin= CGPointZero;
        
        newRect.size.width = self.viewFrameWidth;
        newRect.size.height= self.viewFrameHeight;
        
        //缩放倍数
        float ratio = MIN(newRect.size.width/origImageSize.width, newRect.size.height/origImageSize.height);
        
        UIGraphicsBeginImageContext(newRect.size);
        
        
        CGRect projectRect;
        projectRect.size.width =ratio * origImageSize.width;
        projectRect.size.height=ratio * origImageSize.height;
        projectRect.origin.x= (newRect.size.width -projectRect.size.width)/2.0;
        projectRect.origin.y= (newRect.size.height-projectRect.size.height)/2.0;
        
        [image drawInRect:projectRect];
        
        UIImage * small = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [LC_GCD dispatchAsyncInMainQueue:^{
           
            [super setImage:small];
            
        }];

    }];
}

- (void)setFrame:(CGRect)frame
{
	[super setFrame:frame];
    
	if ( _indicator )
	{
		CGRect indicatorFrame;
		indicatorFrame.size.width = 20.0f;
		indicatorFrame.size.height = 20.0f;
		indicatorFrame.origin.x = (frame.size.width - indicatorFrame.size.width) / 2.0f;
		indicatorFrame.origin.y = (frame.size.height - indicatorFrame.size.height) / 2.0f;
		
		_indicator.frame = indicatorFrame;
	}
}

- (void)clear
{
	[self cancelRequests];
	[self changeImage:nil];
    
	self.loadedURL = nil;
	self.loading = NO;
}

- (void)dealloc
{
	[self cancelRequests];
	
    self.imageTintColor = nil;
	self.loadedURL = nil;
	self.loading = NO;
    self.loadImageFinishedBlock = nil;
    self.downloadProgressUpdateBlock = nil;

	[super dealloc];
}

- (LC_UIActivityIndicatorView *)indicator
{
	if ( nil == _indicator && self.showIndicator)
	{
		CGRect indicatorFrame;
		indicatorFrame.size.width = 20.0f;
		indicatorFrame.size.height = 20.0f;
		indicatorFrame.origin.x = (self.frame.size.width - indicatorFrame.size.width) / 2.0f;
		indicatorFrame.origin.y = (self.frame.size.height - indicatorFrame.size.height) / 2.0f;
		_indicator = [[LC_UIActivityIndicatorView alloc] initWithFrame:indicatorFrame];
		_indicator.backgroundColor = [UIColor clearColor];
		[self addSubview:_indicator];
        [_indicator release];
	}
	
	return _indicator;
}

-(void) setPlaceHolderImage:(UIImage *)placeHolderImage
{
    if (placeHolderImage) {
        [self changeImage:placeHolderImage];
    }
}

-(UIImage *) placeHolderImage
{
    return self.image;
}

- (UIActivityIndicatorViewStyle)indicatorStyle
{
	return self.indicator.activityIndicatorViewStyle;
}

- (void)setIndicatorStyle:(UIActivityIndicatorViewStyle)value
{
	self.indicator.activityIndicatorViewStyle = value;
}

#pragma mark -
#pragma mark NetworkRequestDelegate

- (void)setProgress:(float)newProgress
{
    if (self.downloadProgressUpdateBlock) {
        self.downloadProgressUpdateBlock(newProgress);
    }
}

- (void)handleRequest:(LC_HTTPRequest *)request
{
	if ( request.sending )
	{
		[self.indicator startAnimating];
        
		[self setLoading:YES];
	}
	else if ( request.sendProgressed )
	{
        
	}
	else if ( request.recving )
	{

	}
	else if ( request.recvProgressed )
	{

	}
	else if ( request.succeed )
	{
		[self.indicator stopAnimating];
    
        NSString * string = [request.url absoluteString];
        
        NSString * md5String = [string MD5];
        NSString * filePath = [[LC_ImageCache LCInstance].fileCache.cachePath stringByAppendingString:LC_NSSTRING_FORMAT(@"/%@",md5String)];
        
        UIImage * image = [UIImage imageWithContentsOfFile:filePath];
        
        if ( image )
        {
            [[LC_ImageCache LCInstance] saveImage:image forURL:string];
            
            //由于更改了下载方式，现在不需要在这保存了
            //[[LC_ImageCache LCInstance] saveData:data forURL:string];
            
            [self setLoading:NO];
            self.loaded = YES;
            
            CATransition * animation = [CATransition animation];
            [animation setDuration:0.25];
            [animation setType:kCATransitionFade];
            [self.layer addAnimation:animation forKey:@"transition"];
            
            [self changeImage:image];
            
            if (self.loadImageFinishedBlock) {
                self.loadImageFinishedBlock(self);
            }
		}
		else
		{
			[self setLoading:NO];
			self.loaded = NO;
		}
	}
	else if ( request.failed )
	{
		[self.indicator stopAnimating];
		
		[self setLoading:NO];
		self.loaded = NO;
	}
	else if ( request.cancelled )
	{
		[self.indicator stopAnimating];
		[self setLoading:NO];
        self.loaded = NO;
	}
}

+(NSString *) currentWebImageCache
{
    NSDictionary * cache = [LC_ImageCache LCInstance].memoryCache.cacheObjs;
    
    if (!cache) {
        return @"No web image cache, or no use LC_ImageCache.";
    }
    
    NSMutableString * info = [NSMutableString stringWithFormat:@"  * count : %d\n",cache.allKeys.count];
    
    float size = 0.0f;
    
    for (NSString * key in cache.allKeys) {
        
        UIImage * oneInfo = cache[key];
        
        size_t bit = CGImageGetBitsPerPixel(oneInfo.CGImage);
        
        float aSize = oneInfo.size.width * oneInfo.size.height * bit / 8;
        
        size += aSize;
    
        [info appendFormat:@"  * %@ size : %fMB [%@]\n",oneInfo,aSize/1024./1024./10,key];
    }
    
    [info appendFormat:@"  * All size : %fMB\n",size/1024./1024./10];
    
    return info;
    
}


@end
