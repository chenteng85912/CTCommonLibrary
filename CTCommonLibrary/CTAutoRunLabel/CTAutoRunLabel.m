//
//  AutoRunLabel.m
//  webhall
//
//  Created by Apple on 2016/10/24.
//  Copyright © 2016年 TENG. All rights reserved.
//

#import "CTAutoRunLabel.h"
#import "CADisplayLink+DisplayBlock.h"

@interface CTAutoRunLabel ()

@property (strong, nonatomic) UILabel *contentLabel;//内容
@property (strong, nonatomic) CADisplayLink *displayLink;//定时器
@property (nonatomic, assign) NSInteger speed;

@end

@implementation CTAutoRunLabel

+ (instancetype)initWithFrame:(CGRect)frame
                    labelText:(NSString *)text
                         font:(CGFloat)fontSize
                    textColor:(UIColor *)textColor
                textAlignment:(NSTextAlignment)textAlignment
                        speed:(NSInteger)speed{
    return [[self alloc] initWithFrame:frame
                             labelText:text
                                  font:fontSize
                             textColor:textColor
                         textAlignment:textAlignment
                                 speed:speed];
}
- (instancetype)initWithFrame:(CGRect)frame
                    labelText:(NSString *)text
                         font:(CGFloat)fontSize
                    textColor:(UIColor *)textColor
                textAlignment:(NSTextAlignment)textAlignment
                        speed:(NSInteger)speed
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.frame = frame;
        self.contentLabel.text = text;
        self.contentLabel.font = [UIFont systemFontOfSize:fontSize?fontSize:15];
        self.contentLabel.textColor = textColor?textColor:[UIColor blackColor];
        self.contentLabel.textAlignment = textAlignment?textAlignment:NSTextAlignmentCenter;
        _speed = speed;
        if (text) {
    
            [self calucateLabelLenght];
           
        }
    }
    return self;
}

//计算长度 判断是否滚动
- (void)calucateLabelLenght{
   
    CGSize maxSize = [self.contentLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.contentLabel.font} context:nil].size;

    if (maxSize.width<=self.frame.size.width) {
        return;
    }
    self.contentLabel.frame = CGRectMake(20, 0, maxSize.width, self.frame.size.height);

    [self startRun];
}
//开始滚动
- (void)autoRun{
    CGFloat centerX = self.contentLabel.center.x-1;
    if (centerX<-self.contentLabel.frame.size.width/2) {
        centerX = self.contentLabel.frame.size.width/2+self.frame.size.width;
    }
    self.contentLabel.center = CGPointMake(centerX, self.contentLabel.center.y);

}
//开始滚动
- (void)startRun{
    
    CACurrentMediaTime();
    self.displayLink.paused = NO;
    NSLog(@"autoRunLabel start run");

}
//停止滚动
- (void)stopRun{
//    if (!self.displayLink.paused) {
        self.displayLink.paused = YES;

//    }

    NSLog(@"autoRunLabel stop run");
}
#pragma mark - getter and setter

- (UILabel *)contentLabel{
    if (_contentLabel==nil) {
        _contentLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (CADisplayLink *)displayLink{
    if (!_displayLink) {
        
        __weak typeof(self) weakSelf = self;
        _displayLink = [CADisplayLink CT_DisplayLinkWithFrameInterval:_speed ? _speed : 30 block:^{
            [weakSelf autoRun];
            
        }];

    }
    return _displayLink;
}
- (void)dealloc{
    [self stopRun];
    NSLog(@"CTAutoRunLabel dealloc");
}

@end
