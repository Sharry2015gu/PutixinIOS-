//
//  TempleVow.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/6.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TempleVow : NSObject

@property(nonatomic,assign)NSInteger buddhistTempleID;//佛寺的id
@property(nonatomic,assign)NSInteger fulfilID;//还愿ID
@property(nonatomic,strong)NSString * fulfildate;//还愿日期
@property(nonatomic,strong)NSString *fulfileTaskType;//还愿类别
@property(nonatomic,assign)NSInteger * sceneType;//场景类别
@property(nonatomic,assign)NSInteger userTaskID;//许愿ID
@property(nonatomic,strong)NSString * wishContent;//许愿内容
@property(nonatomic,strong)NSString * wishFor;//许愿对象
@property(nonatomic,strong)NSString * createDate;//许愿日期
@property(nonatomic,assign)NSInteger prayMoneyFulfil;//还愿获取祈福币金额
@property(nonatomic,assign)NSInteger templeIntegralFulfil;//还愿佛堂经验
@end
