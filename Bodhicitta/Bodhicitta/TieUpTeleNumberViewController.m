

//
//  TieUpTeleNumberViewController.m
//  Bodhicitta
//
//  Created by 怀恩03 on 20/9/14.
//  Copyright (c) 2020年 怀恩2. All rights reserved.
//

#import "TieUpTeleNumberViewController.h"
#import "HeaderFile.h"
@interface TieUpTeleNumberViewController()
{
    NSInteger  second ;
}
@property(nonatomic,strong)UITextField  * telePhoneField;
@property(nonatomic,strong)UITextField  * codeField;
@property(nonatomic,strong)UIButton  *repeatPostBtn;
@property(nonatomic,strong)NSTimer  *timer;
@property(nonatomic,strong)NSDictionary *userInfoDictionary;
@end
@implementation TieUpTeleNumberViewController
-(NSTimer *)timer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeRepeatBtnFunction) userInfo:nil repeats:YES];
    }
    return _timer;
}
-(void)viewDidLoad
{
    second = 60;
    [super viewDidLoad];
    [self createNavBar];
    [self createUI];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"登录背景"]];
}
-(void)createNavBar
{
    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NAVBARHEIGHT)];
    [navBar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景"] forBarMetrics:UIBarMetricsDefault];
    UINavigationItem *titleItem = [[UINavigationItem alloc]initWithTitle:@"绑定手机"];
    NSDictionary *navTitleArr = [NSDictionary dictionaryWithObjectsAndKeys:
                                 
                                 [UIFont boldSystemFontOfSize:20],UITextAttributeFont,
                                 [UIColor whiteColor],UITextAttributeTextColor ,nil];
    [navBar setTitleTextAttributes:navTitleArr];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(20, 20,30, 25)];
    [leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [titleItem setLeftBarButtonItem:leftItem];
    [navBar pushNavigationItem:titleItem animated:NO];
    [self.view addSubview:navBar];
}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createUI
{
    CGFloat  marginX  = 20;
    UILabel * teleNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(marginX, NAVBARHEIGHT + 50,80,30)];
    teleNumberLabel.text = @"手机号";
    teleNumberLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:teleNumberLabel];
    
    self.telePhoneField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(teleNumberLabel.frame) + 25, teleNumberLabel.frame.origin.y,SCREEN_WIDTH - (CGRectGetMaxX(teleNumberLabel.frame) + 25 + marginX + 60), 30)];
    self.telePhoneField.placeholder = @"请输入手机号";
    self.telePhoneField.keyboardType =  UIKeyboardTypeNumberPad;
    self.telePhoneField.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.telePhoneField];
    
    UIView  * seperatorLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.telePhoneField.frame)+1,self.telePhoneField.frame.origin.y + 4,1 ,self.telePhoneField.frame.size.height - 8)];
    seperatorLine.backgroundColor = [UIColor lightGrayColor];
    seperatorLine.alpha = 0.5;
    [self.view addSubview:seperatorLine];
    
    UIButton *postBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(seperatorLine.frame)+1,self.telePhoneField.frame.origin.y,60,30)];
    [postBtn setTitle:@"发送" forState:UIControlStateNormal];
    [postBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [postBtn addTarget:self action:@selector(postBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postBtn];
    
    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(marginX,CGRectGetMaxY(teleNumberLabel.frame)+10,SCREEN_WIDTH - 2 * marginX,1)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    lineView1.alpha = 0.5;
    [self.view addSubview:lineView1];
    
    UILabel  * codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(marginX,lineView1.frame.origin.y + 10, teleNumberLabel.frame.size.width,teleNumberLabel.frame.size.height)];
    codeLabel.font = [UIFont systemFontOfSize:20];
    codeLabel.text = @"验证码";
    [self.view addSubview:codeLabel];

    self.codeField = [[UITextField alloc]initWithFrame:CGRectMake(self.telePhoneField.frame.origin.x,codeLabel.frame.origin.y,self.telePhoneField.frame.size.width,self.telePhoneField.frame.size.height)];
    self.codeField.placeholder = @"请输入验证码";
    self.codeField.font = [UIFont systemFontOfSize:20];
    self.codeField.keyboardType =  UIKeyboardTypeNumberPad;
    [self.view addSubview:self.codeField];
    
    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake(marginX,CGRectGetMaxY(self.codeField.frame)+10,SCREEN_WIDTH - 2*marginX,1)];
    lineView2.alpha = 0.5;
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView2];
    
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(marginX, lineView2.frame.origin.y + 50, SCREEN_WIDTH - 2 * marginX,20)];
    hintLabel.text = @"重新绑定后, 之前绑定的手机号不能作为登录凭证";
    hintLabel.textAlignment = NSTextAlignmentCenter;
    hintLabel.font = [UIFont systemFontOfSize:14];
    hintLabel.textColor = [UIColor colorWithRed:0.123 green:0.435 blue:0.52 alpha:1.0];
    [self.view addSubview:hintLabel];
    
    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(marginX,hintLabel.frame.origin.y+20+20,SCREEN_WIDTH - 2 * marginX,40)];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forState:UIControlStateNormal];
    [submitBtn setTitle:@"绑定" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
 
    self.repeatPostBtn = [[UIButton alloc] initWithFrame:CGRectMake(marginX,CGRectGetMaxY(submitBtn.frame)+20,SCREEN_WIDTH - 2*marginX, 20)];
    [self.repeatPostBtn setTitle:@"收不到短信验证码，点击重新发送" forState:UIControlStateNormal];
    self.repeatPostBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.repeatPostBtn.userInteractionEnabled  = NO;
    [self.repeatPostBtn setTitleColor: [UIColor colorWithRed:0.123 green:0.435 blue:0.52 alpha:1.0] forState:UIControlStateNormal];
    [self.repeatPostBtn addTarget:self action:@selector(repeatPostBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.repeatPostBtn];
}
-(void)repeatPostBtnClick
{
    [self postBtnClick];
}
-(void)postBtnClick
{
    if ([self.telePhoneField.text isEqualToString:@""]){
        //提示 手机号码不能为空  1秒钟后消失
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.3, 30)];
    label.text = @"手机号码不能为空！";
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
        return;
    if (self.telePhoneField.text.length != 11)
        return;
    NSDictionary  *dict  = @{@"mobile":self.telePhoneField.text,@"verType":@1};
    NSDictionary  *resultDict = @{@"params":[NSString stringWithFormat:@"%@",dict]};
    AppDelegate  *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,usrSendMobileVerCodeURL] parameters:resultDict success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber   *result  = jsonData[@"result"];
        if ([result integerValue] > 0) {
            second = 60;
            [self.timer setFireDate:[NSDate distantPast]];
            self.repeatPostBtn.userInteractionEnabled  = NO;
        }
        else
        {
            //提示  发送失败 1秒钟后消失
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.3, 30)];
            label.text = @"发送失败！";
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark ---提示信息
-(void)changeRepeatBtnFunction
{
    [self.repeatPostBtn setTitle:[NSString stringWithFormat:@"接收短信大约需要%ld",second--] forState:UIControlStateNormal];
    if (second==-1) {
        [self.repeatPostBtn setTitle:@"收不到短信验证码，点击重新发送" forState:UIControlStateNormal];
        self.repeatPostBtn.userInteractionEnabled = YES;
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}
#pragma mark ----绑定
-(void)submitBtnClick
{
    if ([self.codeField.text isEqualToString:@""]){
        //提示 验证码为空  一秒钟后消失
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.35, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.3, 30)];
    label.text = @"验证码为空";
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
    }else{
    AppDelegate   *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.userInfoDictionary = delegate.accountBasicDict;
    NSDictionary  *dict  = @{@"huaienID":[self.userInfoDictionary objectForKey:@"huaienID"],@"mobile":self.telePhoneField.text};
    NSDictionary  *paramDict  = @{@"params":[NSString stringWithFormat:@"%@",dict]};
    [delegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,usrUptUserMobile] parameters:paramDict success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:
                       NSJSONReadingMutableContainers error:nil];
        NSNumber * result = jsonData[@"result"];
        if ([result integerValue] == 0) {
            //  提示   绑定成功 1秒钟后消失
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.35, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.3, 30)];
            label.text = @"绑定成功";
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

            self.block(self.telePhoneField.text);
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    }
}
@end
