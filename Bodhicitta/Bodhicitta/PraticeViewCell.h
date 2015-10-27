//
//  PraticeViewCell.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/9/7.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PracticeModel.h"
@interface PraticeViewCell : UITableViewCell
@property(nonatomic,strong) PracticeModel * practicemodel;
-(void)setPracticeModel:(PracticeModel *)pramodel IndexPath:(NSIndexPath *) indexPath;
@property(nonatomic,strong) id up;
@end
