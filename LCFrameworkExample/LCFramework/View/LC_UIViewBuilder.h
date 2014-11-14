//
//  LC_UIViewBuilder.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <Foundation/Foundation.h>

//LCUIQueryBlock __getQueryBlock( id object , id tagString );

//#define $(string) __getQueryBlock( self, string ));

@interface LC_UIViewBuilder : NSObject

@property(nonatomic,readonly) UIView * view;

@end
