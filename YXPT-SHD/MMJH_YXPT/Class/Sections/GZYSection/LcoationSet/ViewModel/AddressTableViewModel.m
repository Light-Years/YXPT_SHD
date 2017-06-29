//
//  AddressTableViewModel.m
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/28.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "AddressTableViewModel.h"
#import "CellModel.h"
#import "AddressCellViewModel.h"
@implementation AddressTableViewModel
-(NSMutableArray*)CellViewModelArray
{
    if (!_CellViewModelArray) {
        _CellViewModelArray=[NSMutableArray array];
    }
    return _CellViewModelArray;
}
#pragma mark-一次性获取数据
-(RACCommand*)RefreshCommand
{
    if (!_RefreshCommand) {
        
        _RefreshCommand=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
              
                NSMutableDictionary* parameter=[NSMutableDictionary dictionary];
                
                NSString *url =@"http://182.92.183.143:8050/DeliveryInfoList.aspx?token=e40df7c78c26418eb62f921bca903c97";
                
                NSLog(@"%@==",url);
                
                
                [[CMRequest request] POST:url parameters:parameter success:^(CMRequest *request, NSString *responseString) {
                    
                    NSDictionary* dic=[responseString objectFromJSONString];
                    if ([IF_NULL_TO_STRING(dic[@"status"]) intValue]==0)
                    {
                        NSArray* cellModelArray=[CellModel objectArrayWithKeyValuesArray:dic[@"res"]];
                        
                        for (CellModel* model in cellModelArray)
                        {
                            
                            AddressCellViewModel* viewModel=[AddressCellViewModel new];
                            viewModel.model=model;
                            
                            [self.CellViewModelArray addObject:viewModel];
                            
                        }
                        
                    }
                    else
                    {
                        [self ls_showError:@"网络连接失败"];
                    }
                    
                    
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                } failure:^(CMRequest *request, NSError *error) {
                    
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                    
                }];
                
               
                return nil;
            }];
        }];
        
    }
    return _RefreshCommand;
}
@end

