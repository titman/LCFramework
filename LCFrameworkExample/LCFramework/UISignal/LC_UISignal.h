//
//  LC_UISignal.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "UIView+LCUISignal.h"
#import "LC_Model+LCUISignal.h"
#import "LC_UISignalCenter.h"

#undef  LC_ST_SIGNAL
#define LC_ST_SIGNAL( __name )	 LC_ST_PROPERTY( __name )

#undef  LC_IMP_SIGNAL
#define LC_IMP_SIGNAL( __name )  LC_IMP_PROPERTY( __name )

#undef	LC_HANDLE_SIGNAL
#define LC_HANDLE_SIGNAL( __signal ) \
    - (void)handleUISignal_##__signal:(LC_UISignal *)signal

@interface LC_UISignal : NSObject

@property (nonatomic, assign) id					source;
@property (nonatomic, retain) NSString *			name;
@property (nonatomic, retain) id					object;

+(LC_UISignal *)signal;

-(BOOL) send;
-(BOOL) forward:(id)object;

@end


@interface NSObject (LCUISignalResponder)

- (BOOL)isUISignalResponder;
- (NSObject *)signalTarget;

@end

@interface UIViewController (LCUISignalResponder)

- (BOOL)isUISignalResponder;
- (NSObject *)signalTarget;

@end

@interface UIView (LCUISignalResponder)

- (BOOL)isUISignalResponder;
- (NSObject *)signalTarget;

@end