//
//  HomeWorkModel.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/19.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeWorkModel : NSObject

@property(nonatomic,strong)NSString * achieveCond;//达成说明
@property(nonatomic,strong)NSString * achieveFlag;//完成情况
@property(nonatomic,strong)NSString * logoUrl;//LogoURL(图片地址)
@property(nonatomic,assign)NSInteger sceneType;//场景类型
@property(nonatomic,strong)NSString * taskDesc;//功课说明
@property(nonatomic,strong)NSString * taskName;//功课名称
@property(nonatomic,strong)NSString * taskType;//类型
@property(nonatomic,strong)NSString * getRewardFlag;//是否已经领取奖励
@property(nonatomic,assign)NSInteger  achieveQty;//当日已经完成的功课类别数

@end
