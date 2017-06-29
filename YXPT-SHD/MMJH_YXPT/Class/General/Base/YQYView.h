//
//  YQYView.h
//  MaternalInfant
//
//  Created by 王隆帅 on 15/12/7.
//  Copyright © 2015年 王隆帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQYViewModelProtocol.h"
//#import "YYKit.h"
#import <YYKit.h>
@interface YQYView : UIView <YQYViewModelProtocol>

- (instancetype)initWithViewModel:(id<YQYViewModelProtocol>)viewModel;

- (void)yqy_bindViewModel;

- (void)yqy_setupViews;

@end
