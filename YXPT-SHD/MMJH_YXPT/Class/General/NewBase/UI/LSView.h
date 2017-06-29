//
//  LSView.h
//  MaternalInfant
//
//  Created by 王隆帅 on 16/11/17.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSViewProtocol.h"
#import "LSViewModel.h"

@interface LSView : UIView <LSViewProtocol>

/**
 初始化方法
 
 @param dataInfo VM
 
 @return VM实例
 */
- (instancetype)initWithViewModel:(id<LSViewModelProtocol>)viewModel;


@end
