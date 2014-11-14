//
//  NSDictionary+MTLManipulationAdditions.m
//  Mantle
//
//  Created by Justin Spahr-Summers on 2012-09-24.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "NSDictionary+MTLManipulationAdditions.h"

@implementation NSDictionary (MTLManipulationAdditions)

- (NSDictionary *)mtl_dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary {
	NSMutableDictionary *result = [[self mutableCopy] autorelease];
	[result addEntriesFromDictionary:dictionary];
	return result;
}

- (NSDictionary *)mtl_dictionaryByRemovingEntriesWithKeys:(NSSet *)keys {
	NSMutableDictionary *result = [[self mutableCopy] autorelease];
	[result removeObjectsForKeys:keys.allObjects];
	return result;
}

@end
