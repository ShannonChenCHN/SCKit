//
//  NSTimer+Extension.h
//  YesIDo
//
//  Created by ShannonChen on 16/9/29.
//  Copyright © 2016年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Extension)

@property (assign, nonatomic, getter=yid_isPaused) BOOL yid_paused;


/// Creates and returns a new NSTimer object initialized with the specified block object and schedules it on the current run loop in the default mode.
+ (NSTimer *)yid_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *))block;

/// Creates and returns a new NSTimer object initialized with the specified block object.
+ (NSTimer *)yid_timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;

- (void)yid_pause;

- (void)yid_continue;

@end
