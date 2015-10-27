//
//  FenSi_MainViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/15.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "MyMain_MyViewController.h"

@interface FenSi_MainViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>{

    UIButton * fanhuiBt;
    UISearchBar * searchBt;
    UITableView * tableview;
    
    NSDictionary *dictionary;
    NSArray *list;
}

@end
