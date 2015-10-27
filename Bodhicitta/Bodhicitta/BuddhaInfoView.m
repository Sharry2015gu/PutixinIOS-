
//
//  BuddhaInfoView.m
//  Bodhicitta
//
//  Created by 怀恩11 on 15/9/22.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "BuddhaInfoView.h"
#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "HeaderFile.h"
#import "BuddhaddRankViewController.h"
@implementation BuddhaInfoView
-(instancetype)initWithFrame:(CGRect)frame WithModel:(TempleImage *) model
{
    self = [super  initWithFrame:frame];
    if (self) {
        self.model = model;
        self.backgroundColor = [UIColor clearColor];
        [self createViews];
    }
    return self;
}
- (void)createViews
{
    maskView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.5;
    maskView.userInteractionEnabled=NO;
    [self addSubview:maskView];
    
    iv=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.035, 0.04*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    iv.image=[UIImage imageNamed:@"返回上级"];
    iv.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTapped)];
    [iv addGestureRecognizer:singleTap];//点击图片事件
    [self addSubview:iv];//加载图片
    self.title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    self.title.text=self.model.taskName;
    NSLog(@"名字哦哦＝%@",self.model.taskName);
    self.title.textColor=[UIColor whiteColor];
    self.title.font=[UIFont systemFontOfSize:20];
    [self addSubview:self.title];
    
    foxiangImage=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.15, SCREEN_HEIGHT*0.08, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.4)];
    [foxiangImage setImageWithURL:[NSURL URLWithString:self.model.materialImageUrl]];
    [self addSubview:foxiangImage];
    
    jianjieImage=[[UIImageView alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT*0.5, SCREEN_HEIGHT*0.47, SCREEN_HEIGHT*0.3)];
    jianjieImage.image=[UIImage imageNamed:@"please_buddha_result_bg"];
    jianjieImage.userInteractionEnabled = YES;
    [self addSubview:jianjieImage];
    
    CGFloat width;
    CGFloat height ;
    CGFloat font ;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        width = 230;
        height =  100;
        font  = 16;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            width = 180;
            height = 95;
            font = 14;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            width = 230;
            height = 100;
            font = 16;
        }
        else
        {
            width = 180;
            height  = 100;
            font = 14;
        }
    }

    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(50, SCREEN_HEIGHT*0.52, SCREEN_HEIGHT*0.41, SCREEN_HEIGHT*0.25)];
    [scrollview setShowsHorizontalScrollIndicator:NO];
    [scrollview setShowsVerticalScrollIndicator:NO];
    [scrollview setContentSize:CGSizeMake(0, 300)];
    [scrollview setBackgroundColor:[UIColor clearColor]];
    scrollview.userInteractionEnabled = YES;
    [self addSubview:scrollview];
    
    titleText=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, SCREEN_HEIGHT*0.01, SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.04)];
    titleText.text=self.model.taskName;
    titleText.textAlignment = NSTextAlignmentCenter;
    titleText.backgroundColor=[UIColor clearColor];
    [scrollview addSubview:titleText];
    
    _textview=[[UITextView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, SCREEN_HEIGHT*0.04, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.4)];
    _textview.backgroundColor=[UIColor clearColor];
    _textview.text=self.model.taskDesc;
    [_textview setEditable:NO];
    _textview.font=[UIFont systemFontOfSize:14];
    [scrollview addSubview:_textview];
    
    UIButton * supportBtn = [[UIButton alloc]initWithFrame:CGRectMake(scrollview.frame.origin.x+width*0.32, scrollview.frame.origin.y+scrollview.frame.size.height+height*0.3, width*0.6, height*0.45)];
    [supportBtn setTitle:@"供养排行" forState:UIControlStateNormal];
    [supportBtn setBackgroundImage:[UIImage imageNamed:@"佛堂排行入口按钮"] forState:UIControlStateNormal];
    [supportBtn setTitleColor:[UIColor colorWithRed:255.0f/255.0 green:234.0f/255.0f blue:43.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [supportBtn addTarget:self action:@selector(supportClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:supportBtn];
}
-(void)photoTapped
{
    
    [self removeFromSuperview];
}
-(void)supportClick{
    
    self.blockBudd();
}
@end
