//
//  DRShotCommentCell.m
//  LCFrameworkExample
//
//  Created by 郭历成 ( titm@tom.com ) on 14-11-24.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import "DRShotCommentCell.h"
#import "DRShotsListData.h"

@interface DRShotCommentCell ()
{
    LC_UIImageView * _userHead;
    LC_UILabel * _userName;

    LC_UILabel * _content;
    
    UIView * _line;
}

@end

@implementation DRShotCommentCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _userHead = LC_UIImageView.view;
        _userHead.viewFrameX = 5;
        _userHead.viewFrameY = 5;
        _userHead.viewFrameWidth = 30;
        _userHead.viewFrameHeight = 30;
        
        self.ADD(_userHead);
        
        
        _userName = LC_UILabel.view;
        _userName.viewFrameX = _userHead.viewRightX + 5;
        _userName.viewFrameY = 5;
        _userName.viewFrameWidth = LC_DEVICE_WIDTH - _userHead.viewRightX - 10;
        _userName.viewFrameHeight = 14;
        _userName.textColor = LC_RGB(56, 56, 56);
        _userName.font = [UIFont systemFontOfSize:14];
        _userName.numberOfLines = 1;
        
        self.ADD(_userName);
        
        
        _content = LC_UILabel.view;
        _content.viewFrameX = _userHead.viewRightX + 5;
        _content.viewFrameY = _userName.viewBottomY + 5;
        _content.viewFrameWidth = _userName.viewFrameWidth;
        _content.textColor = LC_RGB(156, 156, 156);
        _content.font = [UIFont systemFontOfSize:14];
        _content.numberOfLines = 0;
        
        self.ADD(_content);
        
        
        _line = UIView.view;
        _line.viewFrameWidth = LC_DEVICE_WIDTH;
        _line.viewFrameHeight = 0.5;
        _line.backgroundColor = LC_RGB(191, 191, 191);
        
        self.ADD(_line);
    }
    
    return self;
}

-(void) setComment:(COMMENT *)comment
{
    _userHead.url = comment.player.avatar_url;
    _userName.text = comment.player.name;
    _content.text = comment.body;

    CGSize size = [comment.body sizeWithFont:_content.font byWidth:_content.viewFrameWidth];
    
    _content.viewFrameHeight = size.height;
    
    float height = size.height < 40 ? 40 : size.height;
    
    _line.viewFrameY = height + 24.f - _line.viewFrameHeight;
}

@end
