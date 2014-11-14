//
//  NSObject+LCJSON
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//
 
#import "NSObject+LCJSON.h"
#import "LC_Runtime.h"
#import "NSObject+LCTypeConversion.h"
#import "NSDictionary+LCExtension.h"

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark -

@implementation NSObject(JSON)

+ (id)objectsFromArray:(id)arr
{
	if ( nil == arr )
		return nil;
	
	if ( NO == [arr isKindOfClass:[NSArray class]] )
		return nil;

	NSMutableArray * results = [NSMutableArray array];

	for ( NSObject * obj in (NSArray *)arr )
	{
		if ( [obj isKindOfClass:[NSDictionary class]] )
		{
			obj = [self objectFromDictionary:obj];
			if ( obj )
			{
				[results addObject:obj];
			}
		}
		else
		{
			[results addObject:obj];
		}
	}

	return results;
}

+ (id)objectFromDictionary:(id)dict
{
	if ( nil == dict )
	{
		return nil;
	}
		
	if ( NO == [dict isKindOfClass:[NSDictionary class]] )
	{
		return nil;
	}
	
	return [(NSDictionary *)dict objectForClass:[self class]];
}

+ (id)objectFromString:(id)str
{
	if ( nil == str )
	{
		return nil;
	}
	
	if ( NO == [str isKindOfClass:[NSString class]] )
	{
		return nil;
	}
	
	NSObject * obj = [(NSString *)str objectFromJSONString];
	if ( nil == obj )
	{
		return nil;
	}
	
	if ( [obj isKindOfClass:[NSDictionary class]] )
	{
		return [(NSDictionary *)obj objectForClass:[self class]];
	}
	else if ( [obj isKindOfClass:[NSArray class]] )
	{
		NSMutableArray * array = [NSMutableArray array];
		
		for ( NSObject * elem in (NSArray *)obj )
		{
			if ( [elem isKindOfClass:[NSDictionary class]] )
			{
				NSObject * result = [(NSDictionary *)elem objectForClass:[self class]];
				if ( result )
				{
					[array addObject:result];
				}
			}
		}
		
		return array;
	}
	else if ( [LC_TypeEncoding isAtomClass:[obj class]] )
	{
		return obj;
	}
	
	return nil;
}

+ (id)objectFromData:(id)data
{
	if ( nil == data )
	{
		return nil;
	}
	
	if ( NO == [data isKindOfClass:[NSData class]] )
	{
		return nil;
	}

	NSObject * obj = [(NSData *)data objectFromJSONData];
	if ( obj && [obj isKindOfClass:[NSDictionary class]] )
	{
		return [(NSDictionary *)obj objectForClass:[self class]];
	}
	
	return nil;
}

+ (id)objectFromAny:(id)any
{
	if ( [any isKindOfClass:[NSArray class]] )
	{
		return [self objectsFromArray:any];
	}
	else if ( [any isKindOfClass:[NSDictionary class]] )
	{
		return [self objectFromDictionary:any];
	}
	else if ( [any isKindOfClass:[NSString class]] )
	{
		return [self objectFromString:any];
	}
	else if ( [any isKindOfClass:[NSData class]] )
	{
		return [self objectFromData:any];
	}
	
	return any;
}

- (id)objectToDictionary
{
	return [self objectToDictionaryUntilRootClass:nil];
}

- (id)objectToDictionaryUntilRootClass:(Class)rootClass
{
	NSMutableDictionary * result = [NSMutableDictionary dictionary];
	
	if ( [self isKindOfClass:[NSDictionary class]] )
	{
		NSDictionary * dict = (NSDictionary *)self;

		for ( NSString * key in dict.allKeys )
		{
			NSObject * obj = [dict objectForKey:key];
			if ( obj )
			{
				NSUInteger propertyType = [LC_TypeEncoding typeOfObject:obj];
                
				if ( LCTypeEncoding_NSNumber == propertyType )
				{
					[result setObject:obj forKey:key];
				}
				else if ( LCTypeEncoding_NSString == propertyType )
				{
					[result setObject:obj forKey:key];
				}
				else if ( LCTypeEncoding_NSArray == propertyType )
				{
					NSMutableArray * array = [NSMutableArray array];
					
					for ( NSObject * elem in (NSArray *)obj )
					{
						NSDictionary * dict = [elem objectToDictionaryUntilRootClass:rootClass];
                        
						if ( dict )
						{
							[array addObject:dict];
						}
						else
						{
							if ( [LC_TypeEncoding isAtomClass:[elem class]] )
							{
								[array addObject:elem];
							}
						}
					}
					
					[result setObject:array forKey:key];
				}
				else if ( LCTypeEncoding_NSDictionary == propertyType )
				{
					NSMutableDictionary * dict = [NSMutableDictionary dictionary];
					
					for ( NSString * key in ((NSDictionary *)obj).allKeys )
					{
						NSObject * val = [(NSDictionary *)obj objectForKey:key];
						if ( val )
						{
							NSDictionary * subresult = [val objectToDictionaryUntilRootClass:rootClass];
							if ( subresult )
							{
								[dict setObject:subresult forKey:key];
							}
							else
							{
								if ( [LC_TypeEncoding isAtomClass:[val class]] )
								{
									[dict setObject:val forKey:key];
								}
							}
						}
					}
					
					[result setObject:dict forKey:key];
				}
				else if ( LCTypeEncoding_NSDate == propertyType )
				{
					[result setObject:[obj description] forKey:key];
				}
				else
				{
					obj = [obj objectToDictionaryUntilRootClass:rootClass];
					if ( obj )
					{
						[result setObject:obj forKey:key];
					}
					else
					{
						[result setObject:[NSDictionary dictionary] forKey:key];
					}
				}
			}
//			else
//			{
//				[result setObject:[NSNull null] forKey:key];
//			}
		}
	}
	else
	{
		for ( Class clazzType = [self class];; )
		{
			if ( rootClass )
			{
				if ( clazzType == rootClass )
					break;
			}
			else
			{
				if ( [LC_TypeEncoding isAtomClass:clazzType] )
					break;
			}

			unsigned int		propertyCount = 0;
			objc_property_t *	properties = class_copyPropertyList( clazzType, &propertyCount );
			
			for ( NSUInteger i = 0; i < propertyCount; i++ )
			{
				const char *	name = property_getName(properties[i]);
				const char *	attr = property_getAttributes(properties[i]);
				
				NSString *		propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
				NSUInteger		propertyType = [LC_TypeEncoding typeOf:attr];
				
				NSObject * obj = [self valueForKey:propertyName];
				if ( obj )
				{
					if ( LCTypeEncoding_NSNumber == propertyType )
					{
						[result setObject:obj forKey:propertyName];
					}
					else if ( LCTypeEncoding_NSString == propertyType )
					{
						[result setObject:obj forKey:propertyName];
					}
					else if ( LCTypeEncoding_NSArray == propertyType )
					{
						NSMutableArray * array = [NSMutableArray array];
						
						for ( NSObject * elem in (NSArray *)obj )
						{
							NSUInteger elemType = [LC_TypeEncoding typeOfObject:elem];
							
							if ( LCTypeEncoding_NSNumber == elemType )
							{
								[array addObject:elem];
							}
							else if ( LCTypeEncoding_NSString == elemType )
							{
								[array addObject:elem];
							}
							else
							{
								NSDictionary * dict = [elem objectToDictionaryUntilRootClass:rootClass];
								if ( dict )
								{
									[array addObject:dict];
								}
								else
								{
									if ( [LC_TypeEncoding isAtomClass:[elem class]] )
									{
										[array addObject:elem];
									}
								}
							}
						}
						
						[result setObject:array forKey:propertyName];
					}
					else if ( LCTypeEncoding_NSDictionary == propertyType )
					{
						NSMutableDictionary * dict = [NSMutableDictionary dictionary];
						
						for ( NSString * key in ((NSDictionary *)obj).allKeys )
						{
							NSObject * val = [(NSDictionary *)obj objectForKey:key];
							if ( val )
							{
								NSDictionary * subresult = [val objectToDictionaryUntilRootClass:rootClass];
								if ( subresult )
								{
									[dict setObject:subresult forKey:key];
								}
								else
								{
									if ( [LC_TypeEncoding isAtomClass:[val class]] )
									{
										[dict setObject:val forKey:key];
									}
								}
							}
						}
						
						[result setObject:dict forKey:propertyName];
					}
					else if ( LCTypeEncoding_NSDate == propertyType )
					{
						[result setObject:[obj description] forKey:propertyName];
					}
					else
					{
						obj = [obj objectToDictionaryUntilRootClass:rootClass];
						if ( obj )
						{
							[result setObject:obj forKey:propertyName];
						}
						else
						{
							[result setObject:[NSDictionary dictionary] forKey:propertyName];
						}
					}
				}
//				else
//				{
//					[result setObject:[NSNull null] forKey:propertyName];
//				}
			}
			
			free( properties );

			clazzType = class_getSuperclass( clazzType );
			if ( nil == clazzType )
				break;
		}
	}
	
	return result.count ? result : nil;
}

- (id)objectZerolize
{
	return [self objectZerolizeUntilRootClass:nil];
}

- (id)objectZerolizeUntilRootClass:(Class)rootClass
{
	for ( Class clazzType = [self class];; )
	{
		if ( rootClass )
		{
			if ( clazzType == rootClass )
				break;
		}
		else
		{
			if ( [LC_TypeEncoding isAtomClass:clazzType] )
				break;
		}

		unsigned int		propertyCount = 0;
		objc_property_t *	properties = class_copyPropertyList( clazzType, &propertyCount );
		
		for ( NSUInteger i = 0; i < propertyCount; i++ )
		{
			const char *	name = property_getName(properties[i]);
			const char *	attr = property_getAttributes(properties[i]);
			
			NSString *		propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
			NSUInteger		propertyType = [LC_TypeEncoding typeOfAttribute:attr];
			
			if ( LCTypeEncoding_NSNumber == propertyType )
			{
				[self setValue:[NSNumber numberWithInt:0] forKey:propertyName];
			}
			else if ( LCTypeEncoding_NSString == propertyType )
			{
				[self setValue:@"" forKey:propertyName];
			}
			else if ( LCTypeEncoding_NSArray == propertyType )
			{
				[self setValue:[NSMutableArray array] forKey:propertyName];
			}
			else if ( LCTypeEncoding_NSDictionary == propertyType )
			{
				[self setValue:[NSMutableDictionary dictionary] forKey:propertyName];
			}
			else if ( LCTypeEncoding_NSDate == propertyType )
			{
				[self setValue:[NSDate dateWithTimeIntervalSince1970:0] forKey:propertyName];
			}
			else if ( LCTypeEncoding_Object == propertyType )
			{
				Class clazz = [LC_TypeEncoding classOfAttribute:attr];
				if ( clazz )
				{
					NSObject * newObj = [[[clazz alloc] init] autorelease];
					[self setValue:newObj forKey:propertyName];
				}
				else
				{
					[self setValue:nil forKey:propertyName];
				}
			}
			else
			{
				[self setValue:nil forKey:propertyName];
			}
		}
		
		free( properties );
		
		clazzType = class_getSuperclass( clazzType );
		if ( nil == clazzType )
			break;
	}
	
	return self;
}

- (id)objectToString
{
	return [self objectToStringUntilRootClass:nil];
}

- (id)objectToStringUntilRootClass:(Class)rootClass
{
	NSString *	json = nil;
	NSUInteger	propertyType = [LC_TypeEncoding typeOfObject:self];
	
	if ( LCTypeEncoding_NSNumber == propertyType )
	{
		json = [self asNSString];
	}
	else if ( LCTypeEncoding_NSString == propertyType )
	{
		json = [self asNSString];
	}
	else if ( LCTypeEncoding_NSArray == propertyType )
	{
		NSMutableArray * array = [NSMutableArray array];

		for ( NSObject * elem in (NSArray *)self )
		{
			NSDictionary * dict = [elem objectToDictionaryUntilRootClass:rootClass];
			if ( dict )
			{
				[array addObject:dict];
			}
			else
			{
				if ( [LC_TypeEncoding isAtomClass:[elem class]] )
				{
					[array addObject:elem];
				}
			}
		}

		json = [array JSONString];
	}
	else if ( LCTypeEncoding_NSDictionary == propertyType )
	{
		NSDictionary * dict = [self objectToDictionaryUntilRootClass:rootClass];
		if ( dict )
		{
			json = [dict JSONString];
		}
	}
	else if ( LCTypeEncoding_NSDate == propertyType )
	{
		json = [self description];
	}
	else
	{
		NSDictionary * dict = [self objectToDictionaryUntilRootClass:rootClass];
		if ( dict )
		{
			json = [dict JSONString];
		}
	}

	if ( nil == json || 0 == json.length )
		return nil;
	
	return [NSMutableString stringWithString:json];
}

- (id)objectToData
{
	return [self objectToDataUntilRootClass:nil];
}

- (id)objectToDataUntilRootClass:(Class)rootClass
{
	NSString * string = [self objectToStringUntilRootClass:rootClass];
	if ( nil == string )
		return nil;

	return [string dataUsingEncoding:NSUTF8StringEncoding];
}

- (id)serializeObject
{
	NSUInteger type = [LC_TypeEncoding typeOfObject:self];
	
	if ( LCTypeEncoding_NSNumber == type )
	{
		return self;
	}
	else if ( LCTypeEncoding_NSString == type )
	{
		return self;
	}
	else if ( LCTypeEncoding_NSDate == type )
	{
		return self;
	}
	else if ( LCTypeEncoding_NSArray == type )
	{
		NSArray *			array = (NSArray *)self;
		NSMutableArray *	result = [NSMutableArray array];
		
		for ( NSObject * elem in array )
		{
			NSObject * val = [elem serializeObject];
			if ( val )
			{
				[result addObject:val];
			}
		}
		
		return result;
	}
	else if ( LCTypeEncoding_NSDictionary == type )
	{
		NSDictionary *			dict = (NSDictionary *)self;
		NSMutableDictionary *	result = [NSMutableDictionary dictionary];
		
		for ( NSString * key in dict.allKeys )
		{
			NSObject * val = [dict objectForKey:key];
			NSObject * val2 = [val serializeObject];

			if ( val2 )
			{
				[result setObject:val2 forKey:key];
			}
		}

		return result;
	}
	else if ( LCTypeEncoding_Object == type )
	{
		return [self objectToDictionary];
	}

	return nil;
}

+ (id)unserializeObject:(id)obj
{
	NSUInteger type = [LC_TypeEncoding typeOfObject:obj];
	
	if ( LCTypeEncoding_NSNumber == type )
	{
		return self;
	}
	else if ( LCTypeEncoding_NSString == type )
	{
		return [self objectFromString:obj];
	}
	else if ( LCTypeEncoding_NSDate == type )
	{
		return self;
	}
	else if ( LCTypeEncoding_NSArray == type )
	{
		return [self objectsFromArray:obj];
	}
	else if ( LCTypeEncoding_NSDictionary == type )
	{
		return [self objectFromDictionary:obj];
	}
	else if ( LCTypeEncoding_Object == type )
	{
		return self;
	}

	return nil;
}

@end
