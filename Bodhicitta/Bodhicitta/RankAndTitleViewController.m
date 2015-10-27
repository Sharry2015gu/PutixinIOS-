//
//  RankAndTitleViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/9/10.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "RankAndTitleViewController.h"
#import "HeaderFile.h"
#import "NewsViewController.h"
#import "RESideMenu.h"
@interface RankAndTitleViewController (){

    UINavigationBar * bar;
}
@property(nonatomic,strong)UILabel * rankAndTitleLabel;
@property(nonatomic,strong)UILabel * problemeLabel;
@property(nonatomic,strong)UILabel * answerLabel;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * answerTitle;
@property(nonatomic,strong)UIImageView * rankImageView;
@end

@implementation RankAndTitleViewController
#pragma mark -----主页面----
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
    title.text=@"等级与称号";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [bar addSubview:title];
    
    [self createUI];
}
#pragma mark ----UI----
-(void)createUI{

    UIView * backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, bar.frame.origin.y+bar.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backGroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"putibj.jpg"]];
    [self.view addSubview:backGroundView];
    
    _rankAndTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, bar.frame.origin.y+25, SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.074)];
    _rankAndTitleLabel.text=@"等级与称号";
    _rankAndTitleLabel.textColor=[UIColor brownColor];
    _rankAndTitleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:22.f];
    [backGroundView addSubview:_rankAndTitleLabel];
    
    _problemeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_rankAndTitleLabel.frame.origin.x+20, _rankAndTitleLabel.frame.origin.y+50, SCREEN_WIDTH*0.7, SCREEN_WIDTH*0.075)];
    _problemeLabel.text=@"Q:用户目前最高可升到多少级?";
    _problemeLabel.textColor = [UIColor brownColor];
    _problemeLabel.font=[UIFont systemFontOfSize:18];
    [backGroundView addSubview:_problemeLabel];
    
    _answerLabel = [[UILabel alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, _problemeLabel.frame.origin.y+25, SCREEN_WIDTH*0.6, SCREEN_HEIGHT*0.075)];
    _answerLabel.text=@"A:目前用户最高等级100级";
    _answerLabel.font=[UIFont systemFontOfSize:16];
    _answerLabel.textColor=[UIColor lightGrayColor];
    [backGroundView addSubview:_answerLabel];
    
    UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _answerLabel.frame.origin.y+_answerLabel.frame.size.height+5, SCREEN_WIDTH, 0.5)];
    lineLabel.backgroundColor=[UIColor brownColor];
    lineLabel.alpha=0.5;
    [backGroundView addSubview:lineLabel];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, lineLabel.frame.origin.y, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.075)];
    _titleLabel.text=@"Q:如何获得称号?";
    _titleLabel.textColor=[UIColor brownColor];
    _titleLabel.font=[UIFont systemFontOfSize:18];
    [backGroundView addSubview:_titleLabel];
    
    _answerTitle = [[UILabel alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, _titleLabel.frame.origin.y+35, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.075)];
    _answerTitle.text=@"A:用户每提升10级就可以获得1个称号";
    _answerTitle.textColor=[UIColor lightGrayColor];
    _answerTitle.font=[UIFont systemFontOfSize:16];
    [backGroundView addSubview:_answerTitle];
    
    UILabel * disPlayLabel = [[UILabel alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, _answerTitle.frame.origin.y+30, SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.075)];
    disPlayLabel.text=@"称号名称如下：";
    disPlayLabel.textColor= [UIColor lightGrayColor];
    disPlayLabel.font=[UIFont systemFontOfSize:14];
    [backGroundView addSubview:disPlayLabel];
    
    _rankImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, disPlayLabel.frame.origin.y+disPlayLabel.frame.size.height, SCREEN_WIDTH*0.68, SCREEN_HEIGHT*0.32)];
    _rankImageView.image=[UIImage imageNamed:@"rankAndTitle"];
    [backGroundView addSubview:_rankImageView];
}
-(void)buclick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
