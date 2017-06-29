//
//  AppDelegate.m
//  MMJH_YXPT
//
//  Created by 聂赫 on 2017/6/25.
//  Copyright © 2017年 聂赫. All rights reserved.
//

#import "AppDelegate.h"
#import "LogController.h"
#import <BaiduMapKit/BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "LocationController.h"
@interface AppDelegate ()
@property (strong, nonatomic) BMKMapManager *mapManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [self.mapManager start:@"pdYvIYRIN3jSNs1sKa3DsSgRvvhPYjj7" generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    

    
    // 设置键盘弹起
    [self nh_setKeyBord];
    
    LocationController* location=[LocationController new];
    
    
    location.model=[[LocationModel alloc] init];
    
    location.model.Name=@"哈哈";
    
    location.model.Y=@"43.837442";
    location.model.X=@"125.328047";
    
    [location.ViewModel.BackRefreshSubject subscribeNext:^(id x) {
        
        NSLog(@"BackRefreshSubject");
        
    }];
    
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:location];
    
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - 键盘回收相关
- (void)nh_setKeyBord {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
