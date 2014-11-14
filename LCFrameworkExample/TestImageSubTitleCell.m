//
//  TestImageSubTitleCell.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

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
        
        self.selectedViewColor = [UIColor colorWithHexString:@"#6cbbcc"];

        
        
        headImageView = LC_UIImageView.view;
        self.ADD(headImageView);
        
        
        
        titleLabel = LC_UILabel.view;
        
        titleLabel.textAlignment = UITextAlignmentLeft;
        titleLabel.textColor = [UIColor colorWithHexString:@"#6cbbcc"];
        titleLabel.font      = [UIFont boldSystemFontOfSize:14];
        titleLabel.text      = @"";
        
        self.ADD(titleLabel);
        
        
        
        subTitleLabel = LC_UILabel.view;
        
        subTitleLabel.textAlignment = UITextAlignmentLeft;
        subTitleLabel.textColor = [UIColor grayColor];
        subTitleLabel.font      = [UIFont systemFontOfSize:12];
        subTitleLabel.text      = @"";
        
        self.ADD(subTitleLabel);
    }
    
    return self;
}

-(void) setTitle:(NSString *)title subTitle:(NSString *)subTitle imageURL:(NSString *)imageURL
{
    titleLabel.text = title;
    subTitleLabel.text = subTitle;
    
    //headImageView.url = imageURL;
    // or
     [headImageView GET:imageURL useCache:YES placeHolder:[UIImage imageNamed:@"120.png" useCache:YES]];
    
    headImageView.frame = LC_RECT_CREATE(10, 10, 40, 40);
    titleLabel.frame    = LC_RECT_CREATE(60, 0, self.viewFrameWidth - 70, 30);
    subTitleLabel.frame = LC_RECT_CREATE(60, 30, self.viewFrameWidth - 70, 30);
}

@end
