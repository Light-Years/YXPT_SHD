
//
//  POISearchCell.m
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/4/10.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "POISearchCell.h"

@interface POISearchCell ()

@property (nonatomic,strong) UIView *lineView;
@end

@implementation POISearchCell
+(instancetype)SearchCellWithTableView:(UITableView *)tableView
{
    static NSString* ID=@"POI";
    POISearchCell* cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[POISearchCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];;
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initUI];
    }
    return self;
}
-(void)initUI
{
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.right.bottom.equalTo(self.contentView);
        make.height.equalTo(1);
    }];
}
-(UIView*)lineView
{
    if (!_lineView) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=DSColor(238, 238, 238);
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

@end
