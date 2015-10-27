//
//  TintView.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/25.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TributeModel.h"
@interface TintView : UIView
@property(nonatomic,strong)TributeModel *model;
-(void)setModel:(TributeModel *)model;
@property(nonatomic,copy) void(^submitBlock)(TributeModel *);
@property(nonatomic,copy) void(^resignBlock)();
@property(nonatomic,copy) void(^removeBlock)();
@end