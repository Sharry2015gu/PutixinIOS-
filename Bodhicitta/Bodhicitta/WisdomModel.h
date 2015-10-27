//
//  WisdomModel.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/13.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WisdomModel : NSObject

@property(nonatomic,assign)NSInteger bookId;//经书ID

@property(nonatomic,assign)NSInteger clicks;//点击下载量
@property(nonatomic,strong)NSString * downloadUrl_r;//（用于读）下载地址
@property(nonatomic,strong)NSString * downloadUrl_w;//（用于抄）下载地址
@property(nonatomic,assign)NSInteger isReco;//是否推荐
@property(nonatomic,strong)NSString * title;//书名
@property(nonatomic,assign)NSInteger wordTotal;//总字数
@property(nonatomic,assign)NSInteger category;//类型
@end
