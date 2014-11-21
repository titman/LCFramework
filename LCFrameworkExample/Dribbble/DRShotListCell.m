//
//  DRShotListCell.m
//  LCFrameworkExample
//
//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-11.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "DRShotListCell.h"
#import "DRShotsListData.h"

@interface DRShotBottomView : LC_UIBlurView
{
    LC_UIImageView * _lookTip;
    LC_UILabel * _lookLabel;
    
    LC_UIImageView * _commentTip;
    LC_UILabel * _commentLabel;
    
    LC_UIImageView * _likeTip;
    LC_UILabel * _likeLabel;

}

@end

@implementation DRShotBottomView

-(instancetype) init
{
    LC_SUPER_INIT({
        
        self.viewFrameHeight = 20;
#1
        _lookTip = [LC_UIImageView imageViewWithImage:[[UIImage imageNamed:@"icon-views.png" useCache:YES] imageWithTintColor:[UIColor whiteColor]]];
        _lookTip.viewFrameX = 10;
        _lookTip.viewFrameY = self.viewMidHeight - _lookTip.viewMidHeight;
        
        self.ADD(_lookTip);
        
        _lookLabel = LC_UILabel.view;
        _lookLabel.font = [UIFont systemFontOfSize:10];
        
        self.ADD(_lookLabel);
#2
        _commentTip = [LC_UIImageView imageViewWithImage:[[UIImage imageNamed:@"icon-comments.png" useCache:YES] imageWithTintColor:[UIColor whiteColor]]];
        _commentTip.viewFrameY = self.viewMidHeight - _commentTip.viewMidHeight;
        
        self.ADD(_commentTip);
        
        _commentLabel = LC_UILabel.view;
        _commentLabel.font = [UIFont systemFontOfSize:10];
        
        self.ADD(_commentLabel);
#3
        _likeTip = [LC_UIImageView imageViewWithImage:[[UIImage imageNamed:@"icon-hearts.png" useCache:YES] imageWithTintColor:[UIColor whiteColor]]];
        _likeTip.viewFrameY = self.viewMidHeight - _likeTip.viewMidHeight;
        
        self.ADD(_likeTip);
        
        _likeLabel = LC_UILabel.view;
        _likeLabel.font = [UIFont systemFontOfSize:10];
        
        self.ADD(_likeLabel);
    })
}

-(void) setShot:(SHOT *)shot
{
    _lookLabel.text = shot.views_count.description;
    _lookLabel.FIT();
    _lookLabel.viewFrameX = _lookTip.viewRightX + 5;
    _lookLabel.viewFrameY = self.viewMidHeight - _lookLabel.viewMidHeight;
    
    _commentTip.viewFrameX = _lookLabel.viewRightX + 10;
    
    _commentLabel.text = shot.comments_count.description;
    _commentLabel.FIT();
    _commentLabel.viewFrameX = _commentTip.viewRightX + 5;
    _commentLabel.viewFrameY = self.viewMidHeight - _commentLabel.viewMidHeight;
    
    _likeTip.viewFrameX = _commentLabel.viewRightX + 10;
    
    _likeLabel.text = shot.likes_count.description;
    _likeLabel.FIT();
    _likeLabel.viewFrameX = _likeTip.viewRightX + 5;
    _likeLabel.viewFrameY = self.viewMidHeight - _likeLabel.viewMidHeight;
}

@end

#pragma mark -

@interface DRShotListCell ()
{
    LC_UIImageView * _shotView;
    LC_UIImageView * _headView;

    LC_UIImageView * _shotViewOther;
    LC_UIImageView * _headViewOther;

    DRShotBottomView * _bottomBack;
    DRShotBottomView * _bottomBackOther;
}

@end

@implementation DRShotListCell

LC_IMP_SIGNAL(DRShotListCellDetailAction);

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
        _shotView.userInteractionEnabled = YES;
        _shotView.signalName = self.DRShotListCellDetailAction;
        self.ADD(_shotView);
        
        
        _shotViewOther = LC_UIImageView.view;
        _shotViewOther.frame = _shotView.frame;
        _shotViewOther.viewFrameX = _shotView.viewRightX + 5;
        _shotViewOther.showIndicator = YES;
        _shotViewOther.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        _shotViewOther.userInteractionEnabled = YES;
        _shotViewOther.signalName = self.DRShotListCellDetailAction;
        self.ADD(_shotViewOther);
        
        
        _bottomBack = DRShotBottomView.view;
        _bottomBack.viewFrameY = _shotView.viewFrameHeight - _bottomBack.viewFrameHeight;
        _bottomBack.viewFrameWidth = _shotView.viewFrameWidth;
        
        _shotView.ADD(_bottomBack);
        
        
        _bottomBackOther = DRShotBottomView.view;
        _bottomBackOther.viewFrameY = _shotView.viewFrameHeight - _bottomBackOther.viewFrameHeight;
        _bottomBackOther.viewFrameWidth = _shotView.viewFrameWidth;

        _shotViewOther.ADD(_bottomBackOther);
        
        
        
        _headView = LC_UIImageView.view;
        _headView.viewFrameX = _shotView.viewFrameWidth - 5 - 45;
        _headView.viewFrameY = _shotView.viewFrameHeight - _bottomBackOther.viewFrameHeight - 5 - 45;
        _headView.viewFrameWidth = 45;
        _headView.viewFrameHeight = 45;
        _headView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
        _headView.layer.borderWidth = 2;
        _shotView.ADD(_headView);
        
        
        
        _headViewOther = LC_UIImageView.view;
        _headViewOther.frame = _headView.frame;
        _headViewOther.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
        _headViewOther.layer.borderWidth = 1;
        
        _shotViewOther.ADD(_headViewOther);
        
    }
    
    return self;
}

-(void) setShot:(SHOT *)shot
{
    if (_shot) {
        [_shot release];
    }
    
    _shot = [shot retain];
    
    _shotView.url    = _shot.image_teaser_url;
    _headView.url    = _shot.player.avatar_url;
    _bottomBack.shot = shot;
}

-(void) setShotOther:(SHOT *)shotOther
{
    if (_shotOther) {
        [_shotOther release];
    }
    
    _shotOther = [shotOther retain];
    
    _shotViewOther.url    = _shotOther.image_teaser_url;
    _headViewOther.url    = _shotOther.player.avatar_url;
    _bottomBackOther.shot = shotOther;
}

@end
