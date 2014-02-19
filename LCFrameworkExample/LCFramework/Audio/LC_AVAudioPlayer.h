//
//  LC_AVAudioPlayer.h
//  LCFrameworkDemo
//
//  Created by 郭历成 ( titm@tom.com ) on 14-2-19.
//  Copyright (c) 2014年 LS Developer ( http://www.likesay.com ). All rights reserved.
//

#if defined(LC_AUDIO_ENABLE) && LC_AUDIO_ENABLE

#import <AVFoundation/AVFoundation.h>

@interface LC_AVAudioPlayer : AVAudioPlayer

+ (id) playerWithContentsOfPath:(NSString *)path;

@end

#endif