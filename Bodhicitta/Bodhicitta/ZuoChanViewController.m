//
//  ZuoChanViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/22.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "ZuoChanViewController.h"
#import "ZhuYeMianViewController.h"
#import "HeaderFile.h"
@interface ZuoChanViewController ()

@end

@implementation ZuoChanViewController

#pragma mark ---主页面UI----
- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBar * bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.1+5)];
    
    [bar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:bar];
    
    UIButton * bu=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [bu setBackgroundImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(buclick) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:bu];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"为何坐禅";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [bar addSubview:title];
    
    fenxiangBt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.89, 0.05*SCREEN_HEIGHT, 25, 25)];
    [fenxiangBt setBackgroundImage:[UIImage imageNamed:@"share_white_icon"] forState:UIControlStateNormal];
//    [fenxiangBt addTarget:self action:@selector(fenxiangClick) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:fenxiangBt];
    
    UIView * bgview=[[UIView alloc]initWithFrame:CGRectMake(0, bar.frame.origin.y+bar.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgview.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景.png"]];
    [self.view addSubview:bgview];
    
    CGFloat width;
    CGFloat height ;
    CGFloat font;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        width = 210;
        height =  148;
        font = 16;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            width = 180;
            height = 125;
            font = 14;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            width = 233;
            height = 160;
            font = 18;
        }
        else
        {
            width = 180;
            height  = 105;
            font = 13;
        }
    }
    
    UIImageView * zuochan=[[UIImageView alloc]initWithFrame:CGRectMake(width*0.14, bgview.frame.origin.x+bgview.frame.size.height-height*0.95*4.6, width*0.75*2, height + height * 0.5*2)];
    zuochan.image=[UIImage imageNamed:@"meditation_icon"];
    [bgview addSubview:zuochan];
    
    UILabel * name=[[UILabel alloc]initWithFrame:CGRectMake(zuochan.frame.origin.x+width*0.62, zuochan.frame.origin.y+zuochan.frame.size.height+10, 70, 20)];
    name.text=@"坐禅图";
    name.font=[UIFont systemFontOfSize:font+2];
    [bgview addSubview:name];
    
    textView=[[UITextView alloc]initWithFrame:CGRectMake(zuochan.frame.origin.x+width*0.02, zuochan.frame.origin.y+zuochan.frame.size.height+35, SCREEN_WIDTH*0.85, 200)];
    textView.text=@"    坐禅，简称“禅”，意谓思维修或静虑。坐禅，就是跌坐而修禅，是佛教修持的主要方法之一。坐禅，同时是民间爱好佛学者理疗，治病，修身，养性，养生，悟道的一种修炼方式。";
    textView.font=[UIFont systemFontOfSize:font+2];
    textView.backgroundColor=[UIColor clearColor];
    [bgview addSubview:textView];
    
    
}
-(void)buclick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
