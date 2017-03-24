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

typedef NS_ENUM(NSInteger, HttpMethod) {
    HttpMethodGET,
    HttpMethodPOST,
    HttpMethodPUT,
    HttpMethodDELETE,
    HttpMethodPATH,
    HttpMethodHEAD,
};

@interface HCDRequestHander : NSObject

@property (copy, nonatomic) NetWorkNotReachable netWorkNotReachableHandler;
@property (assign, nonatomic,readonly) NetworkStatus networkStatus;

+(instancetype)shareInstance;

- (void)requestWithAPIName:(NSString *)apiName method:(HttpMethod)method parameters:(id)parameters  success:(RequestSuccess)success failure:(RequestFaild)failure;


//上传文件   data 和 url 二者选一种方式

/**
 上传文件   data 和 url 二者选一种方式  支持流和表单模式

 @param apiName <#apiName description#>
 @param parameters <#parameters description#>
 @param data <#data description#>
 @param fileName <#fileName description#>
 @param mineType <#mineType description#>
 @param name <#name description#>
 @param fileUrl <#fileUrl description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
-(void)postWithAPIName:(NSString *)apiName parameters:(id)parameters fromData:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mineType name:(NSString *)name fileUrl:(NSURL *)fileUrl success:(RequestSuccess)success failure:(RequestFaild)failure;

@end
