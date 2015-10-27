//
//  LeftViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/8.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
//#import "ZhangHuViewController.h"
//#import "XinDengViewController.h"
#import "BlockActionSheet.h"
#import "SetUpViewController.h"
#import "UserInfoEditingViewController.h"
#import "XinXiangViewController.h"
#import "BuddhistCalendarViewController.h"

@interface LeftViewController :UIViewController<UIActionSheetDelegate>{
    UIImageView * touxiang;
    UITextField * guanzhutext;
    UITextField * fensitext;
    UITextField * huaienIDtext;
    
    UIButton * lvt;
    UIProgressView *pro;
    UILabel * proLabel;
    UILabel * colorPro;
    UIView * view;
    
//    BlockActionSheet * sheet;
    UIActionSheet *actionSheet;
    UILabel * title;
    UILabel * signture;

}


-(void)getInfo;//得到信息

@end
