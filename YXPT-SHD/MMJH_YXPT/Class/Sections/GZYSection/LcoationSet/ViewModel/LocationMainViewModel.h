//
//  LocationMainViewModel.h
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/28.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSViewModel.h"
#import "LocatinCenterViewModel.h"
#import "LocationHeadViewModel.h"
#import "AddressTableViewModel.h"
#import "SearchViewModel.h"
#import "POISearchViewModel.h"
#import "MapViewModel.h"
@interface LocationMainViewModel : LSViewModel
/**
 HeadViewModel
 */
@property (nonatomic,strong) LocationHeadViewModel *HeadViewModel;
/**
 CenterViewModel
 */
@property (nonatomic,strong) LocatinCenterViewModel *CenterViewModel;

/**
 地图Viewmodel
 */
@property (nonatomic,strong) MapViewModel *PaltViewModel;
/**
 HeadViewModel
 */
@property (nonatomic,strong) AddressTableViewModel *AddressViewModel;
/**
 搜索ViewMdoel
 */
@property (nonatomic,strong) SearchViewModel *search;
/**
 搜索POIViewMdoel
 */
@property (nonatomic,strong) POISearchViewModel *POIViewModel
;
/**
 选择地址的回调函数
 */
@property (nonatomic,strong) RACSubject *SeletedSubject;
@end
