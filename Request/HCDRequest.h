//
//  HCDRequest.h
//  HCDNetworking
//
//  Created by cheaterhu on 16/1/11.
//  Copyright © 2016年 cheaterhu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,HttpMode) {
    HttpModeGet = 0,
    HttpModePost,
    HttpModePut,
    HttpModeDelete
};

@interface HCDRequest : NSObject

- (NSURLRequest *)getWithAPIName:(NSString *)apiName apiVersion:(NSString *)apiVersion parameters:(NSDictionary *)parameters cachIdentifier:(NSString *)cachIdentifier;

- (NSURLRequest *)postWithAPIName:(NSString *)apiName apiVersion:(NSString *)apiVersion parameters:(NSDictionary *)parameters cachIdentifier:(NSString *)cachIdentifier jsonPara:(BOOL)json;

- (NSURLRequest *)putWithAPIName:(NSString *)apiName apiVersion:(NSString *)apiVersion parameters:(NSDictionary *)parameters cachIdentifier:(NSString *)cachIdentifier;

- (NSURLRequest *)deleteWithAPIName:(NSString *)apiName apiVersion:(NSString *)apiVersion parameters:(NSDictionary *)parameters cachIdentifier:(NSString *)cachIdentifier;

@end
