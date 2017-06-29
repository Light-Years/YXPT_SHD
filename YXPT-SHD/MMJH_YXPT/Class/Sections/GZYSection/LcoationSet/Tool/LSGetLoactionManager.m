//
//  LSGetLoactionManager.m
//  MaternalInfant
//
//  Created by 王隆帅 on 16/12/23.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "LSGetLoactionManager.h"
#import <CoreLocation/CoreLocation.h>
#import <BaiduMapKit/BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapKit/BaiduMapAPI_Search/BMKGeocodeSearch.h>

@interface LSGetLoactionManager ()<CLLocationManagerDelegate,BMKLocationServiceDelegate>

@property (nonatomic, strong) CLLocationManager* locationManager;

/**
 百度地图位置管理者
 */
@property (nonatomic, strong) BMKLocationService *localService;

@property (nonatomic, assign) CGFloat currentLongitude;

@property (nonatomic, assign) CGFloat currentLatitude;

@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *cityName;

@end

@implementation LSGetLoactionManager
-(BMKLocationService*)localService
{
    if (!_localService) {
        _localService=[[BMKLocationService alloc]init];
        _localService.delegate=self;
    }
    return _localService;
}

+ (instancetype)sharedInstance {
    
    static LSGetLoactionManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LSGetLoactionManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {

    if (self = [super init]) {
        
        self.currentLongitude = 0.0;
        self.currentLatitude = 0.0;
        self.city = @"";
    }
    
    return self;
}

- (NSString *)getLatitude {

    return [NSString stringWithFormat:@"%f",self.currentLatitude];
}

- (NSString *)getLongitude {

    return [NSString stringWithFormat:@"%f",self.currentLongitude];
}
-(CLLocationCoordinate2D)getLocation
{
    return CLLocationCoordinate2DMake(self.currentLatitude, self.currentLongitude);
}
-(NSString*)getCityName
{
    return self.cityName;
}
- (NSString *)getCity {

    return self.city;
}

//开始定位
- (void)startLocation {
    
    [self.localService startUserLocationService];
}

#pragma mark -- BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    self.currentLatitude = userLocation.location.coordinate.latitude;//newLocation.coordinate.latitude;
    self.currentLongitude = userLocation.location.coordinate.longitude;
    
    
    
    NSLog(@"*******************");
    NSLog(@"Y纬度%f",self.currentLatitude);//  Y
    NSLog(@"X经度%f",self.currentLongitude);// X
    
    //X／Y添加到userdefaults
    [[NSUserDefaults standardUserDefaults] setFloat:userLocation.location.coordinate.latitude forKey:@"LocationY"];
    [[NSUserDefaults standardUserDefaults] setFloat:userLocation.location.coordinate.longitude forKey:@"LocationX"];
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            //获取城市,区域,街道
            NSString *city = placemark.locality;
            NSString *sublocality = placemark.subLocality;
            NSString *street = placemark.thoroughfare;
            //            NSString *subStreet = placemark.subThoroughfare;
            //            NSString *details = placemark.name;
            
            self.cityName=city;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
                self.city = city;
            }
            else
            {
                NSString *location = [NSString stringWithFormat:@"%@%@%@",city,sublocality,street];
                self.city = location;
            }
            NSLog(@"city = %@", self.city);
            
            
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
        
        [self.completeSubject sendNext:@(YES)];
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [self.localService stopUserLocationService];

   
    
}
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
//   
//    if ([error code] == kCLErrorDenied) {
//       
//        NSLog(@"访问被拒绝");
//        [self.completeSubject sendNext:@(NO)];
//    }
//    
//    if ([error code] == kCLErrorLocationUnknown) {
//       
//        NSLog(@"无法获取位置信息");
//        [self.completeSubject sendNext:@(NO)];
//    }
//}
//
////定位代理经纬度回调
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
//    
//    
//    NSLog(@"%@",self.locationManager);
//    
//    
//    CLLocation *newLocation = locations[0];
//    self.currentLatitude = newLocation.coordinate.latitude;
//    self.currentLongitude = newLocation.coordinate.longitude;
//    
//    NSLog(@"*******************");
//    NSLog(@"Y纬度%f",self.currentLatitude);//  Y
//    NSLog(@"X经度%f",self.currentLongitude);// X
//    
//    //X／Y添加到userdefaults
//    [[NSUserDefaults standardUserDefaults] setFloat:newLocation.coordinate.latitude forKey:@"LocationY"];
//    [[NSUserDefaults standardUserDefaults] setFloat:newLocation.coordinate.longitude forKey:@"LocationX"];
//    
//    // 获取当前所在的城市名
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    //根据经纬度反向地理编译出地址信息
//    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
//        if (array.count > 0){
//            CLPlacemark *placemark = [array objectAtIndex:0];
//            
//            //获取城市,区域,街道
//            NSString *city = placemark.locality;
//            NSString *sublocality = placemark.subLocality;
//            NSString *street = placemark.thoroughfare;
////            NSString *subStreet = placemark.subThoroughfare;
////            NSString *details = placemark.name;
//            
//            self.cityName=city;
//            if (!city) {
//                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
//                city = placemark.administrativeArea;
//                self.city = city;
//            }
//            else
//            {
//                NSString *location = [NSString stringWithFormat:@"%@%@%@",city,sublocality,street];
//                self.city = location;
//            }
//            NSLog(@"city = %@", self.city);
//            
//            
//        }
//        else if (error == nil && [array count] == 0)
//        {
//            NSLog(@"No results were returned.");
//        }
//        else if (error != nil)
//        {
//            NSLog(@"An error occurred = %@", error);
//        }
//        
//        [self.completeSubject sendNext:@(YES)];
//    }];
//    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
//    [manager stopUpdatingLocation];
//    
//}

- (RACSubject *)completeSubject {

    if (!_completeSubject) {
        
        _completeSubject = [RACSubject subject];
    }
    
    return _completeSubject;
}

@end
