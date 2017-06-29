//
//  MapViewModel.h
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/4/11.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSViewModel.h"

@interface MapViewModel : LSViewModel
/**
 定位回调
 */
@property (nonatomic,strong) RACSubject *LocationSubject;
// 地理编码回调
@property (nonatomic,strong) RACSubject *GeoCodeSubject;

/**
 反地理编码命令
 */
@property (nonatomic,strong) RACCommand *ReverGeoCodeCommand;

/**
 poi搜索命令
 */
@property (nonatomic,strong) RACCommand *POISearchCommand;

/**
 poi搜索完成回调
 */
@property (nonatomic,strong) RACSubject *SearchCompleteSubject;

/**
 选择城市 重新定位
 */
@property (nonatomic,strong) RACSubject *refreshLocation;

-(void)startLocation;
@end
