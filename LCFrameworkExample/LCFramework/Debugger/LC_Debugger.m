//
//  LC_Debug.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-9.
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
#import "LC_SystemInfoViewer.h"
#import "LC_CMDInput.h"

#if defined(LC_DEBUG_ENABLE) && LC_DEBUG_ENABLE

#define MAX_LOG_LENGTH 50000

#pragma mark -

@interface LC_Debugger ()

@property(nonatomic,assign) LC_UILabel * tip;
@property(nonatomic,assign) LC_UILabel * cpuUsed;
@property(nonatomic,assign) LC_UILabel * networkUsed;

@end

#pragma mark -

@interface LC_DebugInformationView()

@property(nonatomic,assign) BOOL isShowing;
@property(nonatomic,assign) LC_UITextView * logView;


-(void) setupUI;
-(void) show:(BOOL)yesOrNo;
-(void) appendLogString:(NSString *)logString;


@end


#pragma mark -


@implementation LC_DebugInformationView


-(id) init
{
    LC_SUPER_INIT({
        
        self.backgroundColor = [UIColor clearColor];
        
        self.isShowing = NO;
        
        self.frame = LC_RECT_CREATE(0, LC_DEVICE_HEIGHT+20, LC_DEVICE_WIDTH, LC_DEVICE_HEIGHT+20);
        
    });
}

-(void) setupUI
{
    
    [LC_KEYWINDOW addSubview:self];
    
    UIView * back = LC_AUTORELEASE([[LC_UIView alloc] initWithFrame:self.bounds]);
    back.backgroundColor = [UIColor blackColor];
    back.alpha = 0.6;
    [self addSubview:back];
    
    LC_UILabel * tip = [LC_UILabel view];
    tip.frame = CGRectMake(0, 20, LC_DEVICE_WIDTH, 20);
    tip.text = @"Debugger";
    tip.textAlignment = UITextAlignmentCenter;
    [self addSubview:tip];
    
    float inv = (LC_DEVICE_WIDTH-60)/2;
    
    LC_UIButton * systemInfoButton = [[LC_UIButton alloc] initWithFrame:LC_RECT_CREATE(20, 45, inv, 40)];
    systemInfoButton.hidden = NO;
    systemInfoButton.titleColor = [UIColor whiteColor];
    systemInfoButton.titleFont = [UIFont systemFontOfSize:14.0f];
    systemInfoButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    systemInfoButton.layer.cornerRadius = 6.0f;
    systemInfoButton.layer.borderColor = [UIColor grayColor].CGColor;
    systemInfoButton.layer.borderWidth = 2.0f;
    systemInfoButton.title = @"System Info";
    [systemInfoButton addTarget:self action:@selector(systemInfoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:systemInfoButton];
    [systemInfoButton release];
    
    LC_UIButton * viewInspectorButton = [[LC_UIButton alloc] initWithFrame:LC_RECT_CREATE(20*2+inv, 45, inv, 40)];
    viewInspectorButton.hidden = NO;
    viewInspectorButton.titleColor = [UIColor whiteColor];
    viewInspectorButton.titleFont = [UIFont systemFontOfSize:14.0f];
    viewInspectorButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    viewInspectorButton.layer.cornerRadius = 6.0f;
    viewInspectorButton.layer.borderColor = [UIColor grayColor].CGColor;
    viewInspectorButton.layer.borderWidth = 2.0f;
    viewInspectorButton.title = @"View Inspector";
    [viewInspectorButton addTarget:self action:@selector(viewInspectorButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:viewInspectorButton];
    [viewInspectorButton release];
    
    LC_UIButton * crashReport = [[LC_UIButton alloc] initWithFrame:LC_RECT_CREATE(20, viewInspectorButton.viewBottomY + 5, inv, 40)];
    crashReport.hidden = NO;
    crashReport.titleColor = [UIColor whiteColor];
    crashReport.titleFont = [UIFont systemFontOfSize:14.0f];
    crashReport.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    crashReport.layer.cornerRadius = 6.0f;
    crashReport.layer.borderColor = [UIColor grayColor].CGColor;
    crashReport.layer.borderWidth = 2.0f;
    crashReport.title = @"Crash Report";
    [crashReport addTarget:self action:@selector(crashReportButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:crashReport];
    [crashReport release];
    
    LC_CMDInput * cmdInput = [LC_CMDInput LCInstance];
    cmdInput.frame = CGRectMake(viewInspectorButton.viewFrameX, viewInspectorButton.viewBottomY + 5, inv,40);
    [self addSubview:cmdInput];
    
    self.logView = LC_AUTORELEASE([[LC_UITextView alloc] initWithFrame:LC_RECT_CREATE(0, crashReport.viewBottomY + 20, LC_DEVICE_WIDTH, (LC_DEVICE_HEIGHT+20) - (crashReport.viewBottomY + 20))]);
    self.logView.editable = NO;
    self.logView.font = [UIFont systemFontOfSize:12];
    self.logView.textColor = LC_RGB(56, 56, 56);
    self.logView.backgroundColor = LC_RGBA(255, 255, 255, 0.8);
    self.logView.text = @" \n \
                `              \
    *             +            \
               +               \
                 *             \
    \n                      LCFramework Log Information \n\n  \
    `              \
    +           *            \
    `               \
    *            +  \n         +        \n";
    
    [self addSubview:_logView];
    
}

-(void) show:(BOOL)yesOrNo
{
    self.isShowing = yesOrNo;
    
    if (yesOrNo) {
        
        self.alpha = 0;
        
        LC_FAST_ANIMATIONS(0.5, ^{
        
            self.alpha = 1;
            self.frame = LC_RECT_CREATE(0, 0, LC_KEYWINDOW.viewFrameWidth, LC_KEYWINDOW.viewFrameHeight);
        
        });
        
    }
    else{
    
        LC_FAST_ANIMATIONS(0.5, ^{
            
            self.alpha = 0;
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
    
    float cpuUsed = [LC_SystemInfo cpuUsage];
    
    [LC_Debugger LCInstance].cpuUsed.text = LC_NSSTRING_FORMAT(@"CPU %.0f%%",cpuUsed * 100);
    [LC_Debugger LCInstance].networkUsed.text = LC_NSSTRING_FORMAT(@"NET %.1fkb/s",[LC_HTTPRequestQueue bandwidthUsedPerSecond]/1024.);

    LC_AUTORELEASE_POOL_END();
}

-(void) appendLogString:(NSString *)logString
{
    if (!self.superview) {
        return;
    }
    
    [LC_GCD dispatchAsyncInMainQueue:^{
        
        LC_AUTORELEASE_POOL_START();
        
        NSString * newLogString = [_logView.text stringByAppendingString:LC_NSSTRING_FORMAT(@"%@\n",logString)];
        
        if (newLogString.length > MAX_LOG_LENGTH) {
            newLogString = [newLogString substringWithRange:NSMakeRange(newLogString.length-MAX_LOG_LENGTH, MAX_LOG_LENGTH)];
        }
        
        self.logView.text = newLogString;
        
        LC_FAST_ANIMATIONS(1, ^{
        
            NSRange txtOutputRange;
            txtOutputRange.location = _logView.text.length;
            txtOutputRange.length = 0;
            _logView.editable = YES;
            [_logView scrollRangeToVisible:txtOutputRange];
            [_logView setSelectedRange:txtOutputRange];
            _logView.editable = NO;
        
        });
        
        LC_AUTORELEASE_POOL_END();
        
    }];

}

-(void) systemInfoButtonAction
{
    LC_SystemInfoViewer * viewer = [LC_SystemInfoViewer LCInstance];
    viewer.frame = LC_RECT_CREATE(0, 20, LC_DEVICE_WIDTH, LC_DEVICE_HEIGHT);
    [self addSubview:viewer];
}

-(void) viewInspectorButtonAction
{
    [[LC_DebugInformationView LCInstance] show:NO];
    [self performSelector:@selector(showViewInspector) withObject:nil afterDelay:0.5];
}

-(void) crashReportButtonAction
{
    NSArray * log = [LC_CrashReport crashLog];
    
    CMDLog(@"Crash total of %d. (If you want see detail of crash report, use method : [LC_CrashReport crashLog].)",log.count);
    
    for (NSDictionary * dic in log) {
        
        CMDLog(@"%@",dic.EXTRACT(@"exception"));
    }
}

-(void) showViewInspector
{
    [[LC_ViewInspector LCInstance] prepareShow:LC_KEYWINDOW];
    [LC_ViewInspector LCInstance].alpha = 1;
    
    [UIView beginAnimations:@"OPEN" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [[LC_ViewInspector LCInstance] show];
    
    [UIView commitAnimations];
}

@end


#pragma mark -


@implementation LC_Debugger


+ (void)load
{
    [LC_Debugger LCInstance];
}

-(id) init
{
    LC_SUPER_INIT({
        
        [self observeNotification:UIApplicationDidFinishLaunchingNotification];
        [UIWindow hook];
        
    });
}

-(void) handleNotification:(NSNotification *)notification
{
    if ([notification is:UIApplicationDidFinishLaunchingNotification]) {
        
        
        [[LC_DebugInformationView LCInstance] setupUI];
        [[LC_DebugInformationView LCInstance] startRefreshGraph];
        
        
        UIWindow * debuggerTip = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, LC_DEVICE_WIDTH, 20)];

        debuggerTip.windowLevel = UIWindowLevelNormal;
        debuggerTip.windowLevel = UIWindowLevelStatusBar + 1.0f;
        debuggerTip.frame = [UIApplication sharedApplication].statusBarFrame;
        debuggerTip.backgroundColor = LC_RGB(0, 118, 247);
        debuggerTip.hidden = NO;
        debuggerTip.alpha = 1.0f;
        
        float inv = LC_DEVICE_WIDTH/3;
        
        self.tip = LC_UILabel.view;
        self.tip.text = @"DEBUG OPEN";
        self.tip.backgroundColor = [UIColor clearColor];
        self.tip.textAlignment = UITextAlignmentCenter;
        self.tip.viewFrameWidth = inv;
        self.tip.viewFrameHeight = debuggerTip.viewFrameHeight;
        self.tip.userInteractionEnabled = YES;
        [self.tip addTapTarget:self selector:@selector(handleTap:)];
        
        debuggerTip.ADD(self.tip);
        
        LC_UIView * line = LC_UIView.view;
        line.viewFrameX = self.tip.viewRightX;
        line.viewFrameWidth = 1;
        line.viewFrameHeight = debuggerTip.viewFrameHeight;
        
        line.backgroundColor = [UIColor whiteColor];
        
        debuggerTip.ADD(line);
        
        self.cpuUsed = LC_UILabel.view;
        self.cpuUsed.viewFrameX = line.viewRightX;
        self.cpuUsed.viewFrameWidth = inv;
        self.cpuUsed.viewFrameHeight = debuggerTip.viewFrameHeight;
        self.cpuUsed.textColor = [UIColor whiteColor];
        self.cpuUsed.textAlignment = UITextAlignmentCenter;

        debuggerTip.ADD(self.cpuUsed);
        
        LC_UIView * line1 = LC_UIView.view;
        line1.viewFrameX = self.cpuUsed.viewRightX;
        line1.viewFrameWidth = 1;
        line1.viewFrameHeight = debuggerTip.viewFrameHeight;
        line1.backgroundColor = [UIColor whiteColor];
        
        debuggerTip.ADD(line1);
        
        self.networkUsed = LC_UILabel.view;
        self.networkUsed.viewFrameX = line1.viewRightX;
        self.networkUsed.viewFrameWidth = inv;
        self.networkUsed.viewFrameHeight = debuggerTip.viewFrameHeight;
        self.networkUsed.textColor = [UIColor whiteColor];
        self.networkUsed.textAlignment = UITextAlignmentCenter;
        
        debuggerTip.ADD(self.networkUsed);
    }
}

-(void) handleTap:(UIPanGestureRecognizer *)pan
{
    if ([LC_DebugInformationView LCInstance].isShowing) {
        
        [[LC_DebugInformationView LCInstance] show:NO];
    }
    else{
        
        [[LC_DebugInformationView LCInstance] show:YES];
    }
}

@end


#pragma mark -


#endif

