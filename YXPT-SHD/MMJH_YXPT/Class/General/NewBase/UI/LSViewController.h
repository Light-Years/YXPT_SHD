//
//  LSViewController.h
//  MaternalInfant
//
//  Created by 王隆帅 on 16/11/17.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSViewControllerProtocol.h"
#import "LSViewModel.h"

@interface LSViewController : UIViewController <LSViewControllerProtocol>

/**
 *  VIEW是否渗透导航栏
 * (YES_VIEW渗透导航栏下／NO_VIEW不渗透导航栏下)
 */
@property (assign,nonatomic) BOOL isExtendLayout;

/**
 初始化方法
 
 @param dataInfo VM
 @param delegate 代理者
 
 @return VM实例
 */
- (instancetype)initWithViewModel:(LSViewModel *)viewModel;



@end
