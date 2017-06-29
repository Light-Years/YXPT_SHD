//
//  LocationMainView.m
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/28.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LocationMainView.h"
#import "LocationHeadView.h"
#import "LocationCenterView.h"
#import "LocationCell.h"
#import "SearchView.h"
#import "POISearchView.h"
#import "HeadView.h"
#import "GZYMapView.h"
@interface LocationMainView()<UITableViewDelegate,UITableViewDataSource>
/**
 导航头视图
 */
@property (nonatomic,strong) LocationHeadView *headView;

/**
 中间的地图
 */
@property (nonatomic,strong) GZYMapView *PlatView;


/**
 地址tableView
 */
@property (nonatomic,strong) UITableView *AddressTableView;

/**
 城市搜索
 */
@property (nonatomic,strong) SearchView *citySearch;

/**
 
 */
@property (nonatomic,strong) POISearchView *POIsearch;

/**
 TableView头视图
 */
@property (nonatomic,strong) HeadView *tableHeadView;

/**
 
 */
@property (nonatomic,strong) UIView *lineView;


@end

@implementation LocationMainView
-(void)ls_initData
{
    self.IsshowMapView=NO;
}
-(void)setModel:(LocationModel *)Model
{
    _Model=Model;
    
    self.headView.Model=Model;
    
    
}
-(void)ls_bindViewModel
{
    
    // 城市按钮点击的回调
    [self.ViewModel.HeadViewModel.CityCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
       
        
        if ([x boolValue]) {
            [self bringSubviewToFront:self.citySearch];
        }
        else
        {
           [self sendSubviewToBack:self.citySearch];
        }
        
        [self.citySearch refreshData];
    }];
    //poi检索按钮点击的回调
    [self.ViewModel.HeadViewModel.POICommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        
        [self.ViewModel.POIViewModel getNewDataWithInfo:x];
        
    }];
    
    [self.ViewModel.HeadViewModel.HideTableViewSubject subscribeNext:^(id x) {
        
        if (![x boolValue]) {
            [self bringSubviewToFront:self.POIsearch];
        }
        else
        {
            [self sendSubviewToBack:self.POIsearch];
        }

        
    }];
    // 设置城市名称的回调
    [self.ViewModel.search.CellClickSubject subscribeNext:^(id x) {

        [self.ViewModel.HeadViewModel.ChangeTitleSubject sendNext:x];
        
        [self.ViewModel.PaltViewModel.refreshLocation sendNext:x];
        
    }];
    
    [self.ViewModel.POIViewModel.CellClickSubject subscribeNext:^(id x) {
        
        [self.ViewModel.SeletedSubject sendNext:x];
        
    }];
    
    [self.ViewModel.PaltViewModel.SearchCompleteSubject subscribeNext:^(id x) {
    
        
        self.ViewModel.AddressViewModel.CellViewModelArray=x;
        
        if (self.ViewModel.AddressViewModel.CellViewModelArray.count==0) {
            
            [self ls_showError:@"暂无数据"];
        
        }
        
        [self.AddressTableView reloadData];
    }];
    
}
-(void)ls_makeConstraints
{
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self).offset(20);
        make.height.equalTo(SCREEN_HEIGHT*0.03748*2);
        
    }];
    
    [self.PlatView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.headView.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(SCREEN_HEIGHT*0.4);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.PlatView.mas_bottom);
        make.left.and.right.equalTo(self);
        make.height.equalTo(SCREEN_WIDTH*0.0213);
        
    }];
    
    [self.AddressTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.left.and.right.and.bottom.equalTo(self);
        
    }];
    [self.citySearch mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.headView.mas_bottom);
        make.left.and.bottom.right.equalTo(self);
    }];
    
    [self.POIsearch mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.headView.mas_bottom);
        make.left.and.bottom.right.equalTo(self);
    }];
    
}

-(void)refreshAddress
{
    [self.ViewModel.AddressViewModel.RefreshCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
            
            [self.AddressTableView reloadData];
        }];
    [self.ViewModel.AddressViewModel.RefreshCommand execute:nil];
}
#pragma mark-TableView代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ViewModel.AddressViewModel.CellViewModelArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationCell* cell=[LocationCell CellWithTableView:tableView];
    
    NSObject* model=self.ViewModel.AddressViewModel.CellViewModelArray[indexPath.row];
    if ([model isKindOfClass:[AddressCellViewModel class]]) {
     
         cell.viewModel=self.ViewModel.AddressViewModel.CellViewModelArray[indexPath.row];
    }
    else
    {
        cell.info=self.ViewModel.AddressViewModel.CellViewModelArray[indexPath.row];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_HEIGHT*0.12;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSObject* model=self.ViewModel.AddressViewModel.CellViewModelArray[indexPath.row];
    if ([model isKindOfClass:[AddressCellViewModel class]]) {
        
        AddressCellViewModel*AddressViewModel=(AddressCellViewModel*)model;
        
        [self.ViewModel.SeletedSubject sendNext:AddressViewModel.model];
    }
    else
    {
        [self.ViewModel.SeletedSubject sendNext:model];
    }
    
}
#pragma mark- LazyLoad
-(GZYMapView*)PlatView
{
    if (!_PlatView) {
        _PlatView=[[GZYMapView alloc] initWithViewModel:self.ViewModel.PaltViewModel];
        [self addSubview:_PlatView];
    }
    return _PlatView;
}
-(POISearchView*)POIsearch
{
    if (!_POIsearch) {
        _POIsearch=[[POISearchView alloc]initWithViewModel:self.ViewModel.POIViewModel];
        
        [self addSubview:_POIsearch];
        [self sendSubviewToBack:_POIsearch];
    }
    return _POIsearch;
}
-(SearchView*)citySearch
{
    if (!_citySearch) {
        _citySearch=[[SearchView alloc]initWithViewModel:self.ViewModel.search];
        [self addSubview:_citySearch];
        [self sendSubviewToBack:_citySearch];
    }
    return _citySearch;
}
-(LocationMainViewModel*)ViewModel
{
    if (!_ViewModel) {
        _ViewModel=[LocationMainViewModel new];
    }
    return _ViewModel;
}
-(LocationHeadView*)headView
{
    if (!_headView) {
        _headView=[[LocationHeadView alloc] initWithViewModel:self.ViewModel.HeadViewModel];
        
        _headView.backgroundColor=RGBCOLOR(226, 65, 88);
        [self addSubview:_headView];
    }
    return _headView;
}
-(UITableView*)AddressTableView
{
    if (!_AddressTableView) {
        _AddressTableView=[[UITableView alloc] init];
        _AddressTableView.delegate=self;
        _AddressTableView.dataSource=self;
        _AddressTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _AddressTableView.tableHeaderView=self.tableHeadView;
        [self addSubview:_AddressTableView];
    }
    return _AddressTableView;
}
-(HeadView*)tableHeadView
{
    if (!_tableHeadView) {
        _tableHeadView=[[HeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.059)];
        
        _tableHeadView.hiddenLine=YES;
    }
    return _tableHeadView;
}
-(UIView*)lineView
{
    if (!_lineView) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=DSColor(238, 238, 238);
        [self addSubview:_lineView];
    }
    return _lineView;
}


@end
