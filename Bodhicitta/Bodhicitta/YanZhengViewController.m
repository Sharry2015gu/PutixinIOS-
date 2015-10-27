//
//  YanZhengViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/1.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "YanZhengViewController.h"
#import "HeaderFile.h"
@interface YanZhengViewController ()
@property(nonatomic,strong)UIImageView * accentLine;
@property(nonatomic,strong)UIImageView * passLine;
@property(nonatomic,strong)UIButton * reSendBtn;
@end

@implementation YanZhengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.22, SCREEN_HEIGHT*0.1, 0.8*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"短信验证码已发送，请填";
    title.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:title];
    UILabel * la=[[UILabel alloc]initWithFrame:CGRectMake(title.frame.origin.x+70, title.frame.origin.y+40, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.075)];
    la.text=@"写验证码";
    la.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:la];
    quxiao=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01-30, SCREEN_HEIGHT*0.01+35, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.1)];
    [quxiao setTitleColor:majorityColor forState:UIControlStateNormal];
    [quxiao setTitle:@"返回" forState:UIControlStateNormal];
    [quxiao addTarget:self action:@selector(quxiaoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quxiao];
    
    _accentLine=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, title.frame.size.height+title.frame.origin.y+70, SCREEN_WIDTH*0.85, 1)];
    _accentLine.image=[UIImage imageNamed:@"line.png"];
    [self.view addSubview:_accentLine];
    
    nameiv=[[UIImageView alloc]initWithFrame:CGRectMake(_accentLine.frame.origin.x-5, _accentLine.frame.origin.y+_accentLine.frame.size.height-45, 28, 30)];
    nameiv.image=[UIImage imageNamed:@"user.png"];
    [self.view addSubview:nameiv];
    nametext=[[UITextField alloc]initWithFrame:CGRectMake(nameiv.frame.origin.x+nameiv.frame.size.width+40,_accentLine.frame.origin.y+_accentLine.frame.size.height-50, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.075)];
    nametext.placeholder = @"+86 15029219724";
    [nametext setBackgroundColor:[UIColor clearColor]];
    nametext.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:nametext];
    
    _passLine=[[UIImageView alloc]initWithFrame:CGRectMake(_accentLine.frame.origin.x, _accentLine.frame.size.height+_accentLine.frame.origin.y+55, SCREEN_WIDTH*0.85, 1)];
    _passLine.image=[UIImage imageNamed:@"line.png"];
    [self.view addSubview:_passLine];
    
    yaniv=[[UILabel alloc]initWithFrame:CGRectMake(nameiv.frame.origin.x, _accentLine.frame.origin.y+10, SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.075)];
    yaniv.text=@"验证码";
    yaniv.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:yaniv];
    
    yanzheng=[[UITextField alloc]initWithFrame:CGRectMake(yaniv.frame.origin.x+80,_passLine.frame.origin.y+_passLine.frame.size.height-50, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.075)];
    yanzheng.placeholder=@"请填写验证码";
    yanzheng.font=[UIFont systemFontOfSize:20];
    yanzheng.secureTextEntry = YES;
    [self.view addSubview:yanzheng];
    
    sure=[UIButton buttonWithType:UIButtonTypeCustom];
    sure.frame=CGRectMake(_passLine.frame.origin.x, _passLine.frame.size.height+_passLine.frame.origin.y+40, SCREEN_WIDTH*0.88, 47);
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
        yanzheng.text = pwd;
    }

}
-(void)quxiaoClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)tijiaoClick{

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.39, SCREEN_HEIGHT*0.68, SCREEN_WIDTH*0.4, 30)];
    label.text = @"验证码输入不能为空";
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
    // Dispose of any resources that can be recreated.
}

@end
