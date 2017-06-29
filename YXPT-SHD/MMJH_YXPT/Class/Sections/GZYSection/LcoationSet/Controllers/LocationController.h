//
//  LocationController.h
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/28.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSViewController.h"
#import "LocationControllerViewModel.h"
#import "LocationModel.h"
@interface LocationController : LSViewController
/**
 控制器的ViewModel
 */
@property (nonatomic,strong) LocationControllerViewModel *ViewModel;
/**
 地址
 */
@property (nonatomic,strong) NSString *Location;
/**
 是否展示地图
 */
//@property (nonatomic,assign) BOOL IsshowMapView;

/**
 存放初始的位置信息
 */
@property (nonatomic,strong) LocationModel *model;
@end
