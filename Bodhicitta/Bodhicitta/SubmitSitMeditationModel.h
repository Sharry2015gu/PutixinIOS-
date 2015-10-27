//
//  SubmitSitMeditationModel.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/19.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubmitSitMeditationModel : NSObject
@property(nonatomic,assign)NSInteger integral;//所获积分数量
@property(nonatomic,strong)NSString * desc;//结果描述
@property(nonatomic,assign)NSInteger prayMoney;//消耗祈福币数量
@property(nonatomic,assign)NSInteger templeIntegral;//获得佛堂经验值数量
@property(nonatomic,assign)NSInteger result;
@end
