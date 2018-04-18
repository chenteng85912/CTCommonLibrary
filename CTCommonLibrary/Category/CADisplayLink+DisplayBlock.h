//
//  CADisplayLink+DisplayBlock.h
//  CommonLibraryDemo
//
//  Created by 陈腾 on 2018/4/18.
//  Copyright © 2018年 陈腾. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CADisplayLink (DisplayBlock)

+ (CADisplayLink *)CT_DisplayLinkWithFrameInterval:(NSInteger)frameInterval
                                             block:(dispatch_block_t)block;

@end
