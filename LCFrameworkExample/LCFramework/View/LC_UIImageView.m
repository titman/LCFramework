//
//  LC_UIImageView.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UIImageView.h"

@interface LC_ImageCache()
{
	LC_MemoryCache *	_memoryCache;
	LC_FileCache *		_fileCache;
}
@end

#pragma mark -

@implementation LC_ImageCache

+ (LC_ImageCache *)sharedInstance
{
    static dispatch_once_t once;
    static LC_ImageCache * __singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } );
    return __singleton__;
}

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
    
    self.autoRotate = YES;
    
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
    
	if ( NO == [string hasPrefix:@"http://"] )
	{
		string = [NSString stringWithFormat:@"http://%@", string];
	}
    
	if ( [string isEqualToString:self.loadedURL] )
		return;
    
	if ( [self requestingURL:string] )
		return;
    
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
    
	[self cancelRequests];
    
	self.loading	= NO;
	self.loadedURL	= string;
	self.loaded		= NO;
    
	if ( useCache && [[LC_ImageCache sharedInstance] hasCachedForURL:string] )
	{
		UIImage * image = [[LC_ImageCache sharedInstance] imageForURL:string];
		
		if ( image )
		{
			[self changeImage:image];
			
			self.loaded = YES;
            
            //Load finished
			return;
		}
	}
    
	[self changeImage:defaultImage];
	
	self.HTTP_GET( string ).TIMEOUT( 20.0f );
	
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
	UIImage * image = [UIImage imageNamed:string];
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
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
    
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
        
        if (self.autoRotate) {
         
            CGAffineTransform transform = CGAffineTransformIdentity;
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
            
            self.transform = transform;
            
        }
        
		[super setImage:image];
	}
	
	[self setNeedsDisplay];
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
	
	self.loadedURL = nil;
	self.loading = NO;
	
	[_indicator removeFromSuperview];
	[_indicator release];
    
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
        
		NSData * data = [request responseData];
		if ( data )
		{
			UIImage * image = [UIImage imageWithData:data];
			if ( image )
			{
				NSString * string = [request.url absoluteString];
                
				[[LC_ImageCache sharedInstance] saveImage:image forURL:string];
				[[LC_ImageCache sharedInstance] saveData:data forURL:string];
                
				[self setLoading:NO];
				self.loaded = YES;
				
				[self changeImage:image];
			}
			else
			{
				[self setLoading:NO];
				self.loaded = NO;
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
	}
}


@end
