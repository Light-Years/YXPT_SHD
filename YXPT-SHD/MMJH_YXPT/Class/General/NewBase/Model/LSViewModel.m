//
//  LSViewModel.m
//  MaternalInfant
//
//  Created by 王隆帅 on 16/11/17.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "LSViewModel.h"

@interface LSViewModel ()

@property (nonatomic, strong, readwrite) LSDataInfo *dataInfo;

@property (nonatomic, strong, readwrite) NSHashTable *observers;

@end

@implementation LSViewModel

- (instancetype)init {

    return [self initWithDataInfo:nil delegate:nil];
}

- (id)initWithDataInfo:(LSDataInfo *)dataInfo delegate:(NSObject<LSViewModelDelegate> *)delegate {

    if (self = [super init]) {
        
        _dataInfo = dataInfo;
        _delegate = delegate;
        _observers = [NSHashTable weakObjectsHashTable];
        [self ls_initData];
    }
    
    return self;
}

- (BOOL)addObserver:(id<LSViewModelObserver>)observer {
    
    if ([self.observers containsObject:observer]) {
        
        return NO;
    } else {
        
        [self.observers addObject:observer];
        return YES;
    }
}

- (BOOL)removeObserver:(id<LSViewModelObserver>)observer {
    
    if (![self.observers containsObject:observer]) {
        
        return NO;
    } else {
        
        [self.observers removeObject:observer];
        return YES;
    }
}

- (void)ls_initData {

}

- (void)dealloc {
    
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

@end
