//
//  ViewController.m
//  CommonLibraryDemo
//
//  Created by 陈腾 on 2018/4/18.
//  Copyright © 2018年 陈腾. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "CTAutoRunLabel.h"

@interface ViewController ()
@property (nonatomic, strong) CTAutoRunLabel *autoRunlabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _autoRunlabel = [CTAutoRunLabel initWithFrame:CGRectMake(50, 200, 200, 40) labelText:@"跑马灯测试，自动计算内容长度，如果超过显示宽度，自动滚动，不信你试试" font:16 textColor:[UIColor redColor] textAlignment:NSTextAlignmentCenter speed:30];
    
    [self.view addSubview:_autoRunlabel];
   
}
- (IBAction)testAction:(UIButton *)sender {
    [self.navigationController pushViewController:[TestViewController new] animated:YES];

}
- (IBAction)btnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_autoRunlabel stopRun];
    }else{
        [_autoRunlabel startRun];
    }
}


@end
