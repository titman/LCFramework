//
//  LC_Model.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

@class LC_Model;

typedef NSData *   (^LCModelArchiverBlock)();
typedef LC_Model * (^LCModelArchiverSaveBlock)( NSString * path );


@interface LC_Model : NSObject
{
    LC_HTTPInterface * _modelInterface;
    NSMutableArray * _observers;
}

@property Class interfaceClass;
@property (nonatomic,readonly)  LC_HTTPInterface * modelInterface;
@property (nonatomic, readonly) NSMutableArray * observers;

- (void)addObserver:(id)obj;

@end
