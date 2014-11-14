//
//  LC_AVAudioPlayer.h
//  LCFramework
//
//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 14-2-19.
//  Copyright (c) 2014年 LS Developer ( http://www.likesay.com ). All rights reserved.
//

#if defined(LC_AUDIO_ENABLE) && LC_AUDIO_ENABLE

#import <AVFoundation/AVFoundation.h>

@class LC_AVAudioPlayer;

typedef void (^LCAVAudioPlayerDidFinishPlayingBlock) (LC_AVAudioPlayer * audioPlayer, BOOL flag);

@interface LC_AVAudioPlayer : AVAudioPlayer

@property(nonatomic,copy) LCAVAudioPlayerDidFinishPlayingBlock didFinishPlayingBlock;

+ (id) playerWithContentsOfPath:(NSString *)path;

@end

#endif