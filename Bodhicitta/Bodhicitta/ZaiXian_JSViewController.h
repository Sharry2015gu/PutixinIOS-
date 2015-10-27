//
//  ZaiXian_JSViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/2.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"
#import "ZhuYeMianViewController.h"
#import "RESideMenu.h"
#import "DuJingViewController.h"
#import "ChaoJingViewController.h"
#import "WisdomModel.h"
@protocol  ZaiXian_JSViewControllerDelegate<NSObject>
- (void)selectZaixianAction:(WisdomModel*)model WithSelectNumber:(NSInteger)selectNumber;
@end

@interface ZaiXian_JSViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>{
    
    UIScrollView * scrollview;
    UIImageView * backgroundImage;
    UITableView * tableview;
    UILabel * nameLa;
    UIButton * seachBt;
    UIButton * fanhuiBt;
    UIButton * bookShelfBtn;
    int numOfRows;
    BOOL isClick;
    
}

@property(retain, nonatomic) NSIndexPath *selectIndex;
//选中那个按钮
@property(nonatomic,assign) NSInteger selectedNumber;
@property(nonatomic,assign)id<ZaiXian_JSViewControllerDelegate>delegate;

//-(void)getClassicInterface;
@end