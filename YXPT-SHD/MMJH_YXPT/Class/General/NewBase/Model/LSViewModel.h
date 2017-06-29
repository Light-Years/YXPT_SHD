//
//  LSViewModel.h
//  MaternalInfant
//
//  Created by 王隆帅 on 16/11/17.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

/**
 ViewModel 处理V相关逻辑部分与Model对接，持有Info数据模型
 */

#import <Foundation/Foundation.h>
#import "LSViewModelProtocol.h"
#import "LSDataInfo.h"

@interface LSViewModel : NSObject <LSViewModelProtocol> {

    LSDataInfo *_dataInfo;
    NSHashTable *_observers;
      __weak NSObject<LSViewModelDelegate> *_delegate;
}


/**
 初始化方法

 @param dataInfo 数据模型
 @param delegate 代理者

 @return VM实例
 */
- (id)initWithDataInfo:(LSDataInfo *)dataInfo delegate:(NSObject<LSViewModelDelegate> *)delegate;

@end
