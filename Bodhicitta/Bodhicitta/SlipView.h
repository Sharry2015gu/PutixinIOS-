//
//  SlipView.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/26.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlipModel.h"
@interface SlipView : UIView
@property(nonatomic,strong) SlipModel *model;
@property(nonatomic,copy) void(^block)(SlipModel * model);

@end
