//
//  Practice_MyRankViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/9/10.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Practice_MyRankViewController : UIViewController
-(void)getPracticeRankInfo;
//-(void)getMonthInfo;
//-(void)getDayInfo;
//-(void)getWeekInfo;
@property(nonatomic,strong)NSMutableArray * resultArray;
@end
