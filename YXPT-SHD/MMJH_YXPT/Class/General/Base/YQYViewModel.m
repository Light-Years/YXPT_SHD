//
//  YQYViewModel.m
//  MaternalInfant
//
//  Created by 王隆帅 on 15/11/24.
//  Copyright © 2015年 王隆帅. All rights reserved.
//

#import "YQYViewModel.h"

@interface YQYViewModel ()

@end

@implementation YQYViewModel

@synthesize errors   = _errors;
@synthesize request  = _request;
@synthesize currentVCName = _currentVCName;
@synthesize canLayOutUI = _canLayOutUI;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {

    YQYViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        
        [viewModel initialize];
    }
    return viewModel;
}

- (RACSubject *)errors {

    if (!_errors) {
        
        _errors = [RACSubject subject];
    }
    return _errors;
}

- (CMRequest *)request {

    if (!_request) {
        
        _request = [CMRequest request];
    }
    return _request;
}

- (NSString *)currentVCName {

    if (!_currentVCName) {
        
        _currentVCName = @"";
    }
    
    return _currentVCName;
}

- (NSString *)canLayOutUI {

    if (!_canLayOutUI) {
        
        _canLayOutUI = @"0";
    }
    
    return _canLayOutUI;
}

- (void)initialize {}

- (void)ls_refreshData {}

- (void)ls_addNextPageData {}

- (void)ls_refreshUI {

    self.canLayOutUI = @"1";
    self.canLayOutUI = @"0";
}

@end
