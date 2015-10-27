//
//  BuddhaddRankViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/10/15.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//
#import "TempleImage.h"
#import <UIKit/UIKit.h>
#import "MyBuddhaHallViewController.h"
@protocol BuddhaddRankViewDelegate<NSObject>

@end

@interface BuddhaddRankViewController : UIViewController
@property(nonatomic,strong)  MyBuddhaHallViewController *vc;
@property(nonatomic,strong) id<BuddhaddRankViewDelegate> delegate;
-(instancetype)initWithModel:(TempleImage* )model;
@end
