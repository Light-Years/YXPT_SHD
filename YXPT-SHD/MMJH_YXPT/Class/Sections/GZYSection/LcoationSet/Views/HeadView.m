
//
//  HeadView.m
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/4/10.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "HeadView.h"

@interface HeadView()
@property (nonatomic,strong) UIView *lineView;

@end

@implementation HeadView
-(UIView*)lineView
{
    if (!_lineView) {
        _lineView=[UIView new];
        
        _lineView.backgroundColor=DSColor(238, 238, 238);
        
        [self addSubview:_lineView];
    }
    return _lineView;
}
-(UIImageView*)leftImageView
{
    if (!_leftImageView) {
        _leftImageView=[[UIImageView alloc] init];
        _leftImageView.image=[UIImage imageNamed:@"xzx.png"];
        [self addSubview:_leftImageView];
    }
    return _leftImageView;
}
-(UILabel*)TitleLabel
{
    if (!_TitleLabel) {
        _TitleLabel=[[UILabel alloc] init];
        _TitleLabel.textAlignment=NSTextAlignmentLeft;
        _TitleLabel.text=@"您的收货地址";
        _TitleLabel.font=[UIFont systemFontOfSize:14];
        _TitleLabel.textColor=DSColor(153, 153, 153);
        
        [self addSubview:_TitleLabel];
    }
    return _TitleLabel;
}
-(instancetype)initWithFrame:(CGRect)frame

{
    if (self=[super initWithFrame:frame]) {
        
        [self initUI];
        
        self.backgroundColor=[UIColor whiteColor];
        
    }
    return self;;
}
-(void)setHiddenLefrImageVew:(BOOL)hiddenLefrImageVew
{
    _hiddenLefrImageVew=hiddenLefrImageVew;
    
    [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.height.equalTo(0);
        make.width.equalTo(0);
    }];
}
-(void)setHiddenLine:(BOOL)hiddenLine
{
    self.lineView.hidden=hiddenLine;
}
-(void)initUI
{
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self);
        make.height.equalTo(SCREEN_WIDTH*0.0213*2);
        make.width.equalTo(SCREEN_WIDTH*0.0213*2);
        make.left.equalTo(self).offset(SCREEN_WIDTH*0.0213);
        
    }];
    [self.TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self);
        make.left.equalTo(self.leftImageView.mas_right).offset(SCREEN_WIDTH*0.0213);
        
    }];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.left.and.right.equalTo(self);
        make.height.equalTo(1);
    }];
    
}
@end
