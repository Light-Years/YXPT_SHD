//
//  LSViewController.m
//  MaternalInfant
//
//  Created by 王隆帅 on 16/11/17.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "LSViewController.h"

@interface LSViewController ()

@property(nonatomic,assign) UIStatusBarStyle statusBarStyle;

@property(nonatomic,assign) BOOL statusBarHidden;

@property(nonatomic,assign) BOOL changeStatusBarAnimated;

@end

@implementation LSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = white_color;
    
    [self setIsExtendLayout:NO];
    [self removeNavgationBarLine];
    [self layoutNavigationBar:nil titleColor:black_color titleFont:[UIFont systemFontOfSize:18] leftBarButtonItem:nil rightBarButtonItem:nil];
}

#pragma mark - general

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    LSViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController ls_initData];
        [viewController ls_setupViews];
        [viewController ls_makeConstraints];
        [viewController ls_bindViewModel];
    }];
    
    return viewController;
}

- (instancetype)initWithViewModel:(LSViewModel *)viewModel {

    self = [super init];
    
    if (self) {
        
        [self ls_getViewModel:viewModel];
    }
    
    return self;
}

- (void)ls_getViewModel:(id<LSViewModelProtocol>)viewModel {};

- (void)ls_initData {};

- (void)ls_setupViews {};

- (void)ls_makeConstraints {};

- (void)ls_bindViewModel {};

#pragma mark - lifeCycle

#pragma mark - system
- (void)setIsExtendLayout:(BOOL)isExtendLayout {
   
    if (!isExtendLayout) {
       
        [self initializeSelfVCSetting];
    }
}

- (void)initializeSelfVCSetting {
   
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
       
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
   
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
       
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return self.statusBarStyle;
}

- (BOOL)prefersStatusBarHidden {
    
    return self.statusBarHidden;
}

- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
            statusBarHidden:(BOOL)statusBarHidden
    changeStatusBarAnimated:(BOOL)animated {
   
    self.statusBarStyle=statusBarStyle;
    self.statusBarHidden=statusBarHidden;
   
    if (animated) {
       
        [UIView animateWithDuration:0.25 animations:^{
          
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    } else {
        
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)hideNavigationBar:(BOOL)isHide
                animated:(BOOL)animated{
    
    if (animated) {
       
        [UIView animateWithDuration:0.25 animations:^{
          
            self.navigationController.navigationBarHidden=isHide;
        }];
    } else {
        
        self.navigationController.navigationBarHidden=isHide;
    }
}

- (void)layoutNavigationBar:(UIImage*)backGroundImage
                titleColor:(UIColor*)titleColor
                 titleFont:(UIFont*)titleFont
         leftBarButtonItem:(UIBarButtonItem*)leftItem
        rightBarButtonItem:(UIBarButtonItem*)rightItem {
   
    if (backGroundImage) {
       
        [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
   
    if (titleColor&&titleFont) {
       
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFont}];
    } else if (titleFont) {
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:titleFont}];
    } else if (titleColor){
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
    }
   
    if (leftItem) {
       
        self.navigationItem.leftBarButtonItem=leftItem;
    }
    
    if (rightItem) {
       
        self.navigationItem.rightBarButtonItem=rightItem;
    }
}

- (void)removeNavgationBarLine {
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        
        NSArray *list=self.navigationController.navigationBar.subviews;
        
        for (id obj in list) {
            
            if ([obj isKindOfClass:[UIImageView class]]) {
                
                UIImageView *imageView=(UIImageView *)obj;
                
                NSArray *list2=imageView.subviews;
                
                for (id obj2 in list2) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        
                        UIImageView *imageView2=(UIImageView *)obj2;
                        
                        imageView2.hidden=YES;
                    }
                }
                
            }
            
        }
    }
}

- (void)dealloc {
    
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

@end
