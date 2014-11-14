//
//  NSObject+LCSwizzle.h
//  WuxianchangPro
//
//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-12-18.
//  Copyright (c) 2013年 Wuxiantai Developer ( http://www.wuxiantai.com ). All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -

@interface UIView (LCSwizzle)

@end

#pragma mark -

@interface NSArray (LCSwizzle)

@end

#pragma mark -

@interface NSDictionary (LCSwizzle)

@end

#pragma mark -

@interface NSMutableDictionary (LCSwizzle)

@end

#pragma mark -

@interface NSObject (LCSwizzle)

+ (BOOL) swizzleAll;

@end

#pragma mark -

