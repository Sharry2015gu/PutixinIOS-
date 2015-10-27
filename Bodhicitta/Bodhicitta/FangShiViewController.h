//
//  FangShiViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/1.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindViewController.h"
#import "TelePhoneViewController.h"
#import "EmailViewController.h"
#import "MiBaoViewController.h"
@interface FangShiViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    UITableView * tableview;
    UIButton * backbt;
    UILabel * title;
    
    NSMutableArray * arrllist;
}

@end
