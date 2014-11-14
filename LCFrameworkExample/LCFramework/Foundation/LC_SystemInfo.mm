//
//  LC_SystemInfo.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_SystemInfo.h"
#import "LC_Vendor.h"
#import <mach/mach.h>
#import <malloc/malloc.h>
#import <mach/mach.h>
#import <sys/utsname.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

#define RUNS_NUMBER_KEY @"LC_RUNS_NUMBER_KEY"

@implementation LC_SystemInfo

+(void) load
{
    NSNumber * number = [LC_UserDefaults objectForKey:RUNS_NUMBER_KEY];
    
    if (!number) {
        [LC_UserDefaults setObject:[NSNumber numberWithInt:1] forKey:RUNS_NUMBER_KEY];
    }else{
        [LC_UserDefaults setObject:[NSNumber numberWithInt:([number intValue] + 1)] forKey:RUNS_NUMBER_KEY];
    }
}

+ (int) applicationRunsNumber
{
    NSNumber * number = [LC_UserDefaults objectForKey:RUNS_NUMBER_KEY];
    
    if (!number) {
        return 0;
    }else{
        return [number intValue];
    }
}

+ (NSString *)appVersion
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR || TARGET_OS_MAC)
	NSString * value = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersion"];
	if ( nil == value || 0 == value.length )
	{
		value = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	}
	return value;
#else
	return nil;
#endif
}

+ (NSString *)appIdentifier
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	static NSString * __identifier = nil;
	if ( nil == __identifier )
	{
		__identifier = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] retain];
	}
	return __identifier;
#else
	return @"";
#endif
}

+ (NSString *)deviceModel
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	return [UIDevice currentDevice].model;
#else
	return nil;
#endif
}

+ (NSString *)deviceUUID
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR || TARGET_OS_MAC)
    
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
//        
//        return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//    }
//    else{
    
        Class openUDID = NSClassFromString( @"LC_UDID" );
        
        if ( openUDID )
        {
            return [openUDID UDID];
        }
        else
        {
            return nil; //已弃用 [UIDevice currentDevice].uniqueIdentifier;
        }
//    }
    

#else
	return nil;
#endif
}

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
static const char * __jb_app = NULL;
#endif

+ (BOOL)isJailBroken NS_AVAILABLE_IOS(4_0)
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	static const char * __jb_apps[] =
	{
		"/Application/Cydia.app",
		"/Application/limera1n.app",
		"/Application/greenpois0n.app",
		"/Application/blackra1n.app",
		"/Application/blacksn0w.app",
		"/Application/redsn0w.app",
		NULL
	};
    
	__jb_app = NULL;
    
	// method 1
    for ( int i = 0; __jb_apps[i]; ++i )
    {
        if ( [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:__jb_apps[i]]] )
        {
			__jb_app = __jb_apps[i];
			return YES;
        }
    }
	
    // method 2
	if ( [[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/apt/"] )
	{
		return YES;
	}
	
	// method 3
	if ( 0 == system("ls") )
	{
		return YES;
	}
    
    // method 4
    FILE *f = fopen("/bin/bash", "r");

    if (f != NULL)
    {
        // Device is jailbroken
        fclose(f);
        return YES;
    }
    
    fclose(f);
    
#endif
	
    return NO;
}

+ (NSString *)jailBreaker NS_AVAILABLE_IOS(4_0)
{
#if (TARGET_OS_IPHONE)
	if ( __jb_app )
	{
		return [NSString stringWithUTF8String:__jb_app];
	}
#endif
    
	return @"";
}

+ (BOOL)isDevicePhone
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	NSString * deviceType = [UIDevice currentDevice].model;
	
	if ( [deviceType rangeOfString:@"iPhone" options:NSCaseInsensitiveSearch].length > 0 ||
		[deviceType rangeOfString:@"iPod" options:NSCaseInsensitiveSearch].length > 0 ||
		[deviceType rangeOfString:@"iTouch" options:NSCaseInsensitiveSearch].length > 0 )
	{
		return YES;
	}
#endif
	
	return NO;
}

+ (BOOL)isDevicePad
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	NSString * deviceType = [UIDevice currentDevice].model;
	
	if ( [deviceType rangeOfString:@"iPad" options:NSCaseInsensitiveSearch].length > 0 )
	{
		return YES;
	}
#endif
	
	return NO;
}

+ (BOOL)isPhone35
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	return [LC_SystemInfo isScreenSize:CGSizeMake(320, 480)];
#else
	return NO;
#endif
}

+ (BOOL)isPhoneRetina35
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	return [LC_SystemInfo isScreenSize:CGSizeMake(640, 960)];
#else
	return NO;
#endif
}

+ (BOOL)isPhoneRetina4
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	return [LC_SystemInfo isScreenSize:CGSizeMake(640, 1136)];
#else
	return NO;
#endif
}

+ (BOOL)isPad
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	return [LC_SystemInfo isScreenSize:CGSizeMake(768, 1024)];
#else
	return NO;
#endif
}

+ (BOOL)isPadRetina
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	return [LC_SystemInfo isScreenSize:CGSizeMake(1536, 2048)];
#else
	return NO;
#endif
}

+ (BOOL)isScreenSize:(CGSize)size
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	if ( [UIScreen instancesRespondToSelector:@selector(currentMode)] )
	{
		CGSize screenSize = [UIScreen mainScreen].currentMode.size;
		CGSize size2 = CGSizeMake( size.height, size.width );
        
		if ( CGSizeEqualToSize(size, screenSize) || CGSizeEqualToSize(size2, screenSize) )
		{
			return YES;
		}
	}
	
	return NO;
#else
	return NO;
#endif
}

+ (void)simulateLowMemoryWarning
{    
    SEL memoryWarningSel =  NSSelectorFromString(@"_performMemoryWarning");
    if ([[UIApplication sharedApplication] respondsToSelector:memoryWarningSel]) {
        NSLog(@"!!! Simulate low memory warning !!!");
        // Supress the warning. -Wundeclared-selector was used while ARC is enabled.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [[UIApplication sharedApplication] performSelector:memoryWarningSel];
#pragma clang diagnostic pop
    } else {
        // UIApplication no loger responds to _performMemoryWarning
        exit(1);
    }
}

+ (NSString *)deviceName
{
    NSString * name = [[UIDevice currentDevice] name];
    
    if (LC_NSSTRING_IS_INVALID(name)) {
        return @"";
    }
    
    return name;
}

+ (NSString *) platformType
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *result = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString *type;
    
    if ([result isEqualToString:@"i386"])           type = @"Simulator";
    else if ([result isEqualToString:@"iPod3,1"])        type = @"iPod Touch 3";
    else if ([result isEqualToString:@"iPod4,1"])        type = @"iPod Touch 4";
    else if ([result isEqualToString:@"iPod5,1"])        type = @"iPod Touch 5";
    else if ([result isEqualToString:@"iPhone2,1"])      type = @"iPhone 3Gs";
    else if ([result isEqualToString:@"iPhone3,1"])      type = @"iPhone 4";
    else if ([result isEqualToString:@"iPhone4,1"])      type = @"iPhone 4s";
    else if ([result isEqualToString:@"iPhone5,1"]   ||
        [result isEqualToString:@"iPhone5,2"])      type = @"iPhone 5";
    else if ([result isEqualToString:@"iPad2,1"]     ||
        [result isEqualToString:@"iPad2,2"]     ||
        [result isEqualToString:@"iPad2,3"])        type = @"iPad 2";
    else if ([result isEqualToString:@"iPad3,1"]     ||
        [result isEqualToString:@"iPad3,2"]     ||
        [result isEqualToString:@"iPad3,3"])        type = @"iPad 3";
    else if ([result isEqualToString:@"iPad3,4"]     ||
        [result isEqualToString:@"iPad3,5"]     ||
        [result isEqualToString:@"iPad3,6"])         type = @"iPad 4";
    else if ([result isEqualToString:@"iPad2,5"]     ||
        [result isEqualToString:@"iPad2,6"]     ||
        [result isEqualToString:@"iPad2,7"])        type = @"iPad Mini";
    else if ([result isEqualToString:@"iPhone6,1"]   ||
        [result isEqualToString:@"iPhone6,2"])      type = @"iPhone 5s";
    else if ([result isEqualToString:@"iPhone5,3"]   ||
        [result isEqualToString:@"iPhone5,4"])      type = @"iPhone 5c";
    else type = @"未知设备";
    return type;
}

+ (NSString *) systemVersion
{
    NSString * device = [[UIDevice currentDevice] systemVersion];
    
    if (LC_NSSTRING_IS_INVALID(device)) {
        return @"";
    }
    
    return device;
}

+ (NSString *)currentIPAddress
{
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    NSString *wifiAddress = nil;
    NSString *cellAddress = nil;
    
    // retrieve the current interfaces - returns 0 on success
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            sa_family_t sa_type = temp_addr->ifa_addr->sa_family;
            if(sa_type == AF_INET || sa_type == AF_INET6) {
                NSString *name = [NSString stringWithUTF8String:temp_addr->ifa_name];
                NSString *addr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]; // pdp_ip0
                //NSLog(@"NAME: \"%@\" addr: %@", name, addr); // see for yourself
                
                if([name isEqualToString:@"en0"])
                    // Interface is the wifi connection on the iPhone
                    wifiAddress = addr;
                else
                    if([name isEqualToString:@"pdp_ip0"])
                        // Interface is the cell connection on the iPhone
                        cellAddress = addr;
                
            }
            temp_addr = temp_addr->ifa_next;
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    NSString *addr = wifiAddress ? wifiAddress : cellAddress;
    return addr ? addr : @"0.0.0.0";
}

+ (NSString *) cellIPAddress
{
    // Set a string for the address
    NSString * IPAddress = nil;
    // Set up structs to hold the interfaces and the temporary address
    struct ifaddrs *Interfaces;
    struct ifaddrs *Temp;
    struct sockaddr_in *s4;
    char buf[64];
    
    // If it's 0, then it's good
    if (!getifaddrs(&Interfaces))
    {
        // Loop through the list of interfaces
        Temp = Interfaces;
        
        // Run through it while it's still available
        while(Temp != NULL)
        {
            // If the temp interface is a valid interface
            if(Temp->ifa_addr->sa_family == AF_INET)
            {
                // Check if the interface is Cell
                if([[NSString stringWithUTF8String:Temp->ifa_name] isEqualToString:@"pdp_ip0"])
                {
                    s4 = (struct sockaddr_in *)Temp->ifa_addr;
                    
                    if (inet_ntop(Temp->ifa_addr->sa_family, (void *)&(s4->sin_addr), buf, sizeof(buf)) == NULL) {
                        // Failed to find it
                        IPAddress = nil;
                    } else {
                        // Got the Cell IP Address
                        IPAddress = [NSString stringWithUTF8String:buf];
                    }
                }
            }
            
            // Set the temp value to the next interface
            Temp = Temp->ifa_next;
        }
    }
    
    // Free the memory of the interfaces
    freeifaddrs(Interfaces);
    
    // Check to make sure it's not empty
    if (IPAddress == nil || IPAddress.length <= 0) {
        // Empty, return not found
        return nil;
    }
    
    // Return the IP Address of the WiFi
    return IPAddress;
}


+(NSDictionary *) deviceDetailInfo
{
    NSString *device = [LC_SystemInfo platformType];
    NSDictionary *info = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[device stringByReplacingOccurrencesOfString:@" " withString:@""] ofType:@"plist"]];
    return [info autorelease];
}


+ (CGFloat) cpuUsage
{
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;
    
    task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS)
        return -1;
    
    task_basic_info_t      basic_info;
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    thread_basic_info_t basic_info_th;
    uint32_t stat_thread = 0; // Mach threads
    
    basic_info = (task_basic_info_t)tinfo;
#pragma unused(basic_info)

    // get threads in the task
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS)
        return -1;
    if (thread_count > 0)
        stat_thread += thread_count;
#pragma unused(stat_thread)

    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;
    
    for (j = 0; j < thread_count; j++) {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS)
            return -1;
        
        basic_info_th = (thread_basic_info_t)thinfo;
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->system_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE;
        }
        
    } // for each thread
    
    return tot_cpu;
}


+ (NSInteger)totalMemory
{
    int nearest = 256;
    int totalMemory = [[NSProcessInfo processInfo] physicalMemory] / 1024.f / 1024.f;
    int rem = (int)totalMemory % nearest;
    int tot = 0;
    if (rem >= nearest/2) {
        tot = ((int)totalMemory - rem)+256;
    } else {
        tot = ((int)totalMemory - rem);
    }
    
    return tot;
}

+ (CGFloat)freeMemory
{
    double totalMemory = 0.00;
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if(kernReturn != KERN_SUCCESS) {
        return -1;
    }
    totalMemory = ((vm_page_size * vmStats.free_count) / 1024) / 1024;
    
    return totalMemory;
}

+ (CGFloat)usedMemory
{
    double usedMemory = 0.00;
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if(kernReturn != KERN_SUCCESS) {
        return -1;
    }
    usedMemory = ((vm_page_size * (vmStats.active_count + vmStats.inactive_count + vmStats.wire_count)) / 1024) / 1024;
    
    return usedMemory;
}

#define MB (1024*1024)
#define GB (MB*1024)

+ (NSString *)memoryFormatter:(long long)diskSpace
{
    NSString *formatted;
    double bytes = 1.0 * diskSpace;
    double megabytes = bytes / MB;
    double gigabytes = bytes / GB;
    if (gigabytes >= 1.0)
        formatted = [NSString stringWithFormat:@"%.2f GB", gigabytes];
    else if (megabytes >= 1.0)
        formatted = [NSString stringWithFormat:@"%.2f MB", megabytes];
    else
        formatted = [NSString stringWithFormat:@"%.2f bytes", bytes];
    
    return formatted;
}

+ (NSString *)totalDiskSpace
{
    long long space = [[[[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil] objectForKey:NSFileSystemSize] longLongValue];
    return [LC_SystemInfo memoryFormatter:space];
}

+ (NSString *)freeDiskSpace
{
    long long freeSpace = [[[[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil] objectForKey:NSFileSystemFreeSize] longLongValue];
    return [LC_SystemInfo memoryFormatter:freeSpace];
}

+ (NSString *)usedDiskSpace
{
    return [LC_SystemInfo memoryFormatter:[LC_SystemInfo usedDiskSpaceInBytes]];
}

+ (CGFloat)totalDiskSpaceInBytes
{
    long long space = [[[[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil] objectForKey:NSFileSystemSize] longLongValue];
    return space;
}

+ (CGFloat)freeDiskSpaceInBytes
{
    long long freeSpace = [[[[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil] objectForKey:NSFileSystemFreeSize] longLongValue];
    return freeSpace;
}

+ (CGFloat)usedDiskSpaceInBytes
{
    long long usedSpace = [LC_SystemInfo totalDiskSpaceInBytes] - [LC_SystemInfo freeDiskSpaceInBytes];
    return usedSpace;
}


@end
