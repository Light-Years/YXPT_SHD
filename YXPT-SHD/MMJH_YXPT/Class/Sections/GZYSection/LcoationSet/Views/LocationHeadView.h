//
//  LocationHeadView.h
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/28.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSView.h"
#import "LocationHeadViewModel.h"
#import "LocationModel.h"
@interface LocationHeadView : LSView
/**
 头ViewModel
 */
@property (nonatomic,strong) LocationHeadViewModel *viewModel;

/**
 存放位置信息
 */
@property (nonatomic,strong) LocationModel *Model;


@end
