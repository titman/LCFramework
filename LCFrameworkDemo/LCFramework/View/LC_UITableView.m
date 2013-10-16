//
//  LC_UITableView.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-20.
//  Copyright (c) 2013年 Like Say Developer ( https://github.com/titman/LCFramework / USE IN PROJECT http://www.likesay.com ).
//  All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "LC_UITableView.h"

@implementation LC_UITableView

-(id) autoCreateDequeueReusableCellWithIdentifier:(NSString *)identifier andClass:(Class)cellClass
{
    id cell =  [self dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[cellClass alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    
    return cell;
}

-(id) autoCreateDequeueReusableCellWithIdentifier:(NSString *)identifier
                                         andClass:(Class)cellClass
                                configurationCell:(void (^)(LC_UITableViewCell * cell))configurationCell
{
    id cell =  [self dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[cellClass alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
        configurationCell(cell);
    }
    
    return cell;
}

- (void) setContentSize:(CGSize)contentSize {
    CGFloat contentSizeArea = contentSize.width*contentSize.height;
    CGFloat frameArea = self.frame.size.width*self.frame.size.height;
    CGSize adjustedContentSize = contentSizeArea < frameArea ? self.frame.size : contentSize;
    [super setContentSize:adjustedContentSize];
}


+ (void) _roundCornersForSelectedBackgroundViewForTableView:(UITableView *)tableView cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    NSUInteger rows = [tableView numberOfRowsInSection:indexPath.section];
    
    if (rows == 1) {
        
        [[self class] roundCorners:UIRectCornerAllCorners forView:cell.selectedBackgroundView];
        
    } else if (indexPath.row == 0) {
        
        [[self class] roundCorners:UIRectCornerTopLeft | UIRectCornerTopRight forView:cell.selectedBackgroundView];
        
    } else if (indexPath.row == rows-1) {
        
        [[self class] roundCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight forView:cell.selectedBackgroundView];
        
    } else {
        
        [[self class] roundCorners:0 forView:cell.selectedBackgroundView];
        
    }
    
}

+ (void)roundCornersForSelectedBackgroundViewForGroupTableView:(UITableView *)tableView cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    if(tableView.style != UITableViewStyleGrouped){
        return;
    }
    
    if (IOS7_OR_LATER) {
        return;
    }
    
    int64_t delayInSeconds = 0;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [[self class] _roundCornersForSelectedBackgroundViewForTableView:tableView cell:cell indexPath:indexPath];
        
    });
}

+ (void)roundCorners:(UIRectCorner)corners forView:(UIView *)view {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                              
                                                   byRoundingCorners:corners
                              
                                                         cornerRadii:CGSizeMake(10.0, 10.0)];
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    
    maskLayer.frame = view.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    view.layer.mask = maskLayer;
}


@end
