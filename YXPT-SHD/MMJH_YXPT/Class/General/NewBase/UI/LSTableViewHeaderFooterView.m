//
//  LSTableViewHeaderFooterView.m
//  MaternalInfant
//
//  Created by 王隆帅 on 16/11/17.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "LSTableViewHeaderFooterView.h"

@implementation LSTableViewHeaderFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self ls_initData];
        [self ls_setupViews];
        [self ls_makeConstraints];
        [self ls_bindViewModel];
    }
    
    return self;
}

- (void)ls_initData {};

- (void)ls_setupViews {};

- (void)ls_makeConstraints {};

- (void)ls_bindViewModel {};

- (void)dealloc {
    
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

@end
