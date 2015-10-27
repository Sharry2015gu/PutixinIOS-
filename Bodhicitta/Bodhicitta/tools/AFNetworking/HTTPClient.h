//
//  HTTPClient.h
//  SixSixNeighborhoods
//
//  Created by joinone on 14-11-26.
//  Copyright (c) 2014年 joinonesoft. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface HTTPClient : AFHTTPRequestOperationManager

+ (instancetype)sharedInstance;

- (void)removeAllHttpHeaderFields;

@end
