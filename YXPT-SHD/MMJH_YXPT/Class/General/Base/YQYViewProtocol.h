//
//  YQYViewProtocol.h
//  MaternalInfant
//
//  Created by 王隆帅 on 15/12/14.
//  Copyright © 2015年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YQYViewModelProtocol;

@protocol YQYViewProtocol <NSObject>

@required

- (instancetype)initWithViewModel:(id <YQYViewModelProtocol>)viewModel;

@property (nonatomic, strong, readonly) id <YQYViewModelProtocol> viewModel;

@optional

- (void)bindViewModel;

@end
