//
//  YQYTableViewCell.m
//  MaternalInfant
//
//  Created by 王隆帅 on 15/12/7.
//  Copyright © 2015年 王隆帅. All rights reserved.
//

#import "YQYTableViewCell.h"

@implementation YQYTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self yqy_setupViews];
        [self yqy_bindViewModel];
    }
    return self;
}

- (void)yqy_setupViews {

}

- (void)yqy_bindViewModel {

}

@end
