//
//  ChaKanViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/10.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "ChaKanViewController.h"

@interface ChaKanViewController ()

@end

@implementation ChaKanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 170)];
    view.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"顶部导航背景"]];
    [self.view addSubview:view];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(145, 30, 120, 30)];
    title.text=@"日行一善圈";
    title.font=[UIFont systemFontOfSize:20];
    title.textColor=[UIColor whiteColor];
    [view addSubview:title];
    
    fanhuiBt=[[UIButton alloc]initWithFrame:CGRectMake(6, 33, 25, 25)];
    [fanhuiBt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [fanhuiBt addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhuiBt];
    
    touxiangButton=[[UIButton alloc]initWithFrame:CGRectMake(330, 33, 25, 25)];
    [touxiangButton setBackgroundImage:[UIImage imageNamed:@"make_circle"] forState:UIControlStateNormal];
    [touxiangButton addTarget:self action:@selector(touxiangClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:touxiangButton];
    
    UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(170, 65, 45, 45)];
    imageview.image=[UIImage imageNamed:@"头像.png"];
    [view addSubview:imageview];
    
    accutLa=[[UILabel alloc]initWithFrame:CGRectMake(170, 110, 100, 20)];
    accutLa.text=@"1233245";
    accutLa.textColor=[UIColor whiteColor];
    accutLa.font=[UIFont systemFontOfSize:12];
    [view addSubview:accutLa];
    
    UILabel * huanyin=[[UILabel alloc]initWithFrame:CGRectMake(140, 140, 140, 20)];
    huanyin.text=@"欢迎大家来到日行一善 !";
    huanyin.textColor=[UIColor whiteColor];
    huanyin.font=[UIFont systemFontOfSize:12];
    [view addSubview:huanyin];
    
    UIImageView * huaImage=[[UIImageView alloc]initWithFrame:CGRectMake(230, 115, 10, 13)];
    huaImage.image=[UIImage imageNamed:@"huo.png"];
    [view addSubview:huaImage];
    
    UIView * background=[[UIView alloc]initWithFrame:CGRectMake(0, 170, 380, self.view.frame.size.height)];
    background.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    [self.view addSubview:background];
    
    searchBt=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 375, 50)];
    [searchBt setBackgroundColor:[UIColor clearColor]];
    searchBt.showsScopeBar = NO;
    searchBt.delegate=self;
    [background addSubview:searchBt];
}
-(void)backclick{
    
    [self.sideMenuViewController
     setContentViewController:[[ZhuYeMianViewController alloc] init]animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
}
- (void)touxiangClick{
    
//    [self.sideMenuViewController
//     setContentViewController:[[TouXiang_GXViewController alloc] init]animated:YES];
//    [self.sideMenuViewController hideMenuViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
