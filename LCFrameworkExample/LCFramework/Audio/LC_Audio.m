//
//  LC_Audio.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-14.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_Audio.h"
#import "LC_AVAudioPlayer.h"

@implementation LC_Audio

+(LC_AVAudioPlayer *) playSoundName:(NSString *)soundName
{
    NSString * filePath = [[NSBundle mainBundle] pathForResource:soundName ofType:nil];
    
    return [LC_Audio playSoundAtFile:filePath];
}

+(LC_AVAudioPlayer *) playSoundAtFile:(NSString *)file
{
    if (LC_NSSTRING_IS_INVALID(file)) {
        return nil;
    }
    
    LC_AVAudioPlayer * player = [LC_AVAudioPlayer playerWithContentsOfPath:file];
    
    if (!player) {
        return nil;
    }
    
    BOOL result = [player prepareToPlay];
    
    if (!result) {
        return nil;
    }
    
    result = [player play];
    
    if (!result) {
        return nil;
    }
    
    return player;
}

+(BOOL) playSoundInAudioServices:(NSString *)soundName
{
    SystemSoundID soundID;
    NSURL * sample = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:soundName ofType:nil]];
    
    OSStatus err = AudioServicesCreateSystemSoundID((CFURLRef)sample, &soundID);
    
    if (err) {
        ERROR(@"Error occurred assigning system sound!");
        return NO;
    }

    AudioServicesPlaySystemSound(soundID);
    
    return YES;
}

+(void) vibration
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
