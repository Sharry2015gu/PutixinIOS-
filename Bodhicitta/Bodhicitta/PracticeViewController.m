
//  PracticeViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/9/7.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "PracticeViewController.h"
#import "HeaderFile.h"
#import "PraticeViewCell.h"
#import "PracticeModel.h"
#import "Practice_MyRankViewController.h"
#import "PracticeDayViewController.h"
#import "PracticeMonthViewController.h"
#import "PracticeWeekViewController.h"

@interface PracticeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UILabel *myLevelLabel;
    NSString *twoNameStr;
    NSString *oneNameStr;
    NSString *threeNameStr;
    NSString *twoLevelStr;
    NSString *oneLevelStr;
    NSString *threeLevelStr;
    NSInteger currentPage;
}
@property(nonatomic,strong)NSMutableArray * resultArray;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * contentLabel2;
@property(nonatomic,strong)UITableView * tableview;
@property(nonatomic,strong)UIImageView * titleImage;
@property(nonatomic,strong)UIImageView * bgImage;
@property(nonatomic,strong)PracticeModel * model;
@property(nonatomic,strong)UIButton * dayBtn;
@property(nonatomic,strong)UIButton * monthBtn;
@property(nonatomic,strong)UIButton * totalBtn;
@property(nonatomic,strong)UIButton * weekBtn;
@property(nonatomic,strong)UILabel *dayBtnLabel;
@property(nonatomic,strong)UILabel *weekBtnLabel;
@property(nonatomic,strong)UILabel *monthBtnLabel;
@property(nonatomic,strong)UILabel *totalBtnLabel;
@property(nonatomic,strong)UILabel * listName;
@property(nonatomic,strong)UIButton * listView;
@property(nonatomic,strong)UIImageView * oneBgImageView;
@property(nonatomic,strong)UIImageView * twoBgImageView;
@property(nonatomic,strong)UIImageView * threeBgImageView;
@property(nonatomic,strong)UIImageView * oneImageView;
@property(nonatomic,strong)UIImageView * twoImageView;
@property(nonatomic,strong)UIImageView * threeImageView;
@property(nonatomic,strong)UILabel * oneLabel;
@property(nonatomic,strong)UILabel * twoLabel;
@property(nonatomic,strong)UILabel * threeLabel;
@property(nonatomic,strong)UILabel * oneName;
@property(nonatomic,strong)UILabel * twoName;
@property(nonatomic,strong)UILabel * threeName;
@property(nonatomic,strong)UILabel * oneLevelabel;
@property(nonatomic,strong)UILabel * twoLevelLabel;
@property(nonatomic,strong)UILabel * threeLevelLabel;
@property(nonatomic,strong)UILabel * oneValueLabel;
@property(nonatomic,strong)UILabel * twoValueLabel;
@property(nonatomic,strong)UILabel * threeValueLabel;
@property(nonatomic,strong)UIButton *typeBtn;
@property(nonatomic,strong)NSMutableDictionary * userDic;
@property(nonatomic,strong)UILabel *levelLabel;
@property(nonatomic,strong)UILabel *pmLa;
@property(nonatomic,strong)UIImageView *bottomImageView;
@property(nonatomic,strong)UILabel *dayLabel;
@property(nonatomic,strong)UILabel *weekLabel;
@property(nonatomic,strong)UILabel *monthLabel;
@property(nonatomic,strong)UILabel *totalLabel;
//当前排行的数据 每次是20 如果最后一页不满20 就是剩下的
@property(nonatomic,strong)NSMutableArray * currentRankArray;

@end

@implementation PracticeViewController


#pragma mark ---自定义 主页面UI---
-(NSMutableArray *) currentRankArray
{
    if (_currentRankArray ==  nil) {
        _currentRankArray = [[NSMutableArray  alloc]init];
    }
    return _currentRankArray;
}
-(NSMutableArray *)resultArray
{
    if (_resultArray == nil) {
        _resultArray = [[NSMutableArray alloc]init];
    }
    return _resultArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"putibj.jpg"]];
    [self getDayInfo];
    //    [self getPracticeRankInfo];
    
    CGFloat width;
    CGFloat height ;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        width = 205;
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
            width = 190;
            height = 127;
        }
        else
        {
            width = 175;
            height  = 120;
        }
    }
    
    
    _bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height+SCREEN_HEIGHT*0.24)];
    _bgImage.image=[UIImage imageNamed:@"practice_rank_list_bg@2x.png"];
    _bgImage.userInteractionEnabled=YES;
    [self.view addSubview:_bgImage];
    
    UIImageView * bu=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.06*SCREEN_WIDTH, 0.06*SCREEN_WIDTH)];
    bu.image=[UIImage imageNamed:@"返回上级.png"];
    bu.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buclick)];
    [bu addGestureRecognizer:tap];
    [_bgImage addSubview:bu];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"修行排行";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [_bgImage addSubview:title];
    
    [self createBar];
    
}
#pragma mark ---按钮事件---
-(void)buclick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createBar{
    CGFloat width;
    CGFloat height ;
    CGFloat font;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        width = 255;
        height =  140;
        font = 16;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            width = 220;
            height = 125;
            font = 15;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            width = 290;
            height = 127;
            font = 18;
        }
        else
        {
            width = 215;
            height  = 120;
            font = 14;
        }
    }
    
    _dayBtn = [[UIButton alloc]initWithFrame:CGRectMake(width*0.13, height*0.5, width*0.3, height*0.26)];
    [_dayBtn setTitle:@"日排行" forState:UIControlStateNormal];
    [_dayBtn setBackgroundImage:[UIImage imageNamed:@"day_rank_bt_click_bg"] forState:UIControlStateNormal];
    _dayBtn.titleLabel.font=[UIFont systemFontOfSize:font-2];
    [_dayBtn addTarget:self action:@selector(dayClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgImage addSubview:_dayBtn];
    
    _weekBtn = [[UIButton alloc]initWithFrame:CGRectMake(_dayBtn.frame.origin.x+_dayBtn.frame.size.width+1, _dayBtn.frame.origin.y, width*0.3, height*0.26)];
    [_weekBtn setTitle:@"周排行" forState:UIControlStateNormal];
    [_weekBtn setBackgroundImage:[UIImage imageNamed:@"week_rank_bt_no_click"] forState:UIControlStateNormal];
    _weekBtn.titleLabel.font=[UIFont systemFontOfSize:font-2];
    [_weekBtn setTitleColor:[UIColor colorWithRed:217.0f/255.0f green:163.0f/255.0f blue:34.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_weekBtn addTarget:self action:@selector(weekClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgImage addSubview:_weekBtn];
    
    _monthBtn = [[UIButton alloc]initWithFrame:CGRectMake(_weekBtn.frame.origin.x+_weekBtn.frame.size.width+1, _dayBtn.frame.origin.y, width*0.3, height*0.26)];
    [_monthBtn setTitle:@"月排行" forState:UIControlStateNormal];
    [_monthBtn setBackgroundImage:[UIImage imageNamed:@"week_rank_bt_no_click"] forState:UIControlStateNormal];
    _monthBtn.titleLabel.font=[UIFont systemFontOfSize:font-2];
    [_monthBtn setTitleColor:[UIColor colorWithRed:217.0f/255.0f green:163.0f/255.0f blue:34.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_monthBtn addTarget:self action:@selector(monthClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgImage addSubview:_monthBtn];
    
    _totalBtn = [[UIButton alloc]initWithFrame:CGRectMake(_monthBtn.frame.origin.x+_monthBtn.frame.size.width+1, _dayBtn.frame.origin.y, width*0.3, height*0.26)];
    [_totalBtn setTitle:@"总排行" forState:UIControlStateNormal];
    [_totalBtn setBackgroundImage:[UIImage imageNamed:@"total_rank_bt_no_click"] forState:UIControlStateNormal];
    [_totalBtn addTarget:self action:@selector(totalClick) forControlEvents:UIControlEventTouchUpInside];
    _totalBtn.titleLabel.font=[UIFont systemFontOfSize:font-2];
    [_totalBtn setTitleColor:[UIColor colorWithRed:217.0f/255.0f green:163.0f/255.0f blue:34.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_bgImage addSubview:_totalBtn];
    
    _twoBgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(_dayBtn.frame.origin.x-5, _dayBtn.frame.origin.y+_dayBtn.frame.size.height+5, (SCREEN_WIDTH-80)/3, (SCREEN_WIDTH-80)/3)];
    _twoBgImageView.image=[UIImage imageNamed:@"second_third_head_bg.png"];
    self.twoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 20, _twoBgImageView.frame.size.width-40, _twoBgImageView.frame.size.height-40)];
    self.twoImageView.image=[UIImage imageNamed:@"默认头像.png"];
    
    [_twoBgImageView addSubview:self.twoImageView];
    [self.view addSubview:_twoBgImageView];
    //2等级
    _twoLabel=[[UILabel alloc]initWithFrame:CGRectMake(_twoBgImageView.frame.origin.x, _twoBgImageView.frame.size.height+_twoBgImageView.frame.origin.y, _twoBgImageView.frame.size.width, 20)];
    _twoLabel.text=@"2";
    _twoLabel.textColor=[UIColor whiteColor];
    _twoLabel.font=[UIFont systemFontOfSize:16];
    _twoLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_twoLabel];
    //接口获得数据，假的数据
    
    twoNameStr=@"蓝顶下欧";
    CGSize maxSize = CGSizeMake(MAXFLOAT,MAXFLOAT);
    CGFloat  twoNameStrWidth =[twoNameStr sizeWithFont:[UIFont systemFontOfSize:15] maxSize:maxSize].width;
    _twoName=[[UILabel alloc]initWithFrame:CGRectMake(_twoLabel.frame.origin.x, _twoLabel.frame.origin.y+_twoLabel.frame.size.height+1.5, twoNameStrWidth, 20)];
    
    //
    self.twoName.text=twoNameStr;
    
    _twoName.textColor = [UIColor whiteColor];
    
    _twoName.font = [UIFont systemFontOfSize:15];
    [self.view addSubview: _twoName];
    //等级
    twoLevelStr=@"Lv100";
    CGFloat levelStrWidth =[twoLevelStr sizeWithFont:[UIFont systemFontOfSize:10] maxSize:maxSize].width;
    _twoLevelLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_twoName.frame)+3, _twoName.frame.origin.y+3, levelStrWidth, 15)];
    myLevelLabel=self.twoLevelLabel;
    myLevelLabel.font=[UIFont systemFontOfSize:9];
    _twoLevelLabel.text=twoLevelStr;
    self.twoLevelLabel.textColor=[UIColor whiteColor];
    self.twoLevelLabel.backgroundColor=[UIColor colorWithPatternImage:[self OriginImage:[UIImage imageNamed:@"LV背景"] scaleToSize:CGSizeMake(levelStrWidth, 15)]];
    CALayer *levelLabelLayer =self.twoLevelLabel.layer;
    levelLabelLayer.cornerRadius=3;
    levelLabelLayer.masksToBounds=YES;
    [self.view addSubview:self.twoLevelLabel];
    self.twoLevelLabel.text=twoLevelStr;
    
    //修行值
    UILabel *valueHintLabel =[[UILabel alloc]initWithFrame:CGRectMake(_twoLabel.frame.origin.x, _twoName.frame.origin.y+_twoLabel.frame.size.height+2, 50, 20)];
    valueHintLabel.text=@"修行值";
    
    valueHintLabel.font=[UIFont systemFontOfSize:14];
    valueHintLabel.textColor=[UIColor brownColor];
    
    [self.view addSubview:valueHintLabel];
    self.twoValueLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(valueHintLabel.frame), valueHintLabel.frame.origin.y+3, myLevelLabel.frame.size.width+20, 14)];
    self.twoValueLabel.textColor=[UIColor brownColor];
    
    self.twoValueLabel.textAlignment=NSTextAlignmentLeft;
    self.twoValueLabel.font=[UIFont systemFontOfSize:15];
    myLevelLabel =self.twoValueLabel;
    [self.view addSubview:self.twoValueLabel];
    //1等级
    _oneBgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(_weekBtn.frame.origin.x+30, _weekBtn.frame.origin.y+_weekBtn.frame.size.height+5, (SCREEN_WIDTH-80)/3, (SCREEN_WIDTH-80)/3)];
    _oneBgImageView.image=[UIImage imageNamed:@"first_first_head_bg.png"];
    //怎么让图片是圆形的
    self.oneImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 20, _oneBgImageView.frame.size.width-40, _oneBgImageView.frame.size.height-40)];
    self.oneImageView.image=[UIImage imageNamed:@"默认头像.png"];
    
    [_oneBgImageView addSubview:self.oneImageView];
    
    [self.view addSubview:_oneBgImageView];
    _oneLabel=[[UILabel alloc]initWithFrame:CGRectMake(_oneBgImageView.frame.origin.x, _oneBgImageView.frame.size.height+_oneBgImageView.frame.origin.y, _twoBgImageView.frame.size.width, 20)];
    _oneLabel.text=@"1";
    _oneLabel.textColor=[UIColor whiteColor];
    _oneLabel.font=[UIFont systemFontOfSize:16];
    _oneLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_oneLabel];
    //接口获得数据，假的数据
    oneNameStr=@"蓝顶下欧";
    CGFloat  oneNameStrWidth =[oneNameStr sizeWithFont:[UIFont systemFontOfSize:15] maxSize:maxSize].width;
    _oneName=[[UILabel alloc]initWithFrame:CGRectMake(_oneLabel.frame.origin.x, _oneLabel.frame.origin.y+_oneLabel.frame.size.height+1.5, oneNameStrWidth, 20)];
    
    // _twoName.backgroundColor=[UIColor redColor];
    self.oneName.text=oneNameStr;
    _oneName.textColor = [UIColor whiteColor];
    _oneName.font = [UIFont systemFontOfSize:15];
    [self.view addSubview: _oneName];
    //等级
    oneLevelStr=@"Lv112";
    CGFloat levelStrWidth2 =[oneLevelStr sizeWithFont:[UIFont systemFontOfSize:10] maxSize:maxSize].width;
    _oneLevelabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_oneName.frame)+3, _oneName.frame.origin.y+3, levelStrWidth2, 15)];
    myLevelLabel=self.oneLevelabel;
    myLevelLabel.font=[UIFont systemFontOfSize:9];
    _oneLevelabel.text=oneLevelStr;
    self.oneLevelabel.textColor=[UIColor whiteColor];
    self.oneLevelabel.backgroundColor=[UIColor colorWithPatternImage:[self OriginImage:[UIImage imageNamed:@"LV背景"] scaleToSize:CGSizeMake(levelStrWidth2, 15)]];
    CALayer *levelLabelLayer2 =self.oneLevelabel.layer;
    levelLabelLayer2.cornerRadius=3;
    levelLabelLayer2.masksToBounds=YES;
    [self.view addSubview:self.oneLevelabel];
    _oneLevelabel.text=oneLevelStr;
    //修行值
    UILabel *valueHintLabel2 =[[UILabel alloc]initWithFrame:CGRectMake(self.oneName.frame.origin.x, self.oneName.frame.origin.y+self.oneName.frame.size.height+2, self.oneName.frame.size.width, 20)];
    valueHintLabel2.text=@"修行值";
    valueHintLabel2.font=[UIFont systemFontOfSize:14];
    valueHintLabel2.textColor=[UIColor brownColor];
    
    [self.view addSubview:valueHintLabel2];
    self.oneValueLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(valueHintLabel2.frame), valueHintLabel2.frame.origin.y+3, myLevelLabel.frame.size.width+5, 15)];
    self.oneValueLabel.textColor=[UIColor brownColor];
    self.oneValueLabel.text=@"323";
    self.oneValueLabel.textAlignment=NSTextAlignmentLeft;
    self.oneValueLabel.font=[UIFont systemFontOfSize:14];
    myLevelLabel =self.oneValueLabel;
    [self.view addSubview:self.oneValueLabel];
    
    //3
    _threeBgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(_monthBtn.frame.origin.x+60, _monthBtn.frame.origin.y+_monthBtn.frame.size.height+5, (SCREEN_WIDTH-80)/3, (SCREEN_WIDTH-80)/3)];
    _threeBgImageView.image=[UIImage imageNamed:@"second_third_head_bg.png"];
    
    self.threeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 20, _threeBgImageView.frame.size.width-40, _threeBgImageView.frame.size.height-40)];
    self.threeImageView.image=[UIImage imageNamed:@"默认头像.png"];
    
    [_threeBgImageView addSubview:self.threeImageView];
    [self.view addSubview:_threeBgImageView];
    
    _threeLabel=[[UILabel alloc]initWithFrame:CGRectMake(_threeBgImageView.frame.origin.x, _threeBgImageView.frame.size.height+_twoBgImageView.frame.origin.y, _threeBgImageView.frame.size.width, 20)];
    _threeLabel.text=@"3";
    _threeLabel.textColor=[UIColor whiteColor];
    _threeLabel.font=[UIFont systemFontOfSize:16];
    _threeLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_threeLabel];
    //接口获得数据，假的数据
    threeNameStr=@"蓝顶下欧";
    CGFloat  threeNameStrWidth =[threeNameStr sizeWithFont:[UIFont systemFontOfSize:15] maxSize:maxSize].width;
    _threeName=[[UILabel alloc]initWithFrame:CGRectMake(_threeLabel.frame.origin.x, _threeLabel.frame.origin.y+_threeLabel.frame.size.height+1.5, threeNameStrWidth, 20)];
    
    self.threeName.text=threeNameStr;
    _threeName.textColor = [UIColor whiteColor];
    
    _threeName.font = [UIFont systemFontOfSize:15];
    [self.view addSubview: _threeName];
    //等级
    threeLevelStr=@"Lv133";
    CGFloat levelStrWidth3 =[threeLevelStr sizeWithFont:[UIFont systemFontOfSize:10] maxSize:maxSize].width;
    _threeLevelLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_threeName.frame)+2, _threeName.frame.origin.y+3, levelStrWidth3+5, 15)];
    myLevelLabel=self.threeLevelLabel;
    myLevelLabel.font=[UIFont systemFontOfSize:10];
    _threeLevelLabel.text=threeLevelStr;
    
    self.threeLevelLabel.textColor=[UIColor whiteColor];
    self.threeLevelLabel.backgroundColor=[UIColor colorWithPatternImage:[self OriginImage:[UIImage imageNamed:@"LV背景"] scaleToSize:CGSizeMake(levelStrWidth3+5, 15)]];
    CALayer *levelLabelLayer3 =self.threeLevelLabel.layer;
    levelLabelLayer3.cornerRadius=3;
    levelLabelLayer3.masksToBounds=YES;
    [self.view addSubview:self.threeLevelLabel];
    _threeLevelLabel.text=threeLevelStr;
    //修行值
    UILabel *valueHintLabel3 =[[UILabel alloc]initWithFrame:CGRectMake(self.threeName.frame.origin.x, self.threeName.frame.origin.y+self.threeName.frame.size.height+2, self.threeName.frame.size.width, 20)];
    valueHintLabel3.text=@"修行值";
    valueHintLabel3.font=[UIFont systemFontOfSize:14];
    valueHintLabel3.textColor=[UIColor brownColor];
    
    [self.view addSubview:valueHintLabel3];
    self.threeValueLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(valueHintLabel3.frame), valueHintLabel3.frame.origin.y+3, myLevelLabel.frame.size.width+10, 14)];
    self.threeValueLabel.textColor=[UIColor brownColor];
    self.threeValueLabel.text=@"1252";
    self.threeValueLabel.textAlignment=NSTextAlignmentLeft;
    self.threeValueLabel.font=[UIFont systemFontOfSize:15];
    myLevelLabel =self.threeValueLabel;
    [self.view addSubview:self.threeValueLabel];
    
}

#pragma  mark 日周月总排行
- (void)dayClick
{
    [_dayBtn setBackgroundImage:[UIImage imageNamed:@"day_rank_bt_click_bg"] forState:UIControlStateNormal];
    [_dayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_weekBtn setBackgroundImage:[UIImage imageNamed:@"week_rank_bt_no_click"] forState:UIControlStateNormal];
    [_weekBtn setTitleColor:[UIColor colorWithRed:217.0f/255.0f green:163.0f/255.0f blue:34.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_monthBtn setBackgroundImage:[UIImage imageNamed:@"week_rank_bt_no_click"] forState:UIControlStateNormal];
    [_monthBtn setTitleColor:[UIColor colorWithRed:217.0f/255.0f green:163.0f/255.0f blue:34.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_totalBtn setBackgroundImage:[UIImage imageNamed:@"total_rank_bt_no_click"] forState:UIControlStateNormal];
    [_totalBtn setTitleColor:[UIColor colorWithRed:217.0f/255.0f green:163.0f/255.0f blue:34.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [self.resultArray removeAllObjects];
    [self getDayInfo];
}
- (void)weekClick
{
    [_weekBtn setBackgroundImage:[UIImage imageNamed:@"week_rank_bt_click"] forState:UIControlStateNormal];
    [_weekBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_dayBtn setBackgroundImage:[UIImage imageNamed:@"day_rank_bt_no_click_bg"] forState:UIControlStateNormal];
    [_dayBtn setTitleColor:[UIColor colorWithRed:217.0f/255.0f green:163.0f/255.0f blue:34.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_monthBtn setBackgroundImage:[UIImage imageNamed:@"week_rank_bt_no_click"] forState:UIControlStateNormal];
    [_monthBtn setTitleColor:[UIColor colorWithRed:217.0f/255.0f green:163.0f/255.0f blue:34.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_totalBtn setBackgroundImage:[UIImage imageNamed:@"total_rank_bt_no_click"] forState:UIControlStateNormal];
    [_totalBtn setTitleColor:[UIColor colorWithRed:217.0f/255.0f green:163.0f/255.0f blue:34.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [self.resultArray removeAllObjects];
    [self getWeekInfo];
}
- (void)monthClick
{
    
    [_monthBtn  setBackgroundImage:[UIImage imageNamed:@"week_rank_bt_click"] forState:UIControlStateNormal];
    [_monthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_dayBtn setBackgroundImage:[UIImage imageNamed:@"day_rank_bt_no_click_bg"] forState:UIControlStateNormal];
    [_dayBtn setTitleColor:[UIColor colorWithRed:217.0f/255.0f green:163.0f/255.0f blue:34.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_weekBtn setBackgroundImage:[UIImage imageNamed:@"week_rank_bt_no_click"] forState:UIControlStateNormal];
    [_weekBtn setTitleColor:[UIColor colorWithRed:217.0f/255.0f green:163.0f/255.0f blue:34.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_totalBtn setBackgroundImage:[UIImage imageNamed:@"total_rank_bt_no_click"] forState:UIControlStateNormal];
    [_totalBtn setTitleColor:[UIColor colorWithRed:217.0f/255.0f green:163.0f/255.0f blue:34.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [self.resultArray removeAllObjects];
    [self getMonthInfo];
    
}
-(void)totalClick
{
    
    [_totalBtn setBackgroundImage:[UIImage imageNamed:@"total_rank_bt_click"] forState:UIControlStateNormal];
    [_totalBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_weekBtn setBackgroundImage:[UIImage imageNamed:@"week_rank_bt_no_click"] forState:UIControlStateNormal];
    [_weekBtn setTitleColor:[UIColor colorWithRed:217.0f/255.0f green:163.0f/255.0f blue:34.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_dayBtn setBackgroundImage:[UIImage imageNamed:@"day_rank_bt_no_click_bg"] forState:UIControlStateNormal];
    [_dayBtn setTitleColor:[UIColor colorWithRed:217.0f/255.0f green:163.0f/255.0f blue:34.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_monthBtn setBackgroundImage:[UIImage imageNamed:@"week_rank_bt_no_click"] forState:UIControlStateNormal];
    [_monthBtn setTitleColor:[UIColor colorWithRed:217.0f/255.0f green:163.0f/255.0f blue:34.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [self.resultArray removeAllObjects];
    [self getTotalInfo];
    
}

#pragma mark ----TableView主页面
-(void)createTableView
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,_bgImage.frame.origin.y+_bgImage.frame.size.height,SCREEN_WIDTH,SCREEN_HEIGHT *0.47)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor =[UIColor clearColor];
    _tableview.showsHorizontalScrollIndicator=NO;
    _tableview.showsVerticalScrollIndicator=NO;
    WS(weakSelf);
    //[_tableview  addHeaderWithCallback:^{
    //头部刷新 前20个
    
    //}];
    [_tableview addFooterWithCallback:^{
        //尾部刷新 下20个
        [weakSelf footTableViewRefresh];
    }];
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
            height = 145;
        }
        else
        {
            width = 151;
            height  = 100;
        }
    }
    
    self.bottomImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, width*0.97+SCREEN_HEIGHT*0.61, SCREEN_WIDTH, height*0.4)];
    self.bottomImageView.image=[UIImage imageNamed:@"ranking_bottom_bg"];
    [self.view addSubview: self.bottomImageView];
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(width*0.15, 15, 80, 20)];
    AppDelegate *delegate =(AppDelegate*)[UIApplication sharedApplication].delegate ;
    self.userDic=delegate.accountBasicDict;
    _nameLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    _nameLabel.textColor=[UIColor redColor];
    _nameLabel.font=[UIFont systemFontOfSize:16];
    [self.bottomImageView addSubview:_nameLabel];
    self.pmLa=[[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.frame.size.width+_nameLabel.frame.origin.x, 15, 120, 20)];
    self.pmLa.text=@"您当前的排名 :";
    self.pmLa.textColor=[UIColor blackColor];
    self.pmLa.font=[UIFont systemFontOfSize:16];
    [self.bottomImageView addSubview:self.pmLa];
}
#pragma mark  头部刷新currentArray取前20个

#pragma mark  尾部添20个 然后reload TableView
-(void)footTableViewRefresh
{
    NSInteger  allInteger = self.resultArray.count;
    
    NSInteger  currentInteger = self.currentRankArray.count;
    if (allInteger == currentInteger) {
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(SCREEN_WIDTH *0.35, SCREEN_HEIGHT*0.8,SCREEN_WIDTH*0.3, 30);
        //@"签到成功,获得祈福币%@",jsonData[@"prayMoney"]
        label.text =@"没有更多了!" ;
        label.alpha=0.5;
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
    else
    {
        if ((allInteger - currentPage) <= 20) {
            for(int i = (int)currentInteger ; i < allInteger; i++)
            {
                [self.currentRankArray addObject:self.resultArray[i]];
            }
        }
        else
        {
            for(int i = (int)currentInteger ; i < 20 +  currentInteger; i++)
            {
                [self.currentRankArray addObject:self.resultArray[i]];
            }
        }
    }
    [self.tableview reloadData];
    [self.tableview footerEndRefreshing];
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
        
    }
    
    [cell setPracticeModel:model IndexPath:indexPath];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArray.count;
}
#pragma mark -----日积分和日个人排行接口---
-(void)getDayInfo{
    [ProgressHUD showOnView:self.view];
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * miyaoNum = [appDelegate.accountBasicDict objectForKey:@"secretKey"];
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSDictionary * dic = @{@"secretKey":miyaoNum,@"orderType":@"D"};
    NSDictionary * rankingDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,GetIntegralOrder] parameters:rankingDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"日修行排行=%@",jsonData);
        [_tableview removeFromSuperview];
        NSArray * rankingArray = jsonData[@"data"];
        NSMutableArray *integralArray =[[NSMutableArray alloc]init];
        NSMutableArray *nickNameArray=[[NSMutableArray alloc]init];
        NSMutableArray *levelArray=[[NSMutableArray alloc]init];
        NSMutableArray *headImageArray=[[NSMutableArray alloc]init];
        NSMutableArray *huaienIDArray =[[NSMutableArray alloc]init];
        for (int i = 0; i < rankingArray.count; i++) {
            NSDictionary * arrdic = rankingArray[i];
            NSNumber *integral=arrdic[@"integral"];
            [integralArray addObject:integral];
            NSString *nickName =arrdic[@"nickName"];
            [nickNameArray addObject:nickName];
            NSNumber *leve=arrdic[@"userLevel"];
            [levelArray addObject:leve];
            NSNumber *huaienid =arrdic[@"huaienID"];
            [huaienIDArray addObject:huaienid];
            NSString *headImage =arrdic[@"headImg"];
            [headImageArray addObject:headImage];
            
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
        if (huaienIDArray.count<1){
            self.oneName.text=@"";
            self.oneImageView.image=[UIImage imageNamed:@"默认头像.png"];
            self.oneValueLabel.text=@"";
            self.oneLevelabel.text=@"";
            self.twoName.text=@"";
            self.threeName.text=@"";
            self.twoImageView.image=[UIImage imageNamed:@"默认头像.png"];
            self.threeImageView.image=[UIImage imageNamed:@"默认头像.png"];
            self.twoLevelLabel.text=@"";
            self.threeLevelLabel.text=@"";
            self.twoValueLabel.text=@"";
            self.threeValueLabel.text=@"";
        }else if (huaienIDArray.count==1){
            self.twoName.text=@"";
            self.threeName.text=@"";
            self.twoLevelLabel.text=@"";
            self.threeLevelLabel.text=@"";
            self.twoValueLabel.text=@"";
            self.threeValueLabel.text=@"";
            //1
            for (int i=0;i<nickNameArray.count;i++){
                if([nickNameArray[0] isEqualToString:@""]){
                    oneNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[0]];
                    self.oneName.text=oneNameStr;
                    
                    
                }else{
                    oneNameStr =[NSString stringWithFormat:@"%@",nickNameArray[0]];
                    self.oneName.text=oneNameStr;
                    
                    
                }
                
            }
            for (int i=0;i<headImageArray.count;i++)
            {
                if ([headImageArray[0] hasPrefix:@"http"]){
                    CALayer  *layerHeadImageViewLayer = self.oneImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.oneImageView.frame.size.height * 0.5;
                    [self.oneImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[0]]]];
                    
                }else{
                    self.oneImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
            }
            oneLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[0]];
            self.oneLevelabel.text=oneLevelStr;
            self.oneValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[0]];
            
        }else if (huaienIDArray.count==2){
            self.threeName.text=@"";
            self.threeLevelLabel.text=@"";
            self.threeValueLabel.text=@"";
            //2
            for (int i=0;i<nickNameArray.count;i++){
                if([nickNameArray[1] isEqualToString:@""]){
                    twoNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[1]];
                    self.twoName.text=twoNameStr;
                    
                }else{
                    twoNameStr =[NSString stringWithFormat:@"%@",nickNameArray[1]];
                    self.twoName.text=twoNameStr;
                    
                }
                if([nickNameArray[0] isEqualToString:@""]){
                    oneNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[0]];
                    self.oneName.text=oneNameStr;
                }else{
                    oneNameStr =[NSString stringWithFormat:@"%@",nickNameArray[0]];
                    self.oneName.text=oneNameStr;
                    
                }
                
                
            }
            for (int i=0;i<headImageArray.count;i++)
            {
                if ([headImageArray[1] hasPrefix:@"http"]){
                    CALayer  *layerHeadImageViewLayer = self.twoImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.twoImageView.frame.size.height * 0.5;
                    [self.twoImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[1]]]];
                }else{
                    self.twoImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
                if ([headImageArray[0] hasPrefix:@"http"]
                    ){
                    CALayer  *layerHeadImageViewLayer = self.oneImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.oneImageView.frame.size.height * 0.5;
                    [self.oneImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[0]]]];
                    
                }else{
                    self.oneImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
            }
            
            twoLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[1]];
            
            self.twoLevelLabel.text=twoLevelStr;
            self.twoValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[1]];
            oneLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[0]];
            self.oneLevelabel.text=oneLevelStr;
            self.oneValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[0]];
            
            
        }else{
            //2
            for (int i=0;i<nickNameArray.count;i++){
                if([nickNameArray[1] isEqualToString:@""]){
                    twoNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[1]];
                    self.twoName.text=twoNameStr;
                }else{
                    twoNameStr =[NSString stringWithFormat:@"%@",nickNameArray[1]];
                    self.twoName.text=twoNameStr;
                    
                }
                if([nickNameArray[0] isEqualToString:@""]){
                    oneNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[0]];
                    self.oneName.text=oneNameStr;
                }else{
                    oneNameStr =[NSString stringWithFormat:@"%@",nickNameArray[0]];
                    self.oneName.text=oneNameStr;
                    
                }
                if([nickNameArray[2] isEqualToString:@""]){
                    threeNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[2]];
                    self.threeName.text=threeNameStr;
                }else{
                    threeNameStr =[NSString stringWithFormat:@"%@",nickNameArray[2]];
                    self.threeName.text=threeNameStr;
                    
                }
                
                
            }
            for (int i=0;i<headImageArray.count;i++)
            {
                if ([headImageArray[1] hasPrefix:@"http"]){
                    CALayer  *layerHeadImageViewLayer = self.twoImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.twoImageView.frame.size.height * 0.5;
                    [self.twoImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[1]]]];
                }else{
                    self.twoImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
                if ([headImageArray[0] hasPrefix:@"http"]
                    ){
                    CALayer  *layerHeadImageViewLayer = self.oneImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.oneImageView.frame.size.height * 0.5;
                    [self.oneImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[0]]]];
                    
                }else{
                    self.oneImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
                if ([headImageArray[2] hasPrefix:@"http"]
                    ){
                    CALayer  *layerHeadImageViewLayer = self.threeImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.threeImageView.frame.size.height * 0.5;
                    [self.threeImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[2]]]];
                    
                }else{
                    self.threeImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
            }
            
            twoLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[1]];
            
            self.twoLevelLabel.text=twoLevelStr;
            self.twoValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[1]];
            oneLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[0]];
            self.oneLevelabel.text=oneLevelStr;
            self.oneValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[0]];
            threeLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[2]];
            self.threeLevelLabel.text=threeLevelStr;
            self.threeValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[2]];
            
        }
        NSDictionary * oraderdic = @{@"secretKey":miyaoNum,@"huaienID":huaien,@"orderType":@"D"};
        NSDictionary * oraderDic = @{@"params":[NSString stringWithFormat:@"%@",oraderdic]};
        
        [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,GetIntegralOrderByID] parameters:oraderDic success:^(NSURLSessionDataTask *task, id responseObject) {
            
            id jsonOrder = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"修行个人排行=%@",jsonOrder);
            NSNumber *result=jsonOrder[@"result"];
            [[NSUserDefaults standardUserDefaults]setObject:result forKey:@"dayResult"];
            NSLog(@"结果＝%@",result);
            
            
            self.dayLabel.textColor=[UIColor redColor];
            if ([result integerValue]<0){
                self.dayLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.pmLa.frame.size.width+self.pmLa.frame.origin.x-10, 15, 150, 20)];
                self.dayLabel.text=@"您还未进入排行";
                
                
            }else
            {
                NSNumber *order =jsonOrder[@"userOrder"];
                [[NSUserDefaults standardUserDefaults]setObject:order forKey:@"dayUserOrder"];
                NSInteger userOrder = [[[NSUserDefaults standardUserDefaults] objectForKey:@"dayUserOrder"] integerValue];
                self.dayLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.pmLa.frame.size.width+self.pmLa.frame.origin.x-15, 15, 30, 20)];
                self.dayLabel.text=[NSString stringWithFormat:@"%ld",(long)userOrder];
                UILabel *mLabel=[[UILabel alloc]initWithFrame:CGRectMake( self.dayLabel.frame.size.width+ self.dayLabel.frame.origin.x, 15, 20, 20)];
                mLabel.textColor=[UIColor blackColor];
                mLabel.text=@"名";
                [self.bottomImageView addSubview:mLabel];
            }
            self.dayLabel.textColor=[UIColor redColor];
            [self.bottomImageView addSubview: self.dayLabel];
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedDay)];
            
            [self.bottomImageView addGestureRecognizer:singleTap];//点击图片事件
            self.bottomImageView.userInteractionEnabled=YES;
            [self.view addSubview:self.bottomImageView];
            
            [self createTableView];
            [ProgressHUD hideAfterSuccessOnView:self.view];
            [_tableview reloadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
- (void)photoTappedDay
{
    
    NSNumber *dayResult=[[NSUserDefaults standardUserDefaults]objectForKey:@"dayResult"];
    if ([dayResult integerValue]<0){
        
    }else{
        PracticeDayViewController *dayVC =[[PracticeDayViewController alloc]init];
        [self.navigationController pushViewController:dayVC animated:YES];
    }
    
}
#pragma mark -----周积分和周个人排行接口---
-(void)getWeekInfo{
    
    [ProgressHUD showOnView:self.view];
    
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * miyaoNum = [appDelegate.accountBasicDict objectForKey:@"secretKey"];
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSDictionary * dic = @{@"secretKey":miyaoNum,@"orderType":@"W"};
    NSDictionary * rankingDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,GetIntegralOrder] parameters:rankingDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"日修行排行=%@",jsonData);
        NSMutableArray *integralArray =[[NSMutableArray alloc]init];
        NSMutableArray *nickNameArray=[[NSMutableArray alloc]init];
        NSMutableArray *levelArray=[[NSMutableArray alloc]init];
        NSMutableArray *headImageArray=[[NSMutableArray alloc]init];
        NSMutableArray *huaienIDArray =[[NSMutableArray alloc]init];
        [_tableview removeFromSuperview];
        NSArray * rankingArray = jsonData[@"data"];
        for (int i = 0; i < rankingArray.count; i++) {
            NSDictionary * arrdic = rankingArray[i];
            NSLog(@"日字典＝%@",arrdic);
            NSNumber *huaienID =arrdic[@"huaienID"];
            [[NSUserDefaults standardUserDefaults]setObject:huaienID forKey:@"huaienID"];
            NSNumber *integral=arrdic[@"integral"];
            [integralArray addObject:integral];
            NSLog(@"排行＝%@",integral);
            NSString *nickName =arrdic[@"nickName"];
            [nickNameArray addObject:nickName];
            NSNumber *leve=arrdic[@"userLevel"];
            [levelArray addObject:leve];
            NSNumber *huaienid =arrdic[@"huaienID"];
            [huaienIDArray addObject:huaienid];
            NSString *headImage =arrdic[@"headImg"];
            [headImageArray addObject:headImage];
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
        if (huaienIDArray.count<1){
            self.oneName.text=@"";
            self.oneImageView.image=[UIImage imageNamed:@"默认头像.png"];
            self.oneValueLabel.text=@"";
            self.oneLevelabel.text=@"";
            self.twoName.text=@"";
            self.threeName.text=@"";
            self.twoImageView.image=[UIImage imageNamed:@"默认头像.png"];
            self.threeImageView.image=[UIImage imageNamed:@"默认头像.png"];
            self.twoLevelLabel.text=@"";
            self.threeLevelLabel.text=@"";
            self.twoValueLabel.text=@"";
            self.threeValueLabel.text=@"";
            
        }else if (huaienIDArray.count==1){
            self.twoName.text=@"";
            self.threeName.text=@"";
            self.twoImageView.image=[UIImage imageNamed:@""];
            self.threeImageView.image=[UIImage imageNamed:@""];
            self.twoLevelLabel.text=@"";
            self.threeLevelLabel.text=@"";
            self.twoValueLabel.text=@"";
            self.threeValueLabel.text=@"";
            //1
            for (int i=0;i<nickNameArray.count;i++){
                if([nickNameArray[0] isEqualToString:@""]){
                    oneNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[0]];
                    self.oneName.text=oneNameStr;
                    
                    
                }else{
                    oneNameStr =[NSString stringWithFormat:@"%@",nickNameArray[0]];
                    self.oneName.text=oneNameStr;
                    
                    
                }
                
            }
            for (int i=0;i<headImageArray.count;i++)
            {
                if ([headImageArray[0] hasPrefix:@"http"]){
                    CALayer  *layerHeadImageViewLayer = self.oneImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.oneImageView.frame.size.height * 0.5;
                    [self.oneImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[0]]]];
                    
                }else{
                    self.oneImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
            }
            oneLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[0]];
            self.oneLevelabel.text=oneLevelStr;
            self.oneValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[0]];
            
        }else if (huaienIDArray.count==2){
            self.threeName.text=@"";
            self.threeLevelLabel.text=@"";
            self.threeValueLabel.text=@"";
            //2
            for (int i=0;i<nickNameArray.count;i++){
                if([nickNameArray[1] isEqualToString:@""]){
                    twoNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[1]];
                    self.twoName.text=twoNameStr;
                    
                }else{
                    twoNameStr =[NSString stringWithFormat:@"%@",nickNameArray[1]];
                    self.twoName.text=twoNameStr;
                    
                }
                if([nickNameArray[0] isEqualToString:@""]){
                    oneNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[0]];
                    self.oneName.text=oneNameStr;
                }else{
                    oneNameStr =[NSString stringWithFormat:@"%@",nickNameArray[0]];
                    self.oneName.text=oneNameStr;
                    
                }
                
                
            }
            for (int i=0;i<headImageArray.count;i++)
            {
                if ([headImageArray[1] hasPrefix:@"http"]){
                    CALayer  *layerHeadImageViewLayer = self.twoImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.twoImageView.frame.size.height * 0.5;
                    [self.twoImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[1]]]];
                }else{
                    self.twoImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
                if ([headImageArray[0] hasPrefix:@"http"]
                    ){
                    CALayer  *layerHeadImageViewLayer = self.oneImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.oneImageView.frame.size.height * 0.5;
                    [self.oneImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[0]]]];
                    
                }else{
                    self.oneImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
            }
            
            twoLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[1]];
            
            self.twoLevelLabel.text=twoLevelStr;
            self.twoValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[1]];
            oneLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[0]];
            self.oneLevelabel.text=oneLevelStr;
            self.oneValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[0]];
            
            
        }else{
            //2
            for (int i=0;i<nickNameArray.count;i++){
                if([nickNameArray[1] isEqualToString:@""]){
                    twoNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[1]];
                    self.twoName.text=twoNameStr;
                }else{
                    twoNameStr =[NSString stringWithFormat:@"%@",nickNameArray[1]];
                    self.twoName.text=twoNameStr;
                    
                }
                if([nickNameArray[0] isEqualToString:@""]){
                    oneNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[0]];
                    self.oneName.text=oneNameStr;
                }else{
                    oneNameStr =[NSString stringWithFormat:@"%@",nickNameArray[0]];
                    self.oneName.text=oneNameStr;
                    
                }
                if([nickNameArray[2] isEqualToString:@""]){
                    threeNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[2]];
                    self.threeName.text=threeNameStr;
                }else{
                    threeNameStr =[NSString stringWithFormat:@"%@",nickNameArray[2]];
                    self.threeName.text=threeNameStr;
                    
                }
                
                
            }
            for (int i=0;i<headImageArray.count;i++)
            {
                if ([headImageArray[1] hasPrefix:@"http"]){
                    CALayer  *layerHeadImageViewLayer = self.twoImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.twoImageView.frame.size.height * 0.5;
                    [self.twoImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[1]]]];
                }else{
                    self.twoImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
                if ([headImageArray[0] hasPrefix:@"http"]
                    ){
                    CALayer  *layerHeadImageViewLayer = self.oneImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.oneImageView.frame.size.height * 0.5;
                    [self.oneImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[0]]]];
                    
                }else{
                    self.oneImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
                if ([headImageArray[2] hasPrefix:@"http"]
                    ){
                    CALayer  *layerHeadImageViewLayer = self.threeImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.threeImageView.frame.size.height * 0.5;
                    [self.threeImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[2]]]];
                    
                }else{
                    self.threeImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
            }
            
            twoLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[1]];
            
            self.twoLevelLabel.text=twoLevelStr;
            self.twoValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[1]];
            oneLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[0]];
            self.oneLevelabel.text=oneLevelStr;
            self.oneValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[0]];
            threeLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[2]];
            self.threeLevelLabel.text=threeLevelStr;
            self.threeValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[2]];
            
        }
#pragma mark  周个人排行
        NSDictionary * oraderdic = @{@"secretKey":miyaoNum,@"huaienID":huaien,@"orderType":@"W"};
        NSDictionary * oraderDic = @{@"params":[NSString stringWithFormat:@"%@",oraderdic]};
        
        [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,GetIntegralOrderByID] parameters:oraderDic success:^(NSURLSessionDataTask *task, id responseObject) {
            
            id jsonOrder = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSNumber *result=jsonOrder[@"result"];
            [[NSUserDefaults standardUserDefaults]setObject:result forKey:@"weekResult"];
            NSLog(@"结果＝%@",result);
            [self.dayLabel setHidden:YES];
            [self.monthLabel setHidden:YES];
            [self.totalLabel setHidden:YES];
            
            if ([result integerValue]<0){
                self.weekLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.pmLa.frame.size.width+self.pmLa.frame.origin.x-15, 15, 150, 20)];
                self.weekLabel.text=@"您还未进入排行";
                
                
            }else
            {
                NSNumber *order =jsonOrder[@"userOrder"];
                [[NSUserDefaults standardUserDefaults]setObject:order forKey:@"weekUserOrder"];
                NSInteger userOrder = [[[NSUserDefaults standardUserDefaults] objectForKey:@"weekUserOrder"] integerValue];
                self.weekLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.pmLa.frame.size.width+self.pmLa.frame.origin.x-10, 15, 30, 20)];
                self.weekLabel.text=[NSString stringWithFormat:@"%ld",(long)userOrder];
                UILabel *mLabel=[[UILabel alloc]initWithFrame:CGRectMake( self.weekLabel.frame.size.width+ self.weekLabel.frame.origin.x, 15, 20, 20)];
                mLabel.textColor=[UIColor blackColor];
                mLabel.text=@"名";
                [self.bottomImageView addSubview:mLabel];
            }
            
            self.weekLabel.textColor=[UIColor redColor];
            [self.bottomImageView addSubview: self.weekLabel];
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedWeek)];
            self.bottomImageView.userInteractionEnabled = YES;
            [self.bottomImageView addGestureRecognizer:singleTap];//点击图片事件
            [self createTableView];
            [ProgressHUD hideAfterSuccessOnView:self.view];
            [_tableview reloadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
- (void)photoTappedWeek
{
    NSNumber *weekResult=[[NSUserDefaults standardUserDefaults]objectForKey:@"weekResult"];
    if ([weekResult integerValue]<0){
        
    }else{
        PracticeWeekViewController *weekVC =[[PracticeWeekViewController alloc]init];
        [self.navigationController pushViewController:weekVC animated:YES];
    }
    
}
#pragma mark -----月积分和月个人排行接口---
-(void)getMonthInfo{
    
    [ProgressHUD showOnView:self.view];
    
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * miyaoNum = [appDelegate.accountBasicDict objectForKey:@"secretKey"];
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSDictionary * dic = @{@"secretKey":miyaoNum,@"orderType":@"M"};
    NSDictionary * rankingDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,GetIntegralOrder] parameters:rankingDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *integralArray =[[NSMutableArray alloc]init];
        NSMutableArray *nickNameArray=[[NSMutableArray alloc]init];
        NSMutableArray *levelArray=[[NSMutableArray alloc]init];
        NSMutableArray *headImageArray=[[NSMutableArray alloc]init];
        NSMutableArray *huaienIDArray =[[NSMutableArray alloc]init];
        NSLog(@"月修行排行=%@",jsonData);
        [_tableview removeFromSuperview];
        NSArray * rankingArray = jsonData[@"data"];
        for (int i = 0; i < rankingArray.count; i++) {
            NSDictionary * arrdic = rankingArray[i];
            NSLog(@"日字典＝%@",arrdic);
            NSNumber *huaienID =arrdic[@"huaienID"];
            [[NSUserDefaults standardUserDefaults]setObject:huaienID forKey:@"huaienID"];
            NSNumber *integral=arrdic[@"integral"];
            [integralArray addObject:integral];
            NSLog(@"排行＝%@",integral);
            NSString *nickName =arrdic[@"nickName"];
            [nickNameArray addObject:nickName];
            NSNumber *leve=arrdic[@"userLevel"];
            [levelArray addObject:leve];
            NSNumber *huaienid =arrdic[@"huaienID"];
            [huaienIDArray addObject:huaienid];
            NSString *headImage =arrdic[@"headImg"];
            [headImageArray addObject:headImage];
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
        if (huaienIDArray.count<1){
            self.oneName.text=@"";
            self.oneImageView.image=[UIImage imageNamed:@"默认头像.png"];
            self.oneValueLabel.text=@"";
            self.oneLevelabel.text=@"";
            self.twoName.text=@"";
            self.threeName.text=@"";
            self.twoImageView.image=[UIImage imageNamed:@"默认头像.png"];
            self.threeImageView.image=[UIImage imageNamed:@"默认头像.png"];
            self.twoLevelLabel.text=@"";
            self.threeLevelLabel.text=@"";
            self.twoValueLabel.text=@"";
            self.threeValueLabel.text=@"";
            
        }else if (huaienIDArray.count==1){
            self.twoName.text=@"";
            self.threeName.text=@"";
            self.twoImageView.image=[UIImage imageNamed:@""];
            self.threeImageView.image=[UIImage imageNamed:@""];
            self.twoLevelLabel.text=@"";
            self.threeLevelLabel.text=@"";
            self.twoValueLabel.text=@"";
            self.threeValueLabel.text=@"";
            //1
            for (int i=0;i<nickNameArray.count;i++){
                if([nickNameArray[0] isEqualToString:@""]){
                    oneNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[0]];
                    self.oneName.text=oneNameStr;
                    
                    
                }else{
                    oneNameStr =[NSString stringWithFormat:@"%@",nickNameArray[0]];
                    self.oneName.text=oneNameStr;
                    
                    
                }
                
            }
            for (int i=0;i<headImageArray.count;i++)
            {
                if ([headImageArray[0] hasPrefix:@"http"]){
                    CALayer  *layerHeadImageViewLayer = self.oneImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.oneImageView.frame.size.height * 0.5;
                    [self.oneImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[0]]]];
                    
                }else{
                    self.oneImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
            }
            oneLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[0]];
            self.oneLevelabel.text=oneLevelStr;
            self.oneValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[0]];
            
        }else if (huaienIDArray.count==2){
            self.threeName.text=@"";
            self.threeLevelLabel.text=@"";
            self.threeValueLabel.text=@"";
            //2
            for (int i=0;i<nickNameArray.count;i++){
                if([nickNameArray[1] isEqualToString:@""]){
                    twoNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[1]];
                    self.twoName.text=twoNameStr;
                    
                }else{
                    twoNameStr =[NSString stringWithFormat:@"%@",nickNameArray[1]];
                    self.twoName.text=twoNameStr;
                    
                }
                if([nickNameArray[0] isEqualToString:@""]){
                    oneNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[0]];
                    self.oneName.text=oneNameStr;
                }else{
                    oneNameStr =[NSString stringWithFormat:@"%@",nickNameArray[0]];
                    self.oneName.text=oneNameStr;
                    
                }
                
                
            }
            for (int i=0;i<headImageArray.count;i++)
            {
                if ([headImageArray[1] hasPrefix:@"http"]){
                    CALayer  *layerHeadImageViewLayer = self.twoImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.twoImageView.frame.size.height * 0.5;
                    [self.twoImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[1]]]];
                }else{
                    self.twoImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
                if ([headImageArray[0] hasPrefix:@"http"]
                    ){
                    CALayer  *layerHeadImageViewLayer = self.oneImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.oneImageView.frame.size.height * 0.5;
                    [self.oneImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[0]]]];
                    
                }else{
                    self.oneImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
            }
            
            twoLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[1]];
            
            self.twoLevelLabel.text=twoLevelStr;
            self.twoValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[1]];
            oneLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[0]];
            self.oneLevelabel.text=oneLevelStr;
            self.oneValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[0]];
            
            
        }else{
            //2
            for (int i=0;i<nickNameArray.count;i++){
                if([nickNameArray[1] isEqualToString:@""]){
                    twoNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[1]];
                    self.twoName.text=twoNameStr;
                }else{
                    twoNameStr =[NSString stringWithFormat:@"%@",nickNameArray[1]];
                    self.twoName.text=twoNameStr;
                    
                }
                if([nickNameArray[0] isEqualToString:@""]){
                    oneNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[0]];
                    self.oneName.text=oneNameStr;
                }else{
                    oneNameStr =[NSString stringWithFormat:@"%@",nickNameArray[0]];
                    self.oneName.text=oneNameStr;
                    
                }
                if([nickNameArray[2] isEqualToString:@""]){
                    threeNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[2]];
                    self.threeName.text=threeNameStr;
                }else{
                    threeNameStr =[NSString stringWithFormat:@"%@",nickNameArray[2]];
                    self.threeName.text=threeNameStr;
                    
                }
                
                
            }
            for (int i=0;i<headImageArray.count;i++)
            {
                if ([headImageArray[1] hasPrefix:@"http"]){
                    CALayer  *layerHeadImageViewLayer = self.twoImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.twoImageView.frame.size.height * 0.5;
                    [self.twoImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[1]]]];
                }else{
                    self.twoImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
                if ([headImageArray[0] hasPrefix:@"http"]
                    ){
                    CALayer  *layerHeadImageViewLayer = self.oneImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.oneImageView.frame.size.height * 0.5;
                    [self.oneImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[0]]]];
                    
                }else{
                    self.oneImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
                if ([headImageArray[2] hasPrefix:@"http"]
                    ){
                    CALayer  *layerHeadImageViewLayer = self.threeImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.threeImageView.frame.size.height * 0.5;
                    [self.threeImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[2]]]];
                    
                }else{
                    self.threeImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
            }
            
            twoLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[1]];
            
            self.twoLevelLabel.text=twoLevelStr;
            self.twoValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[1]];
            oneLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[0]];
            self.oneLevelabel.text=oneLevelStr;
            self.oneValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[0]];
            threeLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[2]];
            self.threeLevelLabel.text=threeLevelStr;
            self.threeValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[2]];
            
        }
        NSDictionary * oraderdic = @{@"secretKey":miyaoNum,@"huaienID":huaien,@"orderType":@"M"};
        NSDictionary * oraderDic = @{@"params":[NSString stringWithFormat:@"%@",oraderdic]};
        
        [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,GetIntegralOrderByID] parameters:oraderDic success:^(NSURLSessionDataTask *task, id responseObject) {
            
            id jsonOrder = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSNumber *result=jsonOrder[@"result"];
            [[NSUserDefaults standardUserDefaults]setObject:result forKey:@"monthResult"];
            NSLog(@"结果＝%@",result);
            [self.dayLabel setHidden:YES];
            [self.weekLabel setHidden:YES];
            [self.totalLabel setHidden:YES];
            
            if ([result integerValue]<0){
                self.monthLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.pmLa.frame.size.width+self.pmLa.frame.origin.x-10, 15, 150, 20)];
                self.monthLabel.text=@"您还未进入排行";
                self.monthLabel.textColor=[UIColor redColor];
                
            }else
            {
                NSNumber *order =jsonOrder[@"userOrder"];
                [[NSUserDefaults standardUserDefaults]setObject:order forKey:@"monthUserOrder"];
                NSInteger userOrder = [[[NSUserDefaults standardUserDefaults] objectForKey:@"monthUserOrder"] integerValue];
                self.monthLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.pmLa.frame.size.width+self.pmLa.frame.origin.x-10, 15, 30, 20)];
                self.monthLabel.text=[NSString stringWithFormat:@"%ld",(long)userOrder];
                UILabel *mLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.monthLabel.frame.size.width+ self.monthLabel.frame.origin.x, 15, 20, 20)];
                mLabel.textColor=[UIColor blackColor];
                mLabel.text=@"名";
                [self.bottomImageView addSubview:mLabel];
            }
            self.monthLabel.textColor=[UIColor redColor];
            [self.bottomImageView addSubview: self.monthLabel];
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedMonth)];
            self.bottomImageView.userInteractionEnabled = YES;
            [self.bottomImageView addGestureRecognizer:singleTap];//点击图片事件
            [self createTableView];
            [ProgressHUD hideAfterSuccessOnView:self.view];
            [_tableview reloadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
- (void)photoTappedMonth
{
    NSNumber *monthResult=[[NSUserDefaults standardUserDefaults]objectForKey:@"monthResult"];
    if ([monthResult integerValue]<0){
        
    }else{
        PracticeMonthViewController *monthVC =[[PracticeMonthViewController alloc]init];
        [self.navigationController pushViewController:monthVC animated:YES];
    }
    
}
#pragma mark -----总积分和总个人排行接口---
-(void)getTotalInfo{
    
    [ProgressHUD showOnView:self.view];
    
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * miyaoNum = [appDelegate.accountBasicDict objectForKey:@"secretKey"];
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSDictionary * dic = @{@"secretKey":miyaoNum,@"orderType":@"T"};
    NSDictionary * rankingDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,GetIntegralOrder] parameters:rankingDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"总修行排行=%@",jsonData);
        [_tableview removeFromSuperview];
        NSArray * rankingArray = jsonData[@"data"];
        NSMutableArray *integralArray =[[NSMutableArray alloc]init];
        NSMutableArray *nickNameArray=[[NSMutableArray alloc]init];
        NSMutableArray *levelArray=[[NSMutableArray alloc]init];
        NSMutableArray *headImageArray=[[NSMutableArray alloc]init];
        NSMutableArray *huaienIDArray =[[NSMutableArray alloc]init];
        for (int i = 0; i < rankingArray.count; i++) {
            
            NSDictionary * arrdic = rankingArray[i];
            NSNumber *huaienID =arrdic[@"huaienID"];
            [[NSUserDefaults standardUserDefaults]setObject:huaienID forKey:@"huaienID"];
            NSNumber *integral=arrdic[@"integral"];
            [integralArray addObject:integral];
            NSString *nickName =arrdic[@"nickName"];
            [nickNameArray addObject:nickName];
            NSNumber *leve=arrdic[@"userLevel"];
            [levelArray addObject:leve];
            NSNumber *huaienid =arrdic[@"huaienID"];
            [huaienIDArray addObject:huaienid];
            NSString *headImage =arrdic[@"headImg"];
            [headImageArray addObject:headImage];
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
        if (huaienIDArray.count<1){
            self.oneName.text=@"";
            self.oneImageView.image=[UIImage imageNamed:@"默认头像.png"];
            self.oneValueLabel.text=@"";
            self.oneLevelabel.text=@"";
            self.twoName.text=@"";
            self.threeName.text=@"";
            self.twoImageView.image=[UIImage imageNamed:@"默认头像.png"];
            self.threeImageView.image=[UIImage imageNamed:@"默认头像.png"];
            self.twoLevelLabel.text=@"";
            self.threeLevelLabel.text=@"";
            self.twoValueLabel.text=@"";
            self.threeValueLabel.text=@"";
            
        }else if (huaienIDArray.count==1){
            self.twoName.text=@"";
            self.threeName.text=@"";
            self.twoImageView.image=[UIImage imageNamed:@""];
            self.threeImageView.image=[UIImage imageNamed:@""];
            self.twoLevelLabel.text=@"";
            self.threeLevelLabel.text=@"";
            self.twoValueLabel.text=@"";
            self.threeValueLabel.text=@"";
            //1
            for (int i=0;i<nickNameArray.count;i++){
                if([nickNameArray[0] isEqualToString:@""]){
                    oneNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[0]];
                    self.oneName.text=oneNameStr;
                }else{
                    oneNameStr =[NSString stringWithFormat:@"%@",nickNameArray[0]];
                    self.oneName.text=oneNameStr;
                    
                }
                
            }
            for (int i=0;i<headImageArray.count;i++)
            {
                if ([headImageArray[0] hasPrefix:@"http"]){
                    CALayer  *layerHeadImageViewLayer = self.oneImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.oneImageView.frame.size.height * 0.5;
                    [self.oneImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[0]]]];
                    
                }else{
                    self.oneImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
            }
            oneLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[0]];
            self.oneLevelabel.text=oneLevelStr;
            self.oneValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[0]];
            
        }else if (huaienIDArray.count==2){
            self.threeName.text=@"";
            self.threeLevelLabel.text=@"";
            self.threeValueLabel.text=@"";
            //2
            for (int i=0;i<nickNameArray.count;i++){
                if([nickNameArray[1] isEqualToString:@""]){
                    twoNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[1]];
                    self.twoName.text=twoNameStr;
                    
                }else{
                    twoNameStr =[NSString stringWithFormat:@"%@",nickNameArray[1]];
                    self.twoName.text=twoNameStr;
                    
                }
                if([nickNameArray[0] isEqualToString:@""]){
                    oneNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[0]];
                    self.oneName.text=oneNameStr;
                }else{
                    oneNameStr =[NSString stringWithFormat:@"%@",nickNameArray[0]];
                    self.oneName.text=oneNameStr;
                    
                }
                
                
            }
            for (int i=0;i<headImageArray.count;i++)
            {
                if ([headImageArray[1] hasPrefix:@"http"]){
                    CALayer  *layerHeadImageViewLayer = self.twoImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.twoImageView.frame.size.height * 0.5;
                    [self.twoImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[1]]]];
                }else{
                    self.twoImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
                if ([headImageArray[0] hasPrefix:@"http"]
                    ){
                    CALayer  *layerHeadImageViewLayer = self.oneImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.oneImageView.frame.size.height * 0.5;
                    [self.oneImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[0]]]];
                    
                }else{
                    self.oneImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
            }
            
            twoLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[1]];
            
            self.twoLevelLabel.text=twoLevelStr;
            self.twoValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[1]];
            oneLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[0]];
            self.oneLevelabel.text=oneLevelStr;
            self.oneValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[0]];
            
            
        }else{
            //2
            for (int i=0;i<nickNameArray.count;i++){
                if([nickNameArray[1] isEqualToString:@""]){
                    twoNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[1]];
                    self.twoName.text=twoNameStr;
                }else{
                    twoNameStr =[NSString stringWithFormat:@"%@",nickNameArray[1]];
                    self.twoName.text=twoNameStr;
                    
                }
                if([nickNameArray[0] isEqualToString:@""]){
                    oneNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[0]];
                    self.oneName.text=oneNameStr;
                }else{
                    oneNameStr =[NSString stringWithFormat:@"%@",nickNameArray[0]];
                    self.oneName.text=oneNameStr;
                    
                }
                if([nickNameArray[2] isEqualToString:@""]){
                    threeNameStr =[NSString stringWithFormat:@"%@",huaienIDArray[2]];
                    self.threeName.text=threeNameStr;
                }else{
                    threeNameStr =[NSString stringWithFormat:@"%@",nickNameArray[2]];
                    self.threeName.text=threeNameStr;
                    
                }
                
                
            }
            for (int i=0;i<headImageArray.count;i++)
            {
                if ([headImageArray[1] hasPrefix:@"http"]){
                    CALayer  *layerHeadImageViewLayer = self.twoImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.twoImageView.frame.size.height * 0.5;
                    [self.twoImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[1]]]];
                }else{
                    self.twoImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
                if ([headImageArray[0] hasPrefix:@"http"]
                    ){
                    CALayer  *layerHeadImageViewLayer = self.oneImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.oneImageView.frame.size.height * 0.5;
                    [self.oneImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[0]]]];
                    
                }else{
                    self.oneImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
                if ([headImageArray[2] hasPrefix:@"http"]
                    ){
                    CALayer  *layerHeadImageViewLayer = self.threeImageView.layer;
                    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
                    layerHeadImageViewLayer.borderWidth = 1.5;
                    layerHeadImageViewLayer.masksToBounds = YES;
                    layerHeadImageViewLayer.cornerRadius = self.threeImageView.frame.size.height * 0.5;
                    [self.threeImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headImageArray[2]]]];
                    
                }else{
                    self.threeImageView.image=[UIImage imageNamed:@"默认头像.png"];
                }
            }
            
            twoLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[1]];
            
            self.twoLevelLabel.text=twoLevelStr;
            self.twoValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[1]];
            oneLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[0]];
            self.oneLevelabel.text=oneLevelStr;
            self.oneValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[0]];
            threeLevelStr=[NSString stringWithFormat:@"Lv%@",levelArray[2]];
            self.threeLevelLabel.text=threeLevelStr;
            self.threeValueLabel.text=[NSString stringWithFormat:@"%@",integralArray[2]];
            
        }
        NSDictionary * oraderdic = @{@"secretKey":miyaoNum,@"huaienID":huaien,@"orderType":@"T"};
        NSDictionary * oraderDic = @{@"params":[NSString stringWithFormat:@"%@",oraderdic]};
        
        [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,GetIntegralOrderByID] parameters:oraderDic success:^(NSURLSessionDataTask *task, id responseObject) {
            
            id jsonOrder = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSNumber *result=jsonOrder[@"result"];
            [[NSUserDefaults standardUserDefaults]setObject:result forKey:@"totalResult"];
            
            [self.dayLabel setHidden:YES];
            [self.weekLabel setHidden:YES];
            [self.monthLabel setHidden:YES];
            
            if ([result integerValue]<0){
                self.totalLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.pmLa.frame.size.width+self.pmLa.frame.origin.x-15, 15, 150, 20)];
                self.totalLabel.text=@"您还未进入排行";
                
                
            }else
            {
                NSNumber *order =jsonOrder[@"userOrder"];
                [[NSUserDefaults standardUserDefaults]setObject:order forKey:@"totalUserOrder"];
                NSInteger userOrder = [[[NSUserDefaults standardUserDefaults] objectForKey:@"totalUserOrder"] integerValue];
                self.totalLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.pmLa.frame.size.width+self.pmLa.frame.origin.x-10, 15, 30, 20)];
                self.totalLabel.text=[NSString stringWithFormat:@"%ld",(long)userOrder];
                
                UILabel *mLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.totalLabel.frame.size.width+self.totalLabel.frame.origin.x, 15, 20, 20)];
                mLabel.textColor=[UIColor blackColor];
                mLabel.text=@"名";
                [self.bottomImageView addSubview:mLabel];
            }
            self.totalLabel.textColor=[UIColor redColor];
            [self.bottomImageView addSubview:self.totalLabel];
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedTotal)];
            [self.bottomImageView addGestureRecognizer:singleTap];
            self.bottomImageView.userInteractionEnabled = YES;
            [self createTableView];
            [ProgressHUD hideAfterSuccessOnView:self.view];
            [_tableview reloadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
- (void)photoTappedTotal
{
    NSNumber *totalResult=[[NSUserDefaults standardUserDefaults]objectForKey:@"totalResult"];
    if ([totalResult integerValue]<0){
        
    }else{
        Practice_MyRankViewController *myVC=[[Practice_MyRankViewController alloc]init];
        [self.navigationController pushViewController:myVC animated:YES];
    }
    
}

-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

@end
