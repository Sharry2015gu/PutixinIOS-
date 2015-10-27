//
//  XinXiangViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/9/14.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "XinXiangViewController.h"
#import "HeaderFile.h"
#import "NewModel.h"
#import "EmailViewCell.h"
#import "RESideMenu.h"
#import "AppDelegate.h"
#import "XXNeiRongViewController.h"
@interface XinXiangViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UINavigationBar * bar;
@property(nonatomic,strong)UITableView * tableview;
@property(nonatomic,strong)NSMutableArray * resultArray;
@property(nonatomic,strong)UIButton * changjianBtn;
@end

@implementation XinXiangViewController
-(NSMutableArray *)resultArray{
    
    if (_resultArray == nil) {
        _resultArray = [[NSMutableArray alloc]init];
    }
    return _resultArray;
}
#pragma mark ---主页面--
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getSetMessageInfon:nil];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    _bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.1)];
    [_bar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:_bar];
    
    UIButton * bu=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [bu setBackgroundImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(fhclick) forControlEvents:UIControlEventTouchUpInside];
    [_bar addSubview:bu];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"我的消息";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [_bar addSubview:title];
    
    _changjianBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.85, 0.05*SCREEN_HEIGHT, 0.01*SCREEN_WIDTH+30, 0.08*SCREEN_WIDTH)];
    [_changjianBtn setBackgroundImage:[UIImage imageNamed:@"常见问题.png"] forState:UIControlStateNormal];
    [_changjianBtn addTarget:self action:@selector(changjianbt) forControlEvents:UIControlEventTouchUpInside];
    [_bar addSubview:_changjianBtn];
}
#pragma mark ---创建tableview---
-(void)createTable{
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, _bar.frame.origin.y+_bar.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _tableview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    _tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableview.showsHorizontalScrollIndicator=NO;
    _tableview.showsVerticalScrollIndicator=NO;
    _tableview.delegate=self;
    _tableview.dataSource=self;
    [self.view addSubview:_tableview];
}
#pragma mark ----按钮事件---
-(void)fhclick{
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.sideMenuViewController setContentViewController:delegate.mainVc
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}
-(void)changjianbt{

    UIActionSheet * action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"清空消息", nil];
    [action showInView:self.view];
}
#pragma mark ---actionsheet代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        UIAlertView * alre=[[UIAlertView alloc]initWithTitle:nil message:@"确定清空信箱吗?"  delegate:self cancelButtonTitle:@"取消"  otherButtonTitles:@"确定",nil];
        [alre show];
        
    }else if (buttonIndex==1){
    
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (buttonIndex == 1){
        [ProgressHUD showOnView:self.view];
        NSDictionary * vowdic=@{@"messageID":[NSString stringWithFormat:@"%ld",_model.messageID],@"huaienID":[[NSUserDefaults standardUserDefaults] objectForKey:@"huaienID"],@"optType":@"A"};
        NSDictionary * vowDic = @{@"params":[NSString stringWithFormat:@"%@",vowdic]};
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,SetMessgeStatus]  parameters:vowDic success:^(NSURLSessionDataTask *task, id responseObject) {
            id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"消息已读=%@",jsonData);
            [_tableview removeFromSuperview];
            
            [ProgressHUD hideAfterSuccessOnView:self.view];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
        }];


    }

}

#pragma mark ----tableview代理
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewModel * model= self.resultArray[indexPath.row];
    NSString *cellId = @"cellId";
    EmailViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[EmailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    
    }
    [cell setnewModel:model];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewModel * new = _resultArray[indexPath.row];
    XXNeiRongViewController * xx = [[XXNeiRongViewController alloc]init];
    xx.lastViewConrtroller=self;
    xx.name = new.title;
    xx.centrol = new.content;
    xx.data = new.createDate;
    [self.navigationController pushViewController:xx animated:YES];
    [self getSetMessageInfon:new];
}
#pragma mark -----消息接口----
-(void)getMessageInfo
{
    [ProgressHUD showOnView:self.view];
    NSDictionary * vowdic=@{@"projectID":@15,@"huaienID":[[NSUserDefaults standardUserDefaults] objectForKey:@"huaienID"]};
    NSDictionary * vowDic = @{@"params":[NSString stringWithFormat:@"%@",vowdic]};
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,MessgeByUserID]  parameters:vowDic success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"消息=%@",jsonData);
        NSArray  *modelArray = jsonData[@"data"];
        for(int i = 0 ; i < modelArray.count;i++)
        {
            
            NSDictionary *dict = modelArray[i];
            NewModel * model = [[NewModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.resultArray addObject:model];
        }
        [self createTable];
        [ProgressHUD hideAfterSuccessOnView:self.view];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark -----消息接口----
-(void)getSetMessageInfon:(NewModel *)model
{
    [ProgressHUD showOnView:self.view];
    NSDictionary * vowdic=@{@"messageID":[NSString stringWithFormat:@"%ld",model.messageID],@"huaienID":[[NSUserDefaults standardUserDefaults] objectForKey:@"huaienID"],@"optType":@"R"};
    NSDictionary * vowDic = @{@"params":[NSString stringWithFormat:@"%@",vowdic]};
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,SetMessgeStatus]  parameters:vowDic success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"消息已读=%@",jsonData);
        
        
        [ProgressHUD hideAfterSuccessOnView:self.view];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

@end
