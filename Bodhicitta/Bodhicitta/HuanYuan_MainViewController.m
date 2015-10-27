//
//  HuanYuan_MainViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/17.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "HuanYuan_MainViewController.h"
#import "HeaderFile.h"
#import "HYTableViewCell.h"
#import "ProgressHUD.h"

@interface HuanYuan_MainViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{

    NSInteger currentPage;
    NSInteger buhhdaID;
}
@property(nonatomic,strong)NSMutableArray *resultArray;
@end

@implementation HuanYuan_MainViewController
@synthesize dataArray;

-(NSMutableArray *)resultArray
{
    if (_resultArray == nil) {
        _resultArray = [[NSMutableArray alloc]init];
    }
    return _resultArray;
}
-(void)createNavBar
{
    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NAVBARHEIGHT)];
    [navBar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景"] forBarMetrics:UIBarMetricsDefault];
    navBar.barStyle = UIBarStyleBlackTranslucent;
    UINavigationItem *titleItem = [[UINavigationItem alloc]initWithTitle:@"还愿记录"];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"putibj.jpg"]];
    [self createNavBar];
}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,NAVBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT - NAVBARHEIGHT)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor  colorWithPatternImage:[UIImage imageNamed:@"putibj.jpg"]];
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TempleVow *model = self.resultArray[indexPath.row];
    NSString *cellId = @"cellId";
    HYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[HYTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setModel:model];
    cell.redeemVowBlock= ^void(TempleVow * model)
    {
        [self getTempleVowWithBuddhistId:model];
        //        NSInteger  wayID = [model.fulfileTaskType integerValue];
//        self.myBuddahaVC.isVow = YES;
        //需要怎样的还愿方式  需要返回给佛堂
//        self.myBuddahaVC.flagVowStyle = wayID;
//        self.myBuddahaVC.vowModel = model;
//        switch (wayID)
//        {
//            case 0:
//                [self.myBuddahaVC  incenseBtnClick];
//                break;
//            case 1:
//                [self.myBuddahaVC forteaBtnClick];
//                break;
//            case 2:
//                [self.myBuddahaVC offerBtnClick];
//                break;
//            case 3:
//                [self.myBuddahaVC forflowerBtnClick];
//                break;
//        }
//        [self.navigationController popViewControllerAnimated:YES];
    };
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArray.count;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -----自己还愿信息列表----
-(void)loadDataWithBuddhistId:(NSInteger) buddhistID
{
    buhhdaID = buddhistID;
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [ProgressHUD showOnView:self.view];
    NSNumber * miyaoNum = [appDelegate.accountBasicDict  objectForKey:@"secretKey"];
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSDictionary * vowdic=@{@"secretKey":miyaoNum,@"huaienID":huaien,@"buddhistTempleID":[NSNumber numberWithInteger:buddhistID]};
    NSDictionary * vowDic = @{@"params":[NSString stringWithFormat:@"%@",vowdic]};
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,TempleVowURL]  parameters:vowDic success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"自己还愿信息列表＝%@",jsonData);
        NSArray  *modelArray = jsonData[@"data"];
        if (modelArray.count == 0 ) {
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake((SCREEN_WIDTH - 100) / 2, SCREEN_HEIGHT*0.68, 100, 30);
            label.text = @"快去许愿吧";
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
            [self.resultArray removeAllObjects];
            for(int i = 0 ; i < modelArray.count;i++)
            {
                NSDictionary *dict = modelArray[i];
                TempleVow *model = [[TempleVow alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                model.wishFor = [model.wishFor stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [self.resultArray addObject:model];
                
            }
            if (_tableView == nil) {
                [self createTableView];
            }
            else
            {
                [self.tableView reloadData];
            }
        }
        [ProgressHUD hideAfterSuccessOnView:self.view];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}
#pragma mark -----前去还愿
-(void)getTempleVowWithBuddhistId:(TempleVow *) model
{
    self.isVow = NO;
    //[ProgressHUD showOnView:self.view];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * miyaoNum = [appDelegate.accountBasicDict objectForKey:@"secretKey"];
    NSNumber * loginid = [appDelegate.accountBasicDict objectForKey:@"userLoginID"];
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSDictionary * vowdic=@{@"secretKey":miyaoNum,@"userLoginID":loginid,@"huaienID":huaien,@"userTaskID":[NSNumber numberWithInteger:model.userTaskID],@"fulfilID":[NSNumber numberWithInteger:model.fulfilID],@"sceneType":@1,@"buddhistTempleID":[NSNumber numberWithInteger:model.buddhistTempleID]};
    NSLog(@"id=%@",[NSNumber numberWithInteger:model.userTaskID]);
    NSLog(@"还原id＝%@",vowdic);
    NSDictionary * vowDic = @{@"params":[NSString stringWithFormat:@"%@",vowdic]};
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,VowURL]  parameters:vowDic success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"前去还愿=%@",jsonData);
        
        if (model.fulfilID == 0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"还愿消耗%@,确定还愿吗?",jsonData[@"prayMoneyFulfil"]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }else{
            
            [self dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"ndndndndndn");
        }

        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake((SCREEN_WIDTH - 220) / 2, SCREEN_HEIGHT*0.68, 150, 20);
        label.text = [NSString stringWithFormat:@"获取祈福币%@",jsonData[@"prayMoneyFulfil"]];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.backgroundColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:12];
        [self.view addSubview:label];

        [UIView animateWithDuration:1.5 animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake((SCREEN_WIDTH - 200) / 2, SCREEN_HEIGHT*0.68, 150, 50);
            label.text = [NSString stringWithFormat:@"还愿获取积分数量%@",jsonData[@"integralFulfil"]];
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
            
        }];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}
#pragma mark ----alretsheet代理---
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    HYTableViewCell * hy = [[HYTableViewCell alloc]init];
    if (buttonIndex == 0) {
        [hy.vowBtn setTitle:@"前去许愿" forState:UIControlStateNormal];
        [hy.vowBtn setBackgroundImage:[UIImage imageNamed:@"go_votive_bg"] forState:UIControlStateNormal];
        [self dismissViewControllerAnimated:YES completion:nil];
        NSLog(@"heheheheheh");
        
    }else if (buttonIndex == 1){
        hy.vowBtn.backgroundColor=[UIColor blueColor];
        [hy.vowBtn setTitle:@"还愿成功" forState:UIControlStateNormal];
        [hy.vowBtn setBackgroundImage:[UIImage imageNamed:@"has_votive_bg"] forState:UIControlStateNormal];
        NSLog(@"----%ld---",buhhdaID);
        [self loadDataWithBuddhistId:buhhdaID];
        
    }
    
    
}
@end
