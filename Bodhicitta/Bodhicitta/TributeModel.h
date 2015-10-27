//
//  TributeModel.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/11.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TributeModel : NSObject

@property(nonatomic,assign)NSInteger integral;//所获积分数量
@property(nonatomic,strong)NSString * materialImageUrl;//素材图片URL
@property(nonatomic,strong)NSString * meaning;//素材含义
@property(nonatomic,assign)NSInteger prayMoney;//消耗祈福币数量
@property(nonatomic,assign)NSInteger taskCode;//素材编号
@property(nonatomic,assign)NSInteger taskType;//素材类型
@property(nonatomic,strong)NSString * tasklName;//素材名称
@property(nonatomic,assign)NSInteger templeIntegral;//获得佛堂经验值数量
@property(nonatomic,assign)NSInteger validTimeLen;//有效时长
//@property(nonatomic,assign)NSInteger templeIntegral;//获得佛堂经验值数量
@end
