//
//  HeadView.h
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/4/10.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSView.h"

@interface HeadView : LSView

@property (nonatomic,strong) UIImageView* leftImageView;

@property (nonatomic,strong) UILabel *TitleLabel;

@property (nonatomic,assign) BOOL hiddenLefrImageVew;

@property (nonatomic,assign) BOOL hiddenLine;
@end
