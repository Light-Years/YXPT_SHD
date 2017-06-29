//
//  CityModel.h
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/30.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 "ID": 654,
 "Head": "A",
 "Name": "安图",
 "Name2": "安图县",
 "X": "128.90625",
 "Y": "43.11533"
 */
@interface LocationModel : NSObject

@property (nonatomic,strong) NSNumber *ID;
@property (nonatomic,copy) NSString *Head;
@property (nonatomic,copy) NSString *Name;
@property (nonatomic,copy) NSString *Name2;
@property (nonatomic,copy) NSString *X;
@property (nonatomic,copy) NSString *Y;

@end
