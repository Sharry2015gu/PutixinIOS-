//
//  SetUpViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/15.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "ZhuYeMianViewController.h"
#import "UserLoginViewController.h"
#import "FanKuiViewController.h"
#import "AppDelegate.h"

@interface SetUpViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{

    UITableView * _tableview;
    UISwitch * syswich;
    UISwitch * xxswich;
    
    NSMutableArray * arrlist;
    
    UILabel * shengyinLa;
    UILabel * xinxiLa;
    UILabel * banbenLa;
    UILabel * sumLa;
    UILabel * fankuiLa;
    UILabel * gengxinLa;
    UILabel * zuixinLa;
    UILabel * xiugaiLa;
    UILabel * huaanyingyeLa;
    
    UIButton * dengluBt;
    
    BOOL isClick;
    
    UIAlertView*alert;
}
@property(nonatomic,strong)id set;
@property(nonatomic,strong) id lastViewController;

@end
