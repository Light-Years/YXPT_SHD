//
//  LSGetLoactionManager.h
//  MaternalInfant
//
//  Created by 王隆帅 on 16/12/23.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSGetLoactionManager : NSObject

+ (instancetype)sharedInstance;

- (void)startLocation;

@property (nonatomic, strong) RACSubject *completeSubject;

- (NSString *)getLongitude;

- (NSString *)getLatitude;

- (NSString *)getCity;
- (NSString *)getCityName;

- (CLLocationCoordinate2D)getLocation;




@end
