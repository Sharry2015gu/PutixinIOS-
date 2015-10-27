//
//  NetWorkManager.h
//  xiaoqu
//
//  Created by wendy on 14/12/4.
//  Copyright (c) 2014年 shenhai. All rights reserved.
//

#import <Foundation/Foundation.h>
//网络请求
@interface NetWorkManager : NSObject

+(void)POST:(NSString*) URLString parameters:(id)parameters Completion:(void (^)(BOOL, NSError *,id))Completion;

+(void)GET:(NSString*) URLString parameters:(id)parameters Completion:(void (^)(BOOL, NSError *,id))Completion;

+(void)PUT:(NSString*) URLString parameters:(id)parameters Completion:(void (^)(BOOL, NSError *,id))Completion;

+(void)DELETE:(NSString *)URLString parameters:(id)parameters Completion:(void (^)(BOOL, NSError *,id))Completion;

+(void)POSTFormData:(NSString*)URLString parameters:(id)parameters DataArray:(NSArray*)dataArray Completion:(void (^)(BOOL, NSError *,id))Completion;


@end
