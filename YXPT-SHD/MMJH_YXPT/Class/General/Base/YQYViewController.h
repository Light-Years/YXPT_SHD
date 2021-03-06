//
//  YQYViewController.h
//  MaternalInfant
//
//  Created by 王隆帅 on 15/11/16.
//  Copyright © 2015年 王隆帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQYViewControllerProtocol.h"

@interface YQYViewController : UIViewController <YQYViewControllerProtocol>

/**
 *  VIEW是否渗透导航栏
 * (YES_VIEW渗透导航栏下／NO_VIEW不渗透导航栏下)
 */
@property (assign,nonatomic) BOOL isExtendLayout;


/**
 * 功能：设置修改StatusBar
 * 参数：（1）StatusBar样式：statusBarStyle
 *      （2）是否隐藏StatusBar：statusBarHidden
 *      （3）是否动画过渡：animated
 */

//数据请求
@property (strong, nonatomic)CMRequest *request;

-(void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
            statusBarHidden:(BOOL)statusBarHidden
    changeStatusBarAnimated:(BOOL)animated;

/**
 * 功能：隐藏显示导航栏
 * 参数：（1）是否隐藏导航栏：isHide
 *      （2）是否有动画过渡：animated
 */
-(void)hideNavigationBar:(BOOL)isHide
                animated:(BOOL)animated;

/**
 * 功能： 布局导航栏界面
 * 参数：（1）导航栏背景：backGroundImage
 *      （2）导航栏标题颜色：titleColor
 *      （3）导航栏标题字体：titleFont
 *      （4）导航栏左侧按钮：leftItem
 *      （5）导航栏右侧按钮：rightItem
 */
-(void)layoutNavigationBar:(UIImage*)backGroundImage
                titleColor:(UIColor*)titleColor
                 titleFont:(UIFont*)titleFont
         leftBarButtonItem:(UIBarButtonItem*)leftItem
        rightBarButtonItem:(UIBarButtonItem*)rightItem;

/*!
 * @brief 允许滚动的视图，支付UIScrollView、UITableView、UIWebView
 * @param scrollableView 可滚动的视图
 */
- (void)followScrollView:(UIView *)scrollableView;

/**
 * 去除Nav上的线
 */
- (void)ls_removeNavgationBarLine;

- (void)bindViewModel;
- (void)yqy_addSubviews;
- (void)yqy_makeConstraints;
- (void)yqy_layoutNavigation;
- (void)yqy_getNewData;
- (void)recoverKeyboard;

- (void)initNav;
@end
