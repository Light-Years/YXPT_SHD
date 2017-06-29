//
//  YQYViewController.m
//  MaternalInfant
//
//  Created by 王隆帅 on 15/11/16.
//  Copyright © 2015年 王隆帅. All rights reserved.
//

#import "YQYViewController.h"

@interface YQYViewController ()<RDVTabBarDelegate,RDVTabBarControllerDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,assign) UIStatusBarStyle statusBarStyle;
@property(nonatomic,assign) BOOL statusBarHidden;
@property(nonatomic,assign) BOOL changeStatusBarAnimated;
@property(nonatomic,assign) UIView *backView;

// 滑动隐藏 导航栏
@property (nonatomic, weak)   UIView                 *scrollableView;
@property (assign, nonatomic) float                  lastContentOffset;
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;
@property (strong, nonatomic) UIView                 *overlay;
@property (assign, nonatomic) BOOL                   isCollapsed;
@property (assign, nonatomic) BOOL                   isExpanded;

@property (strong, nonatomic) UIView *statusBarView;

#pragma mark - RAC add

@end

@implementation YQYViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    _request = [CMRequest request];
    
    [self setIsExtendLayout:NO];

    self.view.backgroundColor = white_color;

    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
//    [self layoutNavigationBar:nil titleColor:black_color titleFont:[UIFont systemFontOfSize:18] leftBarButtonItem:nil rightBarButtonItem:nil];
    
    self.navigationController.navigationBar.barTintColor = white_color;

    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
}

-(void)viewWillAppear:(BOOL)animated {
//    [[self rdv_tabBarController] tabBar].delegate = self;
}

-(void)initNav {
    
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setImage:[UIImage imageNamed:@"top.png"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    leftbtn.frame=CGRectMake(5, 24, 10, 20);
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbtn];
}

-(void)leftItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setIsExtendLayout:(BOOL)isExtendLayout {
    if (!isExtendLayout) {
        [self initializeSelfVCSetting];
    }
}

-(void)initializeSelfVCSetting {
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

-(void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
            statusBarHidden:(BOOL)statusBarHidden
    changeStatusBarAnimated:(BOOL)animated {
    self.statusBarStyle=statusBarStyle;
    self.statusBarHidden=statusBarHidden;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
    else{
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

-(void)hideNavigationBar:(BOOL)isHide
                animated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.navigationController.navigationBarHidden=isHide;
        }];
    }
    else{
        self.navigationController.navigationBarHidden=isHide;
    }
}

-(void)layoutNavigationBar:(UIImage*)backGroundImage
                titleColor:(UIColor*)titleColor
                 titleFont:(UIFont*)titleFont
         leftBarButtonItem:(UIBarButtonItem*)leftItem
        rightBarButtonItem:(UIBarButtonItem*)rightItem {
    if (backGroundImage) {
        [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    if (titleColor&&titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFont}];
    }
    else if (titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:titleFont}];
    }
    else if (titleColor){
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
    }
    if (leftItem) {
        self.navigationItem.leftBarButtonItem=leftItem;
    }
    if (rightItem) {
        self.navigationItem.rightBarButtonItem=rightItem;
    }
}

- (UIView *)statusBarView {
    
    if (!_statusBarView) {
        
        _statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        _statusBarView.backgroundColor = CL_LOGIN_TEXT_COLOR_RED;
    }
    return _statusBarView;
}

-(NSUInteger)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationPortrait;
}

- (void)ls_removeNavgationBarLine {
    
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

#pragma mark - RAC add

+ (instancetype)allocWithZone:(struct _NSZone *)zone {

    YQYViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController yqy_addSubviews];
        [viewController bindViewModel];
    }];
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController yqy_layoutNavigation];
        [viewController yqy_getNewData];
    }];
    
    return viewController;
}

- (id <YQYViewControllerProtocol>)initWithViewModel:(id)viewModel {

    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

- (void)bindViewModel {

}

- (void)yqy_addSubviews {
    
}

- (void)yqy_layoutNavigation {

}

- (void)yqy_getNewData {

}

- (void)recoverKeyboard {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
