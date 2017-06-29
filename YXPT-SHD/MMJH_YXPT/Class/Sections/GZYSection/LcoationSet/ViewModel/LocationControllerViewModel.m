
//
//  LocationControllerViewModel.m
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/4/7.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LocationControllerViewModel.h"

@implementation LocationControllerViewModel
-(RACSubject*)BackRefreshSubject
{
    if (!_BackRefreshSubject) {
        _BackRefreshSubject=[RACSubject subject];
    }
    return _BackRefreshSubject;
}
@end
