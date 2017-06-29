//
//  YQYViewModelProtocol.h
//  MaternalInfant
//
//  Created by 王隆帅 on 15/11/24.
//  Copyright © 2015年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YQYViewModelProtocol <NSObject>

@optional

@property (strong, nonatomic)CMRequest *request;

@property (nonatomic, strong, readonly) RACSubject *errors;

@property (nonatomic, copy) NSString *currentVCName;
/**
 *  0 不需要更新 1 需要更新
 */
@property (nonatomic, copy) NSString *canLayOutUI;

/**
 *  初始化
 */
- (void)initialize;

/**
 *  下拉刷新
 */
- (void)ls_refreshData;

/**
 *  上拉加载
 */
- (void)ls_addNextPageData;
/**
 *  更新UI
 */
- (void)ls_refreshUI;

@end
