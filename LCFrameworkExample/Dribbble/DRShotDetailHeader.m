//
//  DRShotDetailHeader.m
//  LCFrameworkExample
//
//  Created by Licheng Guo . http://nsobject.me/ on 14/11/24.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import "DRShotDetailHeader.h"
#import "DRShotListCell.h"
#import "DRShotsListData.h"

#define HEIGHT (LC_DEVICE_WIDTH + 10.f + 45.f)

@interface DRShotDetailHeader ()
{
    LC_UIImageView * _shotView;
    
    LC_UIImageView * _userHead;
    LC_UILabel * _userNick;
    LC_UILabel * _userSigh;
    
    DRShotBottomView * _bottomTool;
}

@end

@implementation DRShotDetailHeader

-(id) init
{
    LC_SUPER_INIT({
        
        self.viewFrameWidth = LC_DEVICE_WIDTH;
        self.viewFrameHeight = HEIGHT;
        
        _shotView = LC_UIImageView.view;
        _shotView.viewFrameWidth = LC_DEVICE_WIDTH;
        _shotView.viewFrameHeight = LC_DEVICE_WIDTH;
        _shotView.showIndicator = YES;
        _shotView.contentMode = UIViewContentModeScaleAspectFill;
        
        self.ADD(_shotView);
        
        _bottomTool = DRShotBottomView.view;
        _bottomTool.viewFrameY = _shotView.viewBottomY - _bottomTool.viewFrameHeight;
        _bottomTool.viewFrameWidth = LC_DEVICE_WIDTH;
        
        self.ADD(_bottomTool);
        
        
        _userHead = LC_UIImageView.view;
        _userHead.viewFrameX = 5;
        _userHead.viewFrameY = _bottomTool.viewBottomY + 5;
        _userHead.viewFrameWidth = 45;
        _userHead.viewFrameHeight = 45;
        
        self.ADD(_userHead);
        
        
        _userNick = LC_UILabel.view;
        _userNick.viewFrameX = _userHead.viewRightX + 5;
        _userNick.viewFrameY = _bottomTool.viewBottomY;
        _userNick.viewFrameWidth = LC_DEVICE_WIDTH - _userHead.viewRightX - 5;
        _userNick.viewFrameHeight = 55./2.;
        _userNick.textColor = LC_RGB(56, 56, 56);
        _userNick.font = [UIFont systemFontOfSize:16];
        
        self.ADD(_userNick);
        
        
        _userSigh = LC_UILabel.view;
        _userSigh.viewFrameX = _userNick.viewFrameX;
        _userSigh.viewFrameY = _userNick.viewBottomY;
        _userSigh.viewFrameWidth = _userNick.viewFrameWidth;
        _userSigh.viewFrameHeight = _userNick.viewFrameHeight;
        _userSigh.textColor = LC_RGB(56, 56, 56);
        _userSigh.font = [UIFont systemFontOfSize:12];
        _userSigh.numberOfLines = 1;
        
        self.ADD(_userSigh);
    })
}

-(void) setShot:(SHOT *)shot
{
    self.backgroundImageView.url = shot.image_teaser_url;
    _shotView.url = shot.image_url;
    _bottomTool.shot = shot;
    _userHead.url = shot.player.avatar_url;
    _userNick.text = shot.player.name;
    _userSigh.text = LC_NSSTRING_FORMAT(@"Likes: %@ Followers: %@ Follow: %@",shot.player.likes_count,shot.player.followers_count,shot.player.following_count);
}

@end
