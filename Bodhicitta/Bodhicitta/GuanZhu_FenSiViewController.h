//
//  GuanZhu_FenSiViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/13.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FenSi_MyViewController.h"
#import "RESideMenu.h"
#import "DockMenuSubView.h"
#import "DockMenuView.h"

@interface GuanZhu_FenSiViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    FenSi_MyViewController * fensi;
    UITableView * tableview;
    NSIndexPath * _editingIndexPath;
    
    UIScrollView * scrollview;
    
//    UIRefreshControl *refreshControl;
    
    //定义字典和数组
    NSDictionary *dictionary;
    NSArray *list;
    
    DockMenuSubView *mDockMenuBackView_SuiXi;
    DockMenuView *mScrollDockMenuView;
    FenSi_MyViewController * fensiview;
}
@property (strong,nonatomic) UISegmentedControl * segment_title;
- (NSString *)getSegmentTitle;

@property (nonatomic) BOOL useCustomCells;
@property (nonatomic, weak) UIRefreshControl *refreshControl;

@end
