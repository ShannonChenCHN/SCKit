//
//  NSTimer+SCExtension.m
//  SCKitDemo
//
//  Created by ShannonChen on 17/4/28.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "NSTimer+SCExtension.h"
#import <objc/runtime.h>

static const char *kSCTimerIsPausedKey = "kSCTimerIsPausedKey";

@implementation NSTimer (SCExtension)

#pragma mark - Properties
- (BOOL)sc_isPaused {
    return [objc_getAssociatedObject(self, kSCTimerIsPausedKey) boolValue];
}

- (void)setSc_paused:(BOOL)sc_paused {
    objc_setAssociatedObject(self, kSCTimerIsPausedKey, @(sc_paused), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - Convenience methods
+ (void)sc_executeBlock:(NSTimer *)timer {
    if (timer.userInfo) {
        void (^block)(NSTimer *timer) = (void (^)(NSTimer *))timer.userInfo;
        block(timer);
    }
}

+ (instancetype)sc_timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block {
    return [self timerWithTimeInterval:interval target:self selector:@selector(sc_executeBlock:) userInfo:[block copy] repeats:repeats];
}

+ (instancetype)sc_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *))block {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(sc_executeBlock:) userInfo:[block copy] repeats:repeats];
}

#pragma mark - Pause and resume
- (void)sc_pause {
    [self setFireDate:[NSDate distantFuture]];
    self.sc_paused = YES;
}

- (void)sc_resume {
    [self setFireDate:[NSDate date]];
    self.sc_paused = NO;
}


@end
