//
//  HCDCache.m
//  ZYMeiHuo
//
//  Created by cheaterhu on 16/1/15.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "HCDCache.h"

@implementation HCDCache

+(instancetype)shareInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (void)cacheRequestWithIdentifier:(NSString *)identifier
{
    
}

- (void)cacheResponseWithIdentifier:(NSString *)identifier
{
    
}

- (instancetype)getCachWithIdentifier:(NSString *)identifier
{
    return nil;
}

-(void)deleteCacheWithIdetifier:(NSString *)identifier
{
    
}

-(void)clearAllCache
{
    
}

@end

