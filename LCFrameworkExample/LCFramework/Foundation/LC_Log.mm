//
//  LS_LOG.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-12.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import "LC_Log.h"
#import "LC_Precompile.h"

#if defined(LC_LOG_ENABLE) && LC_LOG_ENABLE
static BOOL			__enabled = YES;
#else
static BOOL			__enabled = NO;
#endif

#if defined(LC_LOG_FRAME_WORK_INFO) && LC_LOG_FRAME_WORK_INFO
static BOOL	        __firstLine = LC_LOG_FRAME_WORK_INFO;
#endif


extern "C" NSString * NSStringFormatted( NSString * format, va_list argList )
{
	return [[[NSString alloc] initWithFormat:format arguments:argList] autorelease];
}

extern "C" void LCLog( NSObject * format, ... )
{
#if defined(LC_LOG_ENABLE) && LC_LOG_ENABLE
    
	if ( NO == __enabled || nil == format )
		return;
   
#if defined(LC_LOG_FRAME_WORK_INFO) && LC_LOG_FRAME_WORK_INFO
	if ( __firstLine )
	{
		fprintf( stderr, "    、      ＋    ＊			＊		        ＋    	\n" );
		fprintf( stderr, " ＋   	      郭历成 ( titm@tom.com )		＊				\n" );
		fprintf( stderr, "   ＊         version : %s         	＋              \n", LC_VERSION );
		fprintf( stderr, "    	      http://nsobject.me               ＊       	\n" );
		fprintf( stderr, "  、  	＊			＋		｀		＊	＋	   \n" );
		    
		__firstLine = NO;
	}
#endif
	
	va_list args;
	va_start( args, format );
	
	NSString * text = nil;
	
	if ( [format isKindOfClass:[NSString class]] ){
		text = [NSString stringWithFormat:@"LC ⥤ %@", NSStringFormatted((NSString *)format, args)];
	}
	else{
		text = [NSString stringWithFormat:@"LC ⥤ %@", [format description]];
	}
    
    va_end( args );
    
	if ( [text rangeOfString:@"\n"].length ){
		text = [text stringByReplacingOccurrencesOfString:@"\n" withString:[NSString stringWithFormat:@"\n\t\t"]];
	}
    
#if defined(LC_DEBUG_ENABLE) && LC_DEBUG_ENABLE
    
    [[LC_DebugInformationView sharedInstance] appendLogString:text];
    
#endif
    
	printf("%s",[text UTF8String]);
	printf("\n");
    
#endif
}


