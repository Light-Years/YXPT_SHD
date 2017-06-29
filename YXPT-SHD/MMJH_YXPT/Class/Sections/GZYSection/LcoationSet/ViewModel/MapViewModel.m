
//
//  MapViewModel.m
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/4/11.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "MapViewModel.h"
#import <BaiduMapKit/BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapKit/BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import <BaiduMapKit/BaiduMapAPI_Search/BMKPoiSearch.h>

@interface MapViewModel()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKPoiSearchDelegate>

@property (nonatomic,assign) CLLocationCoordinate2D location2D;

@property (nonatomic, strong)BMKGeoCodeSearch* searchAddress;
@property (nonatomic,strong)BMKUserLocation *userLocation; //定位功能
@property (nonatomic,strong) BMKLocationService * locService;

/**
 poi搜索
 */
@property (nonatomic,strong) BMKPoiSearch *poiSeach;

@end

@implementation MapViewModel

#pragma mark-LazyLoad
-(RACSubject*)refreshLocation
{
    if (!_refreshLocation) {
        _refreshLocation=[RACSubject subject];
    }
    return _refreshLocation;
}
-(RACSubject*)SearchCompleteSubject
{
    if (!_SearchCompleteSubject) {
        _SearchCompleteSubject=[RACSubject subject];
    }
    return _SearchCompleteSubject;
}
-(BMKPoiSearch*)poiSeach
{
    if (!_poiSeach) {
        _poiSeach = [[BMKPoiSearch alloc]init];
        _poiSeach.delegate = self;
    }
    return _poiSeach;
}
-(RACSubject*)LocationSubject
{
    if (!_LocationSubject) {
        _LocationSubject=[RACSubject subject];
    }
    return _LocationSubject;
}
-(RACSubject*)GeoCodeSubject
{
    if (!_GeoCodeSubject) {
        _GeoCodeSubject=[RACSubject subject];
    }
    return _GeoCodeSubject;
}

-(BMKGeoCodeSearch*)searchAddress
{
    if (!_searchAddress) {
        _searchAddress=[[BMKGeoCodeSearch alloc] init];
        _searchAddress.delegate=self;
    }
    return _searchAddress;
}
-(BMKLocationService*)locService
{
    if (!_locService) {
        _locService=[[BMKLocationService alloc] init];
        _locService.delegate=self;
    }
    return _locService;
}
-(RACCommand*)ReverGeoCodeCommand
{
    if (!_ReverGeoCodeCommand) {
        _ReverGeoCodeCommand=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                BMKReverseGeoCodeOption * option=input;
                
                self.location2D=option.reverseGeoPoint;
                
                [self.searchAddress reverseGeoCode:option];
                
               
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
                return nil;
            }];
            
        }];
    }
    return _ReverGeoCodeCommand;
}
-(RACCommand*)POISearchCommand
{
    if (!_POISearchCommand) {
        _POISearchCommand=[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
             
                
                BMKNearbySearchOption *nearBySearchOption = [[BMKNearbySearchOption alloc]init];
//                nearBySearchOption.pageIndex = self.page; //第几页
                nearBySearchOption.pageCapacity = 10;  //最多几页
                nearBySearchOption.keyword = input;
                
                nearBySearchOption.location =self.location2D;
    
                
                nearBySearchOption.radius = 10000; //检索范围 m
                [self.poiSeach poiSearchNearBy:nearBySearchOption];
                
                NSLog(@"%@==%f===%f",nearBySearchOption.keyword,nearBySearchOption.location.longitude,nearBySearchOption.location.latitude);
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
                return nil;
            }];
        }];
    }
    return _POISearchCommand;
}
#pragma mark-定位,地理编码,模糊搜索的代理
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [self.locService stopUserLocationService];
    [self.LocationSubject sendNext:userLocation];}


//根据经纬度返回点击的位置的名称
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    
    
    [self.SearchCompleteSubject sendNext:result.poiList];
    /*
    NSString * resultAddress = @"";
    NSString * houseName = @"";
    
    
    
    NSLog(@"%@",result.poiList);
  
    if(result.poiList.count > 0){
        BMKPoiInfo * info = result.poiList[0];
        if([info.name rangeOfString:@"-"].location != NSNotFound){
            houseName = [info.name componentsSeparatedByString:@"-"][0];
        }else{
            houseName = info.name;
        }
        resultAddress = [NSString stringWithFormat:@"%@%@",result.address,info.name];
    }else{
        resultAddress =result.address;
    }
    
    if(resultAddress.length == 0){
        resultAddress = @"位置解析错误，请拖动重试！";
        return;
    }
    
    [self.GeoCodeSubject sendNext:resultAddress];
    
    [self.POISearchCommand execute:resultAddress];
   */
    
}
#pragma mark-模糊搜索回调
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    
     [self.SearchCompleteSubject sendNext:poiResult.poiInfoList];

}
-(void)startLocation
{
    [self.locService startUserLocationService];
}
@end
