//
//  LS_LOG.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-12.
//  Copyright (c) 2013年 Like Say Developer ( https://github.com/titman/LCFramework / USE IN PROJECT http://www.likesay.com ).
//  All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "LC_Log.h"
#import "LC_Precompile.h"

#if defined(LC_LOG_ENABLE) && LC_LOG_ENABLE
static BOOL			__enabled = YES;
#else
static BOOL			__enabled = NO;
#endif

#if defined(LC_LOG_SHOW_FIRST_LINE) && LC_LOG_SHOW_FIRST_LINE
static BOOL	        __firstLine = LC_LOG_SHOW_FIRST_LINE;
#endif

static NSUInteger	__indentTabs = 0;

extern "C" void LCLogIndent( NSUInteger tabs )
{
	__indentTabs += tabs;
}

extern "C" void LCLogUnindent( NSUInteger tabs )
{
	if ( __indentTabs < tabs )
	{
		__indentTabs = 0;
	}
	else
	{
		__indentTabs -= tabs;
    }
}

extern "C" NSString * NSStringFormatted( NSString * format, va_list argList )
{
	return [[[NSString alloc] initWithFormat:format arguments:argList] autorelease];
}

extern "C" void LCLog( NSObject * format, ... )
{
#if defined(LC_LOG_ENABLE) && LC_LOG_ENABLE
    
	if ( NO == __enabled || nil == format )
		return;
    
	if ( __firstLine )
	{
		fprintf( stderr, "    												\n" );
		fprintf( stderr, "    	郭历成 ( titm@tom.com )						\n" );
		fprintf( stderr, "    	version : %s         	             	    \n", LC_VERSION );
		fprintf( stderr, "    	http://www.likesay.com                    	\n" );
		fprintf( stderr, "    												\n" );
		    
		__firstLine = NO;
	}
	
	va_list args;
	va_start( args, format );
	
	NSString * text = nil;
	NSString * tabs = nil;
	
	if ( __indentTabs )
	{
		tabs = [NSMutableString string];
		
		for ( int i = 0; i < __indentTabs; ++i )
		{
			[(NSMutableString *)tabs appendString:@"\t"];
		}
	}
	else
	{
		tabs = @"";
	}
	
	if ( [format isKindOfClass:[NSString class]] )
	{
		text = [NSString stringWithFormat:@"LC ⥤ %@%@", tabs, NSStringFormatted((NSString *)format, args)];
	}
	else
	{
		text = [NSString stringWithFormat:@"LC ⥤ %@%@", tabs, [format description]];
	}
    
	if ( [text rangeOfString:@"\n"].length )
	{
		text = [text stringByReplacingOccurrencesOfString:@"\n" withString:[NSString stringWithFormat:@"\n\t\t"]];
	}
    
#if defined(LC_DEBUG_ENABLE) && LC_DEBUG_ENABLE
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LC_DEBUG_LOG_PRINT_TO_DEBUG_VIEW_NOTIFICATION object:text];
    
#endif
    
	fprintf( stderr, [text UTF8String], NULL );
	fprintf( stderr, "\n", NULL );
    
	va_end( args );
	
#endif
}


