//
//  MiBaoViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/1.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "MiBaoViewController.h"
#import "HeaderFile.h"
@interface MiBaoViewController ()
@property(nonatomic,strong)UIImageView * accentLine;
@property(nonatomic,strong)UIImageView * passLine;
@property(nonatomic,strong)UIImageView * verImageView;
@end

@implementation MiBaoViewController
#pragma mark ----主页面---
- (void)viewDidLoad {
    [super viewDidLoad];
    backbt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01-30, SCREEN_HEIGHT*0.01+40, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.1)];
    [backbt setTitleColor:majorityColor forState:UIControlStateNormal];
    [backbt setTitle:@"返回" forState:UIControlStateNormal];
    [backbt addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbt];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.28, SCREEN_HEIGHT*0.1, 0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"使用密保找回密码";
    title.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:title];
    
    _accentLine=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, title.frame.size.height+title.frame.origin.y+70, SCREEN_WIDTH*0.9, 1)];
    _accentLine.image=[UIImage imageNamed:@"line.png"];
    [self.view addSubview:_accentLine];
    
    nameiv=[[UILabel alloc]initWithFrame:CGRectMake(_accentLine.frame.origin.x-5, _accentLine.frame.origin.y+_accentLine.frame.size.height-40, 60, 30)];
    nameiv.text=@"问题";
    [self.view addSubview:nameiv];
    
    nametext=[[UITextField alloc]initWithFrame:CGRectMake(nameiv.frame.origin.x+nameiv.frame.size.width+20,_accentLine.frame.origin.y+_accentLine.frame.size.height-49, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.075)];
    nametext.text = @"你的初恋是谁？";
    [nametext setBackgroundColor:[UIColor clearColor]];
    nametext.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:nametext];
    
    _verImageView=[[UIImageView alloc]initWithFrame:CGRectMake(_accentLine.frame.origin.x, _accentLine.frame.size.height+_accentLine.frame.origin.y+55, SCREEN_WIDTH*0.9, 1)];
    _verImageView.image=[UIImage imageNamed:@"line.png"];
    [self.view addSubview:_verImageView];
    
    yaniv=[[UILabel alloc]initWithFrame:CGRectMake(nameiv.frame.origin.x, _accentLine.frame.origin.y+10, SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.075)];
    yaniv.text=@"答案";
    yaniv.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:yaniv];
    
    yanzhengtext=[[UITextField alloc]initWithFrame:CGRectMake(yaniv.frame.origin.x+80,_verImageView.frame.origin.y+_verImageView.frame.size.height-45, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.075)];
    yanzhengtext.placeholder=@"请输入答案";
    yanzhengtext.font=[UIFont systemFontOfSize:20];
    yanzhengtext.secureTextEntry = YES;
    [self.view addSubview:yanzhengtext];
    
    _passLine=[[UIImageView alloc]initWithFrame:CGRectMake(_verImageView.frame.origin.x, _verImageView.frame.origin.y+_verImageView.frame.size.height+55, SCREEN_WIDTH*0.9, 1)];
    _passLine.image=[UIImage imageNamed:@"line.png"];
    [self.view addSubview:_passLine];
    
    pass=[[UILabel alloc]initWithFrame:CGRectMake(_verImageView.frame.origin.x, _verImageView.frame.origin.y+5, SCREEN_WIDTH*0.15, SCREEN_HEIGHT*0.075)];
    pass.text=@"新密码";
    pass.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:pass];
    
    passwork=[[UITextField alloc]initWithFrame:CGRectMake(pass.frame.origin.x+pass.frame.size.width+20, _passLine.frame.origin.y+_passLine.frame.size.height-52, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.075)];
    passwork.placeholder=@"请输入新密码";
    passwork.font=[UIFont systemFontOfSize:20];
    passwork.secureTextEntry = YES;
    [self.view addSubview:passwork];
    
    UIImageView * zhongjian=[[UIImageView alloc]initWithFrame:CGRectMake(passwork.frame.origin.x-75+SCREEN_WIDTH*0.7, _passLine.frame.origin.y+_passLine.frame.size.height-40, 1, 25)];
    zhongjian.image=[UIImage imageNamed:@"line1.png"];
    [self.view addSubview:zhongjian];
    
    UIButton * keshi=[[UIButton alloc]initWithFrame:CGRectMake(zhongjian.frame.origin.x+15, _passLine.frame.origin.y+_passLine.frame.size.height-45, SCREEN_WIDTH*0.11, SCREEN_HEIGHT*0.06)];
    [keshi setBackgroundImage:[UIImage imageNamed:@"可视密码.png"] forState:UIControlStateNormal];
    [self.view addSubview:keshi];
    
    sure=[UIButton buttonWithType:UIButtonTypeCustom];
    sure.frame=CGRectMake(_passLine.frame.origin.x, _passLine.frame.origin.y+_passLine.frame.size.height+50, SCREEN_WIDTH*0.9, 47);
    [sure setBackgroundImage:[UIImage imageNamed:@"输入字符时登录按钮"] forState:UIControlStateNormal];
    [sure setTitle:@"提交" forState:UIControlStateNormal];
    [sure addTarget:self action:@selector(tijiaoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sure];
    
    //决定是否显示用户名以及密码
    NSString *name = [Config Instance].getUserName;
    NSString *pwd = [Config Instance].getPwd;
    if (name && ![name isEqualToString:@""]) {
        nametext.text = name;
    }
    if (pwd && ![pwd isEqualToString:@""]) {
        yanzhengtext.text = pwd;
    }

}
-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)tijiaoClick{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.78, 100, 30)];
    label.text = @"答案不能为空";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:12];
    [self.view addSubview:label];
    
    [UIView animateWithDuration:1.5 animations:^{
        label.alpha = 0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
