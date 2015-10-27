//
//  HomeWorkViewCell.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/19.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeWorkModel.h"
@interface HomeWorkViewCell : UITableViewCell

@property(nonatomic,strong) HomeWorkModel * homemodel;

-(void)setHomeWorkModel:(HomeWorkModel *)homemodel;
@property(nonatomic,copy) void(^redeemVowBlock)(HomeWorkModel  * model);
@end
