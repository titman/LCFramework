//
//  UIImageView+LCExtension.m
//  NextApp
//
//  Created by Licheng Guo . http://nsobject.me/ on 14/11/4.
//  Copyright (c) 2014年 http://nextapp.com.cn/. All rights reserved.
//

#import "UIImageView+LCExtension.h"

@implementation UIImageView (LCExtension)

+(instancetype) imageViewWithImage:(UIImage *)image
{
    return [[[[self class] alloc] initWithImage:image] autorelease];
}

@end
