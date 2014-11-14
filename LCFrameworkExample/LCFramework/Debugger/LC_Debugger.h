//
//  LC_Debug.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-9.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <Foundation/Foundation.h>

@interface LC_Debugger : NSObject



@end


@interface LC_DebugInformationView : UIView

/** privite */
-(void) appendLogString:(NSString *)logString;

@end