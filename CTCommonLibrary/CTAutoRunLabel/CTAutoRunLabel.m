//
//  AutoRunLabel.m
//  webhall
//
//  Created by Apple on 2016/10/24.
//  Copyright © 2016年 TENG. All rights reserved.
//

#import "CTAutoRunLabel.h"
#import "NSTimer+timerBlock.h"

@interface CTAutoRunLabel ()

@property (strong, nonatomic) UILabel *contentLabel;//内容
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger speed;

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
        _speed = speed ? speed : 100;
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
    CGFloat centerX = self.contentLabel.center.x- 0.005;
    if (centerX<-self.contentLabel.frame.size.width/2) {
        centerX = self.contentLabel.frame.size.width/2+self.frame.size.width;
    }
    self.contentLabel.center = CGPointMake(centerX, self.contentLabel.center.y);

}
//开始滚动
- (void)startRun{
    
    [self.timer fire];
    NSLog(@"%@ autoRunLabel start run",self);

}
//停止滚动
- (void)stopRun{
    [_timer invalidate];
    _timer = nil;
    NSLog(@"%@ autoRunLabel stop run",self);
}
#pragma mark - getter and setter

- (UILabel *)contentLabel{
    if (_contentLabel==nil) {
        _contentLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}


- (NSTimer *)timer{
    if (!_timer) {
        __weak typeof(self) weakSelf = self;
        _timer = [NSTimer CTScheduledTimerWithTimeInterval:1/_speed block:^{
            [weakSelf autoRun];
        } repeats:YES];
    }
    return _timer;
}

- (void)dealloc{
    [self.timer invalidate];
    NSLog(@"%@ CTAutoRunLabel dealloc",self);
}

@end
