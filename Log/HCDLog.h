//
//  HCDLog.h
//  HCDNetworking
//
//  Created by cheaterhu on 16/1/11.
//  Copyright © 2016年 cheaterhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCDLog : NSObject
+ (void)logUrl:(NSString *)url params:(NSDictionary *)params;
+ (void)logParams:(NSDictionary *)params encryptParams:(id)encryptParams;
+ (void)logObject:(id)object;
@end
