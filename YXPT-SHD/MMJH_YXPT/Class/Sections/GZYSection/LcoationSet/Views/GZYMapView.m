//
//  MapView.m
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/4/11.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "GZYMapView.h"
#import <BaiduMapKit/BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapKit/BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import <BaiduMapKit/BaiduMapAPI_Search/BMKPoiSearch.h>
#import "LocationModel.h"

@interface GZYMapView()<BMKMapViewDelegate>
@property (nonatomic,strong) UILabel * addressLabel;
@property (nonatomic,strong) NSString * name;

@property (nonatomic,assign) CLLocationCoordinate2D location2D;
@property (strong, nonatomic) BMKMapView *mapView;

@property (nonatomic,strong) UIImageView *markImageVew;

@property (nonatomic,strong) UIButton *refreshCurrenLocation;

@end

@implementation GZYMapView
-(UIButton*)refreshCurrenLocation
{
    if (!_refreshCurrenLocation) {
        _refreshCurrenLocation=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_refreshCurrenLocation setImage:[UIImage imageNamed:@"refresh.png"] forState:0];
        
        [[_refreshCurrenLocation rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
           
            [self.ViewModel startLocation];
        }];
        
        [self.mapView addSubview:_refreshCurrenLocation];
    }
    return _refreshCurrenLocation;
}
-(UILabel*)addressLabel
{
    if (!_addressLabel) {
        _addressLabel=[[UILabel alloc] init];
        _addressLabel.backgroundColor=[UIColor whiteColor];
        [self.mapView addSubview:_addressLabel];
    }
    return _addressLabel;
}
-(UIImageView*)markImageVew
{
    if (!_markImageVew) {
        _markImageVew=[[UIImageView alloc] init];
        _markImageVew.image=[UIImage imageNamed:@"定位.png"];
        [self.mapView addSubview:_markImageVew];
    }
    return _markImageVew;
    
}

-(void)ls_makeConstraints
{
    [self.markImageVew mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.equalTo(self.mapView);
        make.height.equalTo(25);
        make.width.equalTo(25);
    }];
    [self.refreshCurrenLocation mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(self.mapView).offset(20);
        make.bottom.equalTo(self.mapView).offset(-25);
        make.height.equalTo(25);
        make.width.equalTo(25);
    }];
    
}

-(void)ls_getViewModel:(id<LSViewModelProtocol>)viewModel
{
    _ViewModel=(MapViewModel*)viewModel;
}

#pragma mark-LazyLoad

-(BMKMapView*)mapView
{
    if (!_mapView) {
        _mapView=[[BMKMapView alloc] init];
        _mapView.delegate=self;
        _mapView.mapType=BMKMapTypeStandard;
        _mapView.showsUserLocation = NO;//先关闭显示的定位图层
        _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
        _mapView.showsUserLocation = YES;//显示定位图层
        _mapView.showMapScaleBar = YES;//显示比例尺
        _mapView.zoomLevel = 17;//地图显示的级别

        [self addSubview:_mapView];
    }
    return _mapView;
}
-(void)initUI
{
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self);
    }];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self initUI];
}
-(void)ls_bindViewModel
{
    
    [self.ViewModel.LocationSubject subscribeNext:^(id x)
    {
        BMKUserLocation*userLocation=x;
        
        [_mapView updateLocationData:userLocation];
       
        _mapView.centerCoordinate = userLocation.location.coordinate;
        
    }];
    
    [self.ViewModel.GeoCodeSubject subscribeNext:^(id x) {
        NSString*resultAddress=x;
        
        NSLog(@"%@",resultAddress);
        
    }];
    
    [self.ViewModel.refreshLocation subscribeNext:^(id x) {
       
        LocationModel* model=x;
        CLLocation* cityLocation=[[CLLocation alloc]initWithLatitude:[model.Y floatValue] longitude:[model.X floatValue]];
        
        BMKUserLocation* userlocation=[[BMKUserLocation alloc] init];
       // kvc
        [userlocation setValue:cityLocation forKey:@"_location"];

        [_mapView updateLocationData:userlocation];
        
        _mapView.centerCoordinate = userlocation.location.coordinate;
        
    }];
    
    [self.ViewModel startLocation];
}
#pragma mark-定位 ,地图, 地理编码的代理

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animate
{

    BMKReverseGeoCodeOption * option = [[BMKReverseGeoCodeOption alloc]init];
    option.reverseGeoPoint = _mapView.centerCoordinate;//touchMapCoordinate;
    [self.ViewModel.ReverGeoCodeCommand execute:option];
}


@end







