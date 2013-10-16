//
//  LC_SystemInfo.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-16.
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

#import "LC_SystemInfo.h"
#import "LC_Vendor.h"
#import <mach/mach.h>
#import <malloc/malloc.h>
#import <mach/mach.h>

static BOOL                 sVMStatsInit = NO;
static vm_statistics_data_t sVMStats;
static vm_size_t            sPageSize = 0;

#define RUNS_NUMBER_KEY @"LC_RUNS_NUMBER_KEY"

@implementation LC_SystemInfo

+ (NSString *)appVersion
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR || TARGET_OS_MAC)
	NSString * value = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	if ( nil == value || 0 == value.length )
	{
		value = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersion"];
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
	Class openUDID = NSClassFromString( @"OpenUDID" );
	if ( openUDID )
	{
		return [openUDID value];
	}
	else
	{
		return nil; //已弃用 [UIDevice currentDevice].uniqueIdentifier;
	}
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

+ (float)applicationCUPUsage
{
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;
    
    task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    
//    task_basic_info_t      basic_info;
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;
    
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    
    thread_basic_info_t basic_info_th;
//    uint32_t stat_thread = 0; // Mach threads
    
//    basic_info = (task_basic_info_t)tinfo;
    
    // get threads in the task
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
//    if (thread_count > 0)
//        stat_thread += thread_count;
    
    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;
    
    for (j = 0; j < thread_count; j++)
    {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return -1;
        }
        
        basic_info_th = (thread_basic_info_t)thinfo;
        
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->system_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
        }
        
    } // for each thread
    
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);
    
    return tot_cpu;
}

+ (BOOL)updateHostStatistics {
    
    if (!sVMStatsInit) {
        memset(&sVMStats, 0, sizeof(sVMStats));
        sVMStatsInit = YES;
    }
    
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    host_page_size(host_port, &sPageSize);
    return (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&sVMStats, &host_size)
            == KERN_SUCCESS);
}

+ (unsigned long long)bytesOfFreeMemory
{
    
    if (![self updateHostStatistics]) {
        return 0;
    }
    
    unsigned long long mem_free = ((unsigned long long)sVMStats.free_count
                                   * (unsigned long long)sPageSize);
    return mem_free;
}

+ (unsigned long long)bytesOfTotalMemory
{
    
//    if (![self updateHostStatistics]) {
//        return 0;
//    }
//    
//    unsigned long long mem_free = (((unsigned long long)sVMStats.free_count
//                                    + (unsigned long long)sVMStats.active_count
//                                    + (unsigned long long)sVMStats.inactive_count
//                                    + (unsigned long long)sVMStats.wire_count)
//                                   * (unsigned long long)sPageSize);
//    return mem_free;
    
    struct mstats stat = mstats();
	
	size_t _usedBytes = stat.bytes_used;
	size_t _totalBytes = NSRealMemoryAvailable();
	
	if ( 0 == _usedBytes )
	{
		mach_port_t host_port;
		mach_msg_type_number_t host_size;
		vm_size_t pagesize;
        
		host_port = mach_host_self();
		host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
		host_page_size( host_port, &pagesize );
        
		vm_statistics_data_t vm_stat;
		kern_return_t ret = host_statistics( host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size );
		if ( KERN_SUCCESS != ret )
		{
			_totalBytes = 0;
		}
		else
		{
			natural_t mem_used = (vm_stat.active_count + vm_stat.inactive_count + vm_stat.wire_count) * pagesize;
			natural_t mem_free = vm_stat.free_count * pagesize;
			natural_t mem_total = mem_used + mem_free;
            
			_totalBytes = mem_total;
		}
	}
    
    return _totalBytes;
}

+ (unsigned long long) bytesOfUsedMemory
{
//    task_basic_info_data_t taskInfo;
//    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
//    kern_return_t kernReturn = task_info(mach_task_self(),
//                                         TASK_BASIC_INFO,
//                                         (task_info_t)&taskInfo,
//                                         &infoCount);
//    
//    if (kernReturn != KERN_SUCCESS)
//    {
//        return NSNotFound;
//    }
//    
//    return taskInfo.resident_size;
    
    struct mstats stat = mstats();
	
	size_t _usedBytes = stat.bytes_used;
	//size_t _totalBytes = NSRealMemoryAvailable();
	
	if ( 0 == _usedBytes )
	{
		mach_port_t host_port;
		mach_msg_type_number_t host_size;
		vm_size_t pagesize;
        
		host_port = mach_host_self();
		host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
		host_page_size( host_port, &pagesize );
        
		vm_statistics_data_t vm_stat;
		kern_return_t ret = host_statistics( host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size );
		if ( KERN_SUCCESS != ret )
		{
			_usedBytes = 0;
			//_totalBytes = 0;
		}
		else
		{
			natural_t mem_used = (vm_stat.active_count + vm_stat.inactive_count + vm_stat.wire_count) * pagesize;
			//natural_t mem_free = vm_stat.free_count * pagesize;
			//natural_t mem_total = mem_used + mem_free;
            
			_usedBytes = mem_used;
			//_totalBytes = mem_total;
		}
	}
    
    return _usedBytes;

}


+(void) load
{
    NSNumber * number = [LC_UserDefaults objectForKey:RUNS_NUMBER_KEY];
    
    if (!number) {
        [LC_UserDefaults setObject:[NSNumber numberWithInt:0] forKey:RUNS_NUMBER_KEY];
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


@end
