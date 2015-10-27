//
//  HuanYuan_MainViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/17.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "MyBuddhaHallViewController.h"

@interface HuanYuan_MainViewController : UIViewController
//@property(nonatomic,assign) int num;
@property(nonatomic,assign) BOOL isVow;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong)MyBuddhaHallViewController * myBuddahaVC;
-(void)loadDataWithBuddhistId:(NSInteger) buddhistID;
@end
