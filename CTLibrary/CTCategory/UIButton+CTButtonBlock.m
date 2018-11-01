//
//  UIButton+TYKYButtonBlock.m
//  webhall
//
//  Created by chenteng on 2017/8/3.
//  Copyright © 2017年 Shenzhen Taiji Software Co., Ltd. All rights reserved.
//

#import "UIButton+CTButtonBlock.h"
#import <objc/runtime.h>

static  NSString const *kBtn_target_key = @"CustomBtnKey";

@implementation UIButton (CTButtonBlock)

- (void)blockWithControlEvents:(UIControlEvents)controlEvents block:(CTCustomBtnBlock)btnBlcok {
    [self addActionBlock:btnBlcok];
    [self addTarget:self action:@selector(invoke:) forControlEvents:controlEvents];
}

- (void)addActionBlock:(CTCustomBtnBlock)block {
    if (block) {
        objc_setAssociatedObject(self, &kBtn_target_key, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (void)invoke:(id)sender {
    CTCustomBtnBlock block = objc_getAssociatedObject(self, &kBtn_target_key);
    if (block) {
        block(sender);
    }
}
@end
