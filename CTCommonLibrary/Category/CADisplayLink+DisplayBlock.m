//
//  CADisplayLink+DisplayBlock.m
//  CommonLibraryDemo
//
//  Created by 陈腾 on 2018/4/18.
//  Copyright © 2018年 陈腾. All rights reserved.
//

#import "CADisplayLink+DisplayBlock.h"
#import <objc/runtime.h>

static  NSString const *kCADisplayLinkKey = @"kCADisplayLinkKey";

@implementation CADisplayLink (DisplayBlock)

+ (CADisplayLink *)CT_DisplayLinkWithFrameInterval:(NSInteger)frameInterval
                                             block:(dispatch_block_t)block{
    
    CADisplayLink *displayLink =[CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
    displayLink.paused = YES;
    displayLink.frameInterval = 60/frameInterval;
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    if (block) {
        objc_setAssociatedObject(self, &kCADisplayLinkKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return displayLink;
}

+ (void)displayLinkAction{
    dispatch_block_t block = objc_getAssociatedObject(self, &kCADisplayLinkKey);
    if (block) {
        block();
    }
}
@end
