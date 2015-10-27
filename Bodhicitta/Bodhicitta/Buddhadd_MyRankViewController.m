//
//  Buddhadd_MyRankViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/10/15.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "Buddhadd_MyRankViewController.h"
#import "HeaderFile.h"
#import "BuddhaHallView.h"
#import "MyBuddhaHallViewController.h"
#include "BuddhaLevel.h"
#import "MyBuddhaLevelCell.h"

@interface Buddhadd_MyRankViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger  buddhaPage;
}
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UIImageView *titleImage;
@property(nonatomic,strong)UIImageView *homeImageView;
@property(nonatomic,strong)UIImageView *conterImageView;
@property(nonatomic,strong)NSMutableArray *levelArray;
@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong) UITableView *buddhaTableView;
@end

@implementation Buddhadd_MyRankViewController

-(instancetype)initWithModel:(TempleImage* )model
{
    if (self = [super init]) {
        self.templeModel = model;
    }
    return self;
}
- (UITableView*)buddhaTableView
{
    if (_buddhaTableView==nil){
        _buddhaTableView =[[UITableView alloc]initWithFrame:CGRectMake(27, self.titleImage.frame.origin.y+self.titleImage.frame.size.height, SCREEN_WIDTH-54, self.conterImageView.frame.origin.y-self.titleImage.frame.origin.y-self.conterImageView.frame.size.height)];
        _buddhaTableView.backgroundColor=[UIColor clearColor];
        _buddhaTableView.delegate = self;
        _buddhaTableView.dataSource = self;
        
        _buddhaTableView.showsHorizontalScrollIndicator=NO;
        _buddhaTableView.showsVerticalScrollIndicator=NO;
        _buddhaTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        WS(weakSelf);
        [_buddhaTableView  addHeaderWithCallback:^{
            //头部刷新 前20个
            [weakSelf loadBuddhaLevelIsRefresh:YES];
            
        }];
        [_buddhaTableView addFooterWithCallback:^{
            //尾部刷新 下20个
            [weakSelf loadBuddhaLevelIsRefresh:NO];
        }];
    }
    return _buddhaTableView;
}

-(NSMutableArray *)levelArray
{
    if (_levelArray == nil) {
        _levelArray = [[NSMutableArray alloc]init];
    }
    return _levelArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    buddhaPage = 1 ;
    self.view.backgroundColor=[UIColor whiteColor];
    CGFloat width;
    CGFloat height ;
    CGFloat font ;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        width = 230;
        height =  100;
        font  = 16;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            width = 180;
            height = 95;
            font = 14;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            width = 230;
            height = 100;
            font = 16;
        }
        else
        {
            width = 180;
            height  = 100;
            font = 14;
        }
    }
    
    self.homeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height+height*0.4)];
    self.homeImageView.image=[UIImage imageNamed:@"temple_rank_top_bg.jpg"];
    self.homeImageView.userInteractionEnabled=YES;
    [self.view addSubview:self.homeImageView];
    
    UIButton * back = [[UIButton alloc]initWithFrame:CGRectMake(width*0.09, height*0.35, width*0.15, height*0.3)];
    [back setBackgroundImage:[UIImage imageNamed:@"返回上级"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.homeImageView addSubview:back];
    
    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(width*0.35, height*0.45, SCREEN_WIDTH*0.5, height*0.1)];
    
    _titleLabel.text=self.templeModel.taskName;
    
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor=[UIColor clearColor];
    _titleLabel.font=[UIFont systemFontOfSize:font];
    [self.homeImageView addSubview:_titleLabel];
    
    self.bgImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, self.homeImageView.frame.origin.y+self.homeImageView.frame.size.height, SCREEN_WIDTH, height+SCREEN_HEIGHT*0.48)];
    //背景图放在表格上
    //self.bgImageView.backgroundColor=[UIColor redColor];
    self.bgImageView.image=[UIImage imageNamed:@"temple_rank_middle_bg.jpg"];
    [self.view addSubview:self.bgImageView];
    
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(width*0.12,self.homeImageView.frame.size.height+self.homeImageView.frame.origin.y, width+width*0.4, height*0.3)];
    //self.titleImage=[[UIImageView alloc]initWithFrame:CGRectMake(width*0.12, 0, width+width*0.4, height*0.4)];
    self.titleImage.image=[UIImage imageNamed:@"temple_rank_middle_top_bg.jpg"];
    [self.view addSubview: self.titleImage];
    
    UILabel * rankLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 10, 50, 20)];
    rankLabel.text=@"排行";
    rankLabel.textColor=BuddhaddTitleColor;
    rankLabel.font=[UIFont systemFontOfSize:font];
    [self.titleImage addSubview:rankLabel];
    
    UILabel * leverLabel = [[UILabel alloc]initWithFrame:CGRectMake(rankLabel.frame.origin.x+rankLabel.frame.size.width+width*0.1, rankLabel.frame.origin.y, 50, 20)];
    leverLabel.text=@"积分";
    leverLabel.textColor=BuddhaddTitleColor;
    leverLabel.font=[UIFont systemFontOfSize:font];
    [self.titleImage addSubview:leverLabel];
    
    UILabel * gatdLabel = [[UILabel alloc]initWithFrame:CGRectMake(leverLabel.frame.origin.x+leverLabel.frame.size.width+width*0.1, rankLabel.frame.origin.y, 50, 20)];
    gatdLabel.text=@"等级";
    gatdLabel.textColor=BuddhaddTitleColor;
    gatdLabel.font=[UIFont systemFontOfSize:font];
    [self.titleImage addSubview:gatdLabel];
    
    UILabel * dedicatedLabel = [[UILabel alloc]initWithFrame:CGRectMake(gatdLabel.frame.origin.x+gatdLabel.frame.size.width+width*0.1, rankLabel.frame.origin.y, 80, 20)];
    dedicatedLabel.text=@"贡奉者";
    dedicatedLabel.textColor=BuddhaddTitleColor;
    dedicatedLabel.font=[UIFont systemFontOfSize:font];
    [self.titleImage addSubview:dedicatedLabel];
    
    self.conterImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.bgImageView.frame.origin.y+self.bgImageView.frame.size.height, SCREEN_WIDTH, height*0.32)];
    self.conterImageView.image=[UIImage imageNamed:@"temple_rank_middle_bottom_bg.jpg"];
    [self.view addSubview: self.conterImageView];
    
    UIImageView * buttomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,  self.conterImageView.frame.origin.y+ self.conterImageView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    buttomImageView.userInteractionEnabled=YES;
    buttomImageView.image=[UIImage imageNamed:@"temple_rank_bottom_bg.jpg"];
    [self.view addSubview:buttomImageView];
    [self loadBuddhaLevelIsRefresh:YES];
}


#pragma mark ---tableView代理方法---
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuddhaLevel *model = self.levelArray[indexPath.row];
    
    NSString *cellId = @"cellId";
    MyBuddhaLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[MyBuddhaLevelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    [cell setBuddhaModel:model IndexPath:indexPath];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.levelArray.count;;
}
//按钮事件
-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark-佛像排行

#pragma mark ----佛堂排行
-(void)loadBuddhaLevelIsRefresh:(BOOL)isfresh{
    NSInteger page;
    if (isfresh){
        buddhaPage=1;
    }else{
        buddhaPage++;
    }
    page=buddhaPage;
    NSLog(@"页数＝%ld",page);
    [ProgressHUD showOnView:self.view];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber *miyao=[appDelegate.accountBasicDict objectForKey:@"secretKey"];
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary * dic = @{@"secretKey":miyao,@"taskCode":self.templeModel.taskCode,@"pageIndex":[NSNumber numberWithInteger:page]};
    NSDictionary * budDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,ptxGetTempleOrder] parameters:budDic success:^(NSURLSessionDataTask *task, id responseObject)
     {
         id  jsonData=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"佛堂＝%@",jsonData);
         if (page==0)
         {
             [self.levelArray removeAllObjects];
             
         }else  if(page==self.levelArray.count/20){
             UILabel *label = [[UILabel alloc]init];
             label.frame = CGRectMake(SCREEN_WIDTH *0.3, SCREEN_HEIGHT*0.8,SCREEN_WIDTH*0.4, 30);
             label.alpha=0.5;
             //@"签到成功,获得祈福币%@",jsonData[@"prayMoney"]
             label.text =@"没有更多数据了!";
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
         NSArray *buddaArray=jsonData[@"data"];
         for (int i=0;i<buddaArray.count;i++){
             NSDictionary *dict=buddaArray[i];
             BuddhaLevel *model=[[BuddhaLevel alloc]init];
             [model setValuesForKeysWithDictionary:dict];
             [self.levelArray addObject:model];
         }
         
         
         if (_buddhaTableView == nil) {
             [self.view addSubview:self.buddhaTableView];
         }
         else
         {
             
             [self.buddhaTableView reloadData];
             [_buddhaTableView headerEndRefreshing];
             [_buddhaTableView footerEndRefreshing];
         }
         [ProgressHUD hideAfterSuccessOnView:self.view];
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         
     }];
    
}
@end
