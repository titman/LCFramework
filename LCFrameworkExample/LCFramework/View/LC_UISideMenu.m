//
//  LC_UISideMenu.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-14.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UISideMenu.h"


#pragma mark -


@implementation LC_UISideMenuItem

-(void) dealloc
{
    self.action = nil;
    
    LC_RELEASE(_image);
    LC_RELEASE(_highlightedImage);
    LC_RELEASE(_title);
    
    LC_SUPER_DEALLOC();
}

- (id)initWithTitle:(NSString *)title action:(LCUISideItemActionBlock) action
{
    return [self initWithTitle:title image:nil highlightedImage:nil action:action];
}

- (id)initWithTitle:(NSString *)title image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage action:(LCUISideItemActionBlock) action
{
    self = [super init];
    if (!self)
        return nil;
    
    self.title = title;
    self.action = action;
    self.image = image;
    self.highlightedImage = highlightedImage;
    
    return self;
}


@end


#pragma mark -

@interface LC_UISideMenu () <UITableViewDataSource,UITableViewDelegate>
{
    float _initialX;
}

@property(nonatomic,assign) LC_UIImageView * screenshotView;
@property(nonatomic,assign) CGSize screenshotOriginalSize;
@property(nonatomic,assign) LC_UITableView * tableView;

@end


@implementation LC_UISideMenu


-(void) dealloc
{
    LC_RELEASE(_items);
    LC_RELEASE(_font);
    LC_RELEASE(_textColor);
    LC_RELEASE(_highlightedTextColor);
    
    LC_SUPER_DEALLOC();
}


- (id)initWithItems:(NSArray *)items
{
    self = [self initWithFrame:LC_RECT_CREATE(0, 0, LC_KEYWINDOW.viewFrameWidth, LC_KEYWINDOW.viewFrameHeight)];
    if (!self)
        return nil;
    
    self.items = items;
    
    self.verticalOffset = 100;
    self.horizontalOffset = 50;
    self.itemHeight = 50;
    self.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:22];
    self.textColor = [UIColor whiteColor];
    self.highlightedTextColor = [UIColor lightGrayColor];
    
    [self setupUI];
    
    return self;
}


-(void) setupUI
{
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_background.png" useCache:YES]];
    self.userInteractionEnabled = YES;
    
    _screenshotView = [[LC_UIImageView alloc] initWithFrame:CGRectZero];
    self.screenshotView.image = [UIImage screenshotsKeyWindowWithStatusBar:YES];
    self.screenshotView.frame = CGRectMake(0, 0, self.viewFrameWidth, self.viewFrameHeight);
    self.screenshotView.userInteractionEnabled = YES;
    
    self.screenshotOriginalSize = self.screenshotView.frame.size;
    
    _tableView = [[LC_UITableView alloc] initWithFrame:CGRectMake(self.horizontalOffset, 0, self.viewFrameWidth-self.horizontalOffset, self.viewFrameHeight)];
    self.tableView.tableHeaderView = LC_AUTORELEASE([[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewFrameWidth, self.verticalOffset)]);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.alpha = 0;
    
    [self addSubview:_tableView];
    [self addSubview:_screenshotView];
    
    LC_RELEASE(_tableView);
    LC_RELEASE(_screenshotView);
    
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
    [self.screenshotView addGestureRecognizer:tapGestureRecognizer];
    LC_RELEASE(tapGestureRecognizer);
}

- (void)show
{
    if (_isShowing)
        return;
    
    _isShowing = YES;
    
    BOOL init = NO;
    
    for (UIView * view in LC_KEYWINDOW.subviews) {
        if (view == self) {
            init = YES;
            break;
        }
    }
    
    if (init == NO) {
        [LC_KEYWINDOW addSubview:self];
    }
    
    _screenshotView.userInteractionEnabled = YES;
    self.screenshotView.image = [UIImage screenshotsKeyWindowWithStatusBar:YES];

    [self screenshotViewToMinimize];
    
    self.alpha = 1;
}

- (void)hide
{
    if (!_isShowing)
        return;
    
    _isShowing = NO;
    
    _screenshotView.userInteractionEnabled = NO;
    
    [self screenshotViewRestore];
}

- (void)setRootViewController:(UIViewController *)viewController
{
    ;
}

- (void) screenshotViewToMinimize
{
    
    LC_FAST_ANIMATIONS(0.35, ^{
    
        self.screenshotView.transform = CGAffineTransformScale(self.screenshotView.transform, 0.5, 0.5);
        self.screenshotView.center = LC_POINT_CREATE(LC_DEVICE_WIDTH, self.center.y);
        self.screenshotView.alpha = 1;
    
    });
    
    if (_tableView.alpha == 0) {
        
        self.tableView.transform = CGAffineTransformScale(_tableView.transform, 0.9, 0.9);
        
        LC_FAST_ANIMATIONS(0.5,^{
        
            self.tableView.transform = CGAffineTransformIdentity;
        
        });
        
        LC_FAST_ANIMATIONS(0.6,^{
            
            self.tableView.alpha = 1;
            
        });

    }
}

-(void) screenshotViewRestore
{
    LC_FAST_ANIMATIONS(0.2, ^{
    
        self.tableView.alpha = 0;
        self.tableView.transform = CGAffineTransformScale(_tableView.transform, 0.7, 0.7);
    
    });
    
    LC_FAST_ANIMATIONS_F(0.3, ^{
    
        self.screenshotView.transform = CGAffineTransformScale(self.screenshotView.transform, 2, 2);
        self.screenshotView.center = self.center;
    
    }, ^(BOOL finished){
    
        self.alpha = 0;
        
    });
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(LC_UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(LC_UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (CGFloat)tableView:(LC_UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.itemHeight;
}

- (LC_UITableViewCell *)tableView:(LC_UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LC_UITableViewCell * cell = [tableView autoCreateDequeueReusableCellWithIdentifier:@"cell"
                                                                              andClass:[LC_UITableViewCell class]
                                                                     configurationCell:^(LC_UITableViewCell * configCell){
                                                                              
                                                                                  configCell.backgroundColor = [UIColor clearColor];
                                                                                  configCell.selectedBackgroundView = LC_AUTORELEASE([[UIView alloc] init]);
                                                                                  configCell.textLabel.font = self.font;
                                                                                  configCell.textLabel.textColor = self.textColor;
                                                                                  configCell.textLabel.highlightedTextColor = self.highlightedTextColor;
                                                                              
                                                                              }];
    
    
    LC_UISideMenuItem * item = [_items objectAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    cell.imageView.image = item.image;
    cell.imageView.highlightedImage = item.highlightedImage;
    
    return cell;
}

- (void)tableView:(LC_UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LC_UISideMenuItem * item = [_items objectAtIndex:indexPath.row];
    item.action(self,item);
}


- (void)tapGestureRecognized:(UITapGestureRecognizer *)sender
{
    [self hide];
}



@end
