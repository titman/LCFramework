//
//  LC_Tools.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-20.
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

/** AppDelegate */
#define LC_APPDELEGATE ([UIApplication sharedApplication].delegate)
/** It will call self = [super init] and return self */
#define LC_SUPER_INIT(x) if(self = [super init]){x} else{} return self;
/** KeyWindow */
#define LC_KEYWINDOW ((UIView*)[UIApplication sharedApplication].keyWindow)
//** Device width */
#define LC_DEVICE_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
/** Device height */
#define LC_DEVICE_HEIGHT (([[UIScreen mainScreen] bounds].size.height)-20)



/** CGRectMake */
#define LC_RECT_CREATE(x,y,w,h) CGRectMake(x,y,w,h)
/** CGSizeMake */
#define LC_SIZE_CREATE(w,h)     CGSizeMake(w,h)
/** CGPointMake */
#define LC_POINT_CREATE(x,y)    CGPointMake(x,y)
/** String with format */
#define LC_NSSTRING_FORMAT(s,...) [NSString stringWithFormat:s,##__VA_ARGS__]
/** String is invalid */
#define LC_NSSTRING_IS_INVALID(s) (s.length <= 0 || [identifier isEqualToString:@"(null)"] || [identifier isKindOfClass:[NSNull class]])

/** UIColor with rgb */
#define LC_COLOR_W_RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]



/** Fast animations */
#define LC_FAST_ANIMATIONS(duration,animationsBlock) [UIView animateWithDuration:duration animations:animationsBlock]

typedef void (^LCAnimationsFinishedBlock)(BOOL isFinished);

/** Fast animations */
#define LC_FAST_ANIMATIONS_F(duration,animationsBlock,LCAnimationsFinishedBlock)                             \
                                                     [UIView animateWithDuration:duration                    \
                                                                      animations:animationsBlock             \
                                                                      completion:LCAnimationsFinishedBlock]

/** Fast animations */
#define LC_FAST_ANIMATIONS_O_F(duration,UIViewAnimationOptions,animationsBlock,LCAnimationsFinishedBlock)    \
                                                     [UIView animateWithDuration:duration                    \
                                                                           delay:0                           \
                                                                         options:UIViewAnimationOptions      \
                                                                      animations:animationsBlock             \
                                                                      completion:LCAnimationsFinishedBlock]



/** Remove from superview */
#define LC_REMOVE_FROM_SUPERVIEW(v,setToNull) [v removeFromSuperview];    \
                                              if(setToNull == YES){       \
                                                    v = NULL;              \
                                              }



/** GCD asynchronous (异步) */
#define LC_GCD_ASYNCHRONOUS(priority,block) dispatch_async(dispatch_get_global_queue(priority, 0), block)
/** GCD synchronous (同步) */
#define LC_GCD_SYNCHRONOUS(block) dispatch_async(dispatch_get_main_queue(),block)



#ifdef __IPHONE_6_0

    #define UILineBreakModeWordWrap			NSLineBreakByWordWrapping
    #define UILineBreakModeCharacterWrap	NSLineBreakByCharWrapping
    #define UILineBreakModeClip				NSLineBreakByClipping
    #define UILineBreakModeHeadTruncation	NSLineBreakByTruncatingHead
    #define UILineBreakModeTailTruncation	NSLineBreakByTruncatingTail
    #define UILineBreakModeMiddleTruncation	NSLineBreakByTruncatingMiddle

    #define UITextAlignmentLeft				NSTextAlignmentLeft
    #define UITextAlignmentCenter			NSTextAlignmentCenter
    #define UITextAlignmentRight			NSTextAlignmentRight

#endif



#if __has_feature(objc_arc)

    #define LC_PROP_RETAIN strong
    #define LC_RETAIN(x) (x)
    #define LC_RELEASE(x)
    #define LC_AUTORELEASE(x) (x)
    #define LC_BLOCK_COPY(x) (x)
    #define LC_BLOCK_RELEASE(x)
    #define LC_SUPER_DEALLOC()
    #define LC_AUTORELEASE_POOL_START() @autoreleasepool {
    #define LC_AUTORELEASE_POOL_END() }

#else

    #define LC_PROP_RETAIN retain
    #define LC_RETAIN(x) ([(x) retain])
    #define LC_RELEASE(x) ([(x) release])
    #define LC_RELEASE_ABSOLUTE(x) if(x){[x release]; x = nil;}

    #define LC_AUTORELEASE(x) ([(x) autorelease])
    #define LC_SUPER_DEALLOC() ([super dealloc])
    #define LC_AUTORELEASE_POOL_START() NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    #define LC_AUTORELEASE_POOL_END() [pool release];

#endif


