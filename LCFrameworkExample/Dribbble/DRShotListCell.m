//
//  DRShotListCell.m
//  LCFrameworkExample
//
//  Created by Licheng Guo . http://nsobject.me/ on 14/11/19.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import "DRShotListCell.h"
#import "DRShotsListData.h"

@interface DRShotListCell ()
{
    LC_UIImageView * _shotView;
    LC_UIImageView * _shotViewOther;
    
    
}

@end

@implementation DRShotListCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        float inv = (LC_DEVICE_WIDTH - (150 * 2))/3;
        
        _shotView = LC_UIImageView.view;
        _shotView.viewFrameX = inv;
        _shotView.viewFrameY = inv;
        _shotView.viewFrameWidth = 150;
        _shotView.viewFrameHeight = 150;
        _shotView.showIndicator = YES;
        _shotView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        
        self.ADD(_shotView);
        
        
        _shotViewOther = LC_UIImageView.view;
        _shotViewOther.frame = _shotView.frame;
        _shotViewOther.viewFrameX = _shotView.viewRightX + 5;
        _shotViewOther.showIndicator = YES;
        _shotViewOther.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        
        self.ADD(_shotViewOther);
        
        
        UIView * bottomBack = UIView.view;
        bottomBack.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        bottomBack.viewFrameWidth = _shotView.viewFrameWidth;
        bottomBack.viewFrameHeight = 30;
        bottomBack.viewFrameY = _shotView.viewFrameHeight - bottomBack.viewFrameHeight;
        
        _shotView.ADD(bottomBack);
        
        
        UIView * bottomBackOther = UIView.view;
        bottomBackOther.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        bottomBackOther.viewFrameWidth = _shotViewOther.viewFrameWidth;
        bottomBackOther.viewFrameHeight = 30;
        bottomBackOther.viewFrameY = _shotViewOther.viewFrameHeight - bottomBack.viewFrameHeight;
        
        _shotViewOther.ADD(bottomBackOther);
    }
    
    return self;
}

-(void) setShot:(SHOT *)shot
{
    if (_shot) {
        [_shot release];
    }
    
    _shot = [shot retain];
    
    _shotView.url = _shot.image_teaser_url;
}

-(void) setShotOther:(SHOT *)shotOther
{
    if (_shotOther) {
        [_shotOther release];
    }
    
    _shotOther = [shotOther retain];
    
    _shotViewOther.url = _shotOther.image_teaser_url;
}

@end
