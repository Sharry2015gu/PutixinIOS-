//
//  TelePhoneViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/1.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "TelePhoneViewController.h"
#import "HeaderFile.h"
#import "UserLoginViewController.h"
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#import "HeaderFile.h"
#import <CommonCrypto/CommonDigest.h>
@interface TelePhoneViewController ()
{
    BOOL flag;
}
@property(nonatomic,strong)UIImageView * accentLine;
@property(nonatomic,strong)UIImageView * passLine;
@property(nonatomic,strong)UIButton * reSendBtn;
@property(nonatomic,strong)UIImageView * verImageView;
@end

@implementation TelePhoneViewController

#pragma mark ----主页面----
- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    backbt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01-30, SCREEN_HEIGHT*0.01+40, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.1)];
    [backbt setTitleColor:majorityColor forState:UIControlStateNormal];
    [backbt setTitle:@"返回" forState:UIControlStateNormal];
    [backbt addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbt];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.28, SCREEN_HEIGHT*0.1, 0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"使用手机找回密码";
    title.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:title];
    
    _accentLine=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, title.frame.size.height+title.frame.origin.y+70, SCREEN_WIDTH*0.9, 1)];
    _accentLine.image=[UIImage imageNamed:@"line.png"];
    [self.view addSubview:_accentLine];
    
    nameiv=[[UILabel alloc]initWithFrame:CGRectMake(_accentLine.frame.origin.x-5, _accentLine.frame.origin.y+_accentLine.frame.size.height-40, 60, 30)];
    nameiv.text=@"手机号";
    [self.view addSubview:nameiv];
    
    nametext=[[UILabel alloc]initWithFrame:CGRectMake(nameiv.frame.origin.x+nameiv.frame.size.width+20,_accentLine.frame.origin.y+_accentLine.frame.size.height-49, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.075)];
    nametext.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"];
    nametext.textColor=[UIColor blackColor];
    nametext.alpha=0.5;
    [nametext setBackgroundColor:[UIColor clearColor]];
    nametext.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:nametext];
    
    UIImageView * sendLine=[[UIImageView alloc]initWithFrame:CGRectMake(nametext.frame.origin.x+nametext.frame.size.width-75, _accentLine.frame.origin.y-35, 1, 25)];
    sendLine.image=[UIImage imageNamed:@"line1.png"];
    [self.view addSubview:sendLine];

    UIButton * sender=[[UIButton alloc]initWithFrame:CGRectMake(sendLine.frame.origin.x, _accentLine.frame.origin.y+_accentLine.frame.size.height-49, SCREEN_WIDTH*0.2, SCREEN_HEIGHT*0.075)];
    [sender setTitle:@"发送" forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor colorWithRed:0.123 green:0.435 blue:0.52 alpha:1.0] forState:UIControlStateNormal];
    [sender addTarget:self action:@selector(sendclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sender];
    
    _verImageView=[[UIImageView alloc]initWithFrame:CGRectMake(_accentLine.frame.origin.x, _accentLine.frame.size.height+_accentLine.frame.origin.y+55, SCREEN_WIDTH*0.9, 1)];
    _verImageView.image=[UIImage imageNamed:@"line.png"];
    [self.view addSubview:_verImageView];
    
    yaniv=[[UILabel alloc]initWithFrame:CGRectMake(nameiv.frame.origin.x, _accentLine.frame.origin.y+10, SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.075)];
    yaniv.text=@"验证码";
    yaniv.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:yaniv];
    //验证码
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
    //新密码
    passwork=[[UITextField alloc]initWithFrame:CGRectMake(pass.frame.origin.x+pass.frame.size.width+20, _passLine.frame.origin.y+_passLine.frame.size.height-52, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.075)];
    passwork.placeholder=@"请输入新密码";
    passwork.font=[UIFont systemFontOfSize:20];
    passwork.secureTextEntry = YES;
    [self.view addSubview:passwork];

    UIImageView * zhongjian=[[UIImageView alloc]initWithFrame:CGRectMake(passwork.frame.origin.x-75+SCREEN_WIDTH*0.7, _passLine.frame.origin.y+_passLine.frame.size.height-40, 1, 25)];
    zhongjian.image=[UIImage imageNamed:@"line1.png"];
    [self.view addSubview:zhongjian];
    
    UIButton * keshi=[[UIButton alloc]initWithFrame:CGRectMake(zhongjian.frame.origin.x+15, _passLine.frame.origin.y+_passLine.frame.size.height-45, SCREEN_WIDTH*0.11, SCREEN_HEIGHT*0.06)];
    [keshi setImage:[UIImage imageNamed:@"不可视密码.png"] forState:UIControlStateNormal];
    [keshi addTarget:self action:@selector(keshiBtnClick:)forControlEvents:UIControlEventTouchUpInside];
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
//    NSString *name = [Config Instance].getUserName;
//    NSString *pwd = [Config Instance].getPwd;
//    if (name && ![name isEqualToString:@""]) {
//        nametext.text = name;
//    }
//    if (pwd && ![pwd isEqualToString:@""]) {
//        yanzhengtext.text = pwd;
//    }

}
- (void)keshiBtnClick:(UIButton*)btn
{
    NSArray *imageTitleArray = @[@"不可视密码",@"可视密码"];
    NSString *imageName = imageTitleArray[passwork.secureTextEntry];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    passwork.secureTextEntry = !passwork.secureTextEntry;
}
-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 发送短信验证码
-(void)sendclick{
    
    NSDictionary  *dict  = @{@"mobile":nametext.text,@"verType":@2};
    NSDictionary * resultDict = @{@"params":[NSString stringWithFormat:@"%@",dict]};
    AppDelegate  *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.sessionManager  GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,usrSendMobileVerCodeURL] parameters:resultDict success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"找回密码手机验证短信＝%@",jsonData);//287
        NSNumber * result = jsonData[@"result"];
        [[NSUserDefaults standardUserDefaults]setObject:result forKey:@"verificationID"];
        
        if ([result integerValue] > 0) {
            nametext.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"];
            self.keyID = result;
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发送失败" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alertView  show];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

//    if (num<3) {
//        
//    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.78, 100, 30)];
//    label.text = @"发送成功，请查收";
//    label.textColor = [UIColor whiteColor];
//    label.textAlignment = 1;
//    label.backgroundColor = [UIColor blackColor];
//    label.font = [UIFont boldSystemFontOfSize:12];
//    [self.view addSubview:label];
//    
//    [UIView animateWithDuration:1.5 animations:^{
//        label.alpha = 0;
//    } completion:^(BOOL finished) {
//        [label removeFromSuperview];
//    }];
//    }else if (num>3){
//       
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.25, SCREEN_HEIGHT*0.78, 170, 30)];
//        label.text = @"您的短信发送已经超过3次，手机已经被锁定，将会在24小时之后自动解锁";
//        label.numberOfLines=2;
//        label.textColor = [UIColor whiteColor];
//        label.textAlignment = 1;
//        label.backgroundColor = [UIColor blackColor];
//        label.font = [UIFont boldSystemFontOfSize:12];
//        [self.view addSubview:label];
//        
//        [UIView animateWithDuration:1.5 animations:^{
//            label.alpha = 0;
//        } completion:^(BOOL finished) {
//            [label removeFromSuperview];
//        }];
//
//    }

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
                [_reSendBtn setTitle:[NSString stringWithFormat:@"接收短信大约需要%@秒",strTime] forState:UIControlStateNormal];
                _reSendBtn.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}
#pragma mark 检验短信验证吗是否正确
-(void)tijiaoClick{
    if([yanzhengtext.text isEqualToString:@""]){
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
  
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
        if ([passwork.text isEqualToString:@""]){
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.78, 100, 30)];
                label.text = @"新密码不能为空";
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
            }else if (passwork.text.length <6&&pass.text.length>0){
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.7, 150, 30)];
                label.text = @"新密码要在6-12位之间";
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
            }else if (passwork.text.length>12){
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.7, 150, 30)];
                label.text = @"新密码要在6-12位之间";
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
            }else
            {
                NSString *newPassWord=passwork.text;
                //密码加密
                const char *passWordChar = [newPassWord UTF8String];
                unsigned char passWordCharResult[CC_MD5_DIGEST_LENGTH];
                CC_MD5(passWordChar, strlen(passWordChar),passWordCharResult);
                NSMutableString  *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
                for(int i = 0 ; i < CC_MD5_DIGEST_LENGTH;i++)
                {
                    [output appendFormat:@"%02x",passWordCharResult[i]];
                }
            NSLog(@"idd=%@",self.keyID);
              NSDictionary  *dict  = @{@"uptWay":@"M",@"verificationID":self.keyID,@"mobile":nametext.text,@"verCode":yanzhengtext.text,@"newPwd":[output lowercaseString]};
                NSDictionary * resultDict = @{@"params":[NSString stringWithFormat:@"%@",dict]};
                NSLog(@"改变字典＝%@",resultDict);
                [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,uptUserPwdByOtherWay] parameters:resultDict success:^(NSURLSessionDataTask *task, id responseObject) {
                    id jsonData =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    NSLog(@"找回密码设置新密码＝%@",jsonData);
                    [self.navigationController popToRootViewControllerAnimated:YES];
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    
                }];
            }
}
#pragma  mark -重新发送短信验证
- (void)reSendBtnClick
{
    NSDictionary  *dict  = @{@"mobile":nametext.text,@"verType":@2};
    NSDictionary * resultDict = @{@"params":[NSString stringWithFormat:@"%@",dict]};
    AppDelegate  *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.sessionManager  GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,usrSendMobileVerCodeURL] parameters:resultDict success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"发送手机短信验证码接口=%@",jsonData);//288
        NSNumber * result = jsonData[@"result"];
        self.keyID=result;
        //self.keyID = result;
        if ([result integerValue] > 0) {
            //提示 发送成功1秒钟后消失
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.5, 30)];
            label.text = @"发送成功";
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
            
            flag = YES;
            
        }
        else
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.5, 30)];
            label.text = @"重新发送";
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
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}


@end
