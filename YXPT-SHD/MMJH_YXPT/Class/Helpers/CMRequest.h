//
//  CMRequest.h
//  PhoneSearch
//
//  Created by 王隆帅 on 15/5/21.
//  Copyright (c) 2015年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef enum : NSUInteger {
    QD_headerRefresh_hasMoreData = 1,// 下拉 有更多数据
    QD_headerRefresh_noMoreData,// 下拉 无更多数据
    QD_footerRefresh_hasMoreData,// 上拉 有更多数据
    QD_footerRefresh_noMoreData,// 上拉 无更多数据
    QD_refresh_error,// 刷新出错
} QDDataRefreshCurrentState;

@class CMRequest;
@protocol CMRequestDelegate <NSObject>

- (void)CMRequest:(CMRequest *)request finished:(NSString *)response;
- (void)CMRequest:(CMRequest *)request Error:(NSString *)error;

@end

@interface CMRequest : NSObject

@property (assign) id <CMRequestDelegate> delegate;

/**
 *[AFNetWorking]的operationManager对象
 */
@property (nonatomic, strong) AFHTTPRequestOperationManager* operationManager;

/**
 *当前的请求operation队列
 */
@property (nonatomic, strong) NSOperationQueue* operationQueue;

/**
 *功能: 创建CMRequest的对象方法
 */
+ (instancetype)request;

/**
 *功能：GET请求
 *参数：(1)请求的url: urlString
 *     (2)请求成功调用的Block: success
 *     (3)请求失败调用的Block: failure
 */
- (void)GET:(NSString *)URLString
    success:(void (^)(CMRequest *request, NSString* responseString))success
    failure:(void (^)(CMRequest *request, NSError *error))failure;

/**
 *功能：POST请求
 *参数：(1)请求的url: urlString
 *     (2)POST请求体参数:parameters
 *     (3)请求成功调用的Block: success
 *     (4)请求失败调用的Block: failure
 */
- (void)POST:(NSString *)URLString
  parameters:(NSDictionary*)parameters
     success:(void (^)(CMRequest *request, NSString* responseString))success
     failure:(void (^)(CMRequest *request, NSError *error))failure;

/**
 *功能：POST请求
 *参数：(1)请求的url: urlString
 *     (2)POST请求体参数:parameters
 *     (3)请求成功调用的Block: success
 *     (4)请求失败调用的Block: failure
 *     (5)文件上传二进制文件 key formDataDic[@"formData"]
 *     (6)文件上传二进制文件名称 key formDataDic[@"name"]
 *     (7)文件上传二进制文件文件名称   key formDataDic[@"fileName"]
 *     (8)文件上传二进制文件标签 key formDataDic[@"mimeType"]
 */
- (AFHTTPRequestOperation*)POST:(NSString *)URLString
                     parameters:(NSDictionary*)parameters andFormData:(NSArray*)formDataArr
                        success:(void (^)(CMRequest *request, NSString* responseString))success
                        failure:(void (^)(CMRequest *request, NSError *error))failure;
/**
 *  post请求
 *
 *  @param URLString  请求网址
 *  @param parameters 请求参数
 */
- (void)postWithURL:(NSString *)URLString parameters:(NSDictionary *)parameters;

/**
 *  get 请求
 *
 *  @param URLString 请求网址
 */
- (void)getWithURL:(NSString *)URLString;

/**
 *取消当前请求队列的所有请求
 */
- (void)cancelAllOperations;


@end
