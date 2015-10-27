//
//  NewsViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/9/9.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "NewsViewController.h"
#import "HeaderFile.h"
#import "RESideMenu.h"
#import "RankAndTitleViewController.h"
#import "PracticeValueViewController.h"
#import "PrayerMoneyViewController.h"
@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    UINavigationBar * bar;
}
@property(nonatomic,strong)UITableView * tableview;
@property(nonatomic,strong)NSArray * arrlist;
@end

@implementation NewsViewController

#pragma mark ---主页面---
- (void)viewDidLoad {
    [super viewDidLoad];
    
    bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.1)];
    [bar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:bar];
    
    UIButton * bu=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [bu setBackgroundImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(buclick) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:bu];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"帮助中心";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [bar addSubview:title];

    UIView * backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, bar.frame.origin.y+bar.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backGroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"putibj.jpg"]];
    [self.view addSubview:backGroundView];
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.35)];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.scrollEnabled=NO;
    _tableview.backgroundColor=[UIColor clearColor];
    [backGroundView addSubview:_tableview];
}
#pragma mark ---按钮事件---
-(void)buclick{
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.sideMenuViewController setContentViewController:delegate.mainVc
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
}

#pragma mark ---tableview代理----
//设置tableView的组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
    
    
}
//设置组数里面各行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger senction = indexPath.section;
    if(senction ==0){
        return 50.0;
    }
    if(senction ==1){
        return 50.0;
    }
    if (senction ==2) {
        return 50.0;
    }
    
    return 100.0;
}

//设置组数里面各行的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section) {
        return _arrlist.count == 0 ? 1 :_arrlist.count;
    }
    else
        return _arrlist.count + 1;
}

//tableView 的代理
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    
    static NSString *mycell = @"ViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mycell];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if(section==0){
        if(cell == nil){
            
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        
        UIImageView * bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        bgImageView.image=[UIImage imageNamed:@"putibj.jpg"];
        [cell addSubview:bgImageView];
        
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, 0, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.075)];
        titleLabel.text=@"等级与称号";
        titleLabel.font=[UIFont systemFontOfSize:18];
        titleLabel.textColor=[UIColor brownColor];
        [bgImageView addSubview:titleLabel];
        
        UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, bgImageView.frame.origin.y+bgImageView.frame.size.height, SCREEN_WIDTH, 0.5)];
        lineLabel.backgroundColor=[UIColor brownColor];
        lineLabel.alpha=0.5;
        [cell addSubview:lineLabel];
        
        UIImageView * im=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.9, 17, SCREEN_WIDTH*0.05, SCREEN_WIDTH*0.05)];
        im.image=[UIImage imageNamed:@"箭头图标"];
        [bgImageView addSubview:im];

    }
    if(section==1){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        UIImageView * bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        bgImageView.image=[UIImage imageNamed:@"putibj.jpg"];
        [cell addSubview:bgImageView];
        
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, 0, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.075)];
        titleLabel.text=@"修行值";
        titleLabel.font=[UIFont systemFontOfSize:18];
        titleLabel.textColor=[UIColor brownColor];
        [bgImageView addSubview:titleLabel];
        
        UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, bgImageView.frame.origin.y+bgImageView.frame.size.height, SCREEN_WIDTH, 0.5)];
        lineLabel.backgroundColor=[UIColor brownColor];
        lineLabel.alpha=0.5;
        [cell addSubview:lineLabel];
        
        UIImageView * im=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.9, 17, SCREEN_WIDTH*0.05, SCREEN_WIDTH*0.05)];
        im.image=[UIImage imageNamed:@"箭头图标"];
        [bgImageView addSubview:im];

    }
    
    if(section==2){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        
        UIImageView * bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        bgImageView.image=[UIImage imageNamed:@"putibj.jpg"];
        [cell addSubview:bgImageView];
        
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, 0, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.075)];
        titleLabel.text=@"祈福币";
        titleLabel.font=[UIFont systemFontOfSize:18];
        titleLabel.textColor=[UIColor brownColor];
        [bgImageView addSubview:titleLabel];
        
        UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, bgImageView.frame.origin.y+bgImageView.frame.size.height, SCREEN_WIDTH, 0.5)];
        lineLabel.backgroundColor=[UIColor brownColor];
        lineLabel.alpha=0.5;
        [cell addSubview:lineLabel];
        
        UIImageView * im=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.9, 17, SCREEN_WIDTH*0.05, SCREEN_WIDTH*0.05)];
        im.image=[UIImage imageNamed:@"箭头图标"];
        [bgImageView addSubview:im];

    }
   
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    NSInteger senction = indexPath.section;
    if(senction == 0){
        
        RankAndTitleViewController * rank = [[RankAndTitleViewController alloc]init];
        [self.navigationController pushViewController:rank animated:YES];
    }
    else
        if(senction == 1){
            PracticeValueViewController * pra = [[PracticeValueViewController alloc]init];
            [self.navigationController pushViewController:pra animated:YES];
        }
        else if (senction == 2){
        
            PrayerMoneyViewController * pray = [[PrayerMoneyViewController alloc]init];
            [self.navigationController pushViewController:pray animated:YES];
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
