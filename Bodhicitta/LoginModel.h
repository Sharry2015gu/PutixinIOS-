//
//  LoginModel.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/30.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject

@property(nonatomic,strong) NSString *loginName;
@property(nonatomic,assign) NSInteger loginNameType;
@property(nonatomic,assign) NSInteger appID;
@property(nonatomic,assign) NSInteger loginIP;
@property(nonatomic,assign) NSInteger loginWay;
@property(nonatomic,strong) NSString *loginPwd;
@property(nonatomic,strong) NSString * OSName;


@end
