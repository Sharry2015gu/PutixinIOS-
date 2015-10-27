//
//  AddressViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/29.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "AddressViewController.h"
#import "HeaderFile.h"
#import "ProvinceViewController.h"
#import "CityViewController.h"
#import "AreaViewController.h"
#import "UserInfoEditingViewController.h"

@interface AddressViewController ()
@property (nonatomic,strong)UITextField *detailField;
@property (nonatomic,strong)NSString *proviceName;
@property (nonatomic,strong)NSString *cityName;
@property (nonatomic,strong)NSString *areaName;
@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    [self createNavBar];
    [self createUI];
}
-(void)createNavBar
{
    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NAVBARHEIGHT)];
    [navBar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景"] forBarMetrics:UIBarMetricsDefault];
    UINavigationItem *titleItem = [[UINavigationItem alloc]initWithTitle:@"所在地区"];
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
    
    UIButton * rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(20,20,30,25)];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [titleItem setRightBarButtonItem:rightItem];
    [navBar pushNavigationItem:titleItem animated:NO];
    [self.view addSubview:navBar];
}
#pragma mark ----保存
-(void)rightBtnClick
{
    if ([self.createVc respondsToSelector:@selector(changeAddressFunctionWithAdressStr:)]) {
        UserInfoEditingViewController * userEditingVc = (UserInfoEditingViewController *)self.createVc;
        [userEditingVc changeAddressFunctionWithAdressStr:[NSString stringWithFormat:@"%@%@",self.resultAdressStr,self.detailField.text]];      
    }
    [self.navigationController popToViewController:self.createVc animated:YES];
}
#pragma mark ----返回
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createUI
{
    self.selectLabel=[[UILabel alloc]initWithFrame:CGRectMake(5,NAVBARHEIGHT, self.view.frame.size.width - 10, 50)];
    self.selectLabel.font=[UIFont systemFontOfSize:20];
    self.selectLabel.textColor=[UIColor blackColor];
    self.selectLabel.text = [NSString stringWithFormat:@"%@",self.resultAdressStr];
    [self.view addSubview:self.selectLabel];
    
    self.detailField =[[UITextField alloc]initWithFrame:CGRectMake(0,NAVBARHEIGHT+ 50, self.view.frame.size.width, 50)];
    self.detailField.placeholder=@"请输入乡/镇/组";
    self.detailField.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.detailField];
}
@end
