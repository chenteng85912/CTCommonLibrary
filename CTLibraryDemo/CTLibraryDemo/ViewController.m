//
//  ViewController.m
//  CommonLibraryDemo
//
//  Created by 陈腾 on 2018/4/18.
//  Copyright © 2018年 陈腾. All rights reserved.
//

#import "ViewController.h"
#import "CTTouchIDAuthorize.h"

@interface ViewController ()<CT_TouchID_Delegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)testAction:(UIButton *)sender {
    [CTTouchIDAuthorize startCT_TouchID_WithMessage:@"登录" FallBackTitle:@"确定" Delegate:self];
}
/**
 *
 *  验证成功
 */
- (void)CT_TouchID_AuthorizeSuccess {
    NSLog(@"success");
}
/**
 *
 *  验证失败
 */
- (void)CT_TouchID_AuthorizeFailure {
    NSLog(@"fail");
}

@end
