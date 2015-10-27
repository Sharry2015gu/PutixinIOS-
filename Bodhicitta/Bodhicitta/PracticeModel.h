//
//  PracticeModel.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/9/7.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PracticeModel : NSObject
@property(nonatomic,strong)NSString * nickName;//昵称
@property(nonatomic,assign)NSInteger integral;//总积分
@property(nonatomic,assign)NSInteger huaienID;
@property(nonatomic,assign)NSInteger userLevel;//用户等级
@property(nonatomic,strong)NSString *headImg;
@end
