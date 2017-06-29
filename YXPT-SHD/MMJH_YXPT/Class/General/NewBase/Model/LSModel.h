//
//  LSModel.h
//  MaternalInfant
//
//  Created by 王隆帅 on 16/11/17.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

/**
 Model 用于处理Requeset、DataBase（包括本地数据库及文件处理）
 */

#import <Foundation/Foundation.h>
#import "LSModelProtocol.h"

@interface LSModel : NSObject <LSModelProtocol>

/**
 观察者数组
 */
@property (nonatomic, strong, readonly) NSHashTable *observers;

/**
 代理者
 */
@property (nonatomic, weak) id<LSModelDelegate> delegate;

@end
