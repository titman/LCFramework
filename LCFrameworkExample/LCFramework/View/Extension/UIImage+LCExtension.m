//
//  UIImage+extension.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "UIImage+LCExtension.h"
#import <CoreGraphics/CoreGraphics.h>
#import <Accelerate/Accelerate.h>

@implementation UIImage (LCExtension)

-(UIImage *) imageFromRect:(CGRect)newRect
{
    CGImageRef imageRef = self.CGImage;
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, newRect);
    
    CGSize size;
    
    size.width = newRect.size.width;
    
    size.height = newRect.size.height;
    
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, newRect, subImageRef);
    
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    
    UIGraphicsEndImageContext();  
    
    
    return smallImage;
}

+(UIImage *)imageNamed:(NSString *)name useCache:(BOOL)useCache
{
    if (YES == useCache) {
        
        if (LC_USE_SYSTEM_IMAGE_CACHE) {
            
            return [UIImage imageNamed:name];
            
        }else{
            
            UIImage * image = [[LC_ImageCache LCInstance].memoryCache objectForKey:LC_NSSTRING_FORMAT(@"Application-%@",name)];
            
            if (image) {
                
                return image;
                
            }else{
                
                image = [self imageNamed:name useCache:NO];
                
                if (image) {
                    [[[LC_ImageCache LCInstance] memoryCache] setObject:image forKey:LC_NSSTRING_FORMAT(@"Application-%@",name)];
                }
                
                return image;
            }
        }
        
    }else{
    
        if (![name hasSuffix:@".png"] && ![name hasSuffix:@".jpg"]) {
            
            name = [name stringByAppendingString:@".png"];
        }
        
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
        
        if (!path) {
            
            NSArray *tmp = [name componentsSeparatedByString:@"."];
            
            if (tmp.count > 0) {
                NSMutableString *string = [[NSMutableString alloc] initWithString:[tmp objectAtIndex:0]];
                [string appendString:@"@2x"];
                
                if (tmp.count == 1) {
                    
                }
                else if (tmp.count == 2) {
                    
                    [string appendFormat:@".%@", [tmp objectAtIndex:1]];
                    
                } else {
                
                }
                
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
	CGContextRef context = CGBitmapContextCreate(nil, size.width, size.height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
	CGColorSpaceRelease(colorSpace);
	
	CGContextDrawImage(context, rect, [self CGImage]);
	CGImageRef grayscale = CGBitmapContextCreateImage(context);
	CGContextRelease(context);
	
	UIImage * image = [UIImage imageWithCGImage:grayscale];
	CFRelease(grayscale);
	
	return image;
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    
    UIImage * tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
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
    
    [gaussianBlur setValue:[NSNumber numberWithFloat:value] forKey:@"inputRadius"];
    [gaussianBlur setValue:clampResult forKey:kCIInputImageKey];

    CIImage * gaussianBlurResult = [gaussianBlur valueForKey:kCIOutputImageKey];
    
    CGImageRef cgImage = [context createCGImage:gaussianBlurResult fromRect:[sourceImage extent]];
    
    UIImage * blurredImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);

    return blurredImage;
}

- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur
{
    
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       &outBuffer,
                                       NULL,
                                       0,
                                       0,
                                       boxSize,
                                       boxSize,
                                       NULL,
                                       kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
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

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,
                                   
                                   color.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    return img;
}

-(UIImage *) scaleToWidth:(float)width height:(float)height
{
    return [[self scaleToWidth:width] scaleToHeight:height];
}

-(UIImage *) scaleToWidth:(float)width
{
    // 110  100
    float selfWidth = self.size.width;
    float selfHeight = self.size.height;
    
    if (selfWidth > width) {
        
        selfHeight = width/selfWidth * selfHeight;
        selfWidth = width;

        
        UIGraphicsBeginImageContext(CGSizeMake(selfWidth, selfHeight));
        [self drawInRect:CGRectMake(0, 0, selfWidth, selfHeight)];
        UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return scaledImage;
    }
    else{
        
        return self;
    }

}

-(UIImage *) scaleToHeight:(float)height
{
    // 110  100
    float selfWidth = self.size.width;
    float selfHeight = self.size.height;
    
    if (selfHeight > height) {
        
        selfWidth = height/selfHeight * selfWidth;
        selfHeight = height;

        UIGraphicsBeginImageContext(CGSizeMake(selfWidth, selfHeight));
        [self drawInRect:CGRectMake(0, 0, selfWidth, selfHeight)];
        UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return scaledImage;
    }
    else{
        
        return self;
    }

}

- (UIImage *)rotateImageLength:(float)length imageOrientation:(UIImageOrientation)orient {
	
    CGImageRef imgRef = [self scaleToWidth:length].CGImage;
 	UIImageOrientation newOrient = orient;
	CGFloat width = CGImageGetWidth(imgRef);
	CGFloat height = CGImageGetHeight(imgRef);
    
	CGAffineTransform transform = CGAffineTransformIdentity;
	CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = 1;
	CGFloat boundHeight;
	switch(newOrient) {
		case UIImageOrientationUp:
			transform = CGAffineTransformIdentity;
			break;
		case UIImageOrientationDown:
			transform = CGAffineTransformMakeTranslation(width, height);
			transform = CGAffineTransformRotate(transform, M_PI);
			break;
		case UIImageOrientationLeft:
			
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(0.0, width);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
		case UIImageOrientationRight:
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(height, 0.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;
		default:
			[NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
	}
    
    
	UIGraphicsBeginImageContext(bounds.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
    
	if (newOrient == UIImageOrientationRight || newOrient == UIImageOrientationLeft) {
		CGContextScaleCTM(context, -scaleRatio, scaleRatio);
		CGContextTranslateCTM(context, -height, 0);
	} else {
		CGContextScaleCTM(context, scaleRatio, -scaleRatio);
		CGContextTranslateCTM(context, 0, -height);
	}
	CGContextConcatCTM(context, transform);
    
	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
	UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	return imageCopy;
}


@end
