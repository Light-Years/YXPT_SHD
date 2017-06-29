
//
//  LocationHeadViewModel.m
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/28.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LocationHeadViewModel.h"
#import "LocationlistModel.h"

BOOL hidden=YES;

@implementation LocationHeadViewModel
-(RACSubject*)ChangeTitleSubject
{
    if (!_ChangeTitleSubject) {
        _ChangeTitleSubject=[RACSubject subject];
    }
    return _ChangeTitleSubject;
}
-(RACSubject*)HideTableViewSubject
{
    if (!_HideTableViewSubject) {
        _HideTableViewSubject=[RACSubject subject];
    }
    return _HideTableViewSubject;
}
-(RACCommand*)POICommand
{
    if (!_POICommand) {
        _POICommand=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
           return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
             
               NSLog(@"POICommandPOICommand");
               
               [subscriber sendNext:input];
               [subscriber sendCompleted];
               
               return nil;
           }];
        }];
    }
    return _POICommand;
}
-(RACCommand*)CityCommand
{
    if (!_CityCommand) {
        _CityCommand=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                [subscriber sendNext:@(hidden)];
                [subscriber sendCompleted];
                hidden=!hidden;
                return nil;
            }];
        }];
    }
    return _CityCommand;
}
-(RACCommand*)BackCommand
{
    if (!_BackCommand) {
        _BackCommand=[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
                return nil;
            }];
            
        }];
    }
    return _BackCommand;
}
@end
