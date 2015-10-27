//
//  RepairHeartViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/3.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingXinViewController.h"
#import "FoZhuViewController.h"
#import "RESideMenu.h"
#import "MiaoYinViewController.h"
#import "WisdomMathViewController.h"

@interface RepairHeartViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    UITableView * tableview;
    NSMutableArray * arrlist;
}

@end
