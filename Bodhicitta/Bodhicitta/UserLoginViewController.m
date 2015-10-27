//
//  UserLoginViewController.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/8.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "UserLoginViewController.h"
#import "AppDelegate.h"
#import "HeaderFile.h"
#import <CommonCrypto/CommonDigest.h>
#import "AFURLRequestSerialization.h"
#import "LeftViewController.h"
#import "ZhuYeMianViewController.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#import "HeaderFile.h"
#import "QHMainGestureRecognizerViewController.h"
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"
#import "UserRegisterViewController.h"
#import "FindViewController.h"
#import "PhoneViewController.h"
@interface UserLoginViewController()<UITextFieldDelegate,RESideMenuDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)NSMutableDictionary  *memberDict;
@property(nonatomic,strong)NSMutableDictionary  *userDict;
@property(nonatomic,strong)UITextField  *accountField;
@property(nonatomic,strong)UITextField  *passWordField;
@property(nonatomic,strong)NSMutableDictionary  *accountBasicDict;
@end
@implementation UserLoginViewController
#pragma mark ---主页面----
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    [self getIntegralLevelInfo];
}
-(void)createUI
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0.1 * SCREEN_HEIGHT,SCREEN_WIDTH, 25)];
    titleLabel.text = @"用户登录";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25,0.25 * SCREEN_HEIGHT,30,25)];
    userImageView.image = [UIImage imageNamed:@"user.png"];
    [self.view addSubview:userImageView];
    
    self.accountField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userImageView.frame)+20,userImageView.frame.origin.y,SCREEN_WIDTH - CGRectGetMaxX(userImageView.frame) - 25 * 2 - 20,30)];
    //    self.accountField.placeholder = @"请输入手机号/用户ID/邮箱";
    self.accountField.text=@"10019";
    self.accountField.textColor=[UIColor blackColor];
    self.accountField.alpha=0.5;
    self.accountField.font = [UIFont systemFontOfSize:17];
    [self.accountField setBackgroundColor:[UIColor clearColor]];
    self.accountField.delegate = self;
    [self.view addSubview:self.accountField];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(20 ,CGRectGetMaxY(self.accountField.frame)+5,SCREEN_WIDTH - 2 * 20,0.5)];
    lineView1.backgroundColor = [UIColor darkGrayColor];
    lineView1.alpha = 0.2;
    [self.view addSubview:lineView1];
    
    UIImageView  *passwdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(lineView1.frame)+20,30,25)];
    passwdImageView.image = [UIImage imageNamed:@"pass.png"];
    [self.view addSubview:passwdImageView];
    
    self.passWordField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(passwdImageView.frame)+20,passwdImageView.frame.origin.y,SCREEN_WIDTH - CGRectGetMaxX(passwdImageView.frame) - 25 * 2 - 20,25)];
    //  self.passWordField.placeholder = @"请输入密码";
    self.passWordField.text=@"123456";
    self.passWordField.font = [UIFont systemFontOfSize:17];
    self.passWordField.secureTextEntry = YES;
    self.passWordField.delegate = self;
    [self.view addSubview:self.passWordField];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(20 ,CGRectGetMaxY(self.passWordField.frame)+5,SCREEN_WIDTH - 2 * 20,0.5)];
    lineView2.backgroundColor = [UIColor darkGrayColor];
    lineView2.alpha = 0.2;
    [self.view addSubview:lineView2];
    
    
    UIButton * loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(25,CGRectGetMaxY(lineView2.frame)+30,SCREEN_WIDTH - 2*25,40)];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont  boldSystemFontOfSize:18];
    [self.view addSubview:loginBtn];
    
    UIButton * registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(loginBtn.frame)+ 20,SCREEN_WIDTH,30)];
    [registerBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.font  = [UIFont boldSystemFontOfSize:16];
    [registerBtn setTitleColor:[UIColor colorWithRed:0.123 green:0.435 blue:0.52 alpha:1.0] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    CGFloat height ;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
            height =  270;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
        
            height = 225;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            height = 295;
        }
        else
        {
            height  = 190;
        }
    }

    
    UIButton * problemBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.5-registerBtn.frame.origin.x, height*2.3, SCREEN_WIDTH*0.5, 20)];
    [problemBtn setTitleColor:[UIColor colorWithRed:0.123 green:0.435 blue:0.52 alpha:1.0] forState:UIControlStateNormal];
    [problemBtn setTitle:@"登陆遇到问题" forState:UIControlStateNormal];
    [problemBtn addTarget:self action:@selector(problemClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:problemBtn];
}
#pragma mark ---按钮事件----
-(void)registerBtnClick
{
    [self.view endEditing:YES];
    UserRegisterViewController  *registerVc = [[UserRegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVc animated:YES];
}
-(void)loginBtnClick
{
    [self.view endEditing:YES];
    NSString *loginName = self.accountField.text;
    NSString *passWord  = self.passWordField.text;
    if ([loginName isEqualToString:@""]) {
        //提示1秒钟消失的
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.3, 30)];
        label.text = @"登录名不能为空！";
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
        return;
    }
    else
    {
        self.memberDict = [[NSMutableDictionary alloc] init];
        [self.memberDict setObject:loginName forKey:@"loginName"];
        if ([passWord isEqualToString:@""]) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.3, 30)];
            label.text = @"密码不能为空！";
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
            return;
        }
        else
        {
            //密码加密
            const char *passWordChar = [passWord UTF8String];
            unsigned char passWordCharResult[CC_MD5_DIGEST_LENGTH];
            CC_MD5(passWordChar, strlen(passWordChar),passWordCharResult);
            NSMutableString  *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
            for(int i = 0 ; i < CC_MD5_DIGEST_LENGTH;i++)
            {
                [output appendFormat:@"%02x",passWordCharResult[i]];
            }
            self.userDict = [[NSMutableDictionary  alloc] init];
            self.accountBasicDict = [[NSMutableDictionary alloc]init];
            [self.accountBasicDict setObject:[output lowercaseString] forKey:@"previousPwd"];
            [self.memberDict setObject:[output lowercaseString] forKey:@"loginPwd"];
            if(loginName.length == 11){
                [self.memberDict  setObject:@2 forKey:@"loginNameType" ];
            }
            else
            {
                if ([loginName containsString:@"@"]) {
                    [self.memberDict setObject:@3 forKey:@"loginNameType" ];
                }
                else
                {
                    [self.memberDict setObject:@1 forKey:@"loginNameType" ];
                }
            }
            [self.memberDict setObject:@15 forKey:@"appID"];
            [self.memberDict setObject:[self getIPAddress:YES] forKey:@"loginIP"];
            [self.memberDict setObject:@1 forKey:@"loginWay"];
            UIDevice  *device = [[UIDevice alloc] init];
            [self.memberDict setObject:[NSString stringWithFormat:@"iOS%@",device.systemVersion] forKey:@"OSName"];
            [self postRequest:self.memberDict];
        }
    }
}
-(void)problemClick{

//    PhoneViewController *pvc=[[PhoneViewController alloc]init];
//    [self.navigationController pushViewController:pvc animated:YES];
    UIActionSheet * actionsheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"找回密码", nil];
    [actionsheet showInView:self.view];
}
#pragma mark ---actionsheet代理----
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        FindViewController * find = [[FindViewController alloc]init];
        [self.navigationController pushViewController:find animated:YES];
    }else if (buttonIndex == 1){
    
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark -------触摸
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark -------发送验证请求
//返回怀恩ID，取出来
-(void)postRequest:(NSDictionary *) dict
{
    [ProgressHUD showOnView:self.view];
    NSDictionary * resultDict = @{@"params":[NSString stringWithFormat:@"%@",dict]};
    AppDelegate  *delegate  = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,memberloginURL]  parameters:resultDict success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"shuju=%@",jsonData);
        NSNumber *huaienID =jsonData[@"result"];
        [[NSUserDefaults standardUserDefaults]setObject:huaienID forKey:@"result"];
        NSString *desc = [NSString stringWithFormat:@"%@",jsonData[@"desc"]];
        if (![desc isEqualToString:@"(null)"]) {
            //给出提示信息 1秒钟后消失
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.3, 30)];
            label.text = @"帐号或密码错了";
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
        else
        {
            
            [self.userDict  setObject:jsonData[@"result"] forKey:@"HuaienID"];
            [self.userDict  setObject:@"" forKey:@"nickName"];
            [self.userDict  setObject:jsonData[@"sex"] forKey:@"sex"];
            [self.userDict  setObject:@"" forKey:@"signature"];
            [self.userDict  setObject:jsonData[@"birthdayType"] forKey:@"birthdayType"];
            [self.userDict  setObject:jsonData[@"birthday"] forKey:@"birthday"];
            [self.userDict  setObject:jsonData[@"constellation"] forKey:@"constellation"];
            [self.userDict  setObject:jsonData[@"animalSign"] forKey:@"animalSign"];
            [self.userDict  setObject:jsonData[@"nowCity"] forKey:@"nowCity"];
            [self.userDict  setObject:jsonData[@"nowAddr"] forKey:@"nowAddr"];
            [self postLoginRequest:self.userDict];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark  -----发送登录请求
-(void)postLoginRequest:(NSDictionary *) dict
{
    NSDictionary  * resultDict = @{@"params":[NSString stringWithFormat:@"%@",dict]};
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,putixinloginURL]  parameters:resultDict success:^(NSURLSessionDataTask *task, id responseObject)
     {
         id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"用户信息=%@",jsonData);
         NSNumber  *result = jsonData[@"result"];
         if ([result integerValue] < 0) {
             //提示登录失败  1秒钟后消失
             UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.3, 30)];
             label.text = @"登录失败";
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
             
             [ProgressHUD hideAfterFailOnView:self.view];
         }
         else
         {
             UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.3, 30)];
             label.text = @"登录成功";
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
             
             
             [self.accountBasicDict setObject:jsonData[@"isVIP"] forKey:@"isVIP"];
             [self.accountBasicDict setObject:jsonData[@"levelAndDesignation"] forKey:@"levelAndDesignation"];
             [self.accountBasicDict setObject:jsonData[@"prayMoney"] forKey:@"prayMoney"];
             [self.accountBasicDict setObject:jsonData[@"secretKey"] forKey:@"secretKey"];
             [self.accountBasicDict setObject:jsonData[@"totalIntegral"] forKey:@"totalIntegral"];
             [self.accountBasicDict setObject:jsonData[@"userLoginID"] forKey:@"userLoginID"];
             [self.accountBasicDict setObject:self.userDict[@"HuaienID"] forKey:@"huaienID"];
             
             [ProgressHUD hideAfterSuccessOnView:self.view];
             AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
             [self needHintEarlyOrLateHomework];
             appDelegate.accountBasicDict = self.accountBasicDict;
             ZhuYeMianViewController * zhuye=[[ZhuYeMianViewController alloc]init];
             [self.navigationController pushViewController:zhuye animated:YES];
             UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:zhuye];
             appDelegate.mainVc = nav;
             zhuye.navigationController.navigationBarHidden = YES;
             LeftViewController *leftMenuViewController = [[LeftViewController alloc] init];
             [leftMenuViewController getInfo];
             RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:nav
                                                                             leftMenuViewController:leftMenuViewController
                                                                            rightMenuViewController:nil];
             sideMenuViewController.menuPreferredStatusBarStyle = 1
             ;
             sideMenuViewController.delegate = self;
             sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
             sideMenuViewController.contentViewShadowOpacity = 0.6;
             sideMenuViewController.contentViewShadowRadius = 12;
             sideMenuViewController.contentViewShadowEnabled = YES;
             self.view.window.rootViewController = sideMenuViewController;
         }
     }failure:^(NSURLSessionDataTask *task, NSError *error) {
         [ProgressHUD hideAfterFailOnView:self.view];
     }];
}
#pragma mark ----确定IP是4位 还是6位的
- (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}
#pragma mark -----IP地址------
- (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}
#pragma mark ---获取积分、等级、称号对照表信息
-(void)getIntegralLevelInfo{
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,GetIntegralLevel]  parameters:nil success:^(NSURLSessionDataTask *task, id responseObject){
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [self.accountBasicDict setObject:jsonData[@"beginIntegral"] forKey:@"beginIntegral"];
        [self.accountBasicDict setObject:jsonData[@"endIntegral"] forKey:@"endIntegral"];
        [self.accountBasicDict setObject:jsonData[@"userLevel"] forKey:@"userLevel"];
//        NSNumber * sum =jsonData[@"userLevel"] ;
//        if (sum == sum+1) {
//            <#statements#>
//        }
        [self.accountBasicDict setObject:jsonData[@"userLevelDesc"] forKey:@"userLevelDesc"];
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        [ProgressHUD hideAfterFailOnView:self.view];
    }];
}
#pragma mark ---- 当程序启动时  就要看它是否需要提醒功课
-(void)needHintEarlyOrLateHomework
{
    NSLog(@"guliqingguliqing");
    
    AppDelegate  * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString  * huaienId = [delegate.accountBasicDict  objectForKey:@"huaienId"];
    NSString  * hintKey1 = [NSString stringWithFormat:@"%@%@",earlyHomeWorkHint,huaienId];
    NSNumber  * earlyNumber = [[NSUserDefaults standardUserDefaults] objectForKey:hintKey1];
    NSString  * hintKey2  = [NSString stringWithFormat:@"%@%@",lateHomeWorkHint,huaienId];
    NSNumber  * lateNumber = [[NSUserDefaults standardUserDefaults] objectForKey:hintKey2];
    NSInteger earlyHomeWorkInteger = [earlyNumber integerValue] ;
    NSInteger lateHomeWorkInteger = [lateNumber integerValue];
    NSLog(@"hahaha%ld-----%ld",earlyHomeWorkInteger,lateHomeWorkInteger);
    //默认是0
    //如果有一个是打开
    if (earlyHomeWorkInteger||lateHomeWorkInteger ) {
        
        [delegate.timer setFireDate:[NSDate distantPast
                                     ]];
    }
}
@end
