//
//  LC_Keychain.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-17.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_Keychain.h"

@implementation LC_Keychain

+ (BOOL)setObject:(id)object forKey:(id)key
{
    NSString * service = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleIdentifierKey];
    
    //generate query
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    if ([service length]) query[( NSString *)kSecAttrService] = service;
    query[( NSString *)kSecClass] = ( id)kSecClassGenericPassword;
    query[( NSString *)kSecAttrAccount] = [key description];
    
    
    //encode object
    NSData *data = nil;
    NSError *error = nil;
    if ([(id)object isKindOfClass:[NSString class]])
    {
        //check that string data does not represent a binary plist
        NSPropertyListFormat format = NSPropertyListBinaryFormat_v1_0;
        if (![object hasPrefix:@"bplist"] || ![NSPropertyListSerialization propertyListWithData:[object dataUsingEncoding:NSUTF8StringEncoding]
                                                                                        options:NSPropertyListImmutable
                                                                                         format:&format
                                                                                          error:NULL])
        {
            //safe to encode as a string
            data = [object dataUsingEncoding:NSUTF8StringEncoding];
        }
    }
    
    //if not encoded as a string, encode as plist
    if (object && !data)
    {
        data = [NSPropertyListSerialization dataWithPropertyList:object
                                                          format:NSPropertyListBinaryFormat_v1_0
                                                         options:0
                                                           error:&error];
        //property list encoding failed. try NSCoding
        if (!data)
        {
            data = [NSKeyedArchiver archivedDataWithRootObject:object];
        }
        
    }
    
    //fail if object is invalid
    NSAssert(!object || (object && data), @"LC_Keychain failed to encode object for key '%@', error: %@", key, error);
    
    if (data)
    {
        //update values
        NSMutableDictionary * update = [[@{(NSString *)kSecValueData: data} mutableCopy] autorelease];
        
        update[(__bridge NSString *)kSecAttrAccessible] = @[(id)kSecAttrAccessibleWhenUnlocked,
                                                            (id)kSecAttrAccessibleAfterFirstUnlock,
                                                            (id)kSecAttrAccessibleAlways,
                                                            (id)kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
                                                            (id)kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly,
                                                            (id)kSecAttrAccessibleAlwaysThisDeviceOnly][0];
        
        //write data
		OSStatus status = errSecSuccess;
		if ([LC_Keychain dataForKey:key])
        {
			//there's already existing data for this key, update it
			status = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)update);
		}
        else
        {
			//no existing data, add a new item
            [query addEntriesFromDictionary:update];
			status = SecItemAdd ((__bridge CFDictionaryRef)query, NULL);
		}
        if (status != errSecSuccess)
        {
            ERROR(@"LC_Keychain failed to store data for key '%@', error: %ld", key, (long)status);
            return NO;
        }
    }
    else
    {
        //delete existing data
        
        OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);
        if (status != errSecSuccess)
        {
            ERROR(@"LC_Keychain failed to delete data for key '%@', error: %ld", key, (long)status);
            return NO;
        }
    }
    return YES;
}


+ (NSData *)dataForKey:(id)key
{
    NSString * service = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleIdentifierKey];
    
	//generate query
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    if ([service length]) query[(NSString *)kSecAttrService] = service;
    query[(__bridge NSString *)kSecClass] = (__bridge id)kSecClassGenericPassword;
    query[(__bridge NSString *)kSecMatchLimit] = (__bridge id)kSecMatchLimitOne;
    query[(__bridge NSString *)kSecReturnData] = (__bridge id)kCFBooleanTrue;
    query[(__bridge NSString *)kSecAttrAccount] = [key description];
    
    //recover data
    CFDataRef data = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&data);
	if (status != errSecSuccess && status != errSecItemNotFound)
    {
		ERROR(@"LC_Keychain failed to retrieve data for key '%@', error: %ld", key, (long)status);
	}
	return CFBridgingRelease(data);
}

+ (id)objectForKey:(id)key
{
    NSData * data = [LC_Keychain dataForKey:key];
    
    if (data)
    {
        id object = nil;
        NSError *error = nil;
        NSPropertyListFormat format = NSPropertyListBinaryFormat_v1_0;
        
        //check if data is a binary plist
        if ([data length] >= 6 && !strncmp("bplist", data.bytes, 6))
        {
            //attempt to decode as a plist
            object = [NSPropertyListSerialization propertyListWithData:data
                                                               options:NSPropertyListImmutable
                                                                format:&format
                                                                 error:&error];
            
            if ([object respondsToSelector:@selector(objectForKey:)] && object[@"$archiver"])
            {
                //parse as archive
                object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            }
        }
        if (!object || format != NSPropertyListBinaryFormat_v1_0)
        {
            //may be a string
            object = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
        }
        if (!object)
        {
            ERROR(@"LC_Keychain failed to decode data for key '%@', error: %@", key, error);
        }
        return object;
    }
    else
    {
        //no value found
        return nil;
    }
}

+ (BOOL)removeObjectForKey:(id)key
{
    return [LC_Keychain setObject:nil forKey:key];
}

@end
