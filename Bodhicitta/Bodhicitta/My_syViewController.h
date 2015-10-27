//
//  My_syViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/8.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhuYeMianViewController.h"
#import "RESideMenu.h"
#import "HMSegmentedControl.h"
#import "FaBu_MyViewController.h"
#import "DockMenuSubView.h"
#import "DockMenuView.h"
#import "TouXiang_GXViewController.h"
#import "GuanZhu_FenSiViewController.h"
#import "GongXiu_SYViewController.h"
#import "MyMain_MyViewController.h"
#import "AppDelegate.h"


@interface My_syViewController : UIViewController{


    UIButton * fanhuiBt;
    UIButton * fabuBt;
    UIButton * touxiangBt;
    UITableView * tableview;
    UIButton * shanyouButton;
    UIButton * dongtai_hyBt,* guanzhu_fensiBt;
    
    UIButton * morenBt;
    UIButton * dianzanBt,*dianzanBt1;;
    UIButton * pinglunBt,*pinglunBt1;
    UILabel * nameLa,* titleLa;
    UILabel * timeLa;
    UILabel * laiyuanLa;
    UIImageView * shangchuanImage,* shangchuanImage1,* shangchuanImage2;
    UITextView * neirongText;
    
    UIButton * shoucangBt;
    UIButton * jubaoBt;
    UIView  * bgview1,*bgview2;
    UIButton * bgview;
    UIView * pinglunView,*pinglunView1;
    
    
    BOOL isClick;
    
    
    GuanZhu_FenSiViewController * guanzhuView;
    GongXiu_SYViewController * gongxiuView;
    DockMenuSubView *mDockMenuBackView_SuiXi;
    DockMenuView *mScrollDockMenuView;

}

@property(retain, nonatomic) NSIndexPath *selectIndex;
@property (retain, nonatomic) NSMutableArray *dataArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl4;

@end
