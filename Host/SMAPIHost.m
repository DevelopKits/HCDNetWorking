//
//  MHAPIHost.m
//  HCDNetworking
//
//  Created by cheaterhu on 16/1/11.
//  Copyright © 2016年 cheaterhu. All rights reserved.
//

#import "SMAPIHost.h"

@implementation SMAPIHost

+(instancetype)shareHost
{
    static dispatch_once_t predicate = 0;
    static SMAPIHost *_instance = nil;
    
    dispatch_once(&predicate, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
#ifdef DEBUG
        self.debug = YES;
        self.baseUrl = @"";
#else
        self.debug = NO;
        self.baseUrl = @"";
#endif
//    }
    }
    return self;
}

@end
