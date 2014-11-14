//
//  NSNull+LCExtension.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "NSNull+LCExtension.h"

@implementation NSNull (LCExtension)

-(NSInteger)length
{
    ERROR(@"NSNull can't call length!");
    return 0;
}

-(NSInteger) integerValue
{
    ERROR(@"NSNull can't call integerValue!");
    return 0;
}

-(instancetype)objectAtIndex:(NSInteger)index
{
    ERROR(@"NSNull can't call objectAtIndex:!");
    return nil;
}

-(instancetype)objectForKey:(NSString *)key
{
    ERROR(@"NSNull can't call objectForKey:!");
    return nil;
}

-(void) setObject:(id)object forKey:(id<NSCopying>)aKey
{
    ERROR(@"NSNull can't call setObject:forKey:!");
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len
{
    ERROR(@"NSNull can't call countByEnumeratingWithState:!");
    return 0;
}

@end
