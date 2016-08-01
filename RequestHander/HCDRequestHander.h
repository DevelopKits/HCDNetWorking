//
//  HCDRequestHander.h
//  HCDNetworking
//
//  Created by cheaterhu on 16/1/12.
//  Copyright © 2016年 cheaterhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

typedef void(^RequestSuccess)(id response);
typedef void(^RequestFaild)(NSString *errorMessage);

typedef void(^NetWorkNotReachable)();

@interface HCDRequestHander : NSObject

@property (copy, nonatomic) NetWorkNotReachable netWorkNotReachableHandler;
@property (assign, nonatomic,readonly) NetworkStatus networkStatus;

+(instancetype)shareInstance;

- (void)getWithAPIName:(NSString *)apiName apiVersion:(NSString *)apiVersion parameters:(id)parameters cachIdentifier:(NSString *)cachIdentifier success:(RequestSuccess)success failure:(RequestFaild)failure;

- (void)postWithAPIName:(NSString *)apiName apiVersion:(NSString *)apiVersion parameters:(id)parameters cachIdentifier:(NSString *)cachIdentifier jsonPara:(BOOL)json success:(RequestSuccess)success failure:(RequestFaild)failure;

- (void)putWithAPIName:(NSString *)apiName apiVersion:(NSString *)apiVersion parameters:(id)parameters cachIdentifier:(NSString *)cachIdentifier success:(RequestSuccess)success failure:(RequestFaild)failure;

- (void)deleteWithAPIName:(NSString *)apiName apiVersion:(NSString *)apiVersion parameters:(id)parameters cachIdentifier:(NSString *)cachIdentifier success:(RequestSuccess)success failure:(RequestFaild)failure;

//上传文件   data 和 url 二者选一种方式
-(void)postWithAPIName:(NSString *)apiName apiVersion:(NSString *)apiVersion parameters:(id)parameters fromData:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mineType name:(NSString *)name fileUrl:(NSURL *)fileUrl cachIdentifier:(NSString *)cachIdentifier success:(RequestSuccess)success failure:(RequestFaild)failure;

// 待用   有问题
//-(void)postWithAPIName:(NSString *)apiName apiVersion:(NSString *)apiVersion parameters:(id)parameters fromData:(NSData *)data cachIdentifier:(NSString *)cachIdentifier success:(RequestSuccess)success failure:(RequestFaild)failure;

@end
