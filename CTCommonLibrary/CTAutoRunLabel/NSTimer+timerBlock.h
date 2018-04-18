//
//  NSTimer+timerBlock.h
//  CommonLibraryDemo
//
//  Created by 陈腾 on 2018/4/18.
//  Copyright © 2018年 陈腾. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (timerBlock)

/**
 初始化定时器 防止循环引用

 @param interval 间隔时间
 @param block 代码块
 @param repeat 是否重复
 @return 定时器
 */
+ (NSTimer *)CTScheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                        block:(dispatch_block_t)block
                                      repeats:(BOOL)repeat;

@end
