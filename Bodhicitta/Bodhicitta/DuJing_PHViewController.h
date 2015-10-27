//
//  DuJing_PHViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/6.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShuJia_MyViewController.h"
#import "RESideMenu.h"
#import "CollectModel.h"
@interface DuJing_PHViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tableview;
    UIButton * preservation;
    UIButton * remove;
    UITextField * nicheng;
    
}
-(void)getReadRankingWit:(CollectModel *) model IsFresh:(BOOL)fresh;
@property(nonatomic,strong) CollectModel *model;
@end
