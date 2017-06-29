//
//  LocationCenterView.h
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/28.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSView.h"
#import "LocatinCenterViewModel.h"
@interface LocationCenterView : LSView
/**
 Viewmodel
 */
@property (nonatomic,strong) LocatinCenterViewModel *viewModel;

/**
 初始化的地址
 */
@property (nonatomic,copy) NSString *address;
@end
