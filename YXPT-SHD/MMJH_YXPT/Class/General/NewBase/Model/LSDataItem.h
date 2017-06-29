//
//  LSDataItem.h
//  MaternalInfant
//
//  Created by 王隆帅 on 16/11/17.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

/**
 与VM对应，VM主要与UI对接进行逻辑处理，DataItem不依赖于UI，单独的数据处理模型，主要进行数据的汇总、处理，与Model、info对接
 */

#import <Foundation/Foundation.h>
#import "LSDataItemProtocol.h"
#import "LSDataInfo.h"

@interface LSDataItem : NSObject <LSDataItemProtocol>

/**
 数据模型
 */
@property (nonatomic, strong, readonly) LSDataInfo *dataInfo;

/**
 观察者数组
 */
@property (nonatomic, strong, readonly) NSHashTable *observers;

/**
 代理者
 */
@property (nonatomic, weak, readonly) id<LSDataItemDelegate> delegate;

/**
 初始化方法
 
 @param dataInfo 数据模型
 @param delegate 代理者
 
 @return VM实例
 */
- (id)initWithDataInfo:(LSDataInfo *)dataInfo delegate:(id<LSDataItemDelegate>)delegate;

@end
