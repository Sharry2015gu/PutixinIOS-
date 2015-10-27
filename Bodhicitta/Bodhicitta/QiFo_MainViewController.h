//
//  QiFo_MainViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/27.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlessingViewController.h"



@interface QiFo_MainViewController : UIViewController{

    UILabel * title;
    UIButton * _button;


    UIImageView * foxiangImage;
    
    UIImageView * gongpingImage1, * gongpingImage2;
    UIImageView * huaImage1,*huaImage2;
    UIImageView * dengImage1,*dengImage2;
    UIImageView * xiangluImage,*xiangImage;
    UIImageView * guobanImage1,*guobanImage2;
    UIImageView * shuiguoImage1,*shuiguoImage2;
    UIImageView * chaImage1,*chaImage2,*chaImage3;
    
    UIButton * jingong;
    UIButton * qifu;
    UIButton * wengua;
    NSArray * array;
    
    
    
    //敬香弹出的图片
    UIImageView * backgroundImage;
    UIScrollView * scrollview;
    UIButton * fugeiImage;
    UIButton * xiangBt1,*xiangBt2,*xiangBt3,*xiangBt4,*xiangBt5,*xiangBt6,*xiangBt7,*xiangBt8,*xiangBt9,*xiangBt10;
    UIImageView * xiang1,*xiang2,*xiang3,*xiang4,* xiang5,*xiang6,* xiang7,* xiang8,* xiang9,* xiang10;
    UILabel * name_sgLa1,*name_sgLa2,*name_sgLa3,*name_sgLa4,*name_sgLa5,*name_sgLa6,*name_sgLa7,*name_sgLa8,*name_sgLa9,*name_sgLa10;
    UILabel * money_sgLa1,*money_sgLa2,*money_sgLa3,*money_sgLa4,*money_sgLa5,*money_sgLa6,* money_sgLa7,* money_sgLa8,* money_sgLa9,* money_sgLa10;
}



- (void) setValue:(NSString *) value;
@property(nonatomic,strong) UIView *contributeBtnView;
@property(nonatomic,strong) UIView *qifuBtnView;
@property(nonatomic,strong) UIView * wenguaBtnView;

@property(nonatomic,strong) id sum;
@property(nonatomic,assign) NSInteger sumNumber;

//@property(nonatomic,assign) NSObject<BlessingviewDelegate> *delegate;

@end
