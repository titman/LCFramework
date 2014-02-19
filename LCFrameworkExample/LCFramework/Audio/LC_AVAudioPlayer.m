//
//  LC_AVAudioPlayer.m
//  LCFrameworkDemo
//
//  Created by 郭历成 ( titm@tom.com ) on 14-2-19.
//  Copyright (c) 2014年 LS Developer ( http://www.likesay.com ). All rights reserved.
//

#if defined(LC_AUDIO_ENABLE) && LC_AUDIO_ENABLE

#import "LC_AVAudioPlayer.h"

@interface LC_AVAudioPlayer ()<AVAudioPlayerDelegate>

@end

@implementation LC_AVAudioPlayer

-(void) dealloc
{
    if (self.isPlaying) {
        [self stop];
    }
    
    self.delegate = nil;
    
    LC_SUPER_DEALLOC();
}

+ (id) playerWithContentsOfPath:(NSString *)path
{
    float fileSize = [LC_FileManager fileSizeWithPath:path];
    
    if (fileSize > 1000.f) {
        LC_AVAudioPlayer * player = LC_AUTORELEASE([[LC_AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:nil]);
        player.delegate = player;
        return player;
    }else{
        
        NSData * soundData = [[NSData alloc] initWithContentsOfMappedFile:path];
        LC_AVAudioPlayer * player = LC_AUTORELEASE([[LC_AVAudioPlayer alloc] initWithData:soundData error:nil]);
        player.delegate = player;
        [soundData release];
        return player;
    }
}

-(id) init
{
    LC_SUPER_INIT({
       
        [self initSelf];
        
    });
}

-(id) initWithContentsOfURL:(NSURL *)url error:(NSError **)outError
{
    self = [super initWithContentsOfURL:url error:outError];
    
    if (self) {
        
        [self initSelf];
    }
    
    return self;
}

-(void) initSelf
{
    ;
}

-(BOOL) play
{
    return [super play];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    ;
}

@end

#endif