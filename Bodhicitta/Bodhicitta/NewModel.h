//
//  NewModel.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/9/14.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewModel : NSObject
@property(nonatomic,strong)NSString * content;//消息内容
@property(nonatomic,strong)NSString * createDate;//消息日期
@property(nonatomic,assign)NSInteger messageID;//消息ID
@property(nonatomic,assign)NSInteger messageType;//消息类型
@property(nonatomic,strong)NSString * readStatus;//状态
@property(nonatomic,strong)NSString * title;//消息标题
@end
