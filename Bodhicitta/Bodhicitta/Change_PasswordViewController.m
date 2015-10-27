//
//  Change_PasswordViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/9/17.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "Change_PasswordViewController.h"
#import "HeaderFile.h"
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
#import "UserLoginViewController.h"
@interface Change_PasswordViewController (){
    
    UINavigationBar * bar;
}
@property(nonatomic,strong)UILabel * huaienLabel;
@property(nonatomic,strong)UITextField * passworkText;
@property(nonatomic,strong)UITextField * repassworkText;
@property(nonatomic,strong)NSMutableDictionary *memDict;

@end

@implementation Change_PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    
    bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.1+5)];
    
    [bar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:bar];
    
    UIButton * bu=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [bu setBackgroundImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(changeClick) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:bu];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.37,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"修改密码";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [bar addSubview:title];
    [self createUI];
}
-(void)createUI{

    UILabel * huaien = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, bar.frame.origin.y+bar.frame.size.height+10, SCREEN_WIDTH*0.28, SCREEN_HEIGHT*0.05)];
    huaien.text=@"用户怀恩ID:";
    huaien.textColor=[UIColor blackColor];
    huaien.alpha=0.5;
    huaien.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:huaien];
    
    _huaienLabel = [[UILabel alloc]initWithFrame:CGRectMake(huaien.frame.origin.x+huaien.frame.size.width-5, huaien.frame.origin.y, SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.05)];
    NSNumber * num = [[NSUserDefaults standardUserDefaults]objectForKey:@"result"];
    _huaienLabel.text=[NSString stringWithFormat:@"%@",num];
    NSLog(@"-------%@",num);
    _huaienLabel.textColor=[UIColor blackColor];
    _huaienLabel.alpha=0.5;
    _huaienLabel.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:_huaienLabel];
    
    UILabel * passLabel = [[UILabel alloc]initWithFrame:CGRectMake(huaien.frame.origin.x, huaien.frame.origin.y+huaien.frame.size.height+10, SCREEN_WIDTH*0.25, SCREEN_HEIGHT*0.05)];
    passLabel.text=@"原密码:";
    passLabel.textColor=[UIColor blackColor];
    passLabel.alpha=0.5;
    passLabel.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:passLabel];
    
    _passworkText = [[UITextField alloc]initWithFrame:CGRectMake(passLabel.frame.origin.x+passLabel.frame.size.width-20, passLabel.frame.origin.y, SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.05)];
    _passworkText.placeholder=@"请输入原密码";
    _passworkText.textColor=[UIColor blackColor];
    _passworkText.alpha=0.5;
    _passworkText.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:_passworkText];
    
    UIButton *visibleBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_passworkText.frame)+40,_passworkText.frame.origin.y-5,CGRectGetMaxX(_passworkText.frame) - CGRectGetMaxX(_passworkText.frame)-10 -20,_passworkText.frame.size.height)];
    [visibleBtn setImage:[UIImage imageNamed:@"可视密码.png"] forState:UIControlStateNormal];
    [visibleBtn addTarget:self action:@selector(visibleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:visibleBtn];
    
    UILabel * repassLabel = [[UILabel alloc]initWithFrame:CGRectMake(huaien.frame.origin.x, passLabel.frame.origin.y+passLabel.frame.size.height+10, SCREEN_WIDTH*0.25, SCREEN_HEIGHT*0.05)];
    repassLabel.text=@"新密码:";
    repassLabel.textColor=[UIColor blackColor];
    repassLabel.alpha=0.5;
    repassLabel.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:repassLabel];
    
    _repassworkText = [[UITextField alloc]initWithFrame:CGRectMake(repassLabel.frame.origin.x+repassLabel.frame.size.width-20, repassLabel.frame.origin.y, SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.05)];
    _repassworkText.placeholder=@"请输入新密码";
    _repassworkText.textColor=[UIColor blackColor];
    _repassworkText.alpha=0.5;
    _repassworkText.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:_repassworkText];

    UIButton *visibleBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_repassworkText.frame)+40,_repassworkText.frame.origin.y-5,CGRectGetMaxX(_repassworkText.frame) - CGRectGetMaxX(_repassworkText.frame)-10 -20,_repassworkText.frame.size.height)];
    [visibleBtn1 setImage:[UIImage imageNamed:@"可视密码.png"] forState:UIControlStateNormal];
    [visibleBtn1 addTarget:self action:@selector(visibleBtnClick1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:visibleBtn1];
    
    
    UIButton * sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(25,CGRectGetMaxY(repassLabel.frame)+30,SCREEN_WIDTH - 2*25,40)];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont  boldSystemFontOfSize:18];
    [self.view addSubview:sureBtn];
}
#pragma mark ---按钮事件---
-(void)changeClick{

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)visibleBtnClick:(UIButton *) btn
{
    NSArray *imageTitleArray = @[@"不可视密码",@"可视密码"];
    NSString *imageName = imageTitleArray[self.passworkText.secureTextEntry];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    self.passworkText.secureTextEntry = !self.passworkText.secureTextEntry;
}
-(void)visibleBtnClick1:(UIButton *) btn
{
    NSArray *imageTitleArray = @[@"不可视密码",@"可视密码"];
    NSString *imageName = imageTitleArray[self.repassworkText.secureTextEntry];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    self.repassworkText.secureTextEntry = !self.repassworkText.secureTextEntry;
}

-(void)sureBtnClick{
    
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *newPwd =self.repassworkText.text;
    NSString *oldPwd =self.passworkText.text;
    const char *passWordChar = [oldPwd UTF8String];
    unsigned char passWordCharResult[CC_MD5_DIGEST_LENGTH];
    CC_MD5(passWordChar, strlen(passWordChar),passWordCharResult);
    NSMutableString  *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0 ; i < CC_MD5_DIGEST_LENGTH;i++)
    {
        [output appendFormat:@"%02x",passWordCharResult[i]];
    }
    self.memDict=[[NSMutableDictionary alloc]init];
    [self.memDict setObject:[output lowercaseString] forKey:@"oldPwd"];
    oldPwd=self.memDict[@"oldPwd"];
    if ([self.passworkText.text isEqualToString:@""]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.35, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.3, 30)];
        label.text = @"原密码不能为空！";
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
    }else if (![oldPwd isEqualToString:delegate.accountBasicDict[@"previousPwd"]]){
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.35, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.3, 30)];
        label.text = @"原密码错误！";
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
    else if ([_repassworkText.text isEqualToString:@""]){
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.35, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.3, 30)];
        label.text = @"新密码不能为空！";
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
    
    else  {
        //密码加密
        const char *passWordChar = [newPwd UTF8String];
        unsigned char passWordCharResult[CC_MD5_DIGEST_LENGTH];
        CC_MD5(passWordChar, strlen(passWordChar),passWordCharResult);
        NSMutableString  *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        for(int i = 0 ; i < CC_MD5_DIGEST_LENGTH;i++)
        {
            [output appendFormat:@"%02x",passWordCharResult[i]];
        }
        self.memDict=[[NSMutableDictionary alloc]init];
        [self.memDict setObject:[output lowercaseString] forKey:@"newPwd"];
        NSDictionary * dic =@{@"huaienID":[[NSUserDefaults standardUserDefaults]objectForKey:@"result"],@"oldPwd":[delegate.accountBasicDict objectForKey:@"previousPwd"],@"newPwd":[output lowercaseString]};
        NSDictionary * passDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
        [delegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,usrUptUserPwd] parameters:passDic success:^(NSURLSessionDataTask *task, id responseObject) {
            id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSNumber *result=jsonData[@"result"];
            if([result integerValue]==0){
                [self.memDict setObject:[output lowercaseString] forKey:@"previousPwd"];
                UserLoginViewController * user = [[UserLoginViewController alloc]init];
                [self.navigationController pushViewController:user animated:YES];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
