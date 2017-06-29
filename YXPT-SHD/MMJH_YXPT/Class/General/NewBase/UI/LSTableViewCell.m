//
//  LSTableViewCell.m
//  MaternalInfant
//
//  Created by 王隆帅 on 16/11/17.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "LSTableViewCell.h"

@implementation LSTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
   
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
