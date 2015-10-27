//
//  HYTableViewCell.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/6.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempleVow.h"
#import "RESideMenu.h"

@protocol HYTableViewCellDelegate<NSObject>
-(void)joinYardWithMemorialId:(NSInteger) memorialId;
@end

@interface HYTableViewCell : UITableViewCell

@property(nonatomic,strong) TempleVow * templemodel;
@property(nonatomic,strong)id<HYTableViewCellDelegate> delegate;
-(void)setModel:(TempleVow *)temodel;
//前去还愿
@property(nonatomic,copy) void(^redeemVowBlock)(TempleVow  * model);
@property(nonatomic,strong)UIButton * vowBtn;

@end
