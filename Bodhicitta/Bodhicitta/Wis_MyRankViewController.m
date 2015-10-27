//
//  Wis_MyRankViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/9/14.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "Wis_MyRankViewController.h"
#import "HeaderFile.h"
#import "Wis_MyRankTableViewCell.h"
#import "ProgressHUD.h"
@interface Wis_MyRankViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableview;
@property(nonatomic,strong)NSMutableArray * resultArray;

@end

@implementation Wis_MyRankViewController

-(NSMutableArray *)resultArray
{
    if (_resultArray == nil) {
        _resultArray = [[NSMutableArray alloc]init];
    }
    return _resultArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar * bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    [bar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:bar];
    
    UIButton * bu=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [bu setBackgroundImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(buclick) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:bu];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"读经总排行";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [bar addSubview:title];
    
    UIImageView * titleImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, bar.frame.origin.y+bar.frame.size.height, SCREEN_WIDTH, 50)];
    titleImage.image=[UIImage imageNamed:@"ranking_top_bg.jpg"];
    [self.view addSubview:titleImage];
    
    UILabel * nameLa=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.09, 0, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.075)];
    nameLa.text=@"用户昵称";
    nameLa.font=[UIFont systemFontOfSize:15];
    nameLa.textColor=RankingListColor;
    [titleImage addSubview:nameLa];
    
    UILabel * cishuLa=[[UILabel alloc]initWithFrame:CGRectMake(nameLa.frame.origin.x+nameLa.frame.size.width+20, 0, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.075)];
    cishuLa.text=@"读经总时间";
    cishuLa.font=[UIFont systemFontOfSize:15];
    cishuLa.textColor=RankingListColor;
    [titleImage addSubview:cishuLa];
    
    UILabel * paimingLa=[[UILabel alloc]initWithFrame:CGRectMake(cishuLa.frame.origin.x+cishuLa.frame.size.width+30, 0, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.075)];
    paimingLa.text=@"排名";
    paimingLa.font=[UIFont systemFontOfSize:15];
    paimingLa.textColor=RankingListColor;
    [titleImage addSubview:paimingLa];
    
    UIView * bgview=[[UIView alloc]initWithFrame:CGRectMake(0, titleImage.frame.origin.y+titleImage.frame.size.height, SCREEN_WIDTH, self.view.frame.size.height)];
    bgview.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"putibj.jpg"]];
    [self.view addSubview:bgview];
    [self viewDidLayoutSubviews];
}
#pragma mark ----tableview分割线的长度设置---
-(void)viewDidLayoutSubviews{
    if ([_tableview respondsToSelector:@selector(setSeparatorInset:)]){
        
        [_tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([_tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [_tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }}

-(void)createTableView
{
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,NAVBARHEIGHT*0.1+110,SCREEN_WIDTH,SCREEN_HEIGHT * 0.9)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"putibj.jpg"]];
    self.tableview.showsVerticalScrollIndicator=NO;
    self.tableview.showsHorizontalScrollIndicator=NO;
    self.tableview.separatorStyle=UITableViewCellEditingStyleNone;
    [self.view addSubview:self.tableview];
//    WS(weakself);
    [self.tableview addHeaderWithCallback:^{
        //        [weakself getReadRanking];
    }];
    [self.tableview addFooterWithCallback:^{
        //        [weakself getReadRanking];
    }];
    
    
    
}
#pragma mark ---tabelview代理---
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankingModel *model = self.resultArray[indexPath.row];
    NSString *cellId = @"cellId";
    Wis_MyRankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[Wis_MyRankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    [cell setrankModel:model IndexPath:indexPath];
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArray.count;
}

-(void)buclick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----抄经总排行接口----
-(void)getScribeRanking{
    
    [ProgressHUD showOnView:self.view];
    NSNumber * miyaoNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"secretKey"];
    NSDictionary * dic = @{@"secretKey":miyaoNum,@"taskCode":@501};
    NSDictionary * rankingDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,RankingURL] parameters:rankingDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"抄经nsfhiehf=%@",jsonData);
        
        NSArray * rankingArray = jsonData[@"data"];
        for (int i = 0; i < rankingArray.count; i++) {
            
            NSDictionary * arrdic = rankingArray[i];
            RankingModel * rank = [[RankingModel alloc]init];
            [rank setValuesForKeysWithDictionary:arrdic];
            [self.resultArray addObject:rank];
        }
        [self createTableView];
        [ProgressHUD hideAfterSuccessOnView:self.view];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}
#pragma mark ----抄经排行接口----
-(void)getScribeRanking:(CollectModel *)model{
    
    [ProgressHUD showOnView:self.view];
    NSNumber * miyaoNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"secretKey"];
    NSDictionary * dic = @{@"secretKey":miyaoNum,@"taskCode":@501,@"bookID":[NSString stringWithFormat:@"%ld",(long)model.objectID],@"orderType":@"T"};
    NSDictionary * rankingDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,ReadingURL] parameters:rankingDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"抄经nsfhiehf=%@",jsonData);
        
        NSArray * rankingArray = jsonData[@"data"];
        for (int i = 0; i < rankingArray.count; i++) {
            
            NSDictionary * arrdic = rankingArray[i];
            RankingModel * rank = [[RankingModel alloc]init];
            [rank setValuesForKeysWithDictionary:arrdic];
            [self.resultArray addObject:rank];
        }
        [self createTableView];
        [ProgressHUD hideAfterSuccessOnView:self.view];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}
@end
