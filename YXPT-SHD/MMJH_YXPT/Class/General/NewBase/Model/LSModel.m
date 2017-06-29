//
//  LSModel.m
//  MaternalInfant
//
//  Created by 王隆帅 on 16/11/17.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "LSModel.h"

@interface LSModel ()

@property (nonatomic, strong, readwrite) NSHashTable *observers;


@end

@implementation LSModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    LSModel *model = [super allocWithZone:zone];
    
    if (model) {
        
        [model ls_initData];
    }
    return model;
}

- (void)ls_initData {

    self.observers = [NSHashTable weakObjectsHashTable];
}

- (BOOL)addObserver:(id<LSModelObserver>)observer {

    if ([self.observers containsObject:observer]) {
        
        return NO;
    } else {
    
        [self.observers addObject:observer];
        return YES;
    }
}

- (BOOL)removeObserver:(id<LSModelObserver>)observer {

    if (![self.observers containsObject:observer]) {
        
        return NO;
    } else {
        
        [self.observers removeObject:observer];
        return YES;
    }
}


@end
