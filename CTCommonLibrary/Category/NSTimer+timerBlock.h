//
//  NSTimer+timerBlock.h
//  CommonLibraryDemo
//
//  Created by 陈腾 on 2018/4/18.
//  Copyright © 2018年 陈腾. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (timerBlock)

+ (NSTimer *)CTScheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                        block:(dispatch_block_t)block
                                      repeats:(BOOL)repeat;

@end
