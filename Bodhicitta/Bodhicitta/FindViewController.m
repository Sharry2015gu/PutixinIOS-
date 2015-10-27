//
//  FindViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/1.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "FindViewController.h"
#import "HeaderFile.h"
#import "PhoneViewController.h"
#import "EmailStyleViewController.h"
#import "PhoneEmailViewController.h"
@interface FindViewController ()
@property(nonatomic,strong)UIImageView * accentLine;
@property(nonatomic,strong)UIImageView * passLine;
@property(nonatomic,strong)UIImageView *imageCode;
@property(nonatomic,strong)NSMutableDictionary  *memberDict;


@end

@implementation FindViewController

#pragma mark ----主界面----
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    CGFloat font ;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        font =  16;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            
            font = 14;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            font = 18;
        }
        else
        {
            font  = 13;
        }
    }
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.1, 0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"输入账号";
    title.font=[UIFont systemFontOfSize:font+4];
    [self.view addSubview:title];
    quxiao=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01-30, SCREEN_HEIGHT*0.01+40, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.1)];
    [quxiao setTitleColor:majorityColor forState:UIControlStateNormal];
    [quxiao setTitle:@"返回" forState:UIControlStateNormal];
    [quxiao addTarget:self action:@selector(quxiaoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quxiao];
    
    _accentLine=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, title.frame.size.height+title.frame.origin.y+70, SCREEN_WIDTH*0.9, 1)];
    _accentLine.image=[UIImage imageNamed:@"line.png"];
    [self.view addSubview:_accentLine];
    
    nameiv=[[UIImageView alloc]initWithFrame:CGRectMake(_accentLine.frame.origin.x-5, _accentLine.frame.origin.y+_accentLine.frame.size.height-45, 28, 30)];
    nameiv.image=[UIImage imageNamed:@"user.png"];
    [self.view addSubview:nameiv];
    
    nametext=[[UITextField alloc]initWithFrame:CGRectMake(nameiv.frame.origin.x+nameiv.frame.size.width+40,_accentLine.frame.origin.y+_accentLine.frame.size.height-50, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.075)];
    nametext.placeholder = @"手机号/用户ID/邮箱";
    [nametext setBackgroundColor:[UIColor clearColor]];
    nametext.font=[UIFont systemFontOfSize:font+4];
    [self.view addSubview:nametext];
    
    _passLine=[[UIImageView alloc]initWithFrame:CGRectMake(_accentLine.frame.origin.x, _accentLine.frame.size.height+_accentLine.frame.origin.y+55, SCREEN_WIDTH*0.9, 1)];
    _passLine.image=[UIImage imageNamed:@"line.png"];
    [self.view addSubview:_passLine];
    
    yaniv=[[UILabel alloc]initWithFrame:CGRectMake(nameiv.frame.origin.x, _accentLine.frame.origin.y+10, SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.075)];
    yaniv.text=@"验证码";
    yaniv.font=[UIFont systemFontOfSize:font+2];
    [self.view addSubview:yaniv];
    
    yanzheng=[[UITextField alloc]initWithFrame:CGRectMake(yaniv.frame.origin.x+80,_passLine.frame.origin.y+_passLine.frame.size.height-50, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.075)];
    yanzheng.placeholder=@"请输入下图中的字符";
    yanzheng.font=[UIFont systemFontOfSize:font+4];
    yanzheng.secureTextEntry = YES;
    [self.view addSubview:yanzheng];
    
    self.imageCode=[[UIImageView  alloc]initWithFrame:CGRectMake(nameiv.frame.origin.x, _passLine.frame.origin.y+_passLine.frame.size.height+25, 80, 40)];
    self.imageCode.backgroundColor=[UIColor whiteColor];
    //self.imageCode.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.imageCode];
    
    huan=[[UIButton alloc]initWithFrame:CGRectMake(self.imageCode.frame.origin.x+self.imageCode.frame.size.width+10, _passLine.frame.origin.y+30, 50, 40)];
    [huan setTitle:@"换一换" forState:UIControlStateNormal];
    [huan setTitleColor:[UIColor colorWithRed:0.123 green:0.435 blue:0.52 alpha:1.0] forState:UIControlStateNormal];
    huan.titleLabel.font=[UIFont systemFontOfSize:font];
    [huan addTarget:self action:@selector(changeCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:huan];
    sure=[UIButton buttonWithType:UIButtonTypeCustom];
    sure.frame=CGRectMake(_passLine.frame.origin.x, self.imageCode.frame.size.height+self.imageCode.frame.origin.y+40, SCREEN_WIDTH*0.9, 47);
    [sure setBackgroundImage:[UIImage imageNamed:@"输入字符时登录按钮"] forState:UIControlStateNormal];
    [sure setTitle:@"确定" forState:UIControlStateNormal];
    [sure addTarget:self action:@selector(loginbtClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sure];
    
//    //决定是否显示用户名以及密码
//    NSString *name = [Config Instance].getUserName;
//    NSString *pwd = [Config Instance].getPwd;
//    if (name && ![name isEqualToString:@""]) {
//        nametext.text = name;
//    }
//    if (pwd && ![pwd isEqualToString:@""]) {
//        yanzheng.text = pwd;
//    }
    [self getCodeData];
    
}
#pragma mark--- 换一换验证码
- (void)changeCode
{
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary * findPassDic=@{@"queryParm":@""};
    NSDictionary * findPassDic1 = @{@"params":[NSString stringWithFormat:@"%@",findPassDic]};
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,usrGetPicVerificationCode] parameters:findPassDic1 success:^(NSURLSessionDataTask *task, id responseObject) {
        id  jsonData=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"换一换＝%@",jsonData);
        NSString *code=jsonData[@"img"];
        NSData *imageCode=[[NSData alloc]initWithBase64Encoding:code];
        UIImage *codeImage =[UIImage imageWithData:imageCode];
        self.imageCode.image=codeImage;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}
#pragma mark ---按钮事件---
-(void)quxiaoClick{

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark获取图形验证码
- (void)getCodeData
{
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary * findPassDic=@{@"queryParm":@""};
    NSDictionary * findPassDic1 = @{@"params":[NSString stringWithFormat:@"%@",findPassDic]};
    NSLog(@"验证zidin=%@",findPassDic1);
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,usrGetPicVerificationCode] parameters:findPassDic1 success:^(NSURLSessionDataTask *task, id responseObject) {
        id  jsonData=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"图形＝%@",jsonData);
        [[NSUserDefaults standardUserDefaults]setObject:jsonData[@"JSESSIONID"] forKey:@"JSESSIONID"];
        NSString *code=jsonData[@"img"];
        //base64=>png
        NSData *imageCode=[[NSData alloc]initWithBase64Encoding:code];
        UIImage *codeImage =[UIImage imageWithData:imageCode];
        self.imageCode.image=codeImage;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark---确定
-(void)loginbtClick{
#pragma 判断图形验证码是否正确
    if ([nametext.text isEqualToString:@""]){
        //提示1秒钟消失的
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.3, 30)];
        label.text = @"输入不能为空！";
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

    }else if ([yanzheng.text isEqualToString:@""]){
        //提示1秒钟消失的
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.3, 30)];
        label.text = @"验证码不能为空！";
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
        AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSLog(@"uijop");
//        UIImage *codeImage=self.imageCode.image;
//        NSLog(@"png=%@",codeImage);
//        NSData *codeData=UIImageJPEGRepresentation(codeImage, 1.0f);
//        NSString *encodeImageStr=[codeData base64Encoding];
        NSString *codeStr =yanzheng.text;
        NSDictionary * surePassDic=@{@"JSESSIONID":[[NSUserDefaults standardUserDefaults]objectForKey:@"JSESSIONID"],@"code":codeStr};
        NSDictionary * surePassDic1 = @{@"params":[NSString stringWithFormat:@"%@",surePassDic]};
     
        appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,usrPicVerificationCode] parameters:surePassDic1 success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"chiuhn");
            id  jsonData=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"验证验证码＝%@",jsonData);
            self.memberDict = [[NSMutableDictionary alloc] init];
            NSString *loginName = nametext.text;
            if(loginName.length == 11){
                [self.memberDict  setObject:@2 forKey:@"queryParmType" ];
            }
            else
            {
                if ([loginName containsString:@"@"]) {
                    [self.memberDict setObject:@3 forKey:@"queryParmType" ];
                }
                else
                {
                    [self.memberDict setObject:@1 forKey:@"queryParmType" ];
                }
            }
            
            [self.memberDict setObject:nametext.text forKey:@"queryParm"];
            [self getMobileByCondition:self.memberDict];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];

    }
    
    
    
}

#pragma mark 判断账户属性
-(void)getMobileByCondition:(NSDictionary *) dict{
    
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
   // NSLog(@"字典＝%@",dict);
    NSDictionary * findPassDic1 = @{@"params":[NSString stringWithFormat:@"%@",dict]};
    NSLog(@"字典＝%@",findPassDic1);
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,usrGetMobileByCondition] parameters:findPassDic1 success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"chiuhn");
        id  jsonData=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"验证账户＝%@",jsonData);
        NSNumber *result =jsonData[@"result"];
        if ([result integerValue]==0){
            NSString *mobile=jsonData[@"mobile"];
            [[NSUserDefaults standardUserDefaults]setObject:mobile forKey:@"mobile"];
            NSString *email=jsonData[@"email"];
            if ([mobile isEqualToString:@""]&&mobile.length==0){
                  NSLog(@"没有找回方式");
                
            }else if ([email isEqualToString:@""]&&mobile.length==11) {
                //手机找回
               
                PhoneViewController *phoneVC=[[PhoneViewController alloc]init];
                [self.navigationController pushViewController:phoneVC animated:YES];
                
            }else if ([email containsString:@"@"]&&mobile.length==0){
                
                EmailStyleViewController *emailVC =[[EmailStyleViewController alloc]init];
                [self.navigationController pushViewController:emailVC animated:YES];
                
                
            }else if ([email containsString:@"@"]&&mobile.length==11){
                
                PhoneEmailViewController *allVC =[[PhoneEmailViewController alloc]init];
                [self.navigationController pushViewController:allVC animated:YES];
            }
        }
        
            
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}
@end
