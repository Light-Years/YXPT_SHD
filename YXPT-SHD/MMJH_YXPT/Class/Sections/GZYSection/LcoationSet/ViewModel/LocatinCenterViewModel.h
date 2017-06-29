//
//  LocatinCenterViewModel.h
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/28.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSViewModel.h"

@interface LocatinCenterViewModel : LSViewModel
/**
 重新定位地址命令
 */
@property (nonatomic,strong) RACCommand *refreshCommand;
@end
