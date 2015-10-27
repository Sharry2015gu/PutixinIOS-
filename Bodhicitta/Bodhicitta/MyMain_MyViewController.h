//
//  MyMain_MyViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/15.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "My_syViewController.h"
#import "ShouCang_JYViewController.h"
#import "GuanZhu_MainViewController.h"
#import "FenSi_MainViewController.h"

@interface MyMain_MyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    UIButton * touxiangBt;
    UIButton * fanhuiBt;
    UIButton * quanziBt;
    UIButton * gzButton;
    UIButton * fsBurron;
    
    UIButton * guanzhuBt;
    
    UILabel * qzLa, * qzText;
    UILabel * gzLa, * gzText;
    UILabel * fsLa, * fsText;
    
    UITableView * tableview;
    
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
    
}
@property (retain, nonatomic) NSMutableArray *dataArray;

@end
