//
//  NSTimer+SCExtension.h
//  SCKitDemo
//
//  Created by ShannonChen on 17/4/28.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (SCExtension)


@property (assign, nonatomic, getter=sc_isPaused) BOOL sc_paused;


+ (NSTimer *)sc_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *))block;
+ (NSTimer *)sc_timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;


- (void)sc_pause;
- (void)sc_resume;


@end
