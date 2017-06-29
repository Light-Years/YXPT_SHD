//
//  CMRequest.m
//  PhoneSearch
//
//  Created by 王隆帅 on 15/5/21.
//  Copyright (c) 2015年 王隆帅. All rights reserved.
//

#import "CMRequest.h"

@implementation CMRequest

+ (instancetype)request {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.operationManager = [AFHTTPSessionManager manager];
    }
    return self;
}

- (void)GET:(NSString *)URLString
    success:(void (^)(CMRequest *, NSString *))success
    failure:(void (^)(CMRequest *, NSError *))failure {
    
    self.operationQueue=self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self.operationManager GET:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                    parameters:nil
                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                           NSString *responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                           NSLog(@"[CMRequest]: %@",responseJson);
                           success(self,responseJson);
                       }
                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           NSLog(@"[CMRequest]: %@",error.localizedDescription);
                           
                           failure(self,error);
                       }];
}

- (void)POST:(NSString *)URLString
  parameters:(NSDictionary*)parameters
     success:(void (^)(CMRequest *request, NSString* responseString))success
     failure:(void (^)(CMRequest *request, NSError *error))failure{
    
    self.operationQueue=self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self.operationManager POST:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                     parameters:parameters
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            NSString* responseJson = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                            NSLog(@"[CMRequest]: %@",responseJson);
                            
                            success(self,responseJson);
                        }
                        failure:^(AFHTTPRequestOperation *operation, NSError *error){
                            NSLog(@"[CMRequest]: %@",error.localizedDescription);
                            failure(self,error);
                        }];
    
}

- (void)postWithURL:(NSString *)URLString parameters:(NSDictionary *)parameters {
    
    [self POST:URLString
    parameters:parameters
       success:^(CMRequest *request, NSString *responseString) {
           if ([self.delegate respondsToSelector:@selector(CMRequest:finished:)]) {
               [self.delegate CMRequest:request finished:responseString];
               
           }
       }
       failure:^(CMRequest *request, NSError *error) {
           if ([self.delegate respondsToSelector:@selector(CMRequest:Error:)]) {
               [self.delegate CMRequest:request Error:error.description];
           }
       }];
}
- (AFHTTPRequestOperation*)POST:(NSString *)URLString
                     parameters:(NSDictionary*)parameters andFormData:(NSArray *)formDataArr
                        success:(void (^)(CMRequest *, NSString *))success
                        failure:(void (^)(CMRequest *, NSError *))failure{
    
    self.operationQueue= self.operationManager.operationQueue;
    [self.operationManager.operationQueue setMaxConcurrentOperationCount:1];
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    self.operationManager.requestSerializer  =   [AFHTTPRequestSerializer serializer];
    AFHTTPRequestOperation* requestOp         = [self.operationManager POST:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (formDataArr.count>0) {
            for (NSInteger i = 0; i<formDataArr.count; i++) {
                
                [formData appendPartWithFileData:formDataArr[i][@"formData"] name:formDataArr[i][@"name"] fileName:formDataArr[i][@"fileName"] mimeType:formDataArr[i][@"mimeType"]];
                
            }
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString* responseJson = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"[CMRequest]: %@",responseJson);
        success(self,responseJson);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"[CMRequest]: %@",error.localizedDescription);
        failure(self,error);
        
    }];
    return requestOp;
}


- (void)getWithURL:(NSString *)URLString {
    
    [self GET:URLString
      success:^(CMRequest *request, NSString *responseString) {
          if ([self.delegate respondsToSelector:@selector(CMRequest:finished:)]) {
              [self.delegate CMRequest:request finished:responseString];
          }
      } failure:^(CMRequest *request, NSError *error) {
          if ([self.delegate respondsToSelector:@selector(CMRequest:Error:)]) {
              [self.delegate CMRequest:request Error:error.description];
          }
      }];
}

- (void)cancelAllOperations{
    [self.operationQueue cancelAllOperations];
}

@end
