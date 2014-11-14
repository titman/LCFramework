//
//  NSObject+Hud.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-30.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <Foundation/Foundation.h>

@interface NSObject (LCHud)

- (LC_UIHud *)showMessageHud:(NSString *)message;
- (LC_UIHud *)showSuccessHud:(NSString *)message;
- (LC_UIHud *)showFailureHud:(NSString *)message;
- (LC_UIHud *)showLoadingHud:(NSString *)message;
- (LC_UIHud *)showProgressHud:(NSString *)message;

@end
