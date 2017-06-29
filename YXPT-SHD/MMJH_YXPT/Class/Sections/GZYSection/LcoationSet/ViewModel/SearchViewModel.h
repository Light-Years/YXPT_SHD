//
//  SearchViewModel.h
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/30.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSViewModel.h"

@interface SearchViewModel : LSViewModel
/**
 获取城市命令
 */
@property (nonatomic,strong) RACCommand *refreshCommand;

/**
 模型数组
 */
@property (nonatomic,strong) NSMutableArray *CityModelArray;

/**
 Cell点击的回调
 */
@property (nonatomic,strong) RACSubject *CellClickSubject;
@end
