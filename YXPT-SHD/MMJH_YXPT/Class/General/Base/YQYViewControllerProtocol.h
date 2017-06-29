//
//  YQYViewControllerProtocol.h
//  MaternalInfant
//
//  Created by 王隆帅 on 15/11/24.
//  Copyright © 2015年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YQYViewModelProtocol;

@protocol YQYViewControllerProtocol <NSObject>

@required

- (instancetype)initWithViewModel:(id <YQYViewModelProtocol>)viewModel;

@property (nonatomic, strong, readonly) id <YQYViewModelProtocol> viewModel;

@optional

- (void)bindViewModel;

@end
