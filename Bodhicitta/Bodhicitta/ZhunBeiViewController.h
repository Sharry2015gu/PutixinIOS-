//
//  ZhunBeiViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/22.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingXinViewController.h"
#import "RESideMenu.h"

@interface ZhunBeiViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    UIButton * fenxiangBt;
    UITableView * _tableview;
    
    NSMutableArray * arrlist;
}

@end
