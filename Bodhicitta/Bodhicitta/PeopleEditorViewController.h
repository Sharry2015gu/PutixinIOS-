//
//  PeopleEditorViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/5/20.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILBarButtonItem.h"
#import "ZhangHuViewController.h"
#import "SettingModel.h"
#import "Config.h"
#import "ViewController.h"


@interface PeopleEditorViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate>{

    UITableView * tableview;
    NSMutableArray * arrllist;
    
    NSArray * settings;
    NSMutableDictionary * settingsInSection;
    UIImageView * _oneView,*_twoView,*_threeView,*_fourView,*_fiveView,*_sixView,*_tevenView,*_eightView,*_nineView,*_tenView;
    UINavigationController *_nav;
    NSMutableArray *app_list;
    
    BOOL isLoadOver;


}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) NSMutableArray *menus;
@property (nonatomic, assign) BOOL shouldObserving;

@end
