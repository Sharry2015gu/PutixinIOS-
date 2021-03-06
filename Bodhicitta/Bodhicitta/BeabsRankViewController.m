//
//  BeabsRankViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/19.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "BeabsRankViewController.h"
#import "RESideMenu.h"
#import "HeaderFile.h"
#import "ProgressHUD.h"
#import "BeadsRankViewCell.h"
#import "Beads_MyRankViewController.h"
#import "FoZhuViewController.h"
#import "RankingModel.h"

@interface BeabsRankViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableview;
@property(nonatomic,strong)UILabel * titleLable;
@property(nonatomic,strong)UIButton * backBtn;
@property(nonatomic,strong)UIButton * shareBtn;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)NSMutableArray * resultArray;
@property(nonatomic,strong)UILabel *levelLabel;
@property(nonatomic,strong)UILabel *valueLabel;

@end

@implementation BeabsRankViewController

-(NSMutableArray *)resultArray
{
    if (_resultArray == nil) {
        _resultArray = [[NSMutableArray alloc]init];
    }
    return _resultArray;
}
#pragma mark ----导航----
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
    title.text=@"念珠排行";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [bar addSubview:title];
    
    UIImageView * titleImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 50)];
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
    cishuLa.text=@"念珠总次数";
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
#pragma mark ----UI界面------
-(void)createTableView
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,NAVBARHEIGHT*0.1+110,SCREEN_WIDTH,SCREEN_HEIGHT - NAVBARHEIGHT-5+10)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"putibj.jpg"]];
    _tableview.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    
    
    CGFloat width;
    CGFloat height ;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        width = 215;
        height =  140;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            width = 180;
            height = 125;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            width = 240;
            height = 140;
        }
        else
        {
            width = 151;
            height  = 100;
        }
    }
    
    UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, width*0.97+SCREEN_HEIGHT*0.61, SCREEN_WIDTH, height*0.4)];
    imageView.image=[UIImage imageNamed:@"ranking_bottom_bg"];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTapped)];
    [imageView addGestureRecognizer:singleTap];//点击图片事件
    [self.view addSubview:imageView];
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(width*0.28, 15, 80, 20)];
    _nameLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"nickName"];
    _nameLabel.textColor=[UIColor redColor];
    _nameLabel.font=[UIFont systemFontOfSize:16];
    [imageView addSubview:_nameLabel];
    
    UILabel * pmLa=[[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.frame.size.width+_nameLabel.frame.origin.x-25, 15, 120, 20)];
    pmLa.text=@"您当前的排名 :";
    pmLa.textColor=[UIColor blackColor];
    pmLa.font=[UIFont systemFontOfSize:16];
    [imageView addSubview:pmLa];
    NSInteger userOrder = [[[NSUserDefaults standardUserDefaults] objectForKey:@"beadOrder"] integerValue];
    if (userOrder==0){
        self.levelLabel=[[UILabel alloc]initWithFrame:CGRectMake(pmLa.frame.size.width+pmLa.frame.origin.x-15, 15, 150, 20)];
        self.levelLabel.text=@"您还未进入排行";
    }else{
        self.levelLabel=[[UILabel alloc]initWithFrame:CGRectMake(pmLa.frame.size.width+pmLa.frame.origin.x-10, 15, 30, 20)];
        self.levelLabel.text=[NSString stringWithFormat:@"%ld",(long)userOrder];
        UILabel *mLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.levelLabel.frame.size.width+self.levelLabel.frame.origin.x, 15, 20, 20)];
        mLabel.textColor=[UIColor blackColor];
        mLabel.text=@"名";
        [imageView addSubview:mLabel];
    }
    
    
    self.levelLabel.textColor=[UIColor redColor];
    self.levelLabel.font=[UIFont systemFontOfSize:16];
    [imageView addSubview:self.levelLabel];

    
}

-(void)buclick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)photoTapped{
    
    Beads_MyRankViewController * myRank = [[Beads_MyRankViewController alloc]init];
    [myRank getBeadsRankInfo];
    [self.navigationController pushViewController:myRank animated:YES];
    
}

#pragma mark -----tabelview代理--------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankingModel *model = self.resultArray[indexPath.row];
    NSString *cellId = @"cellId";
    BeadsRankViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[BeadsRankViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------佛珠排行接口------
-(void)getBeadsRankInfo{
    
    [ProgressHUD showOnView:self.view];
    NSNumber * miyaoNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"secretKey"];
    NSNumber * huaien = [[NSUserDefaults standardUserDefaults] objectForKey:@"huaienID"];
    
    NSDictionary * dic = @{@"secretKey":miyaoNum,@"taskCode":@800};
    NSDictionary * rankingDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,MeditationRankURL] parameters:rankingDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"念珠nsfhiehf=%@",jsonData);
        
        NSArray * rankingArray = jsonData[@"data"];
        for (int i = 0; i < rankingArray.count; i++) {
            
            NSDictionary * arrdic = rankingArray[i];
            RankingModel * rank = [[RankingModel alloc]init];
            [rank setValuesForKeysWithDictionary:arrdic];
            rank.nickName = [NSString stringWithFormat:@"%@",arrdic[@"nickName"]];
            _nameLabel.text = rank.nickName;

            [self.resultArray addObject:rank];
        }
        
        NSDictionary * rdic = @{@"secretKey":miyaoNum,@"taskCode":@800,@"huaienID":huaien};
        NSDictionary * rankingDic = @{@"params":[NSString stringWithFormat:@"%@",rdic]};
        [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,BeadsRankURL] parameters:rankingDic success:^(NSURLSessionDataTask *task, id responseObject) {
            
            id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"念珠排名nsfhiehf=%@",jsonData);
            
            RankingModel * rank = [[RankingModel alloc]init];
            mcLa.text=[NSString stringWithFormat:@"%ld",rank.userOrder];
            _nameLabel.text=rank.nickName;
            [ProgressHUD hideAfterSuccessOnView:self.view];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
        [self createTableView];
        [ProgressHUD hideAfterSuccessOnView:self.view];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
//个人排行接口
-(void)getRankingInfo{
    
    [ProgressHUD showOnView:self.view];
    NSNumber * miyaoNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"secretKey"];
    NSNumber * huaien = [[NSUserDefaults standardUserDefaults] objectForKey:@"huaienID"];
    NSDictionary * dic = @{@"secretKey":miyaoNum,@"taskCode":@800,@"huaienID":huaien};
    NSDictionary * rankingDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,BeadsRankURL] parameters:rankingDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"念珠排名nsfhiehf=%@",jsonData);
        
        NSNumber *order =jsonData[@"userOrder"];
        [[NSUserDefaults standardUserDefaults]setObject:order forKey:@"beadOrder"];
        [ProgressHUD hideAfterSuccessOnView:self.view];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}
@end
