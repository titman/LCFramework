//
//  NSData+LCExtension.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "NSData+LCExtension.h"

@implementation NSData (LCExtension)

@dynamic MD5;
@dynamic MD5String;

- (NSData *)MD5
{
	unsigned char	md5Result[CC_MD5_DIGEST_LENGTH + 1];
	CC_LONG			md5Length = (CC_LONG)[self length];
	
	CC_MD5( [self bytes], md5Length, md5Result );
	
	
	NSMutableData * retData = [[[NSMutableData alloc] init] autorelease];
	if ( nil == retData )
		return nil;
	
	[retData appendBytes:md5Result length:CC_MD5_DIGEST_LENGTH];
	return retData;
}

- (NSString *)MD5String
{
	NSData * value = [self MD5];
	if ( value )
	{
		char			tmp[16];
		unsigned char *	hex = (unsigned char *)malloc( 2048 + 1 );
		unsigned char *	bytes = (unsigned char *)[value bytes];
		unsigned long	length = [value length];
		
		hex[0] = '\0';
		
		for ( unsigned long i = 0; i < length; ++i )
		{
			sprintf( tmp, "%02X", bytes[i] );
			strcat( (char *)hex, tmp );
		}
		
		NSString * result = [NSString stringWithUTF8String:(const char *)hex];
		free( hex );
		return result;
	}
	else
	{
		return nil;
	}
}


@end
