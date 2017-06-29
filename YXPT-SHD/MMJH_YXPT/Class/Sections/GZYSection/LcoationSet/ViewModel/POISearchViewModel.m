//
//  POISearchModel.m
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/30.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "POISearchViewModel.h"
#import "LSGetLoactionManager.h"
@interface POISearchViewModel()
/**
 poi搜索
 */
@property (nonatomic,strong) BMKPoiSearch *poiSeach;

/**
 
 */
@property (nonatomic,assign) int page;

/**
 参数
 */
@property (nonatomic,strong) id parameter;

@end

@implementation POISearchViewModel
-(void)getNewDataWithInfo:(id)message
{
    self.page=0;
    
    [self.POISearchCommand execute:message];
    
    self.parameter=message;
    
}
-(void)refreshNewData
{
    self.page=0;
    
    [self.POISearchCommand execute:self.parameter];
    
}
-(void)getMoreData
{
    self.page++;
    
    [self.POISearchCommand execute:self.parameter];
}
#pragma mark-LazyLoad
-(NSMutableArray*)CellModelArray
{
    if (!_CellModelArray) {
        _CellModelArray=[NSMutableArray array];
    }
    return _CellModelArray;
}
-(RACSubject*)retrivalSubject
{
    if (!_retrivalSubject) {
        _retrivalSubject=[RACSubject subject];
    }
    return _retrivalSubject;
}
-(BMKPoiSearch*)poiSeach
{
    if (!_poiSeach) {
        _poiSeach = [[BMKPoiSearch alloc]init];
        _poiSeach.delegate = self;
    }
    return _poiSeach;
}
-(RACSubject*)CellClickSubject
{
    if (!_CellClickSubject) {
        _CellClickSubject=[RACSubject subject];
    }
    return _CellClickSubject;
}
-(RACCommand*)POISearchCommand
{
    if (!_POISearchCommand) {
        _POISearchCommand=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                BMKNearbySearchOption *nearBySearchOption = [[BMKNearbySearchOption alloc]init];
                nearBySearchOption.pageIndex = self.page; //第几页
                nearBySearchOption.pageCapacity = 10;  //最多几页
                nearBySearchOption.keyword = [input valueForKey:@"Key"];   //检索关键字
                nearBySearchOption.location =CLLocationCoordinate2DMake([[input valueForKey:@"latitudes"] doubleValue], [[input valueForKey:@"longitude"] doubleValue]);// poi检索点
                
                
//                NSLog(@"%f==%f",nearBySearchOption.location.latitude,nearBySearchOption.location.longitude);
                
                nearBySearchOption.radius = 10000; //检索范围 m
                [self.poiSeach poiSearchNearBy:nearBySearchOption];
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
                return nil;
            }];
        }];
    }
    return _POISearchCommand;
}
#pragma mark-根据数组数量判断状态
-(void)adjustStateWithArray:(NSArray*)infoArray
{
    if (infoArray.count<10) {
        
        [self.retrivalSubject sendNext:@(NO)];
    }
    else{
        
        [self.retrivalSubject sendNext:@(YES)];
    }
    
}
#pragma mark-模糊搜索回调
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    if (errorCode == BMK_SEARCH_NO_ERROR)
    {

        if(self.page==0)
        {
            [self.CellModelArray removeAllObjects];
            [self.CellModelArray addObjectsFromArray:poiResult.poiInfoList];
            [self adjustStateWithArray:poiResult.poiInfoList];
            
        }
        else
        {
           
             [self.CellModelArray addObjectsFromArray:poiResult.poiInfoList];
              [self adjustStateWithArray:poiResult.poiInfoList];
        }
        
    }
    if (errorCode==BMK_SEARCH_RESULT_NOT_FOUND)
    {
        
        if (self.page==0) {
            
            [self.CellModelArray removeAllObjects];
            BMKPoiInfo* info=[[BMKPoiInfo alloc] init];
            info.name=@"抱歉 未找到相关信息";
            info.pt=[[LSGetLoactionManager sharedInstance]getLocation];
            
            [self.CellModelArray addObject:info];
            
        }
        
        [self.retrivalSubject sendNext:@(NO)];
    }
    
}

@end
