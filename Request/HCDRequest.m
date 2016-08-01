//
//  HCDRequest.m
//  HCDNetworking
//
//  Created by cheaterhu on 16/1/11.
//  Copyright © 2016年 cheaterhu. All rights reserved.
//

#import "HCDRequest.h"
#import "AFURLRequestSerialization.h"
#import "HCDLog.h"
#import "SMAPIHost.h"
#import "NSDictionary+Encrypt.h"
#import "HCDNetworkConfig.h"

@interface HCDRequest ()
@property (strong, nonatomic) AFHTTPRequestSerializer  *httpRequestSerializer;
@property (strong, nonatomic) SMAPIHost                *host;
@end

@implementation HCDRequest

- (NSURLRequest *)getWithAPIName:(NSString *)apiName apiVersion:(NSString *)apiVersion parameters:(id)parameters cachIdentifier:(NSString *)cachIdentifier
{
    self.httpRequestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSString *url = [NSMutableString stringWithFormat:@"%@%@",[SMAPIHost shareHost].baseUrl,apiName];
    
    DLog(@"url:%@",url);
    //[self initHeaderFiledNotJsonParams:parameters url:url];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:url parameters:parameters error:nil];
 
    [HCDLog logUrl:url params:parameters];
    
    return request;
}

- (NSURLRequest *)postWithAPIName:(NSString *)apiName apiVersion:(NSString *)apiVersion parameters:(id)parameters cachIdentifier:(NSString *)cachIdentifier jsonPara:(BOOL)json
{
    NSString *url = [NSMutableString stringWithFormat:@"%@%@",[SMAPIHost shareHost].baseUrl,apiName];
    
     NSMutableURLRequest *request = nil;
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&parseError];
    
    NSString *paraStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    if (json) {
        
        //[self initHeaderFiledJsonParams:parameters url:url];
        
        request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:url parameters:parameters error:nil];
        
        [request setHTTPBody:[paraStr dataUsingEncoding:NSUTF8StringEncoding]];
        
    }else{
        //不是json
        self.httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        
        //[self initHeaderFiledNotJsonParams:parameters url:url];
        
        request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:url parameters:parameters error:nil];
    }
    
    [HCDLog logUrl:url params:parameters];
    
    return request;
}

- (NSURLRequest *)putWithAPIName:(NSString *)apiName apiVersion:(NSString *)apiVersion parameters:(id)parameters cachIdentifier:(NSString *)cachIdentifier
{
    self.httpRequestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSString *url = [NSMutableString stringWithFormat:@"%@%@",[SMAPIHost shareHost].baseUrl,apiName];
    
    //[self initHeaderFiledNotJsonParams:parameters url:url];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"PUT" URLString:url parameters:parameters error:nil];
    
    [HCDLog logUrl:url params:parameters];
    
    return request;
}

- (NSURLRequest *)deleteWithAPIName:(NSString *)apiName apiVersion:(NSString *)apiVersion parameters:(id)parameters cachIdentifier:(NSString *)cachIdentifier
{
    self.httpRequestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSString *url = [NSMutableString stringWithFormat:@"%@%@/%@",[SMAPIHost shareHost].baseUrl,apiVersion,apiName];
    
    //[self initHeaderFiledNotJsonParams:parameters url:url];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"DELETE" URLString:url parameters:parameters error:nil];
    
    [HCDLog logUrl:url params:parameters];
    
    return request;
}

- (void)initHeaderFiledNotJsonParams:(id)parameters url:(NSString *)url
{
    NSString *urlDescript = url;
    
    if(parameters && [parameters isKindOfClass:[NSDictionary class]]){
        NSMutableArray *paraArr = [NSMutableArray array];
        
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(compare:)];
        
        for (NSString *tmpKey in [[parameters allKeys] sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            NSString *paraStr = [NSString stringWithFormat:[tmpKey stringByAppendingString:@"=%@"],parameters[tmpKey]];
            [paraArr addObject:paraStr];
        }
        
        NSString *paraStr = [NSString stringWithFormat:@"%@",[paraArr componentsJoinedByString:@"&"]];
        urlDescript = [NSString stringWithFormat:@"%@?%@",url,paraStr];
    }
    
//    NSDictionary *headerDic = [NSDictionary dictionaryWithDictionary:[Utils getAuthCommonParamsDicWith:urlDescript]];
//    
//    for (NSString *str in [headerDic allKeys]) {
//        [self.httpRequestSerializer setValue:headerDic[str] forHTTPHeaderField:str];
//    }
}

//- (void)initHeaderFiledJsonParams:(id)parameters url:(NSString *)url
//{
//    NSString *urlDescript = url;
//    if (parameters) {
//        NSString *jsonStr = [Utils toJson:parameters];
//        urlDescript = [NSString stringWithFormat:@"%@?%@",url,jsonStr];
//    }
//    
//    //header
//    NSDictionary *headerDic = [NSDictionary dictionaryWithDictionary:[Utils getAuthCommonParamsDicWith:urlDescript]];
//    
//    for (NSString *str in [headerDic allKeys]) {
//        [self.httpRequestSerializer setValue:headerDic[str] forHTTPHeaderField:str];
//    }
//
//}

- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (!_httpRequestSerializer) {
        _httpRequestSerializer = [AFJSONRequestSerializer serializer];
        //_httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
        //_httpRequestSerializer.timeoutInterval = timeOut;
       // [_httpRequestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return _httpRequestSerializer;
}

- (SMAPIHost *)host
{
    if (!_host) {
        _host = [SMAPIHost shareHost];
    }
    return _host;
}


@end
