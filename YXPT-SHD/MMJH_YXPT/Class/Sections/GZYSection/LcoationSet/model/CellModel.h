//
//  CellModel.h
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/28.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject
/**
 "moren":"1",
 "id":"89",
 "name":"门面",
 "address":"发的",
 "phone":"15686555585",
 "phone2":"",
 "postcode":",",
 "area":"河北省.张家口市.尚义县"
 */
@property (nonatomic,copy) NSString *moren;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *phone2;
@property (nonatomic,copy) NSString *postcode;
@property (nonatomic,copy) NSString *area;
@property (nonatomic,copy) NSString *x;
@property (nonatomic,copy) NSString *y;
@end
