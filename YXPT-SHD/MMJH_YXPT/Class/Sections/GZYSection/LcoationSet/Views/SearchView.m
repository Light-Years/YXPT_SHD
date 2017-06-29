//
//  SearchView.m
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/30.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "SearchView.h"
#import "LocationlistModel.h"
#import "LocationModel.h"
@interface SearchView()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (strong, nonatomic) UISearchBar *searchbar;
@property (strong, nonatomic) UITableView *tableView;

@property(strong,nonatomic)NSMutableArray* reaustArray;

@property(assign,nonatomic)BOOL isSearch;
@end

@implementation SearchView
-(NSMutableArray*)reaustArray
{
    if (!_reaustArray) {
        _reaustArray=[NSMutableArray array];
    }
    return _reaustArray;
}
-(void)refreshData
{
    [self.tableView reloadData];
}
#pragma mark-lazyLaod
-(UITableView*)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]init];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.sectionFooterHeight = 0;
       _tableView.sectionIndexColor = DSColor(225, 66, 88);
        
        [self addSubview:_tableView];
    }
    return _tableView;
}
-(UISearchBar*)searchbar
{
    if (!_searchbar) {
        _searchbar=[[UISearchBar alloc]init];
        _searchbar.delegate=self;
        [self addSubview:_searchbar];
    }
    return _searchbar;
}
-(void)ls_getViewModel:(id<LSViewModelProtocol>)viewModel
{
    _viewModel=(SearchViewModel*)viewModel;
}
-(void)ls_bindViewModel
{
    [self.viewModel.refreshCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        
        self.ModelArray=self.viewModel.CityModelArray;
        
    }];
    [self.viewModel.refreshCommand execute:nil];
    
}
-(void)ls_makeConstraints
{
//    [self.searchbar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.and.left.and.right.equalTo(self);
//        make.height.equalTo(@(60));
//    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.searchbar.mas_bottom);
        make.top.equalTo(self);
        make.left.and.right.and.bottom.equalTo(self);
    }];
}
#pragma mark-searchBar代理方法
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterBySubstring:searchText];
}
#pragma mark-tableView代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.isSearch? self.reaustArray.count:self.ModelArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.isSearch? [[self.reaustArray[section] CityList] count]:[[self.ModelArray[section] CityList] count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"a"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1
                                   reuseIdentifier:@"a"];
    }
    if (self.isSearch)
    {
        LocationModel* model=[self.reaustArray[indexPath.section] CityList][indexPath.row];
        cell.textLabel.text=model.Name;
        
        
        
    }else
    {
        LocationModel* model=[self.ModelArray[indexPath.section] CityList][indexPath.row];
        cell.textLabel.text=model.Name;
    }
    cell.textLabel.textColor=DSColor(91, 91, 91);
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel* label=[[UILabel alloc] init];
    label.backgroundColor=DSColor(244, 244, 244);
    label.textColor=DSColor(151, 151, 151);
    label.textAlignment=NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:18];
    
    if (self.isSearch) {
        
        LocationlistModel* model=self.reaustArray[section];
        
        label.text=[NSString stringWithFormat:@"   %@",model.Key];
    }
    else
    {
         LocationlistModel* model=self.ModelArray[section];
        label.text=[NSString stringWithFormat:@"   %@",model.Key];
    }
    return label;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSObject* model=nil;
//    if (self.isSearch) {
//        model=[self.reaustArray[indexPath.section] CityList][indexPath.row];
//    }
//    else
//    {
//        model=[self.ModelArray[indexPath.section] CityList][indexPath.row];
//    }
//    if (self.CellClickBlock) {
//        self.CellClickBlock(model);
//    }
    
    [self.viewModel.CellClickSubject sendNext:[self.ModelArray[indexPath.section] CityList][indexPath.row]];

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray* numberArray=[NSMutableArray array];
    
    if (self.isSearch) {
        
        return nil;
    }
    else
    {
        for (LocationlistModel* model in self.ModelArray) {
          
            [numberArray addObject:model.Key];
        }
    }
    return numberArray;
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endEditing:YES];
}
- (void)filterBySubstring:(NSString*) subStr
{
    
    [self.reaustArray removeAllObjects];
    self.isSearch = YES?![self.searchbar.text isEqualToString:@""]:NO;
    
    for (LocationlistModel* listModel in self.ModelArray)
    {
        
        NSMutableArray* array=[NSMutableArray array];
        
        for (LocationModel* model in listModel.CityList) {
            if ([model.Name containsString:subStr]) {
                
                [array addObject:listModel];
            }
        }
        
        if (!(array.count==0)) {
            [self.reaustArray addObjectsFromArray:array];
        }
    }
    [self.tableView reloadData];
}
@end
