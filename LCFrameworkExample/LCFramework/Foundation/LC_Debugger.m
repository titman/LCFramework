//
//  LC_Debug.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-9.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//
//
//          +            `
//                      *             +
//  +           *
//      *
//                  LCFramework     `          +
//  `
//             +           *
//      `
//         *                       +           *

#import "LC_Debugger.h"

#if defined(LC_DEBUG_ENABLE) && LC_DEBUG_ENABLE

#define MAX_LOG_LENGTH 50000

#pragma mark -


@interface LC_DebugInformationView()
{
    LC_UIGraphView * cpuGraphView;
    LC_UILabel * cpuInfo;
    
    LC_UIGraphView * memoryGraphView;
    LC_UILabel * memoryInfo;
}

@property(nonatomic,assign) BOOL isShowing;
@property(nonatomic,assign) LC_UITextView * logView;


+(LC_DebugInformationView *) sharedInstance;

-(void) setupUI;
-(void) show:(BOOL)yesOrNo;
-(void) appendLogString:(NSString *)logString;


@end


#pragma mark -


@implementation LC_DebugInformationView

+(LC_DebugInformationView *) sharedInstance
{
    static dispatch_once_t once;
    static LC_DebugInformationView * __singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[LC_DebugInformationView alloc] init]; } );
    return __singleton__;
}

-(id) init
{
    LC_SUPER_INIT({
        
        self.backgroundColor = [UIColor clearColor];
        
        self.isShowing = NO;
        self.frame = LC_RECT_CREATE(0, LC_KEYWINDOW.viewFrameHeight, LC_KEYWINDOW.viewFrameWidth, LC_KEYWINDOW.viewFrameHeight);
        
    });
}

-(void) setupUI
{
    [LC_KEYWINDOW addSubview:self];
    
    UIView * back = LC_AUTORELEASE([[LC_UIView alloc] initWithFrame:self.bounds]);
    back.backgroundColor = [UIColor blackColor];
    back.alpha = 0.6;
    [self addSubview:back];
    
    self.logView = LC_AUTORELEASE([[LC_UITextView alloc] initWithFrame:LC_RECT_CREATE(0, self.viewFrameHeight/2, self.frame.size.width, self.viewFrameHeight/2)]);
    self.logView.editable = NO;
    
    self.logView.backgroundColor = LC_COLOR_W_RGB(255, 255, 255, 0.8);
    self.logView.text = @" \n \
                `              \
    *             +            \
               +               \
                 *             \
    \n                      LCFramework Log Information \n\n  \
    `              \
    +           *            \
    `               \
    *            +  \n";
    
    [self addSubview:_logView];
    
    memoryGraphView = LC_AUTORELEASE([[LC_UIGraphView alloc] initWithFrame:LC_RECT_CREATE(0, self.viewFrameHeight-self.logView.viewFrameHeight- 20 - 50, LC_DEVICE_WIDTH, 50)]);
    [memoryGraphView setBackgroundColor:[UIColor clearColor]];
    [memoryGraphView setSpacing:0];
    [memoryGraphView setFill:NO];
    [memoryGraphView setStrokeColor:[UIColor greenColor]];
    [memoryGraphView setZeroLineStrokeColor:[UIColor clearColor]];
    [memoryGraphView setLineWidth:2];
    [memoryGraphView setCurvedLines:NO];
    [memoryGraphView setMaxValue:60];
    [memoryGraphView setMinValue:0];
    [self addSubview:memoryGraphView];
    
    memoryInfo = LC_AUTORELEASE([[LC_UILabel alloc] initWithFrame:LC_RECT_CREATE(0, self.viewFrameHeight-self.logView.viewFrameHeight- 20, LC_DEVICE_WIDTH, 20)]);
    memoryInfo.textColor = [UIColor whiteColor];
    memoryInfo.textAlignment = UITextAlignmentCenter;
    [self addSubview:memoryInfo];
    
    cpuGraphView = LC_AUTORELEASE([[LC_UIGraphView alloc] initWithFrame:LC_RECT_CREATE(0, self.viewFrameHeight-self.logView.viewFrameHeight- 20 - 50 - 20 - 50, LC_DEVICE_WIDTH, 50)]);
    [cpuGraphView setBackgroundColor:[UIColor clearColor]];
    [cpuGraphView setSpacing:0];
    [cpuGraphView setFill:NO];
    [cpuGraphView setStrokeColor:[UIColor greenColor]];
    [cpuGraphView setZeroLineStrokeColor:[UIColor clearColor]];
    [cpuGraphView setLineWidth:2];
    [cpuGraphView setCurvedLines:NO];
    [cpuGraphView setMaxValue:100];
    [cpuGraphView setMinValue:0];
    [self addSubview:cpuGraphView];
    
    cpuInfo = LC_AUTORELEASE([[LC_UILabel alloc] initWithFrame:LC_RECT_CREATE(0, self.viewFrameHeight-self.logView.viewFrameHeight- 20 - 50 - 20, LC_DEVICE_WIDTH, 20)]);
    cpuInfo.textColor = [UIColor whiteColor];
    cpuInfo.textAlignment = UITextAlignmentCenter;
    [self addSubview:cpuInfo];
}

-(void) show:(BOOL)yesOrNo
{
    self.isShowing = yesOrNo;
    
    if (yesOrNo) {
        
        LC_FAST_ANIMATIONS(0.5, ^{
        
            self.frame = LC_RECT_CREATE(0, 0, LC_KEYWINDOW.viewFrameWidth, LC_KEYWINDOW.viewFrameHeight);
        
        });
        
    }
    else{
    
        LC_FAST_ANIMATIONS(0.5, ^{
            
            self.frame = LC_RECT_CREATE(0, LC_KEYWINDOW.viewFrameHeight, LC_KEYWINDOW.viewFrameWidth, LC_KEYWINDOW.viewFrameHeight);
            
        });
    
    }
}

-(void) startRefreshGraph
{
    [self timer:0.5 repeat:YES name:@"RefreshGraph"];
}

-(void) stopRefreshGraph
{
    [self cancelTimer:@"RefreshGraph"];
}

-(void) handleTimer:(NSTimer *)timer
{
    LC_AUTORELEASE_POOL_START();
    
    float totalBytes = [LC_SystemInfo bytesOfTotalMemory];
    float usedBytes = [LC_SystemInfo bytesOfUsedMemory];
    
    float usedKB = usedBytes/1024.0/1024.0;
    [memoryGraphView setPoint:usedKB];
    
    float percent = (totalBytes > 0.0f) ? ((float)usedBytes / (float)totalBytes * 100.0f) : 0.0f;
    memoryInfo.text = LC_NSSTRING_FORMAT(@"memory use : %.2f%%  memory total : %@",percent,[NSString stringWithBytes:totalBytes]);
    
    float cpuUsed = [LC_SystemInfo applicationCUPUsage];
    [cpuGraphView setPoint:cpuUsed];
    
    cpuInfo.text = LC_NSSTRING_FORMAT(@"cpu use : %.2f%%",cpuUsed);
    
    LC_AUTORELEASE_POOL_END();
}

-(void) appendLogString:(NSString *)logString
{
    if (!self.superview) {
        return;
    }
    
    LC_AUTORELEASE_POOL_START();
    
    NSString * newLogString = [_logView.text stringByAppendingString:LC_NSSTRING_FORMAT(@"%@\n",logString)];
    
    if (newLogString.length > MAX_LOG_LENGTH) {
        newLogString = [newLogString substringWithRange:NSMakeRange(newLogString.length-MAX_LOG_LENGTH, MAX_LOG_LENGTH)];
    }
    
    self.logView.text = newLogString;
    

    LC_AUTORELEASE_POOL_END();
    
    LC_FAST_ANIMATIONS(1, ^{
    
        NSRange txtOutputRange;
        txtOutputRange.location = _logView.text.length;
        txtOutputRange.length = 0;
        _logView.editable = YES;
        [_logView scrollRangeToVisible:txtOutputRange];
        [_logView setSelectedRange:txtOutputRange];
        _logView.editable = NO;
    
    });
}

@end


#pragma mark -


@implementation LC_Debugger

+ (LC_Debugger *)sharedInstance
{
    static dispatch_once_t once;
    static LC_Debugger * __singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } );
    return __singleton__;
}

+ (void)load
{
    [LC_Debugger sharedInstance];
}

-(id) init
{
    LC_SUPER_INIT({
        
        [self observeNotification:UIApplicationDidFinishLaunchingNotification];
        
    });
}

-(void) handleNotification:(NSNotification *)notification
{
    if ([notification is:UIApplicationDidFinishLaunchingNotification]) {
        
        [LC_KEYWINDOW setMultipleTouchEnabled:YES];
        
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        
        pan.minimumNumberOfTouches = 3;
        pan.cancelsTouchesInView = NO;
        
        [LC_KEYWINDOW addGestureRecognizer:pan];
        LC_RELEASE(pan);
        
        [[LC_DebugInformationView sharedInstance] setupUI];
        [[LC_DebugInformationView sharedInstance] startRefreshGraph];
        
        
    }
}

-(void) handlePan:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:LC_KEYWINDOW];
    
    if (point.y < -20  && [LC_DebugInformationView sharedInstance].isShowing == NO) {
        [[LC_DebugInformationView sharedInstance] show:YES];
    }else if (point.y > 20 && [LC_DebugInformationView sharedInstance].isShowing == YES){
        [[LC_DebugInformationView sharedInstance] show:NO];
    }
    
}


@end


#pragma mark -


#endif

