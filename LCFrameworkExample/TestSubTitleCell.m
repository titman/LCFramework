//
//  TestSubTitleCell.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "TestSubTitleCell.h"

@implementation TestSubTitleCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectedViewColor = [UIColor colorWithHexString:@"#6cbbcc"];
        
    }
    
    return self;
}

-(void) setTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    self.textLabel.text = title;
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.textLabel.textColor = LC_RGB(56, 56, 56);
    self.detailTextLabel.text = subTitle;
    self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    self.detailTextLabel.textColor = LC_RGB(190, 190, 190);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
