//
//  PeiHangViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/23.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "PeiHangViewController.h"
#import "ZhuYeMianViewController.h"
#import "HeaderFile.h"
#import "RankingViewCell.h"
#import "ProgressHUD.h"
#import "Meditation_MyRankViewController.h"

@interface PeiHangViewController ()

@property(nonatomic,strong)NSMutableArray * resultArray;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel *levelLabel;
@property(nonatomic,strong)UILabel *valueLabel;

@end

@implementation PeiHangViewController

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
    
    UINavigationBar * bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    [bar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:bar];
    
    UIButton * bu=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [bu setBackgroundImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(buclick) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:bu];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"修禅排行";
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
    [self loadAllRead];
}
-(void)createTableView
{
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,NAVBARHEIGHT*0.1+110,SCREEN_WIDTH,SCREEN_HEIGHT *0.77)];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"putibj.jpg"]];
    tableview.showsVerticalScrollIndicator=NO;
    tableview.showsHorizontalScrollIndicator=NO;
    tableview.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    //刷新
    WS(weakself);
    [tableview addHeaderWithCallback:^{
        
            }];
    [tableview addFooterWithCallback:^{
        
    }];

    
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
    _nameLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    _nameLabel.textColor=[UIColor redColor];
    _nameLabel.font=[UIFont systemFontOfSize:16];
    [imageView addSubview:_nameLabel];
    
    UILabel * pmLa=[[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.frame.size.width+_nameLabel.frame.origin.x-25, 15, 120, 20)];
    pmLa.text=@"您当前的排名 :";
    pmLa.textColor=[UIColor blackColor];
    pmLa.font=[UIFont systemFontOfSize:16];
    [imageView addSubview:pmLa];
    NSInteger userOrder = [[[NSUserDefaults standardUserDefaults] objectForKey:@"meditationOrder"] integerValue];
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

#pragma mark ---按钮事件---
-(void)buclick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)photoTapped{
    
    Meditation_MyRankViewController * myRank = [[Meditation_MyRankViewController alloc]init];
    [myRank getMeditionRankInfo];
    [self.navigationController pushViewController:myRank animated:YES];
    
}

#pragma mark ---tableView代理方法---
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
     [tableview headerEndRefreshing];
     [tableview  footerEndRefreshing];
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
            rank.nickName = [NSString stringWithFormat:@"%@",arrdic[@"nickName"]];
            _nameLabel.text = rank.nickName;
            
            [self.resultArray addObject:rank];
        }
        [self createTableView];
        [ProgressHUD hideAfterSuccessOnView:self.view];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}
- (void)loadAllRead
{
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * miyaoNum = [appDelegate.accountBasicDict objectForKey:@"secretKey"];
    NSNumber *huaien=[appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSDictionary * dic = @{@"secretKey":miyaoNum,@"huaienID":huaien,@"taskCode":@700};
    NSDictionary * rankingDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,ptxGetUserTaskOrderByUserID] parameters:rankingDic success:^(NSURLSessionDataTask *task, id responseObject) {
        id  jsonData =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"修禅总排行=%@",jsonData);
        NSNumber *order =jsonData[@"userOrder"];
        [[NSUserDefaults standardUserDefaults]setObject:order forKey:@"meditationOrder"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

@end
