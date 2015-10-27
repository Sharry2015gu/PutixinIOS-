//
//  SelectBookCell.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/24.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WisdomModel.h"
@interface SelectBookCell : UITableViewCell
@property(nonatomic,strong) WisdomModel *model;
@property(nonatomic,copy) void(^expandBlock)(WisdomModel *model);
@property(nonatomic,copy) void(^downloadBlock)(WisdomModel *model);
@property(nonatomic,copy) void(^reverseBlock)(WisdomModel *model);
@property(nonatomic,copy) void(^rankBlock1)(WisdomModel *model);
@property(nonatomic,copy) void(^rankBlock2)(WisdomModel *model);
@end
