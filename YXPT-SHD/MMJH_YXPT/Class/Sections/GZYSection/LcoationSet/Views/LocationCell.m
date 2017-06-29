//
//  LocationCell.m
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/28.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LocationCell.h"


@interface LocationCell()

@property (nonatomic,strong) UILabel *locationLabel;

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *phoneLabel;

@property (nonatomic,strong) UIView *lineView;

@end

@implementation LocationCell
+(instancetype)CellWithTableView:(UITableView*)tableView
{
    static NSString* ID=@"LocationCell";
    LocationCell* cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell=[[LocationCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}
-(void)setInfo:(BMKPoiInfo *)info
{
    _info=info;
    
    self.locationLabel.text=info.name;
    
    self.nameLabel.text=info.address;

    
}
-(void)setViewModel:(AddressCellViewModel *)viewModel
{
    _viewModel=viewModel;
    
    self.locationLabel.text=viewModel.model.address;
    
    self.nameLabel.text=viewModel.model.name;
    self.phoneLabel.text=viewModel.model.phone;
    
}
-(void)ls_makeConstraints
{
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.top.equalTo(self.top).offset(SCREEN_WIDTH*0.0213);
        make.left.equalTo(self.contentView).offset(SCREEN_WIDTH*0.085);
         make.right.equalTo(self.contentView).offset(-SCREEN_WIDTH*0.085);
        
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.locationLabel);
        make.top.mas_equalTo(self.locationLabel.mas_bottom).offset(5);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(10);
        make.top.equalTo(self.nameLabel);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(@(1));
        make.right.equalTo(self.contentView);
        make.left.equalTo(self.locationLabel);
    }];
}

#pragma mark-LazyLoad
-(UIView*)lineView
{
    if (!_lineView) {
        _lineView=[UIView new];
        _lineView.backgroundColor=DSColor(238, 238, 238);
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}
-(UILabel*)locationLabel
{
    if (!_locationLabel) {
        _locationLabel=[UILabel new];
        _locationLabel.font=[UIFont systemFontOfSize:16];
        _locationLabel.numberOfLines=0;
        _locationLabel.textColor=DSColor(51, 51, 51);
        [self.contentView addSubview:_locationLabel];
    }
    return _locationLabel;
}
-(UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel=[UILabel new];
        _nameLabel.font=[UIFont systemFontOfSize:14];
        _nameLabel.textColor=DSColor(153, 153, 153);
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}
-(UILabel*)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel=[UILabel new];
        _phoneLabel.font=[UIFont systemFontOfSize:14];
        _phoneLabel.textColor=DSColor(153, 153, 153);
        [self.contentView addSubview:_phoneLabel];
    }
    return _phoneLabel;
}
@end
