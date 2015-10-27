//
//  PhoneEmailViewController.m
//  Bodhicitta
//
//  Created by 怀恩11 on 15/10/20.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "PhoneEmailViewController.h"
#import "HeaderFile.h"

@interface PhoneEmailViewController ()

@end

@implementation PhoneEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    UIImageView *imageView1 =[[UIImageView alloc]initWithFrame:CGRectMake(0, title.frame.origin.y+title.frame.size.height+SCREEN_HEIGHT*0.1, SCREEN_WIDTH, SCREEN_HEIGHT*0.1)];
    imageView1.image=[UIImage imageNamed:@"个人中心菜单背景.png"];
    imageView1.userInteractionEnabled=YES;
    UITapGestureRecognizer *phoneTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(phoneAction)];
    [imageView1 addGestureRecognizer:phoneTap];
    [self.view addSubview:imageView1];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, imageView1.frame.size.width*0.4, imageView1.frame.size.height)];
    label1.text=@"手机找回密码";
    label1.font=[UIFont systemFontOfSize:font];
    [imageView1 addSubview:label1];
    UIImageView *rightImageView1 =[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.9, 15, 20, 20)];
    rightImageView1.image=[UIImage imageNamed:@"箭头图标.png"];
    [imageView1 addSubview:rightImageView1];
    //
    UIImageView *imageView2 =[[UIImageView alloc]initWithFrame:CGRectMake(0, imageView1.frame.origin.y+imageView2.frame.size.height+2, SCREEN_WIDTH, SCREEN_HEIGHT*0.1)];
    imageView2.image=[UIImage imageNamed:@"个人中心菜单背景.png"];
    imageView2.userInteractionEnabled=YES;
    UITapGestureRecognizer *emailTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(emailAction)];
    [imageView2 addGestureRecognizer:emailTap];
    [self.view addSubview:imageView2];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, imageView2.frame.size.width*0.4, imageView2.frame.size.height)];
    label2.text=@"手机找回密码";
    label2.font=[UIFont systemFontOfSize:font];
    [imageView2 addSubview:label2];
    UIImageView *rightImageView2 =[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.9, 15, 20, 20)];
    rightImageView2.image=[UIImage imageNamed:@"箭头图标.png"];
    [imageView2 addSubview:rightImageView2];
   
}
- (void)phoneAction
{
    
}

- (void)emailAction
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
