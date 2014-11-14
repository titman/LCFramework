//
//  LC_UINavigationController.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-17.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UINavigationController.h"

typedef void (^LCTransitionBlock)();

#pragma mark -

@interface LC_UINavigationController () <UIGestureRecognizerDelegate,UINavigationControllerDelegate>
{
    BOOL    _transitionInProgress;
    CGFloat _systemVersion;
}

@property(nonatomic,retain) NSMutableArray * peddingBlocks;

@end

#pragma mark -

@implementation LC_UINavigationController

-(void) dealloc
{
    [_peddingBlocks removeAllObjects];
    [_peddingBlocks release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

-(id) init
{
    LC_SUPER_INIT({
    
        self.peddingBlocks = [NSMutableArray array];
        _transitionInProgress = NO;
        _systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        
    });
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:(BOOL)animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    [self setBarTitleTextColor:LC_UINAVIGATIONBAR_DEFAULT_TITLE_COLOR
                   shadowColor:LC_UINAVIGATIONBAR_DEFAULT_TITLE_SHADOW_COLOR];
    
    if (IOS7_OR_LATER) {
        if (LC_UINAVIGATIONBAR_DEFAULT_IMAGE_IOS7_LATER) {
            [self setBarBackgroundImage:LC_UINAVIGATIONBAR_DEFAULT_IMAGE_IOS7_LATER];
        }
    }else{
        if (LC_UINAVIGATIONBAR_DEFAULT_IMAGE_IOS7_BEFORE) {
            [self setBarBackgroundImage:LC_UINAVIGATIONBAR_DEFAULT_IMAGE_IOS7_BEFORE];
        }
    }
    
    if (IOS7_OR_LATER) {
        
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        {
            self.interactivePopGestureRecognizer.delegate = self;
            self.delegate = self;
        }
    }else{
    
    }
}

-(void) setBarTitleTextColor:(UIColor *)color shadowColor:(UIColor *)shadowColor
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
    NSMutableDictionary * dictText = [NSMutableDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName,[UIFont systemFontOfSize:(18)],NSFontAttributeName,nil];
#else
    NSMutableDictionary * dictText = [NSMutableDictionary dictionaryWithObjectsAndKeys:color,UITextAttributeTextColor,shadowColor,UITextAttributeTextShadowColor,NA_FONT(18),UITextAttributeFont,nil];
#endif
    
    [self.navigationBar setTitleTextAttributes:dictText];
}

-(void) setBarBackgroundImage:(UIImage *)image
{
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}


//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (IOS7_OR_LATER) {
//
//        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
//            self.interactivePopGestureRecognizer.enabled = NO;
//        
//    }
//    
//    if (_systemVersion >= 8.0) {
//        [super pushViewController:viewController animated:animated];
//    }
//    else {
//        
//        [self addTransitionBlock:^{
//            
//            [super pushViewController:viewController animated:animated];
//        }];
//    }
//}
//
//- (UIViewController *) popViewControllerAnimated:(BOOL)animated
//{
//    UIViewController * poppedViewController = nil;
//    
//    if (_systemVersion >= 8.0) {
//        poppedViewController = [super popViewControllerAnimated:animated];
//    }
//    else {
//        
//        LC_BLOCK_SELF;
//        
//        [self addTransitionBlock:^{
//            
//            UIViewController *viewController = [super popViewControllerAnimated:animated];
//            
//            if (viewController == nil) {
//                nRetainSelf.transitionInProgress = NO;
//            }
//        }];
//    }
//    
//    return poppedViewController;
//}
//
//-(NSArray *) popToViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    NSArray *poppedViewControllers = nil;
//    
//    if (_systemVersion >= 8.0) {
//        
//        poppedViewControllers = [super popToViewController:viewController animated:animated];
//    }
//    else {
//
//        LC_BLOCK_SELF;
//        
//        [self addTransitionBlock:^{
//            
//            if ([nRetainSelf.viewControllers containsObject:viewController]) {
//                
//                NSArray *viewControllers = [super popToViewController:viewController animated:animated];
//                
//                if (viewControllers.count == 0) {
//                    nRetainSelf.transitionInProgress = NO;
//                }
//            }
//            else {
//                nRetainSelf.transitionInProgress = NO;
//            }
//        }];
//    }
//    
//    return poppedViewControllers;
//}
//
//- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
//{
//    NSArray *poppedViewControllers = nil;
//    
//    if (_systemVersion >= 8.0) {
//        
//        poppedViewControllers = [super popToRootViewControllerAnimated:animated];
//    }
//    else {
//
//        LC_BLOCK_SELF;
//        
//        [self addTransitionBlock:^{
//            NSArray *viewControllers = [super popToRootViewControllerAnimated:animated];
//            if (viewControllers.count == 0) {
//                nRetainSelf.transitionInProgress = NO;
//            }
//        }];
//    }
//    
//    return poppedViewControllers;
//}
//
//- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated
//{
//    if (_systemVersion >= 8.0) {
//        [super setViewControllers:viewControllers animated:animated];
//    }
//    else {
//
//        LC_BLOCK_SELF;
//        
//        [self addTransitionBlock:^{
//            NSArray *originalViewControllers = nRetainSelf.viewControllers;
//
//            [super setViewControllers:viewControllers animated:animated];
//            
//            if (!animated || originalViewControllers.lastObject == viewControllers.lastObject) {
//                nRetainSelf.transitionInProgress = NO;
//            }
//        }];
//    }
//}

#pragma mark -

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if (IOS7_OR_LATER) {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
            self.interactivePopGestureRecognizer.enabled = YES;
    }

}

#pragma mark -

//- (void)addTransitionBlock:(void (^)(void))block
//{
//    if (![self isTransitionInProgress]) {
//        self.transitionInProgress = YES;
//        block();
//    }
//    else {
//        [_peddingBlocks addObject:[[block copy] autorelease]];
//    }
//}
//
//- (BOOL)isTransitionInProgress
//{
//    return _transitionInProgress;
//}
//
//- (void)setTransitionInProgress:(BOOL)transitionInProgress
//{
//    _transitionInProgress = transitionInProgress;
//    if (!transitionInProgress && _peddingBlocks.count > 0) {
//        _transitionInProgress = YES;
//        [self runNextTransition];
//    }
//}
//
//- (void)runNextTransition
//{
//    LCTransitionBlock block = _peddingBlocks.firstObject;
//    block();
//    [_peddingBlocks removeObject:block];
//}


@end
