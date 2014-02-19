//
//  NSObject+LCSwizzle.h
//  WuxianchangPro
//
//  Created by 郭历成 ( titm@tom.com ) on 13-12-18.
//  Copyright (c) 2013年 Wuxiantai Developer ( http://www.wuxiantai.com ). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (LCSwizzle)

- (id) swizzleObjectAtIndex:(int)index;

@end

@interface NSObject (LCSwizzle)

+ (BOOL) swizzleAll;

@end
