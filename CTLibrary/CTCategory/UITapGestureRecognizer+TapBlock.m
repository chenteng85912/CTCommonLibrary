//
//  UITapGestureRecognizer+TapBlock.m
//  CommonLibraryDemo
//
//  Created by 陈腾 on 2018/4/19.
//  Copyright © 2018年 陈腾. All rights reserved.
//

#import "UITapGestureRecognizer+TapBlock.h"
#import <objc/runtime.h>

static  NSString const *kCTTapGestureRecognizerKey = @"kCTTapGestureRecognizerKey";

@implementation UITapGestureRecognizer (TapBlock)

+ (instancetype)initWithBlock:(CTTapGestureBlock)tapBlock {
    return  [[self alloc] initWithBlock:tapBlock];
}
- (instancetype)initWithBlock:(CTTapGestureBlock)tapBlock {
    self = [super init];
    if (self) {
        [self addActionBlock:tapBlock];
        [self addTarget:self action:@selector(tapAction:)];
    }
    return self;
}

- (void)addActionBlock:(CTTapGestureBlock)tapBlock {
    if (tapBlock) {
        objc_setAssociatedObject(self, &kCTTapGestureRecognizerKey, tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (void)tapAction:(UITapGestureRecognizer *)gestureRecogizer {
    CTTapGestureBlock block = objc_getAssociatedObject(self, &kCTTapGestureRecognizerKey);
    if (block) {
        block(gestureRecogizer);
    }
}
@end
