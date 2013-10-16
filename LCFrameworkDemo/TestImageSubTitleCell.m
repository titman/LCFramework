//
//  TestImageSubTitleCell.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-26.
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

#import "TestImageSubTitleCell.h"

@interface TestImageSubTitleCell ()
{
    LC_UILabel * titleLabel;
    LC_UILabel * subTitleLabel;
    
    LC_UIImageView * headImageView;
}

@end

@implementation TestImageSubTitleCell

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //Custum cell
        UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        backgroundView.backgroundColor = [UIColor colorWithHexString:@"#6cbbcc"];
        self.selectedBackgroundView = LC_AUTORELEASE(backgroundView);
        
        
        
        headImageView = [[LC_UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:headImageView];
        LC_RELEASE(headImageView);
        
        
        
        titleLabel = [[LC_UILabel alloc] initWithFrame:CGRectZero copyingEnabled:YES];
        
        titleLabel.textAlignment = UITextAlignmentLeft;
        titleLabel.textColor = [UIColor colorWithHexString:@"#6cbbcc"];
        titleLabel.font      = [UIFont boldSystemFontOfSize:14];
        titleLabel.text      = @"";
        
        [self addSubview:titleLabel];
        LC_RELEASE(titleLabel);
        
        
        
        subTitleLabel = [[LC_UILabel alloc] initWithFrame:CGRectZero copyingEnabled:YES];
        
        subTitleLabel.textAlignment = UITextAlignmentLeft;
        subTitleLabel.textColor = [UIColor grayColor];
        subTitleLabel.font      = [UIFont systemFontOfSize:12];
        subTitleLabel.text      = @"";
        
        [self addSubview:subTitleLabel];
        LC_RELEASE(subTitleLabel);
    }
    
    return self;
}

-(void) setTitle:(NSString *)title subTitle:(NSString *)subTitle imageURL:(NSString *)imageURL
{
    titleLabel.text = title;
    subTitleLabel.text = subTitle;
    
    headImageView.url = imageURL;
    // or
    // [headImageView GET:#string# useCache:YES placeHolder:#image#];
    
    headImageView.frame = LC_RECT_CREATE(10, 10, 40, 40);
    titleLabel.frame    = LC_RECT_CREATE(60, 0, self.viewFrameWidth - 70, 30);
    subTitleLabel.frame = LC_RECT_CREATE(60, 30, self.viewFrameWidth - 70, 30);
}

@end
