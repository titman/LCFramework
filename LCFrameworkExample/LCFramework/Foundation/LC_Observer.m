//
//  LC_Observer.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-17.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_Observer.h"

typedef enum LCObserverBlockArgumentsKind {
    LCObserverBlockArgumentsNone,
    LCObserverBlockArgumentsOldAndNew,
    LCObserverBlockArgumentsChangeDictionary
} LCObserverBlockArgumentsKind;

@interface LC_Observer ()
{
    // The reason this is __unsafe_unretained instead of __weak is so that, if
    // -stopObserving: is called _during_ _observedObject's deallocation, this
    // ivar won't be zeroed out yet, and so we'll still be able to use it to
    // degister for notifications.
    // This does mean that it won't be zeroed out automatically, but we'd be in
    // a dangerous state if that happened anyway (we'd be still registered
    // for KVO on a deallocated object).
    __unsafe_unretained id _observedObject;
}

@property(nonatomic,retain) NSString * keyPath;
@property(nonatomic,copy) dispatch_block_t block;

@end


@implementation LC_Observer

- (void)dealloc
{
    if(_observedObject) {
        [self stopObserving];
    }
    
    [super dealloc];
}


- (id)initForObject:(id)object
            keyPath:(NSString *)keyPath
            options:(NSKeyValueObservingOptions)options
              block:(dispatch_block_t)block
 blockArgumentsKind:(LCObserverBlockArgumentsKind)blockArgumentsKind
{
    if((self = [super init])) {
        if(!object || !keyPath || !block) {
            ERROR(@"Observation must have a valid object (%@), keyPath (%@) and block(%@)",object, keyPath, block);
        } else {
            _observedObject = object;
            self.keyPath = keyPath;
            self.block = block;
            
            [_observedObject addObserver:self
                              forKeyPath:_keyPath
                                 options:options
                                 context:(void *)blockArgumentsKind];
        }
    }
    return self;
}

- (void)stopObserving
{
    [_observedObject removeObserver:self forKeyPath:_keyPath];
    self.block = nil;
    self.keyPath = nil;
    _observedObject = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    switch((LCObserverBlockArgumentsKind)context) {
        case LCObserverBlockArgumentsNone:
            ((LCObserverBlock)_block)();
            break;
        case LCObserverBlockArgumentsOldAndNew:
            ((LCObserverBlockWithOldAndNew)_block)(change[NSKeyValueChangeOldKey], change[NSKeyValueChangeNewKey]);
            break;
        case LCObserverBlockArgumentsChangeDictionary:
            ((LCObserverBlockWithChangeDictionary)_block)(change);
            break;
        default:
            ERROR(@"%s called on %@ with unrecognised context (%p)", __func__, self, context);
    }
}


#pragma mark -
#pragma mark Block-based observer construction.

+ (id)observerForObject:(id)object
                keyPath:(NSString *)keyPath
                  block:(LCObserverBlock)block
{
    return [[[self alloc] initForObject:object
                               keyPath:keyPath
                               options:0
                                 block:(dispatch_block_t)block
                    blockArgumentsKind:LCObserverBlockArgumentsNone] autorelease];
}

+ (id)observerForObject:(id)object
                keyPath:(NSString *)keyPath
         oldAndNewBlock:(LCObserverBlockWithOldAndNew)block
{
    return [[[self alloc] initForObject:object
                               keyPath:keyPath
                               options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                                 block:(dispatch_block_t)block
                    blockArgumentsKind:LCObserverBlockArgumentsOldAndNew] autorelease];
}

+ (id)observerForObject:(id)object
                keyPath:(NSString *)keyPath
                options:(NSKeyValueObservingOptions)options
            changeBlock:(LCObserverBlockWithChangeDictionary)block
{
    return [[[self alloc] initForObject:object
                               keyPath:keyPath
                               options:options
                                 block:(dispatch_block_t)block
                    blockArgumentsKind:LCObserverBlockArgumentsChangeDictionary] autorelease];
}


#pragma mark -
#pragma mark Target-action based observer construction.

//static NSUInteger SelectorArgumentCount(SEL selector)
//{
//    NSUInteger argumentCount = 0;
//    
//    const char *selectorStringCursor = sel_getName(selector);
//    char ch;
//    while((ch = *selectorStringCursor)) {
//        if(ch == ':') {
//            ++argumentCount;
//        }
//        ++selectorStringCursor;
//    }
//    
//    return argumentCount;
//}


//+ (id)observerForObject:(id)object
//                keyPath:(NSString *)keyPath
//                options:(NSKeyValueObservingOptions)options
//                 target:(id)target
//                 action:(SEL)action
//{
//    id ret = nil;
//    
//    __block id wTarget = target;
//    __block id wObject = object;
//    
//    dispatch_block_t block = nil;
//    LCObserverBlockArgumentsKind blockArgumentsKind;
//    
//    // Was doing this with an NSMethodSignature by calling
//    // [target methodForSelector:action], but that will fail if the method
//    // isn't defined on the target yet, beating ObjC's dynamism a bit.
//    // This looks a little hairier, but it won't fail (and is probably a lot
//    // more efficient anyway).
//    NSUInteger actionArgumentCount = SelectorArgumentCount(action);
//    
//    switch(actionArgumentCount) {
//        case 0: {
//            block = [^{
//                id msgTarget = wTarget;
//                if(msgTarget) {
//                    ((void(*)(id, SEL))objc_msgSend)(msgTarget, action);
//                }
//            } copy];
//            blockArgumentsKind = LCObserverBlockArgumentsNone;
//        }
//            break;
//        case 1: {
//            block = [^{
//                id msgTarget = wTarget;
//                if(msgTarget) {
//                    ((void(*)(id, SEL, id))objc_msgSend)(msgTarget, action, wObject);
//                }
//            } copy];
//            blockArgumentsKind = LCObserverBlockArgumentsNone;
//        }
//            break;
//        case 2: {
//            NSString *myKeyPath = [keyPath copy];
//            block = [^{
//                id msgTarget = wTarget;
//                if(msgTarget) {
//                    ((void(*)(id, SEL, id, NSString *))objc_msgSend)(msgTarget, action, wObject, myKeyPath);
//                }
//            } copy];
//            blockArgumentsKind = LCObserverBlockArgumentsNone;
//        }
//            break;
//        case 3: {
//            NSString *myKeyPath = [keyPath copy];
//            block = [(dispatch_block_t)(^(NSDictionary *change) {
//                id msgTarget = wTarget;
//                if(msgTarget) {
//                    ((void(*)(id, SEL, id, NSString *, NSDictionary *))objc_msgSend)(msgTarget, action, wObject, myKeyPath, change);
//                }
//            }) copy];
//            blockArgumentsKind = LCObserverBlockArgumentsChangeDictionary;
//        }
//            break;
//        case 4: {
//            NSString *myKeyPath = [keyPath copy];
//            options |=  NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
//            block = [(dispatch_block_t)(^(id oldValue, id newValue) {
//                id msgTarget = wTarget;
//                if(msgTarget) {
//                    ((void(*)(id, SEL, id, NSString *, id, id))objc_msgSend)(msgTarget, action, wObject, myKeyPath, oldValue, newValue);
//                }
//            }) copy];
//            blockArgumentsKind = LCObserverBlockArgumentsOldAndNew;
//        }
//            break;
//        default:
//            ERROR(@"Incorrect number of arguments (%ld) in action for %s (should be 0 - 4)", (long)actionArgumentCount, __func__);
//    }
//    
//    if(block) {
//        ret = [[[self alloc] initForObject:object
//                                  keyPath:keyPath
//                                  options:options
//                                    block:block
//                       blockArgumentsKind:blockArgumentsKind] autorelease];
//    }
//    
//    return ret;
//}
//
//+ (id)observerForObject:(id)object
//                keyPath:(NSString *)keyPath
//                 target:(id)target
//                 action:(SEL)action
//{
//    return [self observerForObject:object keyPath:keyPath options:0 target:target action:action];
//}


#pragma mark -
#pragma mark Value-only target-action observers.

//+ (id)observerForObject:(id)object
//                keyPath:(NSString *)keyPath
//                options:(NSKeyValueObservingOptions)options
//                 target:(id)target
//            valueAction:(SEL)valueAction
//{
//    id ret = nil;
//    
//    __block id wTarget = target;
//    
//    LCObserverBlockWithChangeDictionary block = nil;
//    
//    NSUInteger actionArgumentCount = SelectorArgumentCount(valueAction);
//    
//    switch(actionArgumentCount) {
//        case 1: {
//            options |= NSKeyValueObservingOptionNew;
//            block = [^(NSDictionary *change) {
//                id msgTarget = wTarget;
//                if(msgTarget) {
//                    ((void(*)(id, SEL, id))objc_msgSend)(msgTarget, valueAction, change[NSKeyValueChangeNewKey]);
//                }
//            } copy];
//        }
//            break;
//        case 2: {
//            options |= NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew;
//            block = [^(NSDictionary *change) {
//                id msgTarget = wTarget;
//                if(msgTarget) {
//                    ((void(*)(id, SEL, id, id))objc_msgSend)(msgTarget, valueAction, change[NSKeyValueChangeOldKey], change[NSKeyValueChangeNewKey]);
//                }
//            } copy];
//        }
//            break;
//        case 3: {
//            __block id wObject = object;
//            
//            options |= NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew;
//            block = [^(NSDictionary *change) {
//                id msgTarget = wTarget;
//                if(msgTarget) {
//                    ((void(*)(id, SEL, id, id, id))objc_msgSend)(msgTarget, valueAction, wObject, change[NSKeyValueChangeOldKey], change[NSKeyValueChangeNewKey]);
//                }
//            } copy];
//        }
//            break;
//        default:
//            [NSException raise:NSInternalInconsistencyException format:@"Incorrect number of arguments (%ld) in action for %s (should be 1 - 2)", (long)actionArgumentCount, __func__];
//    }
//    
//    if(block) {
//        ret = [[self alloc] initForObject:object
//                                  keyPath:keyPath
//                                  options:options
//                                    block:(dispatch_block_t)block
//                       blockArgumentsKind:LCObserverBlockArgumentsChangeDictionary];
//    }
//    
//    return ret;
//}
//
//+ (id)observerForObject:(id)object
//                keyPath:(NSString *)keyPath
//                 target:(id)target
//            valueAction:(SEL)valueAction
//{
//    return [self observerForObject:object keyPath:keyPath options:0 target:target valueAction:valueAction];
//}

@end
