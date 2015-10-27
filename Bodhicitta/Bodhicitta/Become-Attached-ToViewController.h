//
//  Become-Attached-ToViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/3.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShouCang_JYViewController.h"
#import "ShanYou_DTViewController.h"
#import "My_syViewController.h"

@interface Become_Attached_ToViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    UIButton * shanyouBt;
    UIButton * myBt;
    UIScrollView * scrollview;
    UITableView * tableview;
    UIButton * fanhuiBt;
    
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
    
    UIButton * zongjiaoBt;
    UIButton * baoliBt;
    UIButton * qipianBt;
    UIButton * xiemiBt;
    UITextView * whyTextView;
    UIButton * button;
    UIView * vi;


}

@property (retain, nonatomic) NSMutableArray * dataArray;

@end
