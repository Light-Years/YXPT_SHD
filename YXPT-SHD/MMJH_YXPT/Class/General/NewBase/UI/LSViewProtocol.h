//
//  LSViewProtocol.h
//  MaternalInfant
//
//  Created by 王隆帅 on 16/11/17.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSViewModelProtocol.h"

@protocol LSViewProtocol <NSObject>

/**
 初始化数据
 */
- (void)ls_initData;

/**
 初始化Views
 */
- (void)ls_setupViews;

/**
 添加约束
 */
- (void)ls_makeConstraints;

/**
 绑定VM
 */
- (void)ls_bindViewModel;

/**
 设置VM
 */
- (void)ls_getViewModel:(id<LSViewModelProtocol>)viewModel;

@end

@protocol LSViewDelegate <NSObject>

@end
