//
//  YQYView.m
//  MaternalInfant
//
//  Created by 王隆帅 on 15/12/7.
//  Copyright © 2015年 王隆帅. All rights reserved.
//

#import "YQYView.h"

@implementation YQYView 
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self yqy_setupViews];
        [self yqy_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<YQYViewModelProtocol>)viewModel {
    
    self = [super init];
    if (self) {
        
        [self yqy_setupViews];
        [self yqy_bindViewModel];
    }
    return self;
}

- (void)yqy_bindViewModel {
}

- (void)yqy_setupViews {
}


@end
