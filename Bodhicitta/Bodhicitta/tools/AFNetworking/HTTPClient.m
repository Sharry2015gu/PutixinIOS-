//
//  HTTPClient.m
//  SixSixNeighborhoods
//
//  Created by joinone on 14-11-26.
//  Copyright (c) 2014年 joinonesoft. All rights reserved.
//

#import "HTTPClient.h"


//static NSString * const BaseURLString = BaseURLString;
static HTTPClient *_sharedClient = nil;


@implementation HTTPClient

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        _sharedClient = [[HTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
//        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        
//       [_sharedClient.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        [_sharedClient.requestSerializer setValue:@"application/json;text/json;text/javascript;text/html;charset=gb2312" forHTTPHeaderField:@"Content-Type"];
//        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        
        // 设置超时时间
        [_sharedClient.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _sharedClient.requestSerializer.timeoutInterval = 5.0;
        [_sharedClient.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        [_sharedClient.reachabilityManager startMonitoring];

    });
    return _sharedClient;
}

- (void)setHttpHeaderfieldForPostData
{
    [_sharedClient.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
}

-(void)removeAllHttpHeaderFields{
    for (NSString *key in self.requestSerializer.HTTPRequestHeaders.allKeys) {
        [self.requestSerializer setValue:nil forHTTPHeaderField:key];
    }
}




@end
