//
//  NSArray+LCTypeConversion.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "NSObject+LCTypeConversion.h"
#import "NSObject+LCJSON.h"
#import "NSArray+LCExtension.h"

#pragma mark -

@implementation NSObject(LCTypeConversion)

- (NSNumber *)asNSNumber
{
	if ( [self isKindOfClass:[NSNumber class]] )
	{
		return (NSNumber *)self;
	}
	else if ( [self isKindOfClass:[NSString class]] )
	{
		return [NSNumber numberWithInteger:[(NSString *)self integerValue]];
	}
	else if ( [self isKindOfClass:[NSDate class]] )
	{
		return [NSNumber numberWithDouble:[(NSDate *)self timeIntervalSince1970]];
	}
	else if ( [self isKindOfClass:[NSNull class]] )
	{
		return [NSNumber numberWithInteger:0];
        
	}else{
        
        ERROR(@"%@ is not a NSNumber",[self class]);

        return [NSNumber numberWithInteger:0];
    }

}

- (NSString *)asNSString
{
	if ( [self isKindOfClass:[NSNull class]] )
        
		return @"";

	if ( [self isKindOfClass:[NSString class]] )
	{
		return (NSString *)self;
	}
	else if ( [self isKindOfClass:[NSData class]] )
	{
		NSData * data = (NSData *)self;
		return [[[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding] autorelease];
	}
	else
	{
        ERROR(@"%@ is not a NSString",[self class]);

		return [NSString stringWithFormat:@"%@", self];
	}
}

- (NSDate *)asNSDate
{
	if ( [self isKindOfClass:[NSDate class]] )
	{
		return (NSDate *)self;
	}
	else if ( [self isKindOfClass:[NSString class]] )
	{
		NSDate * date = nil;
				
		if ( nil == date )
		{
			NSString * format = @"yyyy-MM-dd HH:mm:ss z";
			NSDateFormatter * formatter = [[[NSDateFormatter alloc] init] autorelease];
			[formatter setDateFormat:format];
			[formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

			date = [formatter dateFromString:(NSString *)self];
		}

		if ( nil == date )
		{
			NSString * format = @"yyyy/MM/dd HH:mm:ss z";
			NSDateFormatter * formatter = [[[NSDateFormatter alloc] init] autorelease];
			[formatter setDateFormat:format];
			[formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
			
			date = [formatter dateFromString:(NSString *)self];
		}
        
		if ( nil == date )
		{
			NSString * format = @"yyyy-MM-dd HH:mm:ss";
			NSDateFormatter * formatter = [[[NSDateFormatter alloc] init] autorelease];
			[formatter setDateFormat:format];
			[formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
			
			date = [formatter dateFromString:(NSString *)self];
		}

		if ( nil == date )
		{
			NSString * format = @"yyyy/MM/dd HH:mm:ss";
			NSDateFormatter * formatter = [[[NSDateFormatter alloc] init] autorelease];
			[formatter setDateFormat:format];
			[formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
			
			date = [formatter dateFromString:(NSString *)self];
		}

		return date;

//		NSTimeZone * local = [NSTimeZone localTimeZone];
//		return [NSDate dateWithTimeInterval:(3600 + [local secondsFromGMT])
//								  sinceDate:[dateFormatter dateFromString:text]];
	}
	else
	{
        ERROR(@"%@ is not a NSDate",[self class]);

		return [NSDate dateWithTimeIntervalSince1970:[self asNSNumber].doubleValue];
	}
	
	return nil;	
}

- (NSData *)asNSData
{
	return (NSData *)self;
}

- (NSArray *)asNSArray
{
	if ( [self isKindOfClass:[NSArray class]] )
	{
		return (NSArray *)self;
	}
	else
	{
        ERROR(@"%@ is not a NSArray",[self class]);

		return [NSArray array];
	}
}

- (NSArray *)asNSArrayWithClass:(Class)clazz
{
	if ( [self isKindOfClass:[NSArray class]] )
	{
		NSMutableArray * results = [NSMutableArray array];

		for ( NSObject * elem in (NSArray *)self )
		{
			if ( [elem isKindOfClass:[NSDictionary class]] )
			{
				NSObject * obj = [[self class] objectFromDictionary:elem];
				[results addObject:obj];
			}
		}
		
		return results;
	}

	return nil;
}

- (NSMutableArray *)asNSMutableArray
{
	if ( [self isKindOfClass:[NSMutableArray class]] )
	{
		return (NSMutableArray *)self;
	}
	
	return [NSMutableArray array];
}

- (NSMutableArray *)asNSMutableArrayWithClass:(Class)clazz
{
	NSArray * array = [self asNSArrayWithClass:clazz];
	if ( nil == array )
		return nil;

	return [NSMutableArray arrayWithArray:array];
}

- (NSDictionary *)asNSDictionary
{
	if ( [self isKindOfClass:[NSDictionary class]] )
	{
		return (NSDictionary *)self;
	}

	return [NSDictionary dictionary];
}

- (NSMutableDictionary *)asNSMutableDictionary
{
	if ( [self isKindOfClass:[NSMutableDictionary class]] )
	{
		return (NSMutableDictionary *)self;
	}
	
	NSDictionary * dict = [self asNSDictionary];
	if ( nil == dict )
		return nil;

	return [NSMutableDictionary dictionaryWithDictionary:dict];
}

@end
