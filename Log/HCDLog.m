//
//  HCDLog.m
//  HCDNetworking
//
//  Created by cheaterhu on 16/1/11.
//  Copyright © 2016年 cheaterhu. All rights reserved.
//

#import "HCDLog.h"

@implementation HCDLog
+(void)logUrl:(NSString *)url params:(NSDictionary *)params
{
#ifdef DEBUG
    NSLog(@"\n===========================\n************URL*****************\n%@\n======================\n**************params******************\n%@\n====================",url,params);
#else
#endif
}

+(void)logParams:(NSDictionary *)params encryptParams:(id)encryptParams
{
#ifdef DEBUG
    NSLog(@"\n=========================\n**********加密前***********\n%@=====================\n*************加密后******************\n%@\n",params,encryptParams);
#else
#endif
}

+(void)logObject:(id)object
{
#ifdef DEBUG
    NSLog(@"\n=========================\n%@\n=========================",object);
#else
#endif
}

@end
