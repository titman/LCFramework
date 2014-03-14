//
//  UIImage+extension.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "UIImage+Extension.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation UIImage (Extension)

+(UIImage *)imageNamed:(NSString *)name useCache:(BOOL)useCache
{
    if (YES == useCache) {
        return [UIImage imageNamed:name];
    }else{
    
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
        
        if (!path) {
            NSArray *tmp = [name componentsSeparatedByString:@"."];
            
            if (tmp.count > 0) {
                NSMutableString *string = [[NSMutableString alloc] initWithString:[tmp objectAtIndex:0]];
                [string appendString:@"@2x"];
                
                if (tmp.count == 1) {} else if (tmp.count == 2) {
                    [string appendFormat:@".%@", [tmp objectAtIndex:1]];
                } else {}
                
                path = [[NSBundle mainBundle] pathForResource:string ofType:nil];
                [string release];
            }
        }
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        return image;
    }
}

-(UIImage *) changeHueValue:(float)value
{
    if (value == 0){
        return [[self retain] autorelease];
    }
    
    CIImage * beginImage = [CIImage imageWithCGImage:self.CGImage];
    CIFilter * filter = [CIFilter filterWithName:@"CIHueAdjust"];
    [filter setValue:beginImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:value] forKey:@"inputAngle"];
    CIImage * outputImage = [filter outputImage];
    CIContext * context = [CIContext contextWithOptions: nil];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage * newImg = [UIImage imageWithCGImage:cgimg scale:2 orientation:UIImageOrientationUp];
    CGImageRelease(cgimg);
    
    return newImg;
}

- (void)addCircleRectToPath:(CGRect)rect context:(CGContextRef)context
{
    CGContextSaveGState( context );
    CGContextTranslateCTM( context, CGRectGetMinX(rect), CGRectGetMinY(rect) );
	CGContextSetShouldAntialias( context, true );
	CGContextSetAllowsAntialiasing( context, true );
	CGContextAddEllipseInRect( context, rect );
    CGContextClosePath( context );
    CGContextRestoreGState( context );
}

- (UIImage *)transprent
{
	CGImageAlphaInfo alpha = CGImageGetAlphaInfo( self.CGImage );
	
	if ( kCGImageAlphaFirst == alpha ||
		kCGImageAlphaLast == alpha ||
		kCGImageAlphaPremultipliedFirst == alpha ||
		kCGImageAlphaPremultipliedLast == alpha )
	{
		return self;
	}
    
	CGImageRef	imageRef = self.CGImage;
	size_t		width = CGImageGetWidth(imageRef);
	size_t		height = CGImageGetHeight(imageRef);
    
	CGContextRef context = CGBitmapContextCreate( NULL, width, height, 8, 0, CGImageGetColorSpace(imageRef), kCGBitmapByteOrderDefault|kCGImageAlphaPremultipliedFirst);
	CGContextDrawImage( context, CGRectMake(0, 0, width, height), imageRef );
    
	CGImageRef	resultRef = CGBitmapContextCreateImage( context );
	UIImage *	result = [UIImage imageWithCGImage:resultRef];
    
	CGContextRelease( context );
	CGImageRelease( resultRef );
    
	return result;
}

- (UIImage *)rounded
{
    UIImage * image = [self transprent];
	if ( nil == image )
		return nil;
	
	CGSize imageSize = image.size;
	imageSize.width = floorf( imageSize.width );
	imageSize.height = floorf( imageSize.height );
	
	CGFloat imageWidth = fminf(imageSize.width, imageSize.height);
	CGFloat imageHeight = imageWidth;
    
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate( NULL,
												 imageWidth,
												 imageHeight,
												 CGImageGetBitsPerComponent(image.CGImage),
												 imageWidth * 4,
												 colorSpace,
												 kCGImageAlphaPremultipliedLast );
    
    CGContextBeginPath(context);
	CGRect circleRect;
	circleRect.origin.x = 0;
	circleRect.origin.y = 0;
	circleRect.size.width = imageWidth;
	circleRect.size.height = imageHeight;
    [self addCircleRectToPath:circleRect context:context];
    CGContextClosePath(context);
    CGContextClip(context);
	
	CGRect drawRect;
	drawRect.origin.x = 0;
	drawRect.origin.y = 0;
	drawRect.size.width = imageWidth;
	drawRect.size.height = imageHeight;
    CGContextDrawImage(context, drawRect, image.CGImage);
    
    CGImageRef clippedImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
	CGColorSpaceRelease( colorSpace );
	
    UIImage * roundedImage = [UIImage imageWithCGImage:clippedImage];
    CGImageRelease(clippedImage);
	
    return roundedImage;
}

- (UIImage *)rounded:(CGRect)circleRect
{
    UIImage * image = [self transprent];
	if ( nil == image )
		return nil;
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate( NULL,
												 circleRect.size.width,
												 circleRect.size.height,
												 CGImageGetBitsPerComponent( image.CGImage ),
												 circleRect.size.width * 4,
												 colorSpace,
												 kCGImageAlphaPremultipliedLast );
	
    CGContextBeginPath(context);
    [self addCircleRectToPath:circleRect context:context];
    CGContextClosePath(context);
    CGContextClip(context);
	
	CGRect drawRect;
	drawRect.origin.x = 0; //(imageSize.width - imageWidth) / 2.0f;
	drawRect.origin.y = 0; //(imageSize.height - imageHeight) / 2.0f;
	drawRect.size.width = circleRect.size.width;
	drawRect.size.height = circleRect.size.height;
    CGContextDrawImage(context, drawRect, image.CGImage);
	
    CGImageRef clippedImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
	CGColorSpaceRelease(colorSpace);
	
    UIImage * roundedImage = [UIImage imageWithCGImage:clippedImage];
    CGImageRelease(clippedImage);
    
    return roundedImage;
}

- (UIImage *)stretched
{
	CGFloat leftCap = floorf(self.size.width / 2.0f);
	CGFloat topCap = floorf(self.size.height / 2.0f);
	return [self stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
}

- (UIImage *)stretched:(UIEdgeInsets)capInsets
{
    return [self resizableImageWithCapInsets:capInsets];
}

- (UIImage *)grayscale
{
	CGSize size = self.size;
	CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
	CGContextRef context = CGBitmapContextCreate(nil, size.width, size.height, 8, 0, colorSpace, kCGImageAlphaNone);
	CGColorSpaceRelease(colorSpace);
	
	CGContextDrawImage(context, rect, [self CGImage]);
	CGImageRef grayscale = CGBitmapContextCreateImage(context);
	CGContextRelease(context);
	
	UIImage * image = [UIImage imageWithCGImage:grayscale];
	CFRelease(grayscale);
	
	return image;
}

- (UIColor *)patternColor
{
	return [UIColor colorWithPatternImage:self];
}

-(UIImage *) blurValue:(float)value
{
    CIContext * context   = [CIContext contextWithOptions:nil];
    CIImage * sourceImage = [CIImage imageWithCGImage:self.CGImage];
    
    NSString *clampFilterName = @"CIAffineClamp";
    CIFilter *clamp = [CIFilter filterWithName:clampFilterName];
    
    if (!clamp) {
        return nil;
    }
    
    [clamp setValue:sourceImage
             forKey:kCIInputImageKey];
    
    CIImage * clampResult = [clamp valueForKey:kCIOutputImageKey];
    
    NSString * gaussianBlurFilterName = @"CIGaussianBlur";
    CIFilter * gaussianBlur           = [CIFilter filterWithName:gaussianBlurFilterName];
    
    if (!gaussianBlur) {
        
        return nil;
    }
    
    [gaussianBlur setValue:clampResult forKey:kCIInputImageKey];

    CIImage * gaussianBlurResult = [gaussianBlur valueForKey:kCIOutputImageKey];
    
    CGImageRef cgImage = [context createCGImage:gaussianBlurResult fromRect:[sourceImage extent]];
    
    UIImage * blurredImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);

    return blurredImage;
}


+(UIImage *) screenshotWithView:(UIView *)view
{
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    else
        UIGraphicsBeginImageContext(view.frame.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // -renderInContext: renders in the coordinate space of the layer,
    // so we must first apply the layer's geometry to the graphics context
    CGContextSaveGState(context);
    // Center the context around the window's anchor point
    CGContextTranslateCTM(context, view.center.x, view.center.y);
    // Apply the window's transform about the anchor point
    CGContextConcatCTM(context, view.transform);
    // Offset by the portion of the bounds left of and above the anchor point
    CGContextTranslateCTM(context,
                          -view.frame.size.width * [view.layer anchorPoint].x,
                          -view.frame.size.height * [view.layer anchorPoint].y);
    
    // Render the layer hierarchy to the current context
    [[view layer] renderInContext:context];
    
    // Restore the context
    CGContextRestoreGState(context);
    
//    if (!withStatusBar)
//        CGContextClearRect(context, CGRectMake(0, 0, [window bounds].size.width, 20));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


+(UIImage *) screenshotsKeyWindowWithStatusBar:(BOOL)withStatusBar
{
    // Create a graphics context with the target size
    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Iterate over every window from back to front
    for (UIWindow * window in [[UIApplication sharedApplication] windows])
    {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
        {
            // -renderInContext: renders in the coordinate space of the layer,
            // so we must first apply the layer's geometry to the graphics context
            CGContextSaveGState(context);
            // Center the context around the window's anchor point
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            // Apply the window's transform about the anchor point
            CGContextConcatCTM(context, [window transform]);
            // Offset by the portion of the bounds left of and above the anchor point
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            // Render the layer hierarchy to the current context
            [[window layer] renderInContext:context];
            
            // Restore the context
            CGContextRestoreGState(context);
            
            if (!withStatusBar)
                CGContextClearRect(context, CGRectMake(0, 0, [window bounds].size.width, 20));
            
            break;
        }
    }
    
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;

}


@end
