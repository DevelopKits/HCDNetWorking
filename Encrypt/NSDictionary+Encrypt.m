//
//  NSDictionary+Encrypt.m
//  HCDNetworking
//
//  Created by cheaterhu on 16/1/11.
//  Copyright © 2016年 cheaterhu. All rights reserved.
//

#import "NSDictionary+Encrypt.h"
#import "HCDLog.h"

@implementation NSDictionary (Encrypt)
+(NSString *)stringFromEncryptParams:(NSDictionary *)params
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    //[jsonStr 加密];
    
    [HCDLog logParams:params encryptParams:jsonStr];
    return jsonStr;
}

+(NSDictionary *)dictionaryFromEncryptParams:(NSDictionary *)paras
{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    
//    for (NSString *str in [paras allKeys]) {
//        [tempDic setObject:@""/*加密参数 */ forKey:@""/*加密参数 */];
//    }
    
    [HCDLog logParams:paras encryptParams:tempDic];
    
    return tempDic;
}
@end
