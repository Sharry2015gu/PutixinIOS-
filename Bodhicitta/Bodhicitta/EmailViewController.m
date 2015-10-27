//
//  EmailViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/5/11.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "EmailViewController.h"
#import "HeaderFile.h"
@interface EmailViewController ()
@property(nonatomic,strong)UIImageView * accentLine;
@property(nonatomic,strong)UIImageView * passLine;
@property(nonatomic,strong)UIButton * reSendBtn;
@property(nonatomic,strong)UIImageView * verImageView;
@end

@implementation EmailViewController
#pragma mark ----主页面---
- (void)viewDidLoad {
    [super viewDidLoad];
    
    backbt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01-30, SCREEN_HEIGHT*0.01+40, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.1)];
    [backbt setTitleColor:majorityColor forState:UIControlStateNormal];
    [backbt setTitle:@"返回" forState:UIControlStateNormal];
    [backbt addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbt];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.28, SCREEN_HEIGHT*0.1, 0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"使用邮箱找回密码";
    title.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:title];
    
    _accentLine=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, title.frame.size.height+title.frame.origin.y+70, SCREEN_WIDTH*0.9, 1)];
    _accentLine.image=[UIImage imageNamed:@"line.png"];
    [self.view addSubview:_accentLine];
    
    nameiv=[[UILabel alloc]initWithFrame:CGRectMake(_accentLine.frame.origin.x-5, _accentLine.frame.origin.y+_accentLine.frame.size.height-40, 60, 30)];
    nameiv.text=@"邮箱";
    [self.view addSubview:nameiv];
    
    nametext=[[UITextField alloc]initWithFrame:CGRectMake(nameiv.frame.origin.x+nameiv.frame.size.width+20,_accentLine.frame.origin.y+_accentLine.frame.size.height-49, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.075)];
    nametext.text = @"shx_vip111@163.com";
    [nametext setBackgroundColor:[UIColor clearColor]];
    nametext.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:nametext];
    
    UIImageView * sendLine=[[UIImageView alloc]initWithFrame:CGRectMake(nametext.frame.origin.x+nametext.frame.size.width-75, _accentLine.frame.origin.y-35, 1, 25)];
    sendLine.image=[UIImage imageNamed:@"line1.png"];
    [self.view addSubview:sendLine];
    
    UIButton * sender=[[UIButton alloc]initWithFrame:CGRectMake(sendLine.frame.origin.x, _accentLine.frame.origin.y+_accentLine.frame.size.height-49, SCREEN_WIDTH*0.2, SCREEN_HEIGHT*0.075)];
    [sender setTitle:@"发送" forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor colorWithRed:0.123 green:0.435 blue:0.52 alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:sender];
    
    _verImageView=[[UIImageView alloc]initWithFrame:CGRectMake(_accentLine.frame.origin.x, _accentLine.frame.size.height+_accentLine.frame.origin.y+55, SCREEN_WIDTH*0.9, 1)];
    _verImageView.image=[UIImage imageNamed:@"line.png"];
    [self.view addSubview:_verImageView];
    
    yaniv=[[UILabel alloc]initWithFrame:CGRectMake(nameiv.frame.origin.x, _accentLine.frame.origin.y+10, SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.075)];
    yaniv.text=@"验证码";
    yaniv.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:yaniv];
    
    yanzhengtext=[[UITextField alloc]initWithFrame:CGRectMake(yaniv.frame.origin.x+80,_verImageView.frame.origin.y+_verImageView.frame.size.height-45, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.075)];
    yanzhengtext.placeholder=@"请填写验证码";
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
    
    _reSendBtn=[[UIButton alloc]initWithFrame:CGRectMake(sure.frame.origin.x+20, sure.frame.origin.y+sure.frame.size.height+10, SCREEN_WIDTH *0.8, SCREEN_HEIGHT*0.075)];
    [_reSendBtn setTitle:@"收不到短信验证码，点击重新发送" forState:UIControlStateNormal];
    [_reSendBtn setTitleColor:[UIColor colorWithRed:0.123 green:0.435 blue:0.52 alpha:1.0] forState:UIControlStateNormal];
    _reSendBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [_reSendBtn addTarget:self action:@selector(reSendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_reSendBtn];
    
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
    label.text = @"验证码不能为空";
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
-(void)reSendBtnClick{
    
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_reSendBtn setTitle:@"收不到短信验证码，点击重新发送" forState:UIControlStateNormal];
                _reSendBtn.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [_reSendBtn setTitle:[NSString stringWithFormat:@"接收短信大约需要%@秒",strTime] forState:UIControlStateNormal];
                _reSendBtn.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)leftTapped:(id)sender {
//    ViewController * view=[[ViewController alloc]init];
//    [self.navigationController pushViewController:view animated:YES];
    
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [emailtext resignFirstResponder];
    
}

@end
