//
//  LocationControllerViewModel.h
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/4/7.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSViewModel.h"

@interface LocationControllerViewModel : LSViewModel
/**
 返回刷新回调
 */
@property (nonatomic,strong) RACSubject *BackRefreshSubject;
@end
