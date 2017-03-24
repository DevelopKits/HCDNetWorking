//
//  HCDRequestHander.m
//  HCDNetworking
//
//  Created by cheaterhu on 16/1/12.
//  Copyright © 2016年 cheaterhu. All rights reserved.
//

#import "HCDRequestHander.h"
#import "AFURLSessionManager.h"
#import "HCDLog.h"
#import "SMAPIHost.h"
#import "AFNetworking.h"


@interface HCDRequestHander ()
@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) Reachability *reachability;
@end

@implementation HCDRequestHander

+(instancetype)shareInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (void)requestWithAPIName:(NSString *)apiName method:(HttpMethod)method parameters:(id)parameters success:(RequestSuccess)success failure:(RequestFaild)failure
{
    NSString *url = [NSMutableString stringWithFormat:@"%@%@",[SMAPIHost shareHost].baseUrl,apiName];
    [self startHttpRequestWithUrl:url method:method para:parameters success:success failure:failure];
}

- (void)postWithAPIName:(NSString *)apiName parameters:(id)parameters fromData:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mineType name:(NSString *)name fileUrl:(NSURL *)fileUrl success:(RequestSuccess)success failure:(RequestFaild)failure
{
    NSString *url = [NSMutableString stringWithFormat:@"%@%@",[SMAPIHost shareHost].baseUrl,apiName];
    
    [self networkReachableAndshowIndicator];
    
    [HCDLog logUrl:url params:parameters];
    
    [self.sessionManager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (data) {
            //表单
            [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mineType];
            //流
//            [formData appendPartWithInputStream:[NSInputStream inputStreamWithData:data] name:name fileName:fileName length:data.length mimeType:mineType];
        }else{
            
            if (fileUrl) {
                [formData appendPartWithFileURL:fileUrl name:name error:nil];
              
                //流
//                NSData *fileData = [NSData dataWithContentsOfURL:fileUrl];
//                [formData appendPartWithInputStream:[NSInputStream inputStreamWithData:fileData] name:name fileName:fileName length:fileData.length mimeType:mineType];
                
            }
        }

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [self hideNetworkIndicator];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self hideNetworkIndicator];
        failure(error.localizedDescription);
    }];
}

- (void)startHttpRequestWithUrl:(NSString *)url method:(HttpMethod)method para:(id)parameters success:(RequestSuccess)success failure:(RequestFaild)failure
{
    [self networkReachableAndshowIndicator];
    
    [HCDLog logUrl:url params:parameters];

    switch (method) {
        case HttpMethodGET:
        {
            [self.sessionManager GET:url parameters:parameters success: ^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                [self hideNetworkIndicator];
                success(responseObject);
                
            }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }
            break;
        case HttpMethodPOST:
        {
            [self.sessionManager POST:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                [self hideNetworkIndicator];
                success(responseObject);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [self hideNetworkIndicator];
                failure(error.localizedDescription);
            }];
        }
            break;
     
        case HttpMethodPUT:
        {
            [self.sessionManager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }
            break;
        case HttpMethodDELETE:
        {
            [self.sessionManager DELETE:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }
            break;
        case HttpMethodPATH:
        {
            [self.sessionManager PATCH:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }
            break;
        case HttpMethodHEAD:
        {
            [self.sessionManager HEAD:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task) {
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }
            break;
        default: return;
            break;
    }
}

- (void)networkReachableAndshowIndicator
{
    if (self.networkStatus == NotReachable) {
        if (self.netWorkNotReachableHandler) {
            self.netWorkNotReachableHandler();
            return;
        }
    }
    
    if (![[UIApplication sharedApplication] isNetworkActivityIndicatorVisible]) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
}

- (void)hideNetworkIndicator
{
    if ([[UIApplication sharedApplication] isNetworkActivityIndicatorVisible]) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}

- (AFURLSessionManager *)sessionManager
{
    if (!_sessionManager) {
        _sessionManager = [[AFHTTPSessionManager alloc]init];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _sessionManager;
}

- (Reachability *)reachability
{
    if (!_reachability) {
        _reachability = [Reachability reachabilityForInternetConnection];
    }
    return _reachability;
}

- (NetworkStatus)networkStatus
{
    return [self.reachability currentReachabilityStatus];
}



@end
