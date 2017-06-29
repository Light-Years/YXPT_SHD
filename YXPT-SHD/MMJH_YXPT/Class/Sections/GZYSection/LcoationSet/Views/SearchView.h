//
//  SearchView.h
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/30.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSView.h"
#import "SearchViewModel.h"
@interface SearchView : LSView
@property (nonatomic,strong) SearchViewModel *viewModel;
@property(strong,nonatomic)NSMutableArray* ModelArray;
@property(copy,nonatomic)void(^CellClickBlock)(NSObject*model);
-(void)refreshData;
@end
