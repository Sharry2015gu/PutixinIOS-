//
//  NetWorkManager.m
//  xiaoqu
//
//  Created by wendy on 14/12/4.
//  Copyright (c) 2014年 shenhai. All rights reserved.
//

#import "NetWorkManager.h"
#import "HTTPClient.h"

#define HTTP_CLIENT  [HTTPClient sharedInstance]
#define SUCCESS     [JSON[@"Result"] intValue] == 1
#define ErrMsg      JSON[@"Message"]
#define ErrCode     [JSON[@"Result"] intValue]

@implementation NetWorkManager

+(void)POST:(NSString*) URLString
 parameters:(id)parameters
 Completion:(void (^)(BOOL, NSError *,id))Completion
{
    [HTTP_CLIENT POST:URLString
           parameters:parameters
              success:^(AFHTTPRequestOperation * __unused task, id JSON){
                  if (SUCCESS)
                  {
                      Completion(YES,nil,JSON);
                  }
                  else
                  {
                      Completion(NO,[NSError errorWithDomain:ErrMsg code:ErrCode userInfo:nil],JSON);
                  }
              }
              failure:^(AFHTTPRequestOperation *__unused task, NSError *error) {
                  if (Completion) {
                      Completion(NO,error,nil);
                  }
              }];
}

+(void)GET:(NSString*) URLString parameters:(id)parameters
                               Completion:(void (^)(BOOL, NSError *,id))Completion
{
    [HTTP_CLIENT GET:URLString
          parameters:parameters
             success:^(AFHTTPRequestOperation * __unused task, id JSON){

                 if (SUCCESS)
                 {
                     Completion(YES,nil,JSON);
                 }
                 else
                 {
                     Completion(NO,[NSError errorWithDomain:ErrMsg code:ErrCode userInfo:nil],JSON);
                 }
             }
             failure:^(AFHTTPRequestOperation *__unused task, NSError *error) {
                 if (Completion)
                 {
                     Completion(NO,error,nil);
                 }
                 NSLog(@"error:%@",error);
             }];
    
}

+(void)PUT:(NSString*) URLString
parameters:(id)parameters
Completion:(void (^)(BOOL, NSError *,id))Completion
{

    [HTTP_CLIENT PUT:URLString
          parameters:parameters
             success:^(AFHTTPRequestOperation * __unused task, id JSON){
                 
                 if (SUCCESS)
                 {
                     Completion(YES,nil,JSON);
                 }
                 else
                 {
                     Completion(NO,[NSError errorWithDomain:ErrMsg code:ErrCode userInfo:nil],JSON);
                 }
                 
             }
             failure:^(AFHTTPRequestOperation *__unused task, NSError *error) {
                 if (Completion) {
                     Completion(NO,error,nil);
                 }
                 NSLog(@"error:%@",error);
             }];
}


+(void)DELETE:(NSString *)URLString
   parameters:(id)parameters
   Completion:(void (^)(BOOL, NSError *,id))Completion
{

    [HTTP_CLIENT DELETE:URLString
             parameters:parameters
                success:^(AFHTTPRequestOperation * __unused task, id JSON){
                    
                    if (SUCCESS)
                    {
                        Completion(YES,nil,JSON);
                    }
                    else
                    {
                        Completion(NO,[NSError errorWithDomain:ErrMsg code:ErrCode userInfo:nil],JSON);

                    }
                }
                failure:^(AFHTTPRequestOperation *__unused task, NSError *error) {
                    if (Completion) {
                        Completion(NO,error,nil);
                    }
                    NSLog(@"error:%@",error);
                }];
}

// 上传图片等
+(void)POSTFormData:(NSString*)URLString
   parameters:(id)parameters
    DataArray:(NSArray*)dataArray
   Completion:(void (^)(BOOL, NSError *,id))Completion
{

    [HTTP_CLIENT POST:URLString
           parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        for (id data in dataArray)
        {
            NSInteger index = [dataArray indexOfObject:data];
            NSString* imageName = [NSString stringWithFormat:@"image%ld",index+1];
            NSLog(@"imagename %@",imageName);
            [formData appendPartWithFileData:data
                                        name:imageName
                                    fileName:imageName
                                    mimeType:@"jpg"];
        }
    
    }
              success:^(AFHTTPRequestOperation *operation, id JSON){
        
                  if (SUCCESS)
                  {
                      Completion(YES,nil,JSON);
                  }
                  else
                  {
                      Completion(NO,[NSError errorWithDomain:JSON[@"ErrMsg"]
                                                        code:[JSON[@"ErrCode"] intValue]
                                                    userInfo:nil],JSON);
                  }
    }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {

                  if (Completion) {
                      Completion(NO,error,nil);
                  }
                  NSLog(@"error:%@",error);
    }];
}




@end
