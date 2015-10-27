//
//  FanKuiViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/15.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "FanKuiViewController.h"
#import "HeaderFile.h"
@interface FanKuiViewController ()
@property(nonatomic,strong)UITextView *jianyiText;
@property(nonatomic,strong)UITextField *teleText;
@property(nonatomic,strong)UIButton *fankuiBt;

@end

@implementation FanKuiViewController
#pragma mark ---主页面---
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar * bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.1+5)];
    [bar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:bar];
    
    UIButton * bu=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [bu setBackgroundImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(fankuiclick) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:bu];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"意见反馈";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [bar addSubview:title];
    
    UIView * bgview=[[UIView alloc]initWithFrame:CGRectMake(0, bar.frame.origin.y+bar.frame.size.height, SCREEN_WIDTH, self.view.frame.size.height)];
    bgview.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景.png"]];
    [self.view addSubview:bgview];
    
    UILabel * xiangfaLa=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.02, bar.frame.origin.y+10, SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.075)];
    xiangfaLa.text=@"您的想法和建议";
    xiangfaLa.font=[UIFont systemFontOfSize:16];
    [bgview addSubview:xiangfaLa];
    
    self.jianyiText=[[UITextView alloc]initWithFrame:CGRectMake(xiangfaLa.frame.origin.x, xiangfaLa.frame.origin.y+xiangfaLa.frame.size.height, SCREEN_WIDTH*0.96, SCREEN_HEIGHT*0.25)];
    self.jianyiText.font=[UIFont systemFontOfSize:16];
    [bgview addSubview: self.jianyiText];
    
    UILabel * xuanze=[[UILabel alloc]initWithFrame:CGRectMake(xiangfaLa.frame.origin.x, self.jianyiText.frame.origin.y+ self.jianyiText.frame.size.height, SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.075)];
    xuanze.text=@"联系方式:(可选)";
    xuanze.font=[UIFont systemFontOfSize:16];
    [bgview addSubview:xuanze];
    
    UIImageView * iv=[[UIImageView alloc]initWithFrame:CGRectMake(xiangfaLa.frame.origin.x, xuanze.frame.origin.y+xuanze.frame.size.height, SCREEN_WIDTH*0.96, 45)];
    iv.image=[UIImage imageNamed:@"底部导航背景.jpg"];
    [bgview addSubview:iv];
    self.teleText=[[UITextField alloc]initWithFrame:CGRectMake(xiangfaLa.frame.origin.x+6, xuanze.frame.origin.y+xuanze.frame.size.height, SCREEN_WIDTH*0.5, 45)];
    self.teleText.backgroundColor=[UIColor whiteColor];
    self.teleText.placeholder=@"输入手机号";
    [bgview addSubview: self.teleText];
    
    self.fankuiBt=[[UIButton alloc]initWithFrame:CGRectMake(xiangfaLa.frame.origin.x+20,self.teleText.frame.origin.y+self.teleText.frame.size.height+30, SCREEN_WIDTH*0.83, 45)];
    [self.fankuiBt setBackgroundImage:[UIImage imageNamed:@"输入字符时登录按钮"] forState:UIControlStateNormal];
    [self.fankuiBt setTitle:@"发送反馈" forState:UIControlStateNormal];
    [self.fankuiBt setTintColor:[UIColor whiteColor]];
    [self.fankuiBt addTarget:self action:@selector(fankuiButton) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:self.fankuiBt];
    
}

-(void)fankuiclick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)fankuiButton{
    
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *str=_jianyiText.text;
    
    NSString *contact =_teleText.text;
    if ([_jianyiText.text isEqualToString:@""]){
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 180) / 2, SCREEN_HEIGHT*0.8, 150, 30)];
        //            label.text = [NSString stringWithFormat:@"修行值+%@",jsonData[@"integral"]];
        label.text=@"反馈意见输入不能为空";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.backgroundColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:14];
        [self.view addSubview:label];
        
        [UIView animateWithDuration:1.5 animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }
    
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSNumber * senderID= [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSArray *keyArray= @[@"projectID",@"senderID",@"content",@"contactWay"];
    NSDictionary * suggestDic=@{@"projectID":@15,@"senderID":senderID,@"content":str,@"contactWay":contact};
    
    NSString *jsonParamsStr = @"{";
    for(int i = 0 ; i < keyArray.count; i++)
    {
        NSString *keyValue = keyArray[i];
        if (i == keyArray.count- 1) {
            jsonParamsStr = [NSString stringWithFormat:@"%@%@:%@}",jsonParamsStr,keyValue,[suggestDic valueForKey:keyValue]];
        }
        else
        {
            jsonParamsStr = [NSString stringWithFormat:@"%@%@:%@,",jsonParamsStr,keyValue,[suggestDic  valueForKey:keyValue]];
        }
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@%@params=%@",__kBaseURLString,msgAddSuggestion,jsonParamsStr];
    [appDelegate.sessionManager GET:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *result =jsonData[@"result"];
        if([result integerValue]>0){
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



@end
