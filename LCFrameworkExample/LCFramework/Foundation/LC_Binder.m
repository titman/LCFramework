//
//  LC_Binder.m
//  NextApp
//
//  Created by Licheng Guo . http://nsobject.me/ on 14/11/5.
//  Copyright (c) 2014年 http://nextapp.com.cn/. All rights reserved.
//

#import "LC_Binder.h"

@interface LC_Binder ()

@property(nonatomic,retain) LC_Observer * observer;

@end

@implementation LC_Binder

-(void) dealloc
{
    [self stopBinding];
    
    [super dealloc];
}

- (id)initForBindingFromObject:(id)fromObject keyPath:(NSString *)fromKeyPath
                      toObject:(id)toObject keyPath:(NSString *)toKeyPath
           transformationBlock:(LCBinderTransformationBlock)transformationBlock
{
    if((self = [super init])) {
        
        __block id wToObject = toObject;
        NSString * myToKeyPath = [[toKeyPath copy] autorelease];
        
        LCObserverBlockWithChangeDictionary changeBlock;
        
        if(transformationBlock) {
            changeBlock = [[^(NSDictionary *change) {
                [wToObject setValue:transformationBlock(change[NSKeyValueChangeNewKey])
                         forKeyPath:myToKeyPath];
            } copy] autorelease];
        } else {
            changeBlock = [[^(NSDictionary *change) {
                [wToObject setValue:change[NSKeyValueChangeNewKey]
                         forKeyPath:myToKeyPath];
            } copy] autorelease];
        }
        
        _observer = [LC_Observer observerForObject:fromObject
                                          keyPath:fromKeyPath
                                          options:NSKeyValueObservingOptionNew
                                      changeBlock:changeBlock];
    }
    return self;
}

- (void)stopBinding
{
    [_observer stopObserving];
    self.observer = nil;
}

+ (id)binderFromObject:(id)fromObject keyPath:(NSString *)fromKeyPath
              toObject:(id)toObject keyPath:(NSString *)toKeyPath
{
    return [[[self alloc] initForBindingFromObject:fromObject keyPath:fromKeyPath
                                         toObject:toObject keyPath:toKeyPath
                              transformationBlock:nil] autorelease];
}

+ (id)binderFromObject:(id)fromObject keyPath:(NSString *)fromKeyPath
              toObject:(id)toObject keyPath:(NSString *)toKeyPath
      valueTransformer:(NSValueTransformer *)valueTransformer
{
    return [[self alloc] initForBindingFromObject:fromObject keyPath:fromKeyPath
                                         toObject:toObject keyPath:toKeyPath
                              transformationBlock:^id(id value) {
                                  return [valueTransformer transformedValue:value];
                              }];
}

+ (id)binderFromObject:(id)fromObject keyPath:(NSString *)fromKeyPath
              toObject:(id)toObject keyPath:(NSString *)toKeyPath
   transformationBlock:(LCBinderTransformationBlock)transformationBlock
{
    return [[[self alloc] initForBindingFromObject:fromObject keyPath:fromKeyPath
                                         toObject:toObject keyPath:toKeyPath
                              transformationBlock:transformationBlock] autorelease];
}

+ (id)binderFromObject:(id)fromObject keyPath:(NSString *)fromKeyPath toObject:(id)toObject keyPath:(NSString *)toKeyPath formatter:(NSFormatter *)formatter;
{
    return [[[self alloc] initForBindingFromObject:fromObject keyPath:fromKeyPath
                                         toObject:toObject keyPath:toKeyPath
                              transformationBlock:^id(id value) {
                                  return [formatter stringForObjectValue: value];
                              }] autorelease];
}


@end
