//
//  DRShotsListData.h
//  LCFrameworkExample
//
//  Created by Licheng Guo . http://nsobject.me/ on 14/11/19.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

@interface PLAYER : LC_Model

@property (nonatomic, retain) NSString *			avatar_url;
@property (nonatomic, retain) NSNumber *			comments_count;
@property (nonatomic, retain) NSNumber *			comments_received_count;
@property (nonatomic, retain) NSString *			created_at;
@property (nonatomic, retain) NSObject *			drafted_by_player_id;
@property (nonatomic, retain) NSNumber *			draftees_count;
@property (nonatomic, retain) NSNumber *			followers_count;
@property (nonatomic, retain) NSNumber *			following_count;
@property (nonatomic, retain) NSNumber *			likes_count;
@property (nonatomic, retain) NSNumber *			likes_received_count;
@property (nonatomic, retain) NSString *			location;
@property (nonatomic, retain) NSString *			name;
@property (nonatomic, retain) NSNumber *			rebounds_count;
@property (nonatomic, retain) NSNumber *			rebounds_received_count;
@property (nonatomic, retain) NSNumber *			shots_count;
@property (nonatomic, retain) NSString *			twitter_screen_name;
@property (nonatomic, retain) NSString *			url;
@property (nonatomic, retain) NSString *			username;
@property (nonatomic, retain) NSNumber *			id;
@end

@interface SHOT : LC_Model

@property (nonatomic, retain) NSNumber *			comments_count;
@property (nonatomic, retain) NSString *			created_at;
@property (nonatomic, retain) NSNumber *			height;
@property (nonatomic, retain) NSString *			image_teaser_url;
@property (nonatomic, retain) NSString *			image_url;
@property (nonatomic, retain) NSNumber *			likes_count;
@property (nonatomic, retain) PLAYER *              player;
@property (nonatomic, retain) NSNumber *			rebound_source_id;
@property (nonatomic, retain) NSNumber *			rebounds_count;
@property (nonatomic, retain) NSString *			short_url;
@property (nonatomic, retain) NSString *			title;
@property (nonatomic, retain) NSString *			url;
@property (nonatomic, retain) NSNumber *			views_count;
@property (nonatomic, retain) NSNumber *			width;
@property (nonatomic, retain) NSNumber *			id;
@end
