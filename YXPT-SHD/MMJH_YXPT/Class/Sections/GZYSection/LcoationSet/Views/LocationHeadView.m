//
//  LocationHeadView.m
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/28.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LocationHeadView.h"

@interface LocationHeadView()

/**
 返回按钮
 */
@property (nonatomic,strong) UIButton *BackBtn;
/**
 城市btn
 */
@property (nonatomic,strong) UIButton *CityBtn;
/**

 */
@property (nonatomic,strong) UITextField *textfield;

/**
 POI搜索按钮
 */
@property (nonatomic,strong) UIButton *POIsearch;

/**
 
 */
@property (nonatomic,strong) UIImageView *imageView;


@end

@implementation LocationHeadView
-(UIImageView*)imageView
{
    if (!_imageView) {
        _imageView=[[UIImageView alloc]init];
        _imageView.image=[UIImage imageNamed:@"csss.png"];
    
        [self addSubview:_imageView];
    }
    return _imageView;
}
-(void)ls_getViewModel:(id<LSViewModelProtocol>)viewModel
{
    _viewModel=(LocationHeadViewModel*)viewModel;
}
-(void)ls_makeConstraints
{
    
    [self.BackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(SCREEN_WIDTH*0.0214);
        make.height.equalTo(SCREEN_WIDTH*0.0213*2);
        make.width.equalTo(SCREEN_WIDTH*0.0213*2);
        
    }];
    
    [self.CityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.BackBtn);
        make.left.mas_equalTo(self.BackBtn.mas_right).offset(5);
        make.height.equalTo(self.BackBtn);
        make.width.equalTo(SCREEN_WIDTH*0.066*2);
        
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {

         make.left.mas_equalTo(self.CityBtn.mas_right);
         make.centerY.equalTo(self);
        make.height.equalTo(SCREEN_WIDTH*0.0267*2);
        make.width.equalTo(SCREEN_WIDTH*0.0213*2);
    }];
    
    [self.POIsearch mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-SCREEN_WIDTH*0.0214);
        make.height.equalTo(SCREEN_WIDTH*0.0267*2);
        make.width.equalTo(SCREEN_WIDTH*0.0267*2);
        
    }];
    [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self);
        make.left.mas_equalTo(self.imageView.mas_right).offset(10);
        make.bottom.equalTo(self);
        make.right.mas_equalTo(self.POIsearch.left);
        
    }];
    
    
}
-(void)ls_bindViewModel
{
    [self.viewModel.ChangeTitleSubject subscribeNext:^(id x) {
       
      self.Model=x;
        
      [self.CityBtn setTitle:self.Model.Name forState:0];
      // 隐藏 城市列表
      [self.viewModel.CityCommand execute:nil];
    }];
}

-(void)setModel:(LocationModel *)Model
{
    _Model=Model;
    [self.CityBtn setTitle:self.Model.Name forState:0];
    
}
#pragma mark-LazyLoad
-(UIButton*)POIsearch
{
    if (!_POIsearch) {
        _POIsearch=[UIButton buttonWithType:UIButtonTypeCustom];
        [_POIsearch setImage:[UIImage imageNamed:@"ssss.png"] forState:0];
       
        [[_POIsearch rac_signalForControlEvents:1]subscribeNext:^(id x) {
            
          [self.viewModel.HideTableViewSubject sendNext:@(NO)];
            
          [self.viewModel.POICommand execute:@{@"Key":self.textfield.text,@"latitudes":self.Model.Y,@"longitude":self.Model.X}];
    
        }];
        
        [self addSubview:_POIsearch];
    }
    return _POIsearch;
}
-(UITextField*)textfield
{
    if (!_textfield) {
        _textfield=[[UITextField alloc]init];
        _textfield.clearButtonMode=UITextFieldViewModeAlways;
        [[_textfield rac_textSignal]subscribeNext:^(id x) {
            
            
            if ([self.textfield.text isEqualToString:@""])
            {
                [self.viewModel.HideTableViewSubject sendNext:@(YES)];
            }
            else
            {
                
               [self.viewModel.HideTableViewSubject sendNext:@(NO)];
               [self.viewModel.POICommand execute:@{@"Key":self.textfield.text,@"latitudes":self.Model.Y,@"longitude":self.Model.X}];
            }
            
        }];
        _textfield.placeholder=@"请输入您的收货地址";
        _textfield.font=[UIFont systemFontOfSize:14];
        [_textfield setValue:DSColor(177, 29, 51) forKeyPath:@"_placeholderLabel.textColor"];
        _textfield.textColor=DSColor(255, 255, 255);
        
        [self addSubview:_textfield];
    }
    return _textfield;
}
-(UIButton*)CityBtn
{
    if (!_CityBtn) {
        _CityBtn=[[UIButton alloc] init];
        
        _CityBtn.titleLabel.textColor=[UIColor whiteColor];
        _CityBtn.rac_command=self.viewModel.CityCommand;
        _CityBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        
        [self addSubview:_CityBtn];
    }
    return _CityBtn;
}
-(UIButton*)BackBtn
{
    if (!_BackBtn) {
        _BackBtn=[UIButton new];
        [_BackBtn setImage:[UIImage imageNamed:@"fh_white"] forState:0];
        _BackBtn.rac_command=self.viewModel.BackCommand;
        [self addSubview:_BackBtn];
    }
    return _BackBtn;
}
@end
