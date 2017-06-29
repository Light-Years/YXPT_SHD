//
//  LocationCell.h
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/28.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSTableViewCell.h"
#import "AddressCellViewModel.h"
#import <BaiduMapKit/BaiduMapAPI_Search/BMKPoiSearch.h>
@interface LocationCell : LSTableViewCell
@property (nonatomic,strong) AddressCellViewModel *viewModel;
+(instancetype)CellWithTableView:(UITableView*)tableView;

@property (nonatomic,strong) BMKPoiInfo* info;
@end
