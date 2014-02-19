//
//  LS_LOG.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-12.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import "LC_Precompile.h"

#undef	NSLog
#define	NSLog	LCLog

#undef  LC_Assert
#define LC_Assert NSAssert

//#undef  INFO
//#define INFO    LCInfo
//
//#undef  ERROR
//#define ERROR   LCError

#if __cplusplus
extern "C" {
#endif
    
	void LCLog( NSObject * format, ... );
    
//    void LCInfo( NSObject * format, ... );
//    void LCError( NSObject * format, ... );
//	  void LCLogIndent( NSUInteger tabs );
//	  void LCLogUnindent( NSUInteger tabs );
    
#if __cplusplus
};
#endif

