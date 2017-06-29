//
//  LocatinCenterViewModel.m
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/28.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LocatinCenterViewModel.h"
#import "LSGetLoactionManager.h"
@implementation LocatinCenterViewModel
-(RACCommand*)refreshCommand
{
    if (!_refreshCommand) {
        
        _refreshCommand=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                
                [[LSGetLoactionManager sharedInstance] startLocation];
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
                
                return nil;
            }];
            
        }];
    }
    return _refreshCommand;
}
@end
