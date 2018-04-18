//
//  NSTimer+timerBlock.m
//  CommonLibraryDemo
//
//  Created by 陈腾 on 2018/4/18.
//  Copyright © 2018年 陈腾. All rights reserved.
//

#import "NSTimer+timerBlock.h"

@implementation NSTimer (timerBlock)

+ (NSTimer *)CTScheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                        block:(dispatch_block_t)block
                                      repeats:(BOOL)repeats{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                      target:self
                                                    selector:@selector(timerAction:)
                                                    userInfo:[block copy]
                                                     repeats:repeats];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

    return timer;
}

+ (void)timerAction:(NSTimer *)timer{
    dispatch_block_t block = timer.userInfo;
    if (block) {
        block();
    }
}
@end
