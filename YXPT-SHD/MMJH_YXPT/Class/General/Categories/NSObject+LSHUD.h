//
//  NSObject+LSHUD.h
//  PeachNet
//
//  Created by 牛哲 on 15/6/16.
//  Copyright (c) 2015年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LSHUD)

- (void)ls_showMessage:(NSString *)msg;

- (void)ls_show;

- (void)ls_showWithStatus:(NSString *)string;

- (void)ls_showprogress:(NSString *)string;

- (void)ls_increateProgress;

- (void)ls_dismiss;

- (void)ls_ProgressDismiss;

//- (void)ls_showMessage:(NSString *)string;

- (void)ls_showError:(NSString *)string;

@end
