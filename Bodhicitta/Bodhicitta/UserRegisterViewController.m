//
//  UserRegisterViewController.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/9.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "UserRegisterViewController.h"
#import "UserInputVerCodeViewController.h"
#import "HeaderFile.h"
@interface UserRegisterViewController()<UITextFieldDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITextField   * telePhoneFiled;
@property(nonatomic,strong)UITextField   * passWordFiled;
//用于验证
@property(nonatomic,strong)NSMutableDictionary *dict;
@end
@implementation UserRegisterViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
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
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0.1 * SCREEN_HEIGHT,SCREEN_WIDTH, 25)];
    titleLabel.text = @"用户注册";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25,0.25 * SCREEN_HEIGHT,30,25)];
    userImageView.image = [UIImage imageNamed:@"user.png"];
    [self.view addSubview:userImageView];
    
    self.telePhoneFiled = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userImageView.frame)+20,userImageView.frame.origin.y,SCREEN_WIDTH - CGRectGetMaxX(userImageView.frame) - 25 * 2 - 20,30)];
    self.telePhoneFiled.placeholder = @"请输入手机号";
    self.telePhoneFiled.font = [UIFont systemFontOfSize:17];
    [self.telePhoneFiled setBackgroundColor:[UIColor clearColor]];
    self.telePhoneFiled.delegate = self;
    self.telePhoneFiled.keyboardType =  UIKeyboardTypeNumberPad;
    [self.view addSubview:self.telePhoneFiled];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(20 ,CGRectGetMaxY(self.telePhoneFiled.frame)+5,SCREEN_WIDTH - 2 * 20,0.5)];
    lineView1.backgroundColor = [UIColor darkGrayColor];
    lineView1.alpha = 0.2;
    [self.view addSubview:lineView1];
    
    UIImageView  *passwdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(lineView1.frame)+20,30,25)];
    passwdImageView.image = [UIImage imageNamed:@"pass.png"];
    [self.view addSubview:passwdImageView];
    
    self.passWordFiled = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(passwdImageView.frame)+20,passwdImageView.frame.origin.y,SCREEN_WIDTH - CGRectGetMaxX(passwdImageView.frame) - 25 * 2 - 20-20,25)];
    self.passWordFiled.placeholder = @"请输入密码";
    self.passWordFiled.font = [UIFont systemFontOfSize:17];
    self.passWordFiled.secureTextEntry = YES;
    self.passWordFiled.delegate = self;
    [self.view addSubview:self.passWordFiled];
    
    UIView *seperatorLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.passWordFiled.frame),self.passWordFiled.frame.origin.y - 2,0.3,self.passWordFiled.frame.size.height - 2 * 2)];
    seperatorLine.backgroundColor = [UIColor darkGrayColor];
    seperatorLine.alpha = 0.2;
    [self.view addSubview:seperatorLine];
    
    UIButton *visibleBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(seperatorLine.frame)+10,seperatorLine.frame.origin.y-5,CGRectGetMaxX(lineView1.frame) - CGRectGetMaxX(seperatorLine.frame)-10 - 10,seperatorLine.frame.size.height+10)];
    [visibleBtn setImage:[UIImage imageNamed:@"不可视密码.png"] forState:UIControlStateNormal];
    [visibleBtn addTarget:self action:@selector(visibleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:visibleBtn];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(20 ,CGRectGetMaxY(self.passWordFiled.frame)+5,SCREEN_WIDTH - 2 * 20-10,0.5)];
    lineView2.backgroundColor = [UIColor darkGrayColor];
    lineView2.alpha = 0.2;
    [self.view addSubview:lineView2];
    
    
    UIButton * registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(25,CGRectGetMaxY(lineView2.frame)+30,SCREEN_WIDTH - 2*25,40)];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"输入字符时注册按钮"] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont  boldSystemFontOfSize:18];
    [self.view addSubview:registerBtn];
    
    UILabel * zhushi=[[UILabel alloc]initWithFrame:CGRectMake(registerBtn.frame.origin.x+50, registerBtn.frame.origin.y+registerBtn.frame.size.height+SCREEN_HEIGHT*0.4, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.075)];
    zhushi.text=@"轻触上面的“注册”按钮，即表示您同意";
    zhushi.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:zhushi];
    
    UILabel * greme=[[UILabel alloc]initWithFrame:CGRectMake(zhushi.frame.origin.x+60, zhushi.frame.origin.y+zhushi.frame.size.height-25, SCREEN_WIDTH * 0.6, SCREEN_HEIGHT*0.075)];
    greme.text=@"《怀恩网注册条款》";
    greme.textColor=[UIColor colorWithRed:0.123 green:0.435 blue:0.52 alpha:1.0];
    greme.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:greme];

    
}
#pragma mark ------返回
-(void)resignBtnClick
{
      [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ------注册
-(void)registerBtnClick
{
    
   [self.view endEditing:YES];
    NSString *telePhoneStr =  self.telePhoneFiled.text;
    NSString *passWordStr  =  self.passWordFiled.text;
   
    [[NSUserDefaults standardUserDefaults]setObject:passWordStr forKey:@"oldPassword"];
     [[NSUserDefaults standardUserDefaults]setObject:telePhoneStr forKey:@"telePhone"];
    NSLog(@"jio=%@",passWordStr);
  

    if ([telePhoneStr isEqualToString:@""]) {
        //要改  一秒钟消失
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.5, 30)];
        label.text = @"手机号不能为空";
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
        if (telePhoneStr.length != 11) {
            //要改  一秒钟消失
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.5, 30)];
            label.text = @"手机号码不正确";
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
        if ([passWordStr isEqualToString:@""]) {
            //要改 一秒钟消失
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.5, 30)];
            label.text = @"密码不能为空";
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
            self.dict = [[NSMutableDictionary alloc] init];
            [self.dict setObject:telePhoneStr forKey:@"mobile"];
            [self verifyTelephoneNumberWithDict:self.dict];
        }
    }
}
#pragma mark -----验证手机是否被注册过
-(void)verifyTelephoneNumberWithDict:(NSDictionary *) dict
{
    NSDictionary  * resultDict = @{@"params":[NSString stringWithFormat:@"%@",dict]};
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",__kBaseURLString,registeredTelePhoneURL]);
    [delegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,registeredTelePhoneURL]  parameters:resultDict success:^(NSURLSessionDataTask *task, id responseObject)
     {
         id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"%@",jsonData);
         NSNumber * result = jsonData[@"result"];
         if ([result integerValue] == 0)
         {
             //申请发送验证码
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认手机号码" message:[NSString stringWithFormat:@"我们将发送验证码短信到这个手机号码:\n+86 %@",self.telePhoneFiled.text]delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"好", nil];
             alertView.delegate = self;
             [alertView  show];
         }
         else
         {
             //提示号码被占用
             //要改  一秒钟消失
             UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.5, 30)];
             label.text = @"该号码已经注册过了";
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
     }failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}
#pragma mark ------UIAlertView的代理方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
       
    }
    else
    {
        [self postRequestVerCode];
    }
}
#pragma mark -----申请发送验证码
-(void)postRequestVerCode
{
    NSDictionary  *dict  = @{@"mobile":self.telePhoneFiled.text,@"verType":@1};
    NSDictionary * resultDict = @{@"params":[NSString stringWithFormat:@"%@",dict]};
    AppDelegate  *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.sessionManager  GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,usrSendMobileVerCodeURL] parameters:resultDict success:^(NSURLSessionDataTask *task, id responseObject) {
     id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber * result = jsonData[@"result"];
        if ([result integerValue] > 0) {
            
            UserInputVerCodeViewController * inputViewController = [[UserInputVerCodeViewController alloc] init];
            inputViewController.telePhoneStr = self.telePhoneFiled.text;
            inputViewController.passWordStr  = self.passWordFiled.text;
            inputViewController.keyID = result;
            [self.navigationController pushViewController:inputViewController animated:YES];
            
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发送失败" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alertView  show];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark -----设置密码是否可视
-(void)visibleBtnClick:(UIButton *) btn
{
    NSArray *imageTitleArray = @[@"不可视密码",@"可视密码"];
    NSString *imageName = imageTitleArray[self.passWordFiled.secureTextEntry];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    self.passWordFiled.secureTextEntry = !self.passWordFiled.secureTextEntry;
}
#pragma mark ----触摸事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
