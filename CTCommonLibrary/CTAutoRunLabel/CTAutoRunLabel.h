//
//  AutoRunLabel.h
//  webhall
//
//  Created by Apple on 2016/10/24.
//  Copyright © 2016年 TENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTAutoRunLabel : UIView

/**
 初始化跑马灯

 @param frame 位置
 @param text 内容
 @param fontSize 字体大小 默认15
 @param textColor 字体颜色 默认黑色
 @param textAlignment 文字位置
 @param speed 滚动速率 默认30 每秒刷新30次
 @return 返回跑马灯对象
 */
+ (instancetype)initWithFrame:(CGRect)frame
                    labelText:(NSString *)text
                         font:(CGFloat)fontSize
                    textColor:(UIColor *)textColor
                textAlignment:(NSTextAlignment)textAlignment
                        speed:(NSInteger)speed;


/**
 开始滚动 （停止滚动后，才需手动触发该方法）
 */
- (void)startRun;

/**
 停止滚动
 */
- (void)stopRun;

@end
