//
//  ShouCang_JYViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/7.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhuYeMianViewController.h"
#import "RESideMenu.h"

@interface ShouCang_JYViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>{

    UIButton * fanhuiBt;
    UIButton * fenxiangBt;
    UIScrollView *scrollview;
    UIView * backgroundview;
    UIButton * morenBt;
    UILabel * nameLa,* titleLa;
    UILabel * timeLa;
    UILabel * laiyuanLa;
    UIImageView * shangchuanImage,* shangchuanImage1,* shangchuanImage2;
    UITextView * neirongText;
    
    UIButton * shoucangBt;
    UIButton * jubaoBt;
    UITableView * tableview;
    UIButton * dianzanBt;
    UIButton * pinglunBt;
    UIButton * senderBt;
    UITextField * senderText;
    UIView * pinglunView1,*pinglunView2;
    
    BOOL isClick;
    
    int prewTag ;  //编辑上一个UITextField的TAG,需要在XIB文件中定义或者程序中添加，不能让两个控件的TAG相同
    float prewMoveY; //编辑的时候移动的高度
    
    UIButton * zongjiaoBt;
    UIButton * baoliBt;
    UIButton * qipianBt;
    UIButton * xiemiBt;
    UITextView * whyTextView;
    UIButton * button;
    UIView * vi;
}

@property (retain, nonatomic) NSMutableArray *dataArray;

@end
