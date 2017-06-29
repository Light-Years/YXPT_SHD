//
//  YCTouchDelegate.h
//  YCWM
//
//  Created by 李帅 on 15/2/2.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @protocol
 @abstract 项目中常用的协议保存在这里
 @discussion 页面之间的回调, 协议
 */
@protocol YCTouchDelegate <NSObject>

@optional

/*!
 @method
 @abstract 点击回调
 @discussion C和V层中使用
 @param obj 被代理的对象
 @param index 触碰的索引位置
 */
- (void)touchObj:(id)obj index:(int)index;

/*!
 @method
 @abstract 长按回调
 @discussion C和V层中使用
 @param obj 被代理的对象
 @param index 长按的索引位置
 */
- (void)longPressObj:(id)obj index:(int)index;

@end
