//
//  TouXiang_GXViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/9.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "TouXiang_GXViewController.h"

@interface TouXiang_GXViewController ()

@end

@implementation TouXiang_GXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 70)];
    view.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"顶部导航背景"]];
    [self.view addSubview:view];
    //    UIImageView *
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(135, 30, 120, 30)];
    title.text=@"填写圈名称";
    title.font=[UIFont systemFontOfSize:20];
    title.textColor=[UIColor whiteColor];
    [view addSubview:title];
    
    fanhuiBt=[[UIButton alloc]initWithFrame:CGRectMake(6, 33, 25, 25)];
    [fanhuiBt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [fanhuiBt addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhuiBt];
    
    updownBt=[[UIButton alloc]initWithFrame:CGRectMake(285, 33, 100, 25)];
    [updownBt setTitle:@"下一步" forState:UIControlStateNormal];
    [updownBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [updownBt addTarget:self action:@selector(updownClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updownBt];
    
    UIView * background=[[UIView alloc]initWithFrame:CGRectMake(0, 70, 380, self.view.frame.size.height)];
    background.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    [self.view addSubview:background];
    
    UIImageView * bgIv=[[UIImageView alloc]initWithFrame:CGRectMake(5, 30, 355, 190)];
    bgIv.image=[UIImage imageNamed:@"make_circle_name"];
    [background addSubview:bgIv];
    
    UILabel * tishiLa=[[UILabel alloc]initWithFrame:CGRectMake(100, 210, 200, 20)];
    tishiLa.text=@"给你的圈子起个温馨的名称";
    tishiLa.font=[UIFont systemFontOfSize:16];
    tishiLa.textColor=[UIColor grayColor];
    [background addSubview:tishiLa];
    
    nameImage=[[UIImageView alloc]initWithFrame:CGRectMake(25, 275, 320, 50)];
    nameImage.image=[UIImage imageNamed:@"circle_name_input_bg"];
    [background addSubview:nameImage];
    
    name_qmText=[[UITextField alloc]initWithFrame:CGRectMake(35, 275, 310, 50)];
    name_qmText.placeholder=@"填写圈名称(至少两个字)";
    name_qmText.delegate=self;
    [background addSubview:name_qmText];
}
-(void)backclick{
    
    [self.sideMenuViewController
     setContentViewController:[[ShanYou_DTViewController alloc] init]animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
}
-(void)updownClick{
    
    if ([name_qmText.text isEqualToString:@""] || name_qmText.text ==nil) {
        
        UIAlertView * alrea=[[UIAlertView alloc]initWithTitle:@"匿名不能为空或最少两个字" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alrea show];

        
    }else {
        [self.sideMenuViewController
         setContentViewController:[[TouXiang_SCViewController alloc] init]animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
     
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
