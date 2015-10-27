//
//  RankingModel.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/17.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankingModel : NSObject

@property(nonatomic,assign)NSInteger huaienID;//怀恩ID
@property(nonatomic,strong)NSString * nickName;//昵称
@property(nonatomic,assign)NSInteger taskValues;//累计值
@property(nonatomic,assign)NSInteger userOrder;//排名

@end
