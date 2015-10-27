//
//  GongXiu_SYViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/9.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
//#import "ChaKan_GXViewController.h"
#import "ChaKanViewController.h"

@interface GongXiu_SYViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>{

    UISearchBar * seachBt;
    UITableView * tableview;
    UIButton * chakanBt1,* chakanBt2,*chakanBt3,*chakanBt4,*chakanBt5;
    UIButton * guanzhuBt1,*guanzhuBt2,*guanzhuBt3,*guanzhuBt4,*guanzhuBt5;
    UIButton * touxiangButton;
    UILabel * titleLa;
    
    UILabel * quanmingLa;
    UILabel * jianjie;
    UILabel * guanzhuLa;
    
    BOOL isClick;
}

@property (retain, nonatomic) NSMutableArray *dataArray;
@end
