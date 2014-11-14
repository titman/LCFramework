//
//  NSNull+LCExtension.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <Foundation/Foundation.h>

@interface NSNull (LCExtension)

-(NSInteger) integerValue;
-(NSInteger) length;

-(instancetype) objectAtIndex:(NSInteger)index;

-(instancetype) objectForKey:(NSString *)key;
-(void) setObject:(id)object forKey:(id<NSCopying>)aKey;

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len;

@end
