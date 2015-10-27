//

//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/22.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "QingFoView1.h"
#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "HeaderFile.h"


@implementation QingFoView1

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
-(void)createViews
{
    maskView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.5;
    maskView.userInteractionEnabled=NO;
    [self addSubview:maskView];
    
    iv=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    iv.image=[UIImage imageNamed:@"返回上级"];
    iv.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTapped)];
    [iv addGestureRecognizer:singleTap];//点击图片事件
    [self addSubview:iv];//加载图片
    title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=self.model.taskName;
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [self addSubview:title];
    
    foxiangImage=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.15, SCREEN_HEIGHT*0.08, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.4)];
    [foxiangImage setImageWithURL:[NSURL URLWithString:self.model.materialImageUrl]];
    [self addSubview:foxiangImage];
    
    jianjieImage=[[UIImageView alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT*0.5, SCREEN_HEIGHT*0.47, SCREEN_HEIGHT*0.3)];
    jianjieImage.image=[UIImage imageNamed:@"please_buddha_result_bg"];
    jianjieImage.userInteractionEnabled = YES;
    [self addSubview:jianjieImage];
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(50, SCREEN_HEIGHT*0.52, SCREEN_HEIGHT*0.41, SCREEN_HEIGHT*0.25)];
    [scrollview setShowsHorizontalScrollIndicator:NO];
    [scrollview setShowsVerticalScrollIndicator:NO];
    [scrollview setContentSize:CGSizeMake(0, 300)];
//    [scrollview setBackgroundColor:[UIColor redColor]];
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
//    _textview.scrollEnabled=NO;
    _textview.font=[UIFont systemFontOfSize:14];
    [scrollview addSubview:_textview];
    
    qingfoBt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.37, SCREEN_HEIGHT*0.87, SCREEN_WIDTH*0.25, SCREEN_HEIGHT*0.05)];
    [qingfoBt setBackgroundImage:[UIImage imageNamed:@"bt_please_buddha_bg"] forState:UIControlStateNormal];
    qingfoBt.userInteractionEnabled = YES;
    [qingfoBt setTitle:@"恭请" forState:UIControlStateNormal];
    [qingfoBt setTitleColor:[[UIColor alloc]initWithRed:51.0f/255.0f green:19.0f/255.0f blue:0.0f alpha:0.9f] forState:UIControlStateNormal];
    [qingfoBt addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:qingfoBt];
}
-(void)btnClick
{
    self.submitBlock(self.model);
    
}
-(void)photoTapped
{
    
    [self removeFromSuperview];
}
@end

