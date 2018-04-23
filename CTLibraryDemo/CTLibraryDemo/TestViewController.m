//
//  TestViewController.m
//
//  Created by 陈腾 on 2018/4/18.
//  Copyright © 2018年 陈腾. All rights reserved.
//

#import "TestViewController.h"
#import "CTLibrary.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CTAutoRunLabel *runLabel = [CTAutoRunLabel initWithFrame:CGRectMake(50, 200, 200, 40) labelText:@"跑马灯测试，自动计算内容长度，如果超过显示宽度，自动滚动，不信你试试" font:16 textColor:[UIColor redColor] textAlignment:NSTextAlignmentCenter speed:200];
    
    [self.view addSubview:runLabel];
    
}

- (void)dealloc{
    NSLog(@"TestViewControlle dealloc");
}

@end
