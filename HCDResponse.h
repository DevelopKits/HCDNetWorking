//
//  HCDResponse.h
//  ZYMeiHuo
//
//  Created by cheaterhu on 16/1/15.
//  Copyright © 2016年 cheaterhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCDResponse : NSObject

@property (strong, nonatomic) NSHTTPURLResponse *response;
@property (strong, nonatomic) NSString          *identifier;

@end
