//
//  LC_UINavigationController.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-17.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UINavigationController.h"

#pragma mark -

@interface LC_UINavigationController () <UIGestureRecognizerDelegate>
{
    CGPoint startTouch;
    CGFloat startBackViewX;
    UIImageView * lastScreenShotView;
    UIView * blackMask;
    
}

@property (nonatomic,retain) UIView * backgroundView;
@property (nonatomic,retain) NSMutableArray * screenShotsList;

@end

#pragma mark -

@implementation LC_UINavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.screenShotsList = [[[NSMutableArray alloc] initWithCapacity:2] autorelease];
        self.canDragBack = NO;
        
    }
    return self;
}

- (void)dealloc
{
    self.screenShotsList = nil;
    
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    
    [super dealloc];
}

-(id) init
{
    LC_SUPER_INIT({
    
        ;
        
    });
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:(BOOL)animated];
    
    if (self.screenShotsList.count == 0) {
        
        UIImage * capturedImage = [self capture];
        
        if (capturedImage) {
            [self.screenShotsList addObject:capturedImage];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setBarTitleTextColor:LC_UINAVIGATIONBAR_DEFAULT_TITLE_COLOR
                   shadowColor:LC_UINAVIGATIONBAR_DEFAULT_TITLE_SHADOW_COLOR];
    
    if (IOS7_OR_LATER) {
        [self setBarBackgroundImage:LC_UINAVIGATIONBAR_DEFAULT_IMAGE_IOS7_LATER];
    }else{
        [self setBarBackgroundImage:LC_UINAVIGATIONBAR_DEFAULT_IMAGE_IOS7_BEFORE];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIPanGestureRecognizer * recognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(paningGestureReceive:)] autorelease];
    recognizer.delegate = self;
    [recognizer delaysTouchesBegan];
    [self.view addGestureRecognizer:recognizer];    
}

-(void) setBarTitleTextColor:(UIColor *)color shadowColor:(UIColor *)shadowColor
{    
    NSMutableDictionary * dictText = [NSMutableDictionary dictionaryWithObjectsAndKeys:color,UITextAttributeTextColor,shadowColor,UITextAttributeTextShadowColor,nil];
    [self.navigationBar setTitleTextAttributes:dictText];
}

-(void) setBarBackgroundImage:(UIImage *)image
{
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIImage * capturedImage = [self capture];
    
    if (capturedImage) {
        [self.screenShotsList addObject:capturedImage];
    }
    
    if (self.tabBarController && [self.tabBarController isKindOfClass:[LC_UITabBarController class]]) {
                
        if (viewController.hidesBottomBarWhenPushed) {
            LC_UITabBarController * tabbar = (LC_UITabBarController *) self.tabBarController;
            [tabbar hideBar:YES animation:animated];
        }
    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.screenShotsList.count) {
        [self.screenShotsList removeLastObject];
    }
    
    UIViewController * popViewController = [super popViewControllerAnimated:animated];
    
    if (self.tabBarController && [self.tabBarController isKindOfClass:[LC_UITabBarController class]]) {
        
        LC_UITabBarController * tabbar = (LC_UITabBarController *)self.tabBarController;
        
        if (self.viewControllers.count == 1) {
            UIViewController * vc = self.viewControllers[0];
            if (vc.hidesBottomBarWhenPushed == NO) {
                [tabbar hideBar:NO animation:animated];
                return popViewController;
            }
        }
        
        BOOL willHidden = NO;
        
        for (int i = 0; i< self.viewControllers.count; i++) {
            
            UIViewController * vc = [self.viewControllers objectAtIndex:i];
            
            if (vc.hidesBottomBarWhenPushed == YES) {
                willHidden = YES;
                break;
            }else{
                willHidden = NO;
            }
        }
        
        [tabbar hideBar:willHidden animation:animated];

    }

    return popViewController;
}

-(NSArray *) popToRootViewControllerAnimated:(BOOL)animated
{
    if (self.screenShotsList.count) {
        [self.screenShotsList removeAllObjects];
    }
    
    if (self.tabBarController && [self.tabBarController isKindOfClass:[LC_UITabBarController class]]) {
        
        LC_UITabBarController * tabbar = (LC_UITabBarController *)self.tabBarController;
        
        if (self.viewControllers.count) {
            
            UIViewController * vc = [self.viewControllers objectAtIndex:0];
            
            if (vc.hidesBottomBarWhenPushed == NO) {
                [tabbar hideBar:NO animation:animated];
            }

        }
    }
    
    return [super popToRootViewControllerAnimated:animated];
}

#pragma mark -

- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(LC_KEYWINDOW.bounds.size, LC_KEYWINDOW.opaque, 0.0);
    [LC_KEYWINDOW.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (void)moveViewWithX:(float)x
{

    x = x>320?320:x;
    x = x<0?0:x;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    
    float alpha = 0.4 - (x/800);
    
    blackMask.alpha = alpha;
    
    CGFloat aa = abs(startBackViewX)/320.f;
    CGFloat y = x*aa;
    
    UIImage *lastScreenShot = [self.screenShotsList lastObject];
    CGFloat lastScreenShotViewHeight = lastScreenShot.size.height;
    CGFloat superviewHeight = lastScreenShotView.superview.frame.size.height;
    CGFloat verticalPos = superviewHeight - lastScreenShotViewHeight;
    
    [lastScreenShotView setFrame:CGRectMake(startBackViewX+y,
                                            verticalPos,
                                            320.f,
                                            lastScreenShotViewHeight)];

    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (self.viewControllers.count <= 1 || !self.canDragBack) return NO;
    
    return YES;
}

-(BOOL)isBlurryImg:(CGFloat)tmp
{
    return YES;
}

#pragma mark -

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
    if (self.viewControllers.count <= 1 || !self.canDragBack) return;
    
    CGPoint touchPoint = [recoginzer locationInView:LC_KEYWINDOW];
    
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        
        _isMoving = YES;
        startTouch = touchPoint;
        
        if (!self.backgroundView)
        {
            CGRect frame = self.view.frame;
            
            self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];
            
            blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            blackMask.backgroundColor = [UIColor blackColor];
            [self.backgroundView addSubview:blackMask];
        }
        
        self.backgroundView.hidden = NO;
        
        if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
        
        
        UIImage *lastScreenShot = [self.screenShotsList lastObject];
        
        lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
        
        startBackViewX = -200;
        [lastScreenShotView setFrame:CGRectMake(startBackViewX,
                                                lastScreenShotView.frame.origin.y,
                                                lastScreenShotView.frame.size.height,
                                                lastScreenShotView.frame.size.width)];
        
        [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
        
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if (touchPoint.x - startTouch.x > 50)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:320];
            } completion:^(BOOL finished) {
                
                [self popViewControllerAnimated:NO];
                CGRect frame = self.view.frame;
                frame.origin.x = 0;
                self.view.frame = frame;
                
                _isMoving = NO;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                self.backgroundView.hidden = YES;
            }];
            
        }
        return;
        
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            self.backgroundView.hidden = YES;
        }];
        
        return;
    }
    
    if (_isMoving) {
        [self moveViewWithX:touchPoint.x - startTouch.x];
    }}

- (void)setLayer3D:(CALayer *)layer YRotation:(CGFloat)degrees anchorPoint:(CGPoint)point perspectiveCoeficient:(CGFloat)m34
{    
	CATransform3D transfrom = CATransform3DIdentity;
	transfrom.m34 = 1.0 / m34;
    CGFloat radiants = degrees / 360.0 * 2 * M_PI;
	transfrom = CATransform3DRotate(transfrom, radiants, 0.0f, 1.0f, 0.0f);
	layer.anchorPoint = point;
	layer.transform = transfrom;
}

@end
