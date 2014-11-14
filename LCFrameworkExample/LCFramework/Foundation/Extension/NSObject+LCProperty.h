//
//  NSObject+LCProperty.h
//  NextApp
//
//  Created by Licheng Guo . http://nsobject.me/  on 14-7-3.
//  Copyright (c) 2014年 http://nextapp.com.cn/. All rights reserved.
//

#pragma mark -

#define LC_ST_PROPERTY( __name ) \
    - (NSString *)__name; \
    + (NSString *)__name;

#define LC_IMP_PROPERTY( __name ) \
    - (NSString *)__name \
    { \
        return (NSString *)[[self class] __name]; \
    } \
    + (NSString *)__name \
    { \
        return [NSString stringWithFormat:@"%s", #__name]; \
    }

#pragma mark -

#define LC_ST_PROPERTY_INT( __name ) \
    - (NSInteger)__name; \
    + (NSInteger)__name;

#define LC_IMP_PROPERTY_INT( __name, __int ) \
    - (NSInteger)__name \
    { \
        return (NSInteger)[[self class] __name]; \
    } \
    + (NSInteger)__name \
    { \
        return __int; \
    }

#pragma mark -

#define LC_ST_PROPERTY_STRING( __name ) \
    - (NSNumber *)__name; \
    + (NSNumber *)__name;

#define LC_IMP_PROPERTY_STRING( __name, __value ) \
    - (NSNumber *)__name \
    { \
        return [[self class] __name]; \
    } \
    + (NSNumber *)__name \
    { \
        return __value; \
    }


@interface NSObject (LCProperty)

@end
