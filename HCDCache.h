//
//  HCDCache.h
//  ZYMeiHuo
//
//  Created by cheaterhu on 16/1/15.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCDCache : NSObject

@property (assign, nonatomic) NSTimeInterval cacheTime;
@property (strong, nonatomic) NSString       *cacheIdentifier;
@property (strong, nonatomic) NSCache        *cache;



+(instancetype)shareInstance;

- (void)cacheResponseWithIdentifier:(NSString *)identifier;

- (void)cacheRequestWithIdentifier:(NSString *)identifier;

- (instancetype)getCachWithIdentifier:(NSString *)identifier;

- (void)deleteCacheWithIdetifier:(NSString *)identifier;

- (void)clearAllCache;

@end
