//
//  Created by 腾 on 16/8/11.
//  Copyright © 2016年 腾. All rights reserved.
//

#import "CTTouchIDAuthorize.h"
#import <UIKit/UIKit.h>
#import <LocalAuthentication/LocalAuthentication.h>

@interface CTTouchIDAuthorize ()

@property (nonatomic, weak) id<CT_TouchID_Delegate> delegate;
@property (nonatomic, strong) LAContext *context;

@end
static CTTouchIDAuthorize *kAuthorize= nil;

@implementation CTTouchIDAuthorize

+ (void)sigtonTouchId {
    @synchronized(self){
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            kAuthorize = [[self alloc] init];
            
        });
    }
}
+ (BOOL)checkAuthorize {
    [self sigtonTouchId];
    if (@available(iOS 8.0, *)) {
        kAuthorize.context = LAContext.new;
        NSError *authError = nil;
        BOOL isCanEvaluatePolicy = [kAuthorize.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError];
        if (isCanEvaluatePolicy) {
            if (@available(iOS 11.0, *)) {
                switch (kAuthorize.context.biometryType) {
                    case LABiometryTypeNone:
                        return NO;
                        break;
                    case LABiometryTypeTouchID:
                    case LABiometryTypeFaceID:
                        return YES;
                        break;
                }
            }else {
                return YES;
            }
        }else {
            return NO;
        }
    }else {
        return NO;
    }
}
+ (void)startCT_TouchID_WithMessage:(NSString *)message
                      FallBackTitle:(NSString *)fallBackTitle
                           Delegate:(id<CT_TouchID_Delegate>)delegate {
    [self sigtonTouchId];
    if (!self.checkAuthorize) {
        return;
    }

    kAuthorize.context.localizedFallbackTitle = fallBackTitle;
    
    kAuthorize.delegate = delegate;
    //使用context对象对识别的情况进行评估
    [kAuthorize.context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                       localizedReason:message
                                 reply:^(BOOL success, NSError * _Nullable error) {
                         
        dispatch_async(dispatch_get_main_queue(), ^{
           //识别成功:
           if (success) {
               if ([kAuthorize.delegate respondsToSelector:@selector(CT_TouchID_AuthorizeSuccess)]) {
                    [kAuthorize.delegate CT_TouchID_AuthorizeSuccess];
               }
           }else if (error) {
               //识别失败（对应代理方法的每种情况,不实现对应方法就没有反应）
               switch (error.code) {
                       //身份验证不成功，因为用户无法提供有效的凭据。
                   case LAErrorAuthenticationFailed:{
                       if ([kAuthorize.delegate respondsToSelector:@selector(CT_TouchID_AuthorizeFailure)]) {
                            [kAuthorize.delegate CT_TouchID_AuthorizeFailure];
                       }
                       break;
                   }
                       //认证被用户取消(例如了取消按钮)。
                   case LAErrorUserCancel:{
                       if ([kAuthorize.delegate respondsToSelector:@selector(CT_TouchID_AuthorizeUserCancel)]) {
                            [kAuthorize.delegate CT_TouchID_AuthorizeUserCancel];
                       }
                       break;
                   }
                       //认证被取消了,因为用户利用回退按钮(输入密码)。
                   case LAErrorUserFallback:{
                       if ([kAuthorize.delegate respondsToSelector:@selector(CT_TouchID_AuthorizeUserFallBack)]) {
                            [kAuthorize.delegate CT_TouchID_AuthorizeUserFallBack];
                       }
                       break;
                   }
                         //身份验证被系统取消了(如另一个应用程序去前台)。
                   case LAErrorSystemCancel:{
                       if ([kAuthorize.delegate respondsToSelector:@selector(CT_TouchID_AuthorizeSystemCancel)]) {
                           [kAuthorize.delegate CT_TouchID_AuthorizeSystemCancel];
                       }
                       break;
                   }
                       
                       //身份验证无法启动,因为设备没有设置密码。
                   case LAErrorPasscodeNotSet:{
                       if ([kAuthorize.delegate respondsToSelector:@selector(CT_TouchID_AuthorizePasswordNotSet)]) {
                           [kAuthorize.delegate CT_TouchID_AuthorizePasswordNotSet];
                       }
                       break;
                   }
                       //身份验证无法启动,因为触摸ID不可用在设备上。
                   case LAErrorBiometryNotAvailable:{
                       if ([kAuthorize.delegate respondsToSelector:@selector(CT_TouchID_AuthorizeTouchIDNotAvailable)]) {
                           [kAuthorize.delegate CT_TouchID_AuthorizeTouchIDNotAvailable];
                       }
                       break;
                   }
                        //身份验证无法启动,因为没有登记的手指触摸ID。
                   case LAErrorBiometryNotEnrolled:{
                       if ([kAuthorize.delegate respondsToSelector:@selector(CT_TouchID_AuthorizeTouchIDNotSet)]) {
                            [kAuthorize.delegate CT_TouchID_AuthorizeTouchIDNotSet];
                       }
                       break;
                   }
                        //身份验证不成功，因为有太多失败的触摸ID尝试和触摸ID现在被锁定。
                   case LAErrorBiometryLockout:{
                       if ([kAuthorize.delegate respondsToSelector:@selector(CT_TouchID_AuthorizeTouchIDNotLockOut)]) {
                            [kAuthorize.delegate CT_TouchID_AuthorizeTouchIDNotLockOut];
                       }
                       break;
                   }
                        //应用程序取消了身份验证（例如在进行身份验证时调用了无效）。
                   case LAErrorAppCancel:{
                       if ([kAuthorize.delegate respondsToSelector:@selector(CT_TouchID_AuthorizeTouchIDAppCancel)]) {
                            [kAuthorize.delegate CT_TouchID_AuthorizeTouchIDAppCancel];
                       }
                       break;
                   }
                        //LAContext传递给这个调用之前已经失效。
                   case LAErrorInvalidContext:{
                       if ([kAuthorize.delegate respondsToSelector:@selector(CT_TouchID_AuthorizeTouchIDInvalidContext)]) {
                               [kAuthorize.delegate CT_TouchID_AuthorizeTouchIDInvalidContext];
                       }
                       break;
                   }
                   default:
                       break;
               }
           }
       });
    }];
}

@end
