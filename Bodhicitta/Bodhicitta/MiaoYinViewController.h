//
//  MiaoYinViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/25.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DockMenuSubView.h"
#import "DockMenuView.h"
#import "RESideMenu.h"
#import "ZhuYeMianViewController.h"
#import "HMSegmentedControl.h"
#import <AVFoundation/AVFoundation.h>
@interface MiaoYinViewController : UITabBarController<UIScrollViewDelegate>{
    
    UIButton *_button;
    
    
    NSMutableArray * arrlist;
    UITableView * tableview;
    UIButton * jingdianBt;
    UIButton * songjingBt;
    UIButton * liuxingBt;
    UIImageView * bgImage;
    UIImageView * shadowImageView;
    
    UIButton * bofangBt;
    
    BOOL isClick;
    
    UIView * _tabbar;
    
    
    
    
}
@property(nonatomic,strong)AVAudioPlayer  * audioPlayer;
@property(nonatomic,strong)NSArray *titleArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl4;
- (void)btnSelect:(UIButton *)sender;
-(void)showTabBar;
-(void)hideTabBar;

@end
