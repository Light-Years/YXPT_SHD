//
//  AddressTableViewModel.h
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/28.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSViewModel.h"

@interface AddressTableViewModel : LSViewModel
/**
 刷新
 */
@property (nonatomic,strong) RACCommand *RefreshCommand;
/**
 模型数组
 */
@property (nonatomic,strong) NSMutableArray *CellViewModelArray;
@end
