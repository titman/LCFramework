//
//  LC_Binder.h
//  NextApp
//
//  Created by Licheng Guo . http://nsobject.me/ on 14/11/5.
//  Copyright (c) 2014年 http://nextapp.com.cn/. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LC_Binder : NSObject

typedef id(^LCBinderTransformationBlock)(id value);

+ (id)binderFromObject:(id)fromObject keyPath:(NSString *)fromKeyPath
              toObject:(id)toObject keyPath:(NSString *)toKeyPath;

+ (id)binderFromObject:(id)fromObject keyPath:(NSString *)fromKeyPath
              toObject:(id)toObject keyPath:(NSString *)toKeyPath
      valueTransformer:(NSValueTransformer *)valueTransformer;

+ (id)binderFromObject:(id)fromObject keyPath:(NSString *)fromKeyPath
              toObject:(id)toObject keyPath:(NSString *)toKeyPath
             formatter:(NSFormatter *)formatter;

+ (id)binderFromObject:(id)fromObject keyPath:(NSString *)fromKeyPath
              toObject:(id)toObject keyPath:(NSString *)toKeyPath
   transformationBlock:(LCBinderTransformationBlock)transformationBlock;

- (void)stopBinding;

@end
