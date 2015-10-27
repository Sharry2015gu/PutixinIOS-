//
//  GongJing_MainViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/20.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "ZhuYeMianViewController.h"
#import "HuanYuan_MainViewController.h"
#import "PlaceholderTextView.h"
#import "Please_QFViewController.h"
#import "Tribute.h"
#import "TempleImage.h"
#import "TempleVow.h"
#import "TributeModel.h"


@interface GongJing_MainViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate>{
    
    UIButton * fanhuiBt;
    UIImageView * bgImage;
    UINavigationBar * bar;
    UILabel * title;
    
    
    UIImageView * gongpingImage1, * gongpingImage2;
    UIImageView * huaImage1,*huaImage2;
    UIImageView * dengImage1,*dengImage2;
    UIImageView * xiangluImage,*xiangImage;
    UIImageView * guobanImage1,*guobanImage2;
    UIImageView * shuiguoImage1,*shuiguoImage2;
    UIImageView * chaImage1,*chaImage2,*chaImage3;
    
    UIScrollView * scrollview,*scrollview1,*scrollview2;
    
    UIButton * jingxiangBt;
    UIButton * gongchaBt;
    UIButton * xiangongBt;
    UIButton * gonghuaBt;
    UIButton * xuyuanBt;
    UIButton * huanyuanBt;
    
    BOOL isClick;
    
    UIImageView * backgroundImage;
    UIImageView * barImage;
    UIButton * fugeiImage,*fugeiImage1;
    
    //敬香弹出的图片
    UIButton * xiangBt;
    UIImageView * xiang;
    UILabel * name_sgLa;
    UILabel * money_sgLa;
    
    //许愿弹出的控件
    UITextField * nameText;
    UIImageView * xuyuanView;
    UIButton * sureBt;
    UIButton * deleteBt;
    UIButton * ImageBt;
    UIButton * xuanzeBt;
    UILabel * xuanzeLa;
    UIButton * sxBt,*xgBt,*gcBt,*ghBt;
    UIImageView * xuanzeImage;
    
    PlaceholderTextView *xinyuanText;
    UIView * tanchuang;
    UIButton * qingfoBt;
    
    UIScrollView * scrollviewImage;
    UIButton * jianjieBt;
    UIScrollView * qingfoScroll;
    UIView * backgroundview;
    

}

@property(nonatomic,strong) id down;

@property(nonatomic,assign) NSInteger selectedNumber;
@property(nonatomic,strong) UILabel *titlefugeiLa;
@property(nonatomic,strong) UIButton *backfugei;
@property(nonatomic,strong) UIImageView *imagefugai;
@property(nonatomic,strong) UIImageView *shuomingfugai;
@property(nonatomic,strong) UIScrollView *scrollfugai;
@property(nonatomic,strong) UILabel *imageLa;
@property(nonatomic,strong) UILabel *shuomingLa;
@property(nonatomic,strong) UIButton * startBt;

@property(nonatomic,strong) UIButton * againBt;//抽签的
@property(nonatomic,strong) UIImageView * chouqianImage;
@property(nonatomic,strong) UILabel * qianName;
@property(nonatomic,strong) UIImageView * markImage;
@property(nonatomic,strong) UILabel * Signpaper;//签文
@property(nonatomic,strong) UILabel * content;
@property(nonatomic,strong) UITextView * tishi;
@property(nonatomic,strong) UILabel * jianjie;
@property(nonatomic,strong) UIButton * jianjiebgImage;

-(void)getTempleImage;
-(void)getWishInfo;
-(void)getWishNum;
-(void)getTribute;
@end
