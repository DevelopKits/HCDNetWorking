//
//  HCDRequestHander.m
//  HCDNetworking
//
//  Created by cheaterhu on 16/1/12.
//  Copyright © 2016年 cheaterhu. All rights reserved.
//

#import "HCDRequestHander.h"
#import "HCDRequest.h"
#import "AFURLSessionManager.h"
#import "HCDLog.h"
#import "SMAPIHost.h"
#import "AFNetworking.h"


@interface HCDRequestHander ()
@property (strong, nonatomic) AFURLSessionManager *sessionManager;
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

- (void)getWithAPIName:(NSString *)apiName apiVersion:(NSString *)apiVersion parameters:(id)parameters cachIdentifier:(NSString *)cachIdentifier success:(RequestSuccess)success failure:(RequestFaild)failure
{
    
    NSURLRequest *request = [[HCDRequest alloc]getWithAPIName:apiName apiVersion:apiVersion parameters:parameters cachIdentifier:cachIdentifier];
    
    [self startHttpRequest:request success:success failure:failure];
}

- (void)postWithAPIName:(NSString *)apiName apiVersion:(NSString *)apiVersion parameters:(id)parameters cachIdentifier:(NSString *)cachIdentifier jsonPara:(BOOL)json success:(RequestSuccess)success failure:(RequestFaild)failure
{
    
    NSURLRequest *request = [[HCDRequest alloc] postWithAPIName:apiName apiVersion:apiVersion parameters:parameters cachIdentifier:cachIdentifier jsonPara:json];
    
    [self startHttpRequest:request success:success failure:failure];
}

- (void)putWithAPIName:(NSString *)apiName apiVersion:(NSString *)apiVersion parameters:(id)parameters cachIdentifier:(NSString *)cachIdentifier success:(RequestSuccess)success failure:(RequestFaild)failure
{
    
    NSURLRequest *request = [[HCDRequest alloc]putWithAPIName:apiName apiVersion:apiVersion parameters:parameters cachIdentifier:cachIdentifier];
    
    [self startHttpRequest:request success:success failure:failure];
}

- (void)postWithAPIName:(NSString *)apiName apiVersion:(NSString *)apiVersion parameters:(id)parameters fromData:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mineType name:(NSString *)name fileUrl:(NSURL *)fileUrl cachIdentifier:(NSString *)cachIdentifier success:(RequestSuccess)success failure:(RequestFaild)failure
{
    NSString *url = [NSMutableString stringWithFormat:@"%@%@",[SMAPIHost shareHost].baseUrl,apiName];
    
     
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (data) {
            [formData appendPartWithFormData:data name:name];
        }else{
//            [formData appendPartWithFileURL:fileUrl name:name fileName:nil mimeType:nil error:nil];
            
            if (fileUrl) {
                [formData appendPartWithFileURL:fileUrl name:name error:nil];
            }
        }
        
    } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        failure([error localizedDescription]);
    }];
}

//-(void)postWithAPIName:(NSString *)apiName apiVersion:(NSString *)apiVersion parameters:(id)parameters fromData:(NSData *)data cachIdentifier:(NSString *)cachIdentifier success:(RequestSuccess)success failure:(RequestFaild)failure
//{
//
//    NSURLRequest *request = [[HCDRequest alloc]postWithAPIName:apiName apiVersion:apiVersion parameters:parameters cachIdentifier:cachIdentifier jsonPara:NO];
//    [self startUploadRequest:request uploadData:data uploadProgress:nil success:success failure:failure];
//}

- (void)deleteWithAPIName:(NSString *)apiName apiVersion:(NSString *)apiVersion parameters:(id)parameters cachIdentifier:(NSString *)cachIdentifier success:(RequestSuccess)success failure:(RequestFaild)failure
{
    NSURLRequest *request = [[HCDRequest alloc]deleteWithAPIName:apiName apiVersion:apiVersion parameters:parameters cachIdentifier:cachIdentifier];
    [self startHttpRequest:request success:success failure:failure];
}

- (void)startHttpRequest:(NSURLRequest *)request success:(RequestSuccess)success failure:(RequestFaild)failure
{
    
    if (self.networkStatus == NotReachable) {
        if (self.netWorkNotReachableHandler) {
            self.netWorkNotReachableHandler();
            return;
        }
    }
    
    NSURLSessionDataTask *task = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nonnull responseObject, NSError * _Nonnull error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        [HCDLog logObject:[NSString stringWithFormat:@"status code : %li   message :%@",(long)httpResponse.statusCode,responseObject[@"appdata"][@"message"]]];
        
        if (httpResponse.statusCode != 200) {
            
            //[HCDLog logObject:httpResponse];
            failure(responseObject[@"appdata"][@"message"]);
        }else{
            
            if ([responseObject[@"appdata"][@"code"] integerValue] == 1) {
                failure(responseObject[@"appdata"][@"message"]);
            }else{
                success(responseObject);
            }
        }
    }];
    
    [task resume];
}

- (void)startUploadRequest:(NSURLRequest *)request uploadData:(NSData *)data uploadProgress:(NSProgress * __autoreleasing *)progress success:(RequestSuccess)success failure:(RequestFaild)failure
{
    
    if (self.networkStatus == NotReachable) {
        if (self.netWorkNotReachableHandler) {
            self.netWorkNotReachableHandler();
            return;
        }
    }
    
    NSURLSessionDataTask *task = [self.sessionManager uploadTaskWithRequest:request fromData:data progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        [HCDLog logObject:[NSString stringWithFormat:@"status code : %li   message :%@",(long)httpResponse.statusCode,responseObject[@"appdata"][@"message"]]];
        
        if (httpResponse.statusCode != 200) {
            
            //[HCDLog logObject:httpResponse];
            failure(responseObject[@"appdata"][@"message"]);
        }else{
            
            if ([responseObject[@"appdata"][@"code"] integerValue] == 1) {
                failure(responseObject[@"appdata"][@"message"]);
            }else{
                success(responseObject);
            }
        }
        
    }];
    
    [task resume];
}

- (AFURLSessionManager *)sessionManager
{
    if (!_sessionManager) {
        _sessionManager = [[AFURLSessionManager alloc]init];
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
