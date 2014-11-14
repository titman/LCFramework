//
//  LC_Observer.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-17.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <Foundation/Foundation.h>

@interface LC_Observer : NSObject

#pragma mark -
#pragma mark Block-based observers.

typedef void(^LCObserverBlock)(void);
typedef void(^LCObserverBlockWithOldAndNew)(id oldValue, id newValue);
typedef void(^LCObserverBlockWithChangeDictionary)(NSDictionary *change);

+ (id)observerForObject:(id)object
                keyPath:(NSString *)keyPath
                  block:(LCObserverBlock)block;

+ (id)observerForObject:(id)object
                keyPath:(NSString *)keyPath
         oldAndNewBlock:(LCObserverBlockWithOldAndNew)block;

+ (id)observerForObject:(id)object
                keyPath:(NSString *)keyPath
                options:(NSKeyValueObservingOptions)options
            changeBlock:(LCObserverBlockWithChangeDictionary)block;

#pragma mark -

// Target-action based observers take a selector with a signature with 0-4
// arguments, and call it like this:
//
// 0 arguments: [target action];
//
// 1 argument:  [target actionForObject:object];
//
// 2 arguments: [target actionForObject:object keyPath:keyPath];
//
// 3 arguments: [target actionForObject:object keyPath:keyPath change:changeDictionary];
//     Don't expect anything in the change dictionary unless you supply some
//     NSKeyValueObservingOptions.
//
// 4 arguments: [target actionForObject:object keyPath:keyPath oldValue:oldValue newValue:newValue];
//     NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew will be
//     automatically added to your options if they're not already there and you
//     supply a 4-argument callback.
//
// The action should not return any value (i.e. should be declared to return
// void).
//
// Both the observer and the target are weakly referenced internally.

/*
+ (id)observerForObject:(id)object
                keyPath:(NSString *)keyPath
                 target:(id)target
                 action:(SEL)action;

+ (id)observerForObject:(id)object
                keyPath:(NSString *)keyPath
                options:(NSKeyValueObservingOptions)options
                 target:(id)target
                 action:(SEL)action;
*/

// A second kind of target-action based observer; takes a selector with a
// signature with 1-2 arguments, and call it like this:
//
// 1 argument:  [target actionWithNewValue:newValue];
//
// 2 arguments: [target actionWithOldValue:oldValue newValue:newValue];
//
// 3 arguments: [target actionForObject:object oldValue:oldValue newValue:newValue];
//
// The action should not return any value (i.e. should be declared to return
// void).
//
// Both the observer and the target are weakly referenced internally.

/*
+ (id)observerForObject:(id)object
                keyPath:(NSString *)keyPath
                 target:(id)target
            valueAction:(SEL)valueAction;

+ (id)observerForObject:(id)object
                keyPath:(NSString *)keyPath
                options:(NSKeyValueObservingOptions)options
                 target:(id)target
            valueAction:(SEL)valueAction;
*/

#pragma mark -
#pragma mark Lifetime management

// This is a one-way street. Call it to stop the observer functioning.
// The THObserver will do this cleanly when it deallocs, but calling it manually
// can be useful in ensuring an orderly teardown.
- (void)stopObserving;


@end
