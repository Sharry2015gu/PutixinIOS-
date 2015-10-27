//
//  Personal.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/31.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Personal : NSObject

@property(nonatomic,strong)NSData  *animalSign;
@property(nonatomic,strong)NSString * backgroundImg;
@property(nonatomic,strong)NSString * birthday;
@property(nonatomic,assign)NSInteger birthdayType;
@property(nonatomic, strong)NSString * constellation;
@property(nonatomic,strong)NSString * createDate;
@property(nonatomic,strong)NSString * headImg;
@property(nonatomic,assign)NSInteger isVIP;
@property(nonatomic,strong)NSString * levelAndDesignation;//等级及称号
@property(nonatomic,strong)NSString * nickName;
@property(nonatomic,strong)NSString * realName;
@property(nonatomic,strong)NSString * nowAddr;
@property(nonatomic,strong)NSString * nowCity;
@property(nonatomic,assign)NSInteger nowCityID;
@property(nonatomic,assign)NSInteger prayMoney;
@property(nonatomic,assign)NSInteger result;
@property(nonatomic,assign)NSInteger  sex;
@property(nonatomic,strong)NSString * signature;
@property(nonatomic,assign)NSInteger totalIntegral;//总积分
@property(nonatomic,strong)NSString*  telephone;
@property(nonatomic,strong)NSString * email;
@property(nonatomic,assign)NSInteger  huaienID;
@property(nonatomic,assign)NSInteger userLoginID;
@end
