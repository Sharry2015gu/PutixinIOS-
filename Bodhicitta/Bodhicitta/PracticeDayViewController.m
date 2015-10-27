//
//  PracticeDayViewController.m
//  Bodhicitta
//
//  Created by 怀恩11 on 15/10/10.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "PracticeDayViewController.h"
#import "HeaderFile.h"
#import "PracticeModel.h"
#import "PraticeViewCell.h"
@interface PracticeDayViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger  currentPage;
}
//@property(nonatomic,strong)NSMutableArray * resultArray;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UITableView * tableview;
@property(nonatomic,strong)UIImageView * titleImage;
@property(nonatomic,strong)UIView * bgview;
@property(nonatomic,strong)PracticeModel * model;
//这里的刷新是要取到当前排行所在的页数
//当前排行的数据 每次是20 如果最后一页不满20 就是剩下的
@property(nonatomic,strong)NSMutableArray * currentRankArray;
@end
@implementation PracticeDayViewController

#pragma mark ---自定义 主页面UI---
-(NSMutableArray *)resultArray
{
    if (_resultArray == nil) {
        _resultArray = [[NSMutableArray alloc]init];
    }
    return _resultArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDayInfo];
    //    [self getPracticeRankInfo];
    UINavigationBar * bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.1)];
    [bar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:bar];
    
    UIButton * bu=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [bu setBackgroundImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(buclick) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:bu];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"我的排行";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [bar addSubview:title];
    
    _bgview=[[UIView alloc]initWithFrame:CGRectMake(0, bar.frame.origin.y+bar.frame.size.height, SCREEN_WIDTH, self.view.frame.size.height)];
    _bgview.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"putibj.jpg"]];
    [self.view addSubview:_bgview];
    
}
-(void)createTableView
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.showsHorizontalScrollIndicator=NO;
    _tableview.showsVerticalScrollIndicator=NO;
    _tableview.separatorStyle=UITableViewCellEditingStyleNone;
    [_bgview addSubview:_tableview];
    
    //    WS(weakself);
    //    [_tableview addHeaderWithCallback:^{
    //        [weakself getDayInfo];
    //    }];
    //    [_tableview addFooterWithCallback:^{
    //        [weakself getDayInfo];
    //    }];
    
    
}
#pragma mark -----日积分和日个人排行接口---
-(void)getDayInfo{
    [self.resultArray removeAllObjects];
    [ProgressHUD showOnView:self.view];
    NSNumber * miyaoNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"secretKey"];
    NSDictionary * dic = @{@"secretKey":miyaoNum,@"orderType":@"D"};
    NSDictionary * rankingDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,GetIntegralOrder] parameters:rankingDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"日修行排行=%@",jsonData);
        
        NSArray * rankingArray = jsonData[@"data"];
        for (int i = 0; i < rankingArray.count; i++) {
            
            NSDictionary * arrdic = rankingArray[i];
            _model = [[PracticeModel alloc]init];
            [_model setValuesForKeysWithDictionary:arrdic];
            [self.resultArray addObject:_model];
        }
        if (self.resultArray.count>3){
            [self.resultArray removeObjectsInRange:NSMakeRange(0, 3)];
        }
        else{
            [self.resultArray removeObjectsInRange:NSMakeRange(0, self.resultArray.count)];
        }
        [self createTableView];
        [ProgressHUD hideAfterSuccessOnView:self.view];
        [_tableview reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
#pragma mark ---按钮事件---
-(void)buclick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---tableView代理方法---
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PracticeModel *model = self.resultArray[indexPath.row];
    NSString *cellId = @"cellId";
    PraticeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[PraticeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // cell.delegate = self;
    }
    //    [self.tableview headerEndRefreshing];
    //    [self.tableview  footerEndRefreshing];
    [cell setPracticeModel:model IndexPath:indexPath];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArray.count;
}

@end
