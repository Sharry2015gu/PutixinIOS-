//
//  ClassicBookCell.h
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/21.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WisdomModel.h"
@interface ClassicBookCell : UITableViewCell
@property(nonatomic,strong)WisdomModel  * model;
@property(nonatomic,strong) void(^expandBlock)(WisdomModel *model);
@property(nonatomic,assign)BOOL *isExpand;
-(void)setModel:(WisdomModel *)model;
@end
