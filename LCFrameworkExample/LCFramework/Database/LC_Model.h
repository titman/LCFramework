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


@interface LC_Model : MTLModel

/*
 
      Thanks for MTLModel.
 
 */

///** 序列化 */
//@property(nonatomic,readonly) LCModelArchiverBlock SERIALIZE;
//
///** 序列化并保存至文件 */
//@property(nonatomic,readonly) LCModelArchiverSaveBlock SERIALIZE_SAVE;
//
///** 反序列化 */
//+(instancetype) deserializeWithPath:(NSString *)archiverPath;
//+(instancetype) deserializeWithData:(NSData *)archiverData;

@end
