//
//  ShanYou_DTViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/8.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhuYeMianViewController.h"
#import "RESideMenu.h"
#import "HMSegmentedControl.h"
#import "FaBiao_SYViewController.h"
#import "DockMenuSubView.h"
#import "DockMenuView.h"
#import "GongXiu_SYViewController.h"
#import "TouXiang_GXViewController.h"
#import "ShouCang_JYViewController.h"
#import "AppDelegate.h"

@interface ShanYou_DTViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{


    UIButton * fanhuiBt;
    UIButton * fabiaoBt;
    UIButton * touxiangBt;
    UITableView * tableview;
    UIButton * shanyouButton;
    UIButton * dongtai_qzBt,* gongxiu_qzBt;
    
    
    UIButton * morenBt;
    UIButton * dianzanBt;
    UIButton * pinglunBt;
    UILabel * nameLa,* titleLa;
    UILabel * timeLa;
    UILabel * laiyuanLa;
    UIImageView * shangchuanImage,* shangchuanImage1,* shangchuanImage2;
    UITextView * neirongText;
    
    UIButton * shoucangBt;
    UIButton * jubaoBt;
    
    BOOL isClick;
    
    
    GongXiu_SYViewController * gongxiuView;
    DockMenuSubView *mDockMenuBackView_SuiXi;
    DockMenuView *mScrollDockMenuView;
}
@property (retain, nonatomic) NSMutableArray *dataArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl4;
@end
