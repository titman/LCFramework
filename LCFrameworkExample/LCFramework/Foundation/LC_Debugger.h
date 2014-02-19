//
//  LC_Debug.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-9.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import <Foundation/Foundation.h>
#import "NSObject+LCNotification.h"

@interface LC_Debugger : NSObject



@end


@interface LC_DebugInformationView : UIView

//* privite */
+(LC_DebugInformationView *) sharedInstance;
//* privite */
-(void) appendLogString:(NSString *)logString;

@end