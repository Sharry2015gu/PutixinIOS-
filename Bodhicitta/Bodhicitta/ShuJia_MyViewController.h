//
//  ShuJia_MyViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/2.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WisdomMathViewController.h"
#import "DuJingViewController.h"
#import "ChaoJingViewController.h"
#import "DuJing_PHViewController.h"
#import "ChaoJing_PHViewController.h"

@interface ShuJia_MyViewController : UIViewController<UIScrollViewDelegate,UIActionSheetDelegate>

@property(retain, nonatomic) NSIndexPath *selectIndex;
@property(nonatomic,strong)  UIButton  *btn;

@property(nonatomic,strong)NSArray *titleArray;

@property (nonatomic, strong) UIScrollView *scrollView;
@end
