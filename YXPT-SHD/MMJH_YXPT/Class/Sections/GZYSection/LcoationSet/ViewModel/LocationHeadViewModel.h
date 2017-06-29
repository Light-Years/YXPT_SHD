//
//  LocationHeadViewModel.h
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/28.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSViewModel.h"
@interface LocationHeadViewModel : LSViewModel
/**
 返回命令
 */
@property (nonatomic,strong) RACCommand *BackCommand;
/**
 城市按钮
 */
@property (nonatomic,strong) RACCommand *CityCommand;
/**
 POI搜索
 */
@property (nonatomic,strong) RACCommand *POICommand;

/**
 当没有数据时候 隐藏头试图
 */
@property (nonatomic,strong) RACSubject *HideTableViewSubject;

/**
 修改城市名城
 */
@property (nonatomic,strong) RACSubject *ChangeTitleSubject;

@end
