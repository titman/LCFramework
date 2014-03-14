//
//  LC_Audio.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-14.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_Audio.h"
#import "LC_AVAudioPlayer.h"

@implementation LC_Audio

+(BOOL) playSoundName:(NSString *)soundName
{
    NSString * filePath = [[NSBundle mainBundle] pathForResource:soundName ofType:nil];
    
    if (LC_NSSTRING_IS_INVALID(filePath)) {
        return NO;
    }
    
    LC_AVAudioPlayer * player = [LC_AVAudioPlayer playerWithContentsOfPath:filePath];
    
    if (!player) {
        return NO;
    }
    
    [player prepareToPlay];
    return [player play];
}

+(void) vibration
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
