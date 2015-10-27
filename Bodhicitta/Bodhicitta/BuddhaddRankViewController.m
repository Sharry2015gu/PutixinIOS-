//
//  BuddhaddRankViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/10/15.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "BuddhaddRankViewController.h"
#import "HeaderFile.h"
#import "TempleImage.h"
#import "Buddhadd_MyRankViewController.h"
#import "BuddhaLevel.h"
#import "TopThreeViewCell.h"
#import "CheckBuddhaHallLevel.h"
#import "MyBuddhaLevelCell.h"
@interface BuddhaddRankViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger  buddhaPage;
}

@property(nonatomic,strong)UILabel * leverLabel;
@property(nonatomic,strong)UILabel * gardLabel;
@property(nonatomic,strong)UILabel * rankLabel;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)TempleImage *templeModel;
@property(nonatomic,strong)NSMutableArray *levelArray;
@property(nonatomic,strong)UIImageView *titleImage;
@property(nonatomic,strong)UIImageView *conterImageView;
@property(nonatomic,strong)UIImageView * homeImageView;
@property(nonatomic,strong)BuddhaLevel *levelModel;
@property(nonatomic,strong)NSMutableArray *nickNameArray;
@property(nonatomic,strong)NSMutableArray *valueArray;
@property(nonatomic,strong)NSMutableArray *rankArray;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong) UITableView *buddhaTableView;
@end

@implementation BuddhaddRankViewController
//自定义
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
-(NSMutableArray *)valueArray
{
    if (_valueArray == nil) {
        _valueArray = [[NSMutableArray alloc]init];
    }
    return _valueArray;
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
    buddhaPage=1;
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
    
    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.homeImageView.frame.origin.y+self.homeImageView.frame.size.height, SCREEN_WIDTH, height+SCREEN_HEIGHT*0.48)];
    //背景图放在表格上
    imageview.image=[UIImage imageNamed:@"temple_rank_middle_bg.jpg"];
    [self.view addSubview:imageview];
    
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(width*0.12,self.homeImageView.frame.size.height+self.homeImageView.frame.origin.y, width+width*0.4, height*0.3)];
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
    
    self.conterImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, imageview.frame.origin.y+imageview.frame.size.height, SCREEN_WIDTH, height*0.32)];
    self.conterImageView.image=[UIImage imageNamed:@"temple_rank_middle_bottom_bg.jpg"];
    [self.view addSubview: self.conterImageView];
    
    UIImageView * buttomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,  self.conterImageView.frame.origin.y+ self.conterImageView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    buttomImageView.userInteractionEnabled=YES;
    buttomImageView.image=[UIImage imageNamed:@"temple_rank_bottom_bg.jpg"];
    [self.view addSubview:buttomImageView];
    
    UIImageView * ownImageView = [[UIImageView alloc]initWithFrame:CGRectMake(width*0.05, height*0.05, width+width*0.54, height*0.4)];
    ownImageView.image=[UIImage imageNamed:@"temple_rank_myself_bg.jpg"];
    ownImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(phoneTapClick)];
    [ownImageView addGestureRecognizer:tap];
    [buttomImageView addSubview:ownImageView];
    
    _rankLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 15, 50, 20)];
    
    _rankLabel.textColor=buddhaddBottomColor;
    _rankLabel.font=[UIFont systemFontOfSize:font];
    [buttomImageView addSubview:_rankLabel];
    
    _leverLabel = [[UILabel alloc]initWithFrame:CGRectMake(_rankLabel.frame.origin.x+_rankLabel.frame.size.width+width*0.15, _rankLabel.frame.origin.y, 50, 20)];
    
    _leverLabel.textColor=buddhaddBottomColor;
    _leverLabel.font=[UIFont systemFontOfSize:font];
    [buttomImageView addSubview:_leverLabel];
    
    _gardLabel = [[UILabel alloc]initWithFrame:CGRectMake(_leverLabel.frame.origin.x+_leverLabel.frame.size.width+width*0.15, _rankLabel.frame.origin.y, 50, 20)];
    
    _gardLabel.textColor=buddhaddBottomColor;
    _gardLabel.font=[UIFont systemFontOfSize:font];
    [buttomImageView addSubview:_gardLabel];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_gardLabel.frame.origin.x+_gardLabel.frame.size.width+width*0.15, _rankLabel.frame.origin.y, width*0.5, 20)];
    
    _nameLabel.textColor=buddhaddBottomColor;
    _nameLabel.font=[UIFont systemFontOfSize:font];
    [buttomImageView addSubview:_nameLabel];
    [self loadBuddhaLevelIsRefresh:YES];
    [self loadTempleData];
    
}


#pragma mark ---tableView代理方法---
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row<3){
        return 60;
    }else{
        return 30;
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuddhaLevel *model = self.levelArray[indexPath.row];
    NSString *cellId1 = @"cellId1";
    NSString *cellId2 =  @"cellId2";
    if (indexPath.row < 3) {
        TopThreeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        if (cell == nil) {
            cell = [[TopThreeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setBuddhaModel:model IndexPath:indexPath];
        return cell;
    }
    else
    {
        MyBuddhaLevelCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId2];
        if (cell==nil){
            cell=[[MyBuddhaLevelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId2];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        [cell setBuddhaModel:model IndexPath:indexPath];
        return cell;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%ld------",self.levelArray.count);
    return self.levelArray.count;
}


//按钮事件
-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)phoneTapClick{
    
    
    Buddhadd_MyRankViewController * myrank = [[Buddhadd_MyRankViewController alloc]initWithModel:self.templeModel];
    [self.navigationController pushViewController:myrank animated:YES];
    
}
#pragma mark ----佛堂排行
-(void)loadBuddhaLevelIsRefresh:(BOOL)isfresh{
    NSInteger page;
    if (isfresh){
        buddhaPage=1;
    }else{
        buddhaPage++;
    }
    page=buddhaPage;
    
    [ProgressHUD showOnView:self.view];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber *miyao=[appDelegate.accountBasicDict objectForKey:@"secretKey"];
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary * dic = @{@"secretKey":miyao,@"taskCode":self.templeModel.taskCode,@"pageIndex":[NSNumber numberWithInteger:page]};
    NSDictionary * budDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,ptxGetTempleOrder] parameters:budDic success:^(NSURLSessionDataTask *task, id responseObject)
     {
         id  jsonData=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSArray  * dataArray = jsonData[@"data"];
         NSLog(@"--------%ld--------",dataArray.count);
         if (page==0)
         {
             [self.levelArray removeAllObjects];
         }
         //判断数据加载完全了
         
         //          else {
         //             UILabel *label = [[UILabel alloc]init];
         //             label.frame = CGRectMake(SCREEN_WIDTH *0.3, SCREEN_HEIGHT*0.9,SCREEN_WIDTH*0.4, 30);
         //             label.alpha=0.5;
         //             //@"签到成功,获得祈福币%@",jsonData[@"prayMoney"]
         //             label.text =@"没有更多数据了!";
         //             label.textColor = [UIColor whiteColor];
         //             label.textAlignment = 1;
         //             label.backgroundColor = [UIColor blackColor];
         //             label.font = [UIFont boldSystemFontOfSize:12];
         //             [self.view addSubview:label];
         //             [UIView animateWithDuration:1.5 animations:^{
         //                 label.alpha = 0;
         //             } completion:^(BOOL finished) {
         //                 [label removeFromSuperview];
         //             }];
         //         }
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
#pragma mark ---私人佛堂接口-----
//佛堂
-(void)loadTempleData
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@%@",__kBaseURLString,ptxGetTempleIntegralOrderByID];
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSNumber *miyao=[appDelegate.accountBasicDict objectForKey:@"secretKey"];
    NSDictionary  *paramter = @{@"secretKey":miyao,@"huaienID":huaien,@"taskCode":self.templeModel.taskCode};
    NSDictionary  *dict = @{@"params":[NSString stringWithFormat:@"%@",paramter]};
    [appDelegate.sessionManager POST: url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"私人佛堂排名=%@",jsonData);
        NSNumber  *valueNum=jsonData[@"templeIntegral"];
        NSInteger value=[valueNum integerValue];
        CheckBuddhaHallLevel *levelManager = [CheckBuddhaHallLevel   shareCheckBuddhaHallLevel];
        NSInteger   levelInteger = [levelManager checkBuddhaHallLevelWithValue:value];
        self.gardLabel.text=[NSString stringWithFormat:@"%ld级",levelInteger];
        
        self.rankLabel.text=[NSString stringWithFormat:@"%@",jsonData[@"userOrder"]];
        
        //        self.leverLabel.text=jsonData[@"templeIntegral"];
        self.leverLabel.text=[NSString stringWithFormat:@"%@",jsonData[@"templeIntegral"]];
        if(jsonData[@"nickName"])
        {
            self.nameLabel.text=[NSString stringWithFormat:@"%@",huaien];
        }else{
            self.nameLabel.text=[NSString stringWithFormat:@"%@",jsonData[@"nickName"]];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

@end
