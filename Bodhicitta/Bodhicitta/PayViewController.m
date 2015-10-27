//
//  PayViewController.m
//  Bodhicitta
//
//  Created by 怀恩11 on 15/9/25.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "PayViewController.h"
#import "HeaderFile.h"
#import "RESideMenu.h"
@interface PayViewController ()
@property(nonatomic,strong)UINavigationBar *bar;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"登录背景"]];

   _bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.1)];
    [_bar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:_bar];
    UIButton * bu=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.06*SCREEN_WIDTH, 0.06*SCREEN_WIDTH)];
    [bu setBackgroundImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [_bar addSubview:bu];
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"功德箱";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [_bar addSubview:title];
  
    [self loadPackageInfo];
}

- (void)backClick
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.sideMenuViewController setContentViewController:delegate.mainVc
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];

}
#pragma mark获取套餐信息
- (void)loadPackageInfo
{
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSLog(@"id ＝%@",huaien);
    NSDictionary *packageDict =@{@"huaienID":huaien,@"packageCode":@"PTX_A"};
    NSDictionary *packageDict1= @{@"params":[NSString stringWithFormat:@"%@",packageDict]};
    NSLog(@"zidian=%@",packageDict1);
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,bllUserGetPackageInfo]  parameters:packageDict1 success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"充值jsonData=%@",jsonData);
        NSString *factPackageCode=jsonData[@"factPackageCode"];
        if([factPackageCode isEqualToString:@"PTX_A001"] ){
            [self createFirstPayView];
        }else{
            [self createPayView];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark 创建视图
- (void)createFirstPayView
{
    UIImageView *bgimageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, _bar.frame.size.height+_bar.frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT-_bar.frame.size.height-_bar.frame.origin.y)];
    bgimageView.image=[UIImage imageNamed:@"功德箱_BG1.gif"];
    bgimageView.alpha=0.95;
   // bgimageView.backgroundColor=[UIColor colorWithPatternImage:@"登录背景.png"];
    [self.view addSubview:bgimageView];
    UIImageView *titleImageView =[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH-10, SCREEN_HEIGHT*0.18)];
    titleImageView.image=[UIImage imageNamed:@"功德箱1.png"];
    [bgimageView addSubview:titleImageView];
    for (int i=0;i<4;i++){
       UIButton *payBtn =[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.15, SCREEN_HEIGHT*0.35+(SCREEN_HEIGHT*0.05+20)*i, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.054)];
        payBtn.tag=100+i;
        [payBtn addTarget:self action:@selector(payFirstClick:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *payImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, payBtn.frame.size.width, payBtn.frame.size.height)];
        payImageView.image=[UIImage imageNamed:@"功德箱2.png"];
        [payBtn addSubview:payImageView];
        NSArray *monerArray =@[@"首充6元",@"30元",@"98元",@"198元"];
        NSArray *payArray =@[@"3000元祈福币",@"3300祈福币",@"11760祈福币",@" 25740祈福币"];
        UILabel *moneyLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, payBtn.frame.size.width/2, payBtn.frame.size.height)];
        moneyLabel.text=monerArray[i];
        moneyLabel.font=[UIFont systemFontOfSize:15];
        moneyLabel.textAlignment=NSTextAlignmentCenter;
        moneyLabel.textColor=[UIColor redColor];
        [payBtn addSubview:moneyLabel];
        UILabel *payLabel =[[UILabel alloc]initWithFrame:CGRectMake(moneyLabel.frame.origin.x+moneyLabel.frame.size.width, 0, moneyLabel.frame.size.width, moneyLabel.frame.size.height)];
        payLabel.text=payArray[i];
        payLabel.font=[UIFont systemFontOfSize:15];
        payLabel.textAlignment=NSTextAlignmentCenter;
        payLabel.textColor=[UIColor yellowColor];
        [payBtn addSubview:payLabel];

        [bgimageView addSubview:payBtn];
        
    }
    
    
}
- (void)createPayView
{
    UIImageView *bgimageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, _bar.frame.size.height+_bar.frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT-_bar.frame.size.height-_bar.frame.origin.y)];
    bgimageView.image=[UIImage imageNamed:@"功德箱_BG1.gif"];
    bgimageView.alpha=0.95;
    // bgimageView.backgroundColor=[UIColor colorWithPatternImage:@"登录背景.png"];
    [self.view addSubview:bgimageView];
    UIImageView *titleImageView =[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH-10, SCREEN_HEIGHT*0.18)];
    titleImageView.image=[UIImage imageNamed:@"功德箱1.png"];
    [bgimageView addSubview:titleImageView];
    for (int i=0;i<4;i++){
        UIButton *payBtn =[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.15, SCREEN_HEIGHT*0.35+(SCREEN_HEIGHT*0.05+20)*i, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.054)];
        payBtn.tag=100+i;
        [payBtn addTarget:self action:@selector(payClick:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *payImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, payBtn.frame.size.width, payBtn.frame.size.height)];
        payImageView.image=[UIImage imageNamed:@"功德箱2.png"];
        [payBtn addSubview:payImageView];
        NSArray *monerArray =@[@"6元",@"30元",@"98元",@"198元"];
        NSArray *payArray =@[@"600元祈福币",@"3300祈福币",@"11760祈福币",@" 25740祈福币"];
        UILabel *moneyLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, payBtn.frame.size.width/2, payBtn.frame.size.height)];
        moneyLabel.text=monerArray[i];
        moneyLabel.font=[UIFont systemFontOfSize:15];
        moneyLabel.textAlignment=NSTextAlignmentCenter;
        moneyLabel.textColor=[UIColor redColor];
        [payBtn addSubview:moneyLabel];
        UILabel *payLabel =[[UILabel alloc]initWithFrame:CGRectMake(moneyLabel.frame.origin.x+moneyLabel.frame.size.width, 0, moneyLabel.frame.size.width, moneyLabel.frame.size.height)];
        payLabel.text=payArray[i];
        payLabel.font=[UIFont systemFontOfSize:15];
        payLabel.textAlignment=NSTextAlignmentCenter;
        payLabel.textColor=[UIColor yellowColor];
        [payBtn addSubview:payLabel];
        
        [bgimageView addSubview:payBtn];
        
    }
    
}
#pragma mark 在线购买怀恩点前置接口
- (void)payFirstClick:(UIButton*)btn
{
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    
    
    
}
- (void)payClick:(UIButton*)btn
{
    
}

@end
