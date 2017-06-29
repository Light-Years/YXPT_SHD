//
//  LocationMainView.h
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/28.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSView.h"
#import "LocationMainViewModel.h"
#import "LocationModel.h"
@interface LocationMainView : LSView
/**
 MainViewModel
 */
@property (nonatomic,strong) LocationMainViewModel *ViewModel;

/**
 是否展示地图
 */
@property (nonatomic,assign) BOOL IsshowMapView;
-(void)refreshAddress;
/**
 存放位置信息
 */
@property (nonatomic,strong) LocationModel *Model;
@end
