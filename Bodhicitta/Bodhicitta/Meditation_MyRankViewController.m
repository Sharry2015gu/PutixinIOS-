//
//  Meditation_MyRankViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/26.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "Meditation_MyRankViewController.h"
#import "HeaderFile.h"
#import "RankingViewCell.h"
#import "DuJingViewController.h"
#import "ProgressHUD.h"

@interface Meditation_MyRankViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableview;
@property(nonatomic,strong)NSMutableArray * resultArray;

@end

@implementation Meditation_MyRankViewController

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
    title.text=@"我的排行";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [bar addSubview:title];
    
    UIImageView * titleImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 70, 380, 50)];
    titleImage.image=[UIImage imageNamed:@"ranking_top_bg.jpg"];
    [self.view addSubview:titleImage];
    
    CGFloat width;
    CGFloat height ;
    CGFloat font;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        width = 215;
        height =  140;
        font = 16;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            width = 180;
            height = 125;
            font = 14;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            width = 280;
            height = 120;
            font = 18;
        }
        else
        {
            width = 151;
            height  = 100;
            font = 14;
        }
    }
    
    UILabel * nameLa=[[UILabel alloc]initWithFrame:CGRectMake(width*0.1, height*0.05, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.075)];
    nameLa.text=@"用户昵称";
    nameLa.font=[UIFont systemFontOfSize:font-1];
    nameLa.textColor=RankingListColor;
    [titleImage addSubview:nameLa];
    
    UILabel * cishuLa=[[UILabel alloc]initWithFrame:CGRectMake(nameLa.frame.origin.x+nameLa.frame.size.width+30, nameLa.frame.origin.y, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.075)];
    cishuLa.text=@"修禅时间";
    cishuLa.font=[UIFont systemFontOfSize:font-1];
    cishuLa.textColor=RankingListColor;
    [titleImage addSubview:cishuLa];
    
    UILabel * paimingLa=[[UILabel alloc]initWithFrame:CGRectMake(cishuLa.frame.origin.x+cishuLa.frame.size.width+30, nameLa.frame.origin.y, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.075)];
    paimingLa.text=@"排名";
    paimingLa.font=[UIFont systemFontOfSize:font-1];
    paimingLa.textColor=RankingListColor;
    [titleImage addSubview:paimingLa];
    
    UIView * bgview=[[UIView alloc]initWithFrame:CGRectMake(0, titleImage.frame.origin.y+titleImage.frame.size.height, SCREEN_WIDTH, self.view.frame.size.height)];
    bgview.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"putibj.jpg"]];
    [self.view addSubview:bgview];
}

-(void)createTableView
{
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,NAVBARHEIGHT*0.1+110,SCREEN_WIDTH,SCREEN_HEIGHT *0.9)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"putibj.jpg"]];
    self.tableview.showsHorizontalScrollIndicator=NO;
    self.tableview.showsVerticalScrollIndicator=NO;
    self.tableview.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    //刷新
    WS(weakself);
    [self.tableview addHeaderWithCallback:^{
        
    }];
    [self.tableview addFooterWithCallback:^{
        
    }];

    
}
#pragma mark ---tableview代理方法-----
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankingModel *model = self.resultArray[indexPath.row];
    NSString *cellId = @"cellId";
    RankingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[RankingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // cell.delegate = self;
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

#pragma mark ----总排行接口-----
-(void)getMeditionRankInfo{
    
    [ProgressHUD showOnView:self.view];
    NSNumber * miyaoNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"secretKey"];
    NSDictionary * dic = @{@"secretKey":miyaoNum,@"taskCode":@700};
    NSDictionary * rankingDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,MeditationRankURL] parameters:rankingDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"修禅总排行=%@",jsonData);
        
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
