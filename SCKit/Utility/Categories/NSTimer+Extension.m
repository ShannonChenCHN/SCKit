//
//  NSTimer+YIDExtension.m
//  YesIDo
//
//  Created by ShannonChen on 16/9/29.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "NSTimer+YIDExtension.h"
#import <objc/runtime.h>

static const char *kYIDTimerIsPausedKey = "kYIDTimerIsPausedKey";

@implementation NSTimer (YIDExtension)


- (BOOL)yid_isPaused {
    return [objc_getAssociatedObject(self, kYIDTimerIsPausedKey) boolValue];
}

- (void)setYid_paused:(BOOL)yid_paused {
    objc_setAssociatedObject(self, kYIDTimerIsPausedKey, @(yid_paused), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


+ (void)yid_executeBlock:(NSTimer *)timer {
    if (timer.userInfo) {
        void (^block)(NSTimer *timer) = (void (^)(NSTimer *))timer.userInfo;
        block(timer);
    }
}

+ (instancetype)yid_timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block {
    return [self timerWithTimeInterval:interval target:self selector:@selector(yid_executeBlock:) userInfo:[block copy] repeats:repeats];
}

+ (instancetype)yid_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *))block {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(yid_executeBlock:) userInfo:[block copy] repeats:repeats];
}

- (void)yid_pause {
    [self setFireDate:[NSDate distantFuture]];
    self.yid_paused = YES;
}

- (void)yid_continue {
    [self setFireDate:[NSDate date]];
    self.yid_paused = NO;
}

@end
