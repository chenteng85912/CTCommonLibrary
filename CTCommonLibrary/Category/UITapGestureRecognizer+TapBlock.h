//
//  UITapGestureRecognizer+TapBlock.h
//  CommonLibraryDemo
//
//  Created by 陈腾 on 2018/4/19.
//  Copyright © 2018年 陈腾. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CTTapGestureBlock)(UITapGestureRecognizer *sender);

@interface UITapGestureRecognizer (TapBlock)

+ (instancetype)initWithBlock:(CTTapGestureBlock)tapBlock;

@end
