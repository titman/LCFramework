//
//  LC_Runtime.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//


#import "LC_Precompile.h"

#pragma mark -

#undef	PRINT_CALLSTACK
#define PRINT_CALLSTACK( __n )	[LC_Runtime printCallstack:__n]

#undef	BREAK_POINT
#define BREAK_POINT()			[LC_Runtime breakPoint];

#undef	BREAK_POINT_IF
#define BREAK_POINT_IF( __x )	if ( __x ) { [LC_Runtime breakPoint]; }

#pragma mark -

typedef enum _LCCallFrameType {
    
    LCCallFrame_Unknown    = 0,
    LCCallFrame_OBJC       = 1,
	LCCallFrame_NativeC    = 2,
    
} LCCallFrameType;

@interface LCCallFrame : NSObject

@property (nonatomic, assign) NSUInteger	type;
@property (nonatomic, retain) NSString *	process;
@property (nonatomic, assign) NSUInteger	entry;
@property (nonatomic, assign) NSUInteger	offset;
@property (nonatomic, retain) NSString *	clazz;
@property (nonatomic, retain) NSString *	method;

+ (id)parse:(NSString *)line;
+ (id)unknown;

@end

#pragma mark -

typedef enum _LCTypeEncoding {
    
    LCTypeEncoding_Unknown      = 0,
    LCTypeEncoding_Object       = 1,
	LCTypeEncoding_NSNumber     = 2,
    LCTypeEncoding_NSString     = 3,
    LCTypeEncoding_NSArray      = 4,
    LCTypeEncoding_NSDictionary = 5,
    LCTypeEncoding_NSDate       = 6,
    
} LCTypeEncoding;

@interface LC_TypeEncoding : NSObject

+ (NSUInteger)typeOf:(const char *)attr;
+ (NSUInteger)typeOfAttribute:(const char *)attr;
+ (NSUInteger)typeOfObject:(id)obj;

+ (NSString *)classNameOf:(const char *)attr;
+ (NSString *)classNameOfAttribute:(const char *)attr;

+ (Class)classOfAttribute:(const char *)attr;

+ (BOOL)isAtomClass:(Class)clazz;

@end

#pragma mark -

@interface LC_Runtime : NSObject

+ (id)allocByClass:(Class)clazz;
+ (id)allocByClassName:(NSString *)clazzName;

+ (NSArray *)allClasses;
+ (NSArray *)allSubClassesOf:(Class)clazz;

+ (NSArray *)callstack:(NSUInteger)depth;
+ (NSArray *)callframes:(NSUInteger)depth;

+ (void)printCallstack:(NSUInteger)depth;

@end
