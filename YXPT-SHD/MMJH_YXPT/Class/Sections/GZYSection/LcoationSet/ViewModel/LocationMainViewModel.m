//
//  LocationMainViewModel.m
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/28.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LocationMainViewModel.h"

@implementation LocationMainViewModel
-(MapViewModel*)PaltViewModel
{
    if (!_PaltViewModel) {
        _PaltViewModel=[[MapViewModel alloc] init];
    }
    return _PaltViewModel;
}
-(RACSubject*)SeletedSubject
{
    if (!_SeletedSubject) {
        _SeletedSubject=[RACSubject subject];
    }
    return _SeletedSubject;
}
-(SearchViewModel*)search
{
    if (!_search) {
        _search=[[SearchViewModel alloc] init];
    }
    return _search;
}
-(POISearchViewModel*)POIViewModel
{
    if (!_POIViewModel) {
        _POIViewModel=[[POISearchViewModel alloc] init];
    }
    return _POIViewModel;
}
-(LocationHeadViewModel*)HeadViewModel
{
    if (!_HeadViewModel) {
        _HeadViewModel=[[LocationHeadViewModel alloc] init];
    }
    return _HeadViewModel;
}
-(LocatinCenterViewModel*)CenterViewModel
{
    if (!_CenterViewModel) {
        _CenterViewModel=[[LocatinCenterViewModel alloc] init];
    }
    return _CenterViewModel;
}
-(AddressTableViewModel*)AddressViewModel
{
    if (!_AddressViewModel) {
        _AddressViewModel=[[AddressTableViewModel alloc] init];
    }
    return _AddressViewModel;
}
@end
