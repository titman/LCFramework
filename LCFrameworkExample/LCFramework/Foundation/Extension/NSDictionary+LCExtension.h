//
//  NSDictionary+LCExtension.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_Precompile.h"

#pragma mark -

typedef NSDictionary *	(^NSDictionaryAppendBlock)( NSString * key, id value );
typedef id (^NSDictionaryObjectForKeyBlock)( NSString * key );

typedef NSMutableDictionary *	(^NSMutableDictionaryAppendBlock)( NSString * key, id value );
typedef id (^NSMutableDictionaryObjectForKeyBlock)( NSString * key );


#pragma mark -

#undef	CONVERT_PROPERTY_CLASS
#define	CONVERT_PROPERTY_CLASS( __name, __class ) \
		+ (Class)convertPropertyClassFor_##__name \
		{ \
			return NSClassFromString( [NSString stringWithUTF8String:#__class] ); \
		}

#pragma mark -

@interface NSDictionary(LCExtension)

@property (nonatomic, readonly) NSDictionaryAppendBlock	APPEND;
@property (nonatomic, readonly) NSDictionaryObjectForKeyBlock EXTRACT;

- (id)allKeysSelectKeyAtIndex:(NSInteger)index;

- (id)objectOfAny:(NSArray *)array;
- (NSString *)stringOfAny:(NSArray *)array;

- (id)objectAtPath:(NSString *)path;
- (id)objectAtPath:(NSString *)path otherwise:(NSObject *)other;

- (id)objectAtPath:(NSString *)path separator:(NSString *)separator;
- (id)objectAtPath:(NSString *)path otherwise:(NSObject *)other separator:(NSString *)separator;

- (id)objectAtPath:(NSString *)path withClass:(Class)clazz;
- (id)objectAtPath:(NSString *)path withClass:(Class)clazz otherwise:(NSObject *)other;

- (BOOL)boolAtPath:(NSString *)path;
- (BOOL)boolAtPath:(NSString *)path otherwise:(BOOL)other;

- (NSNumber *)numberAtPath:(NSString *)path;
- (NSNumber *)numberAtPath:(NSString *)path otherwise:(NSNumber *)other;

- (NSString *)stringAtPath:(NSString *)path;
- (NSString *)stringAtPath:(NSString *)path otherwise:(NSString *)other;

- (NSArray *)arrayAtPath:(NSString *)path;
- (NSArray *)arrayAtPath:(NSString *)path otherwise:(NSArray *)other;

- (NSArray *)arrayAtPath:(NSString *)path withClass:(Class)clazz;
- (NSArray *)arrayAtPath:(NSString *)path withClass:(Class)clazz otherwise:(NSArray *)other;

- (NSMutableArray *)mutableArrayAtPath:(NSString *)path;
- (NSMutableArray *)mutableArrayAtPath:(NSString *)path otherwise:(NSMutableArray *)other;

- (NSDictionary *)dictAtPath:(NSString *)path;
- (NSDictionary *)dictAtPath:(NSString *)path otherwise:(NSDictionary *)other;

- (NSMutableDictionary *)mutableDictAtPath:(NSString *)path;
- (NSMutableDictionary *)mutableDictAtPath:(NSString *)path otherwise:(NSMutableDictionary *)other;

- (id)objectForClass:(Class)clazz;

- (NSInteger) length;

@end

#pragma mark -

@interface NSMutableDictionary(LCExtension)

@property (nonatomic, readonly) NSMutableDictionaryAppendBlock	APPEND;
@property (nonatomic, readonly) NSMutableDictionaryObjectForKeyBlock EXTRACT;

+ (NSMutableDictionary *)nonRetainingDictionary;			// copy from Three20

- (BOOL)setObject:(NSObject *)obj atPath:(NSString *)path;
- (BOOL)setObject:(NSObject *)obj atPath:(NSString *)path separator:(NSString *)separator;

- (BOOL)setKeyValues:(id)first, ...;

+ (NSMutableDictionary *)keyValues:(id)first, ...;

@end
