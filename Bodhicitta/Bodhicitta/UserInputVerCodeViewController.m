//
//  UserInputVerCodeViewController.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/9.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "UserInputVerCodeViewController.h"
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
#import "VerModel.h"
#import "UserInfoprefectViewController.h"
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@interface UserInputVerCodeViewController()
{
    NSInteger second;
    //用来控制等待状态还是重新发送状态
    BOOL flag;
}
@property(nonatomic,strong)UITextField   * telePhoneFiled;
@property(nonatomic,strong)UITextField   * passWordFiled;
@property(nonatomic,strong)UIButton      * hintButton;
@property(nonatomic,strong)NSTimer *timer;
@end
@implementation UserInputVerCodeViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    second = 60;
    flag = YES;
     //提示 一秒钟后消失  发送成功 注意查收
    [self createUI];
     self.navigationController.navigationBarHidden = YES;
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"登录背景"]];
}
-(void)createUI
{
    UIButton  * resignBtn = [[UIButton alloc]initWithFrame:CGRectMake(25,45,40,30)];
    [resignBtn setTitle:@"取消" forState:UIControlStateNormal];
    resignBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    resignBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [resignBtn setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"顶部导航背景.png"]]forState:
     UIControlStateNormal];
    [resignBtn addTarget:self action:@selector(resignBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resignBtn];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.22, SCREEN_HEIGHT*0.1, 0.8*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"短信验证码已发送，请填";
    title.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:title];
    UILabel * la=[[UILabel alloc]initWithFrame:CGRectMake(title.frame.origin.x+70, title.frame.origin.y+40, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.075)];
    la.text=@"写验证码";
    la.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:la];
    
    UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25,0.25 * SCREEN_HEIGHT,30,25)];
    userImageView.image = [UIImage imageNamed:@"user.png"];
    [self.view addSubview:userImageView];
    
    self.telePhoneFiled = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userImageView.frame)+45,userImageView.frame.origin.y,SCREEN_WIDTH - CGRectGetMaxX(userImageView.frame) - 25 * 2 - 20,30)];
    self.telePhoneFiled.placeholder = self.telePhoneStr;
    self.telePhoneFiled.font = [UIFont systemFontOfSize:17];
    [self.telePhoneFiled setBackgroundColor:[UIColor clearColor]];
    self.telePhoneFiled.enabled = NO;
    self.telePhoneFiled.keyboardType =  UIKeyboardTypeNumberPad;
    [self.view addSubview:self.telePhoneFiled];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(20 ,CGRectGetMaxY(self.telePhoneFiled.frame)+5,SCREEN_WIDTH - 2 * 20,0.5)];
    lineView1.backgroundColor = [UIColor darkGrayColor];
    lineView1.alpha = 0.2;
    [self.view addSubview:lineView1];
    
    UILabel  *passwdImageView = [[UILabel alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(lineView1.frame)+20,60,25)];
    passwdImageView.text=@"验证码";
    [self.view addSubview:passwdImageView];
    
    self.passWordFiled = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(passwdImageView.frame)+20,passwdImageView.frame.origin.y,SCREEN_WIDTH - CGRectGetMaxX(passwdImageView.frame) - 25 * 2 - 20-20,25)];
    self.passWordFiled.placeholder = @"请输入验证码";
    self.passWordFiled.font = [UIFont systemFontOfSize:17];
    self.passWordFiled.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.passWordFiled];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(20 ,CGRectGetMaxY(self.passWordFiled.frame)+5,SCREEN_WIDTH - 2 * 20,0.5)];
    lineView2.backgroundColor = [UIColor darkGrayColor];
    lineView2.alpha = 0.2;
    [self.view addSubview:lineView2];
    
    
    UIButton * registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(25,CGRectGetMaxY(lineView2.frame)+30,SCREEN_WIDTH - 2*25,40)];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"输入字符时注册按钮"] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setTitle:@"提交" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont  boldSystemFontOfSize:18];
    [self.view addSubview:registerBtn];
    
    self.hintButton = [[UIButton alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(registerBtn.frame)+ 15,SCREEN_WIDTH,20)];
    [self.hintButton setTitle:[NSString stringWithFormat:@"接收短信大约需要%ld秒",second] forState:UIControlStateNormal];
    self.hintButton.enabled = NO;
    [self.hintButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.hintButton addTarget:self action:@selector(hintButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.hintButton];
    [self createTimer];
}
#pragma mark -----重新发送
-(void)hintButtonClick
{
    if (flag) return;
    NSDictionary  *dict  = @{@"mobile":self.telePhoneFiled.text,@"verType":@1};
    NSDictionary * resultDict = @{@"params":[NSString stringWithFormat:@"%@",dict]};
    AppDelegate  *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.sessionManager  GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,usrSendMobileVerCodeURL] parameters:resultDict success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"发送手机短信验证码接口=%@",jsonData);
        NSNumber * result = jsonData[@"result"];
        self.keyID = result;
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
            label.text = @"发送失败，请重新发送";
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
#pragma mark -----创建定时器
-(void)createTimer
{
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeHintBtnFunction) userInfo:nil repeats:YES];
}
-(void)changeHintBtnFunction
{
    if (!flag)
    {
        second = 60;
        //flag = YES;
        self.hintButton.enabled = YES;
        [self.hintButton setTitle:@"收不到短信验证码,重新发送" forState:UIControlStateNormal];
    }
    else
    {
            second--;
            [self.hintButton setTitle:[NSString stringWithFormat:@"接收短信大约需要%ld秒",second] forState:UIControlStateNormal];
            if (second == 0) {
                flag = NO;
            }
    }
}
-(void)resignBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)registerBtnClick
{
    if ([self.passWordFiled.text isEqualToString:@""]) {
        //提示  请输入验证码 一秒钟后消失
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.5, 30)];
        label.text = @"请输入验证码";
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
    UIDevice  *device = [[UIDevice alloc] init];
    NSMutableDictionary  *userInfoDict = [[NSMutableDictionary alloc] init];
    [userInfoDict setObject:@1 forKey:@"regMode"];
    [userInfoDict setObject:@1 forKey:@"userType"];
    [userInfoDict setObject:self.telePhoneStr forKey:@"loginName"];
    //密码加密
    const char *passWordChar = [self.passWordStr UTF8String];
    unsigned char passWordCharResult[CC_MD5_DIGEST_LENGTH];
    CC_MD5(passWordChar, strlen(passWordChar),passWordCharResult);
    NSMutableString  *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0 ; i < CC_MD5_DIGEST_LENGTH;i++)
    {
        [output appendFormat:@"%02x",passWordCharResult[i]];
    }

    [userInfoDict setObject:[output lowercaseString] forKey:@"loginPwd"];
    [userInfoDict setObject:self.keyID forKey:@"verificationID"];
    NSLog(@"dyiu=%@",self.keyID);
    NSLog(@"dict=%@",userInfoDict);
    [userInfoDict setObject:self.passWordFiled.text forKey:@"verCode"];
    [userInfoDict setObject:@15 forKey:@"appID"];
    [userInfoDict setObject:[self getIPAddress:YES] forKey:@"loginIP"];
    [userInfoDict setObject:@1 forKey:@"loginWay"];
    [userInfoDict setObject:device.systemVersion forKey:@"mobileOSDesc"];
    [userInfoDict setObject:device.systemName  forKey:@"OSType"];
    //获取到手机唯一标识号
    [userInfoDict setObject:[[UIDevice currentDevice].identifierForVendor UUIDString] forKey:@"IMEI"];
    [userInfoDict setObject:@"1.0.2" forKey:@"version"];
    
     NSDictionary * resultDict = @{@"params":[NSString stringWithFormat:@"%@",userInfoDict]};
    NSLog(@"--------=%@",resultDict);
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,usrAddUserURL] parameters:resultDict success:^(NSURLSessionDataTask *task, id responseObject) {
         id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"-----jsonData=%@",jsonData);
         NSNumber  *result = jsonData[@"result"];
        if ([result integerValue] > 0)
        {
            UserInfoprefectViewController * per = [[UserInfoprefectViewController alloc]init];
            [self.navigationController pushViewController:per animated:YES];
        }
        else
        {
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}
@end
