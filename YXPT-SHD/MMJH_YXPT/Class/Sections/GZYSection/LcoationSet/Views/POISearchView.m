//
//  POISearchView.m
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/30.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "POISearchView.h"
#import <BaiduMapKit/BaiduMapAPI_Search/BMKPoiSearch.h>
#import "HeadView.h"
#import "POISearchCell.h"
@interface POISearchView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *POITableView;

/**
 TableView头视图
 */
@property (nonatomic,strong) HeadView *tableHeadView;

@end

@implementation POISearchView
-(UITableView*)POITableView
{
    if (!_POITableView) {
        _POITableView=[[UITableView alloc]init];
        
        _POITableView.dataSource=self;
        
        _POITableView.delegate=self;
        _POITableView.tableHeaderView=self.tableHeadView;
        [self addSubview:_POITableView];
        
        _POITableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.ViewModel refreshNewData];
        }];
        
        _POITableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [self.ViewModel getMoreData];
        }];
        _POITableView.separatorStyle=UITableViewCellSeparatorStyleNone;

    }
    return _POITableView;
}
-(HeadView*)tableHeadView
{
    if (!_tableHeadView) {
        _tableHeadView=[[HeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.059)];
        _tableHeadView.hiddenLefrImageVew=YES;
        _tableHeadView.TitleLabel.text=@"搜索到的地址";
        _tableHeadView.TitleLabel.textColor=DSColor(153,153,153);
    }
    return _tableHeadView;
}
-(void)ls_makeConstraints
{
    [self.POITableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
-(void)ls_getViewModel:(id<LSViewModelProtocol>)viewModel
{
    _ViewModel=(POISearchViewModel*)viewModel;
}
-(void)ls_bindViewModel
{
    [self.ViewModel.retrivalSubject subscribeNext:^(id x) {
    
        if ([x boolValue]) {
            [self.POITableView.mj_footer endRefreshing];
        }else
        {
          [self.POITableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.POITableView.mj_header endRefreshing];
        [self.POITableView reloadData];
    }];
    
    self.translatesAutoresizingMaskIntoConstraints=NO;
}
#pragma mark- TableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ViewModel.CellModelArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    POISearchCell* cell=[POISearchCell SearchCellWithTableView:tableView];
    BMKPoiInfo* info=[self.ViewModel.CellModelArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor=DSColor(51,51,51);
    cell.textLabel.text=[NSString stringWithFormat:@"%@ , %@",info.name,info.address];
    cell.textLabel.numberOfLines=0;
    
    return cell;
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.superview endEditing:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.ViewModel.CellClickSubject sendNext:[self.ViewModel.CellModelArray objectAtIndex:indexPath.row]];
}
@end










