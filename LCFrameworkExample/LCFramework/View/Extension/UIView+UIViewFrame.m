//
//  UIView+UIViewFrame.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import "UIView+UIViewFrame.h"

@implementation UIView (UIViewFrame)

-(float) viewFrameX
{
    return self.frame.origin.x;
}

-(void) setViewFrameX:(float)newViewFrameX
{
    self.frame = LC_RECT_CREATE(newViewFrameX, self.viewFrameY, self.viewFrameWidth, self.viewFrameHeight);
}

-(float) viewFrameY
{
    return self.frame.origin.y;
}

-(void) setViewFrameY:(float)newViewFrameY
{
    self.frame = LC_RECT_CREATE(self.viewFrameX, newViewFrameY, self.viewFrameWidth, self.viewFrameHeight);
}

-(float) viewFrameWidth
{
    return self.frame.size.width;
}

-(void) setViewFrameWidth:(float)newViewFrameWidth
{
    self.frame = LC_RECT_CREATE(self.viewFrameX, self.viewFrameY, newViewFrameWidth, self.viewFrameHeight);
}

-(float) viewFrameHeight
{
    return self.frame.size.height;
}

-(void) setViewFrameHeight:(float)newViewFrameHeight
{
    self.frame = LC_RECT_CREATE(self.viewFrameX, self.viewFrameY, self.viewFrameWidth, newViewFrameHeight);
}

@end
