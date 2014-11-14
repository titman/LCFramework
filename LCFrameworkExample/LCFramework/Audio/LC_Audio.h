//
//  LC_Audio.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-14.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_AVAudioPlayer.h"
#import <AudioToolbox/AudioToolbox.h>

@interface LC_Audio : NSObject

+(LC_AVAudioPlayer *) playSoundName:(NSString *)soundName;
+(LC_AVAudioPlayer *) playSoundAtFile:(NSString *)file;

+(BOOL) playSoundInAudioServices:(NSString *)soundName;

+(void) vibration;

@end
