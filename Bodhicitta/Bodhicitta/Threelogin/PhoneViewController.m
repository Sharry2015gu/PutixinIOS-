//
//  PhoneViewController.m
//  Bodhicitta
//
//  Created by 怀恩11 on 15/10/20.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "PhoneViewController.h"
#import "HeaderFile.h"
#import "TelePhoneViewController.h"
@interface PhoneViewController ()

@end

@implementation PhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"登录背景"]];
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
    
   UIButton   *backbt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01-30, SCREEN_HEIGHT*0.01+40, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.1)];
    [backbt setTitleColor:majorityColor forState:UIControlStateNormal];
    [backbt setTitle:@"返回" forState:UIControlStateNormal];
    [backbt addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbt];
    
   UILabel  *title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.1, 0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"找回密码方式";
    title.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:title];
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, title.frame.origin.y+title.frame.size.height+SCREEN_HEIGHT*0.01, SCREEN_WIDTH, SCREEN_HEIGHT*0.06)];
    imageView.image=[UIImage imageNamed:@"个人中心菜单背景.png"];
    imageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *phoneTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(phoneAction)];
    [imageView addGestureRecognizer:phoneTap];
    [self.view addSubview:imageView];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, imageView.frame.size.width*0.4, imageView.frame.size.height)];
    label.text=@"手机找回密码";
    label.font=[UIFont systemFontOfSize:font];
    [imageView addSubview:label];
    UIImageView *rightImageView =[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.9, 15, 20, 20)];
    rightImageView.image=[UIImage imageNamed:@"箭头图标.png"];
    [imageView addSubview:rightImageView];
    
}
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)phoneAction
{
   TelePhoneViewController *Phone=[[TelePhoneViewController alloc]init];
    [self.navigationController pushViewController:Phone animated:YES];
}



@end
