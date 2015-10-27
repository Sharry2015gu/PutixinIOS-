//
//  TopThreeViewCell.h
//  Bodhicitta
//
//  Created by 怀恩11 on 15/10/19.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuddhaLevel.h"

@interface TopThreeViewCell : UITableViewCell
@property(nonatomic,strong)BuddhaLevel *model;
-(void)setBuddhaModel:(BuddhaLevel *)model IndexPath:(NSIndexPath *) indexPath;
@end
