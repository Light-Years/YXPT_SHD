//
//  AddressCellViewModel.h
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/28.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSViewModel.h"
#import "CellModel.h"
@interface AddressCellViewModel : LSViewModel
/**
  纯粹的数据模型
 */
@property (nonatomic,strong) CellModel *model;
@end
