//
//  LocationController.m
//  MaternalInfant
//
//  Created by 郭子岩 on 2017/3/28.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LocationController.h"
#import "LocationMainView.h"
@interface LocationController ()
/**
 主View
 */
@property (nonatomic,strong) LocationMainView *MainView;


@end

@implementation LocationController
-(LocationControllerViewModel*)ViewModel
{
    if (!_ViewModel) {
        _ViewModel=[[LocationControllerViewModel alloc] init];
    }
    return _ViewModel;
}
-(LocationMainView*)MainView
{
    if (!_MainView) {
        _MainView=[LocationMainView new];
//        _MainView.IsshowMapView=self.IsshowMapView;
        [self.view addSubview:_MainView];
    }
    return _MainView;
}
//-(void)setIsshowMapView:(BOOL)IsshowMapView
//{
//    _IsshowMapView=IsshowMapView;
//}
//-(void)ls_initData
//{
//    if (_IsshowMapView==NO) {
//        
//        [self.MainView refreshAddress];
//    }
//    if (_IsshowMapView) {
//        
//    }
//    
//}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _MainView.Model=self.model;
    
    IQKeyboardManager* KeyboardManager=[IQKeyboardManager sharedManager];
    
    KeyboardManager.shouldResignOnTouchOutside=NO;
    
    [self.navigationController.navigationBar setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    IQKeyboardManager* KeyboardManager=[IQKeyboardManager sharedManager];
    
    KeyboardManager.shouldResignOnTouchOutside=YES
    ;
    [self.navigationController.navigationBar setHidden:NO];
}
- (void)ls_makeConstraints {
    
    WS(weakSelf)
    
    [self.MainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}
- (void)ls_bindViewModel {
    //绑定返回按钮
    [self.MainView.ViewModel.HeadViewModel.BackCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
   
        if (self.navigationController) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self dismissViewControllerAnimated:YES completion:nil];
   
        }
    }];
    
    
    [self.MainView.ViewModel.SeletedSubject subscribeNext:^(id x) {
        
//        if (self.navigationController) {
//            
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        else
//        {
//            [self dismissViewControllerAnimated:YES completion:nil];
//            
//        }
        
        [self.ViewModel.BackRefreshSubject sendNext:x];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title=@"定位";
}

@end
