//
//  MHAPIHost.h
//  HCDNetworking
//
//  Created by cheaterhu on 16/1/11.
//  Copyright © 2016年 cheaterhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMAPIHost : NSObject
@property (assign, nonatomic,getter=isDebug) BOOL debug;
@property (strong, nonatomic) NSString   *baseUrl;

+(instancetype)shareHost;

@end
