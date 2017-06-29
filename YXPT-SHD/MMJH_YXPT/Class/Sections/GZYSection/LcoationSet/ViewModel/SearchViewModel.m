
//
//  SearchViewModel.m
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/30.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "SearchViewModel.h"
#import "LocationlistModel.h"
@implementation SearchViewModel
-(RACSubject*)CellClickSubject
{
    if (!_CellClickSubject) {
        _CellClickSubject=[RACSubject subject];
    }
    return _CellClickSubject;
}
-(NSMutableArray*)CityModelArray
{
    if (!_CityModelArray) {
        _CityModelArray=[NSMutableArray array];
    }
    return _CityModelArray;
}
-(RACCommand*)refreshCommand
{
    if (!_refreshCommand) {
        _refreshCommand=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSString* url=[NSString stringWithFormat:@"%@%@",REQUEST_URL,@"GetLocationCityList.aspx"];
                
                NSLog(@"%@",url);
                
                [[CMRequest request]POST:url parameters:nil success:^(CMRequest *request, NSString *responseString) {
                    
                    NSDictionary* dic=[responseString objectFromJSONString];
                    
                    if ([IF_NULL_TO_STRING(dic[@"status"]) intValue]==0) {
                        
                        self.CityModelArray=[LocationlistModel objectArrayWithKeyValuesArray:dic[@"res"][@"List"]];
                        [subscriber sendNext:nil];
                        [subscriber sendCompleted];
                        
                    }else
                    {
                        [self ls_showError:IF_NULL_TO_STRING(dic[@"mes"])];
                    }
                    
                } failure:^(CMRequest *request, NSError *error) {
                    [self ls_showError:@"网络连接失败"];
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                }];
                
                
                
                return nil;
            }];
        }];
    }
    return _refreshCommand;
}
@end
