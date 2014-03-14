//
//  TestImageSubTitleCell.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UITableViewCell.h"

@interface TestImageSubTitleCell : LC_UITableViewCell

-(void) setTitle:(NSString *)title
        subTitle:(NSString *)subTitle
        imageURL:(NSString *)imageURL;

@end
