//
//  POISearchModel.h
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/30.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSViewModel.h"
#import <BaiduMapKit/BaiduMapAPI_Search/BMKPoiSearch.h>
@interface POISearchViewModel : LSViewModel<BMKPoiSearchDelegate>
/**
 POI搜索命令
 */
@property (nonatomic,strong) RACCommand *POISearchCommand;

/**
 检索回调
 */
@property (nonatomic,strong) RACSubject *retrivalSubject;

/**
 cell点击的回调
 */
@property (nonatomic,strong) RACSubject *CellClickSubject;
/**
  
 */
@property (nonatomic,strong) NSMutableArray *CellModelArray;
/**
 parameter Message 搜索的参数字典
 */
-(void)getNewDataWithInfo:(id)message;
/** 
 获取首页数据
 */
-(void)refreshNewData;
/**
  获得更多数据
 */
-(void)getMoreData;
@end
