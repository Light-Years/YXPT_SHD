//
//  LocationCenterView.m
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/28.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LocationCenterView.h"
#import "LSGetLoactionManager.h"
@interface LocationCenterView()

/**
 定位地址Lbael
 */
@property (nonatomic,strong) UILabel *addressDexcLabel;
/**
 显示地址信息
 */
@property (nonatomic,strong) UILabel *addressMessage;

/**
 分割线
 */
@property (nonatomic,strong) UIView *lineView;
/**
 重新刷新地址
 */
@property (nonatomic,strong) UIButton *refreshBtn;

@end

@implementation LocationCenterView
-(void)ls_getViewModel:(id<LSViewModelProtocol>)viewModel
{
    _viewModel=(LocatinCenterViewModel*)viewModel;
}
-(void)ls_bindViewModel
{
    [[LSGetLoactionManager sharedInstance].completeSubject subscribeNext:^(id x) {
        
        if ([x boolValue]) {
            
            self.addressMessage.text=[[LSGetLoactionManager sharedInstance]getCity];
        } else
        {
            
            [self ls_showError:@"无法获取到您的位置"];
        }
    }];
}
-(void)setAddress:(NSString *)address
{
    _address=address;
    
    self.addressMessage.text=address;
}
-(void)ls_makeConstraints
{
    [self.addressDexcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.and.right.equalTo(self);
        
        make.height.equalTo(self).multipliedBy(0.5);
        
        make.left.equalTo(self).offset(SCREEN_WIDTH*0.0213);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.addressDexcLabel.mas_bottom);
        make.height.equalTo(@(1));
        make.left.and.right.equalTo(self);
    }];
    [self.addressMessage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.bottom.equalTo(self);
         make.left.equalTo(self).offset(SCREEN_WIDTH*0.0213);
    }];
    [self.refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.addressMessage);
        make.right.equalTo(self).offset(-SCREEN_WIDTH*0.0214);
        make.height.equalTo(SCREEN_WIDTH*0.0267*2);
        make.width.equalTo(SCREEN_WIDTH*0.0267*2);
        
    }];
}
#pragma mark-LazyLaoad
-(UIButton*)refreshBtn
{
    
    if (!_refreshBtn) {
        _refreshBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _refreshBtn.rac_command=self.viewModel.refreshCommand;
        [_refreshBtn setImage:[UIImage imageNamed:@"dzsx.png"] forState:0];
        [self addSubview:_refreshBtn];
    }
    return _refreshBtn;
}

-(UILabel*)addressMessage
{
    if (!_addressMessage) {
        _addressMessage=[[UILabel alloc] init];
        _addressMessage.font=[UIFont systemFontOfSize:14];
        [self addSubview:_addressMessage];
    }
    return _addressMessage;
}
-(UIView*)lineView
{
    if (!_lineView) {
        _lineView=[UIView new];
        
        _lineView.backgroundColor=DSColor(238, 238, 238);
        
        [self addSubview:_lineView];
    }
    return _lineView;
}
-(UILabel*)addressDexcLabel
{
    if (!_addressDexcLabel) {
        _addressDexcLabel=[[UILabel alloc] init];
        _addressDexcLabel.text=@"定位地址";
//        _addressDexcLabel.backgroundColor=[UIColor cyanColor];
        _addressDexcLabel.font=[UIFont systemFontOfSize:14];
        _addressDexcLabel.textColor=[UIColor lightGrayColor];
        
        [self addSubview:_addressDexcLabel];
    }
    return _addressDexcLabel;
}

@end





