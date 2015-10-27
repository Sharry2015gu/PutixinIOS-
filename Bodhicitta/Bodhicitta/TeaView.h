//
//  TeaView.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/13.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TributeModel.h"
@interface TeaView : UIView
@property(nonatomic,strong) TributeModel  *model;
-(void)setModel:(TributeModel *)model;
@property(nonatomic,copy) void(^selectBlock)(TributeModel *);
@property(nonatomic,copy) void(^questionBlock)(NSString *);
@end

