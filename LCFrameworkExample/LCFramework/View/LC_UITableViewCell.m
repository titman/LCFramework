//
//  LC_UITableViewCell.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-20.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UITableViewCell.h"

@implementation LC_UITableViewCell

-(void) dealloc
{
    [_cellIndexPath release];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
//        self.backgroundView = ({
//            UIView *view = [[UIView alloc] initWithFrame:self.bounds];
//            view.backgroundColor = [UIColor redColor];
//            view.alpha = 0.8f;
//            view;
//        });
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];    
}

-(void) setSelectedViewColor:(UIColor *)selectedViewColor
{
    self.selectionStyle = UITableViewCellSelectionStyleDefault;

    UIView * view = [[UIView alloc] init];
    view.backgroundColor = selectedViewColor;
    self.selectedBackgroundView = LC_AUTORELEASE(view);
}

-(UIColor *) selectedViewColor
{
    return self.selectedBackgroundView.backgroundColor;
}

@end
