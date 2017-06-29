//
//  NSObject+LSHUD.m
//  PeachNet
//
//  Created by 牛哲 on 15/6/16.
//  Copyright (c) 2015年 王隆帅. All rights reserved.
//

#import "NSObject+LSHUD.h"
#import "SVProgressHUD.h"

@implementation NSObject (LSHUD)

- (void)ls_showMessage:(NSString *)msg {
    [SVProgressHUD setBackgroundColor:COLOR(51, 51, 51, 51)];
    [SVProgressHUD setForegroundColor:white_color];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD showInfoWithStatus:msg];
    [self performSelector:@selector(ls_dismiss) withObject:nil afterDelay:1];

}

- (void)ls_show {
//      [SVProgressHUD show];
    //SVProgressHUDMaskType 设置显示的样式
    [SVProgressHUD setBackgroundColor:clear_color];
    [SVProgressHUD setForegroundColor:CL_LOGIN_TEXT_COLOR_RED];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setRingNoTextRadius:13];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
    [self performSelector:@selector(ls_dismiss) withObject:nil afterDelay:3];
}

- (void)ls_showWithStatus:(NSString *)string {
    [SVProgressHUD setBackgroundColor:CL_LOGIN_TEXT_COLOR_RED];
    [SVProgressHUD setForegroundColor:white_color];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showWithStatus:string];
//    [SVProgressHUD showWithStatus:string maskType:SVProgressHUDMaskTypeNone];
}

- (void)ls_showprogress:(NSString *)string {
    [SVProgressHUD showProgress:0 status:string];
    [self performSelector:@selector(ls_increateProgress) withObject:nil afterDelay:0.3];
}

static float progressValue = 0.0f;
- (void)ls_increateProgress
{
    
    progressValue += 0.1;
//    [SVProgressHUD setForegroundColor:COLOR(51, 51, 51, 1)];
    [SVProgressHUD showProgress:progressValue status:@"加载中"];
    if (progressValue < 1) {
        [self performSelector:@selector(ls_increateProgress) withObject:nil afterDelay:0.3];
    }else{
        [self performSelector:@selector(ls_dismiss) withObject:nil afterDelay:0.4];
    }
}

- (void)ls_dismiss {
    [SVProgressHUD dismiss];
}

- (void)ls_ProgressDismiss {

    [SVProgressHUD showProgress:progressValue status:nil];
    [SVProgressHUD dismiss];
}

- (void)ls_showSuccess:(NSString *)string {
    [SVProgressHUD setBackgroundColor:CL_LOGIN_TEXT_COLOR_RED];
    [SVProgressHUD setForegroundColor:white_color];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD showSuccessWithStatus:string];
    [self performSelector:@selector(ls_dismiss) withObject:nil afterDelay:1];
}

- (void)ls_showError:(NSString *)string {
    [SVProgressHUD setBackgroundColor:CL_LOGIN_TEXT_COLOR_RED];
    [SVProgressHUD setForegroundColor:white_color];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD showErrorWithStatus:string];
    [self performSelector:@selector(ls_dismiss) withObject:nil afterDelay:1];
}

@end
