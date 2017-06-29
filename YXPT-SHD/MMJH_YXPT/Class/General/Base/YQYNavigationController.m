//
//  YQYNavigationController.m
//  MaternalInfant
//
//  Created by 王隆帅 on 15/11/16.
//  Copyright © 2015年 王隆帅. All rights reserved.
//

#import "YQYNavigationController.h"

@interface YQYNavigationController ()

@end

@implementation YQYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(BOOL)shouldAutorotate {
    
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations {
    
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}
@end
