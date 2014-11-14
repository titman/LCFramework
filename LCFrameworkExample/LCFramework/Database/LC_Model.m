//
//  LC_Model.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_Model.h"

@implementation LC_Model

//-(id) initWithCoder:(NSCoder *)aDecoder
//{
//    LC_SUPER_INIT({
//
//        unsigned int outCount = 0;
//        
//        objc_property_t * properties = class_copyPropertyList([self class], &outCount);
//        
//        for (int i = 0; i < outCount; i++) {
//            
//            objc_property_t property = properties[i];
//            
//            NSString * key = [[[NSString alloc] initWithCString:property_getName(property)
//                                                   encoding:NSUTF8StringEncoding] autorelease];
//            
//            id value = [aDecoder decodeObjectForKey:key];
//            [self setValue:value forKey:key];
//        }
//        
//        free(properties);
//    })
//}
//
//- (void) encodeWithCoder:(NSCoder *)aCoder
//{
//    unsigned int outCount = 0;
//    
//    objc_property_t * properties = class_copyPropertyList([self class], &outCount);
//    
//    for (int i = 0; i < outCount; i++) {
//        
//        objc_property_t property = properties[i];
//        
//        NSString * key = [[[NSString alloc] initWithCString:property_getName(property)
//                                               encoding:NSUTF8StringEncoding] autorelease];
//        
//        id value = [self valueForKey:key];
//        
//        if (value && key) {
//            if ([value isKindOfClass:[NSObject class]]) {
//                [aCoder encodeObject:value forKey:key];
//            } else {
//                NSNumber * v = [NSNumber numberWithInt:(int)value];
//                [aCoder encodeObject:v forKey:key];
//            }
//        }
//    }
//    
//    free(properties);
//}
//
//-(LCModelArchiverBlock) ARCHIVER
//{
//    LCModelArchiverBlock block = ^ NSData * (){
//    
//        return [NSKeyedArchiver archivedDataWithRootObject:self];
//        
//    };
//    
//    return [[block copy] autorelease];
//}
//
//-(LCModelArchiverSaveBlock) ARCHIVER_SAVE
//{
//    LCModelArchiverSaveBlock block = ^ LC_Model * ( NSString * path ){
//        
//        BOOL result = [NSKeyedArchiver archiveRootObject:self toFile:path];
//        
//        if (!result) {
//            ERROR(@"Archiver %@ failed!",self.class);
//        }
//        
//        return self;
//        
//    };
//    
//    return [[block copy] autorelease];
//}
//
//+(instancetype) deserializeWithPath:(NSString *)archiverPath
//{
//    id obj = [NSKeyedUnarchiver unarchiveObjectWithFile:archiverPath];
//
//    if (!obj) {
//        ERROR(@"Archiver restore failed from path : %@",archiverPath);
//    }
//    
//    return obj;
//
//}
//
//+(instancetype) deserializeWithData:(NSData *)archiverData
//{
//    id obj = [NSKeyedUnarchiver unarchiveObjectWithData:archiverData];
//    
//    if (!obj) {
//        ERROR(@"Archiver restore failed from data : %@",archiverData);
//    }
//    
//    return obj;
//}

@end
