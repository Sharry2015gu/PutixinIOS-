//
//  HomeWorkViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/8.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "HomeWorkViewController.h"
#import "HeaderFile.h"
#import "ProgressHUD.h"
#import "HomeWorkViewCell.h"
#import "HomeWorkModel.h"
@interface HomeWorkViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UILabel * pageLabel;
@property(nonatomic,strong)UIButton * awardBtn;
@property(nonatomic,strong)UITableView * tableview;
@property(nonatomic,strong)NSMutableArray *resultArray;
@property(nonatomic,strong)UIButton * fanhuiBt;
@end

@implementation HomeWorkViewController

-(NSMutableArray *)resultArray
{
    if (_resultArray == nil) {
        _resultArray = [[NSMutableArray alloc]init];
    }
    return _resultArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getHomeWorkInfo];
    [self getCompletionInfo];
    self.navigationController.navigationBarHidden=YES;
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.1)];
    view.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"顶部导航背景"]];
    [self.view addSubview:view];
    
    _fanhuiBt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [_fanhuiBt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [_fanhuiBt addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_fanhuiBt];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"每日功课";
    title.font=[UIFont systemFontOfSize:20];
    title.textColor=[UIColor whiteColor];
    [view addSubview:title];
    
    UIView * background=[[UIView alloc]initWithFrame:CGRectMake(0, 0.1*SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    background.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"putibj.jpg"]];
    [self.view addSubview:background];
    
    UIImageView * bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.1)];
    bgImageView.image =[UIImage imageNamed:@"every_lesson_top_bg"];
    [background addSubview:bgImageView];
    
    UILabel * wordDay =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.17, 10, SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.075)];
    wordDay.text = @"今日完成功课 : ";
    wordDay.font = [UIFont systemFontOfSize:16];
    wordDay.textColor=WorkDayColor;
    [bgImageView addSubview:wordDay];
    
    _pageLabel = [[UILabel alloc]initWithFrame:CGRectMake(wordDay.frame.origin.x+wordDay.frame.size.height+75, 10, SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.075)];
    
    _pageLabel.textColor = WorkDayColor;
    _pageLabel.font =[UIFont systemFontOfSize:16];
    [bgImageView addSubview:_pageLabel];
    
    _awardBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.65, SCREEN_HEIGHT*0.028, SCREEN_WIDTH*0.2, SCREEN_HEIGHT*0.045)];
    [_awardBtn setBackgroundImage:[UIImage imageNamed:@"bt_get_reward_no"] forState:UIControlStateNormal];
    [_awardBtn setTitle:@"领取奖励" forState:UIControlStateNormal];
    [_awardBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _awardBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [background addSubview:_awardBtn];
    
}
-(void)createTableView
{
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT*0.202,SCREEN_WIDTH,SCREEN_HEIGHT - SCREEN_HEIGHT * 0.202)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.showsHorizontalScrollIndicator =NO;
    self.tableview.showsVerticalScrollIndicator = NO;
    self.tableview.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"putibj.jpg"]];
    self.tableview.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeWorkModel * model = self.resultArray[indexPath.row];
    NSString *cellId = @"cellId";
    HomeWorkViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[HomeWorkViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    /*
     @property(nonatomic,strong)MyBuddhaHallViewController * myBuddahaVC;
     @property(nonatomic,strong)ShuJia_MyViewController   * myShuajiaVC;
     @property(nonatomic,strong)MusicViewController      *  myMusicPlayerVc;
     @property(nonatomic,strong)PracticeViewController   *  myPracticeVc;
     @property(nonatomic,strong)FoZhuViewController   *   fozhuVc;
     */
    [cell setHomeWorkModel:model];
    cell.redeemVowBlock = ^void(HomeWorkModel * homemodel)
    {
        // NSInteger  sceneType = homemodel.sceneType
        NSInteger taskType = [homemodel.taskType integerValue];
        self.myBuddahaVC.isVow = YES;
        //需要怎样的还愿方式  需要返回给佛堂
        //self.myBuddahaVC.flagVowStyle = wayID;
        //self.myBuddahaVC.homeModel = homemodel;
        switch (taskType)
        {
            case 2:
                [self.myBuddahaVC offerBtnClick];
                [self.navigationController pushViewController:self.myBuddahaVC animated:YES];
                break;
            case 3:
                [self.myBuddahaVC forteaBtnClick];
                [self.navigationController pushViewController:self.myBuddahaVC animated:YES];
                break;
            case 4:
                [self.myBuddahaVC forflowerBtnClick];
                [self.navigationController pushViewController:self.myBuddahaVC animated:YES];
                break;
            case 5:
            case 6:
                [self.myBuddahaVC  incenseBtnClick];
                [self.navigationController pushViewController:self.myBuddahaVC animated:YES];
                break;
            case 7:
                //-(void)cliffordClick{
                [self.myBuddahaVC cliffordClick];
                [self.navigationController pushViewController:self.myBuddahaVC animated:YES];
                break;
            case 8:
                [self.navigationController pushViewController:self.myBuddahaVC animated:YES];
                break;
            case 9:
            case 10:
                [self.navigationController pushViewController:self.myShuajiaVC animated:YES];
                break;
            case 11:
                [self.navigationController pushViewController:self.myMusicPlayerVc animated:YES];
                break;
            case 12:
                [self.navigationController pushViewController:self.myJingXinVC animated:YES];
                break;
            case 13:
                [self.navigationController pushViewController:self.fozhuVc animated:YES];
                break;
        }
    };
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArray.count;
}

-(void)backclick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark ----接口------
//详细内容
-(void)getHomeWorkInfo{
    
    [ProgressHUD showOnView:self.view];
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSNumber * miyaoNum=[appDelegate.accountBasicDict objectForKey:@"secretKey"];
    NSDictionary * dic = @{@"secretKey":miyaoNum,@"huaienID":huaien};
    NSDictionary * meditionDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,HomeWorkListURL] parameters:meditionDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id jsonMedition = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray  *modelArray = jsonMedition[@"data"];
        for(int i = 0 ; i < modelArray.count;i++)
        {
            NSDictionary *dict = modelArray[i];
            HomeWorkModel * homemodel = [[HomeWorkModel alloc] init];
            [homemodel setValuesForKeysWithDictionary:dict];
            [self.resultArray addObject:homemodel];
        }
        [self createTableView];
        [ProgressHUD hideAfterSuccessOnView:self.view];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
//完成情况
-(void)getCompletionInfo{
    
    [ProgressHUD showOnView:self.view];
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSNumber * miyaoNum=[appDelegate.accountBasicDict objectForKey:@"secretKey"];
    NSDictionary * dic = @{@"secretKey":miyaoNum,@"huaienID":huaien};
    NSDictionary * meditionDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,CompletionURL] parameters:meditionDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id jsonMedition = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"jsonMedition=%@",jsonMedition);
        HomeWorkModel * homemodel = [[HomeWorkModel alloc] init];
        _pageLabel.text=[NSString stringWithFormat:@"%ld",homemodel.achieveQty];
        
        [ProgressHUD hideAfterSuccessOnView:self.view];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
@end
