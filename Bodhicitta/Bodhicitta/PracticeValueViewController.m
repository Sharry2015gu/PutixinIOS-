//
//  PracticeValueViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/9/10.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "PracticeValueViewController.h"
#import "HeaderFile.h"
#import "NewsViewController.h"
#import "RESideMenu.h"
@interface PracticeValueViewController (){
    
    UINavigationBar * bar;
}
@property(nonatomic,strong)UILabel * practiceValueLabel;
@property(nonatomic,strong)UILabel * problemeLabel;
@property(nonatomic,strong)UILabel * answerLabel;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UITextView * answerTitle;
@property(nonatomic,strong)UIScrollView * scrollview;
@property(nonatomic,strong)UILabel * worshipBuddhaLabel;
@property(nonatomic,strong)UILabel * meditationLabel;
@property(nonatomic,strong)UILabel * wonderfulWashMethodLabel;
@property(nonatomic,strong)UILabel * wisdomLibraryLabel;
@property(nonatomic,strong)UILabel * dailyHomeWorkLabeln;
@property(nonatomic,strong)UILabel * bodhiBeadsLabel;

@end

@implementation PracticeValueViewController
#pragma mark ----主页面--
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
    title.text=@"修行值";
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
    
    _scrollview =[[UIScrollView alloc]initWithFrame:CGRectMake(0, bar.frame.origin.y+bar.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    CGSize newSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+SCREEN_HEIGHT*0.3);
    [_scrollview setContentSize:newSize];
    _scrollview.showsHorizontalScrollIndicator=NO;
    _scrollview.showsVerticalScrollIndicator=NO;
    _scrollview.directionalLockEnabled = YES; //只能一个方向滑动
    _scrollview.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_scrollview];
    
    _practiceValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, bar.frame.origin.y+25, SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.074)];
    _practiceValueLabel.text=@"修行值";
    _practiceValueLabel.textColor=[UIColor brownColor];
    _practiceValueLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:22.f];
    [_scrollview addSubview:_practiceValueLabel];
    
    _problemeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_practiceValueLabel.frame.origin.x+20, _practiceValueLabel.frame.origin.y+50, SCREEN_WIDTH*0.7, SCREEN_WIDTH*0.075)];
    _problemeLabel.text=@"Q:什么是修行值?";
    _problemeLabel.textColor = [UIColor brownColor];
    _problemeLabel.font=[UIFont systemFontOfSize:18];
    [_scrollview addSubview:_problemeLabel];
    
    _answerLabel = [[UILabel alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, _problemeLabel.frame.origin.y+25, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.075)];
    _answerLabel.text=@"A:修行值是用户升级所需的经验值，累积到一定修行值即可提升等级。";
    _answerLabel.numberOfLines=2;
    _answerLabel.font=[UIFont systemFontOfSize:16];
    _answerLabel.textColor=[UIColor lightGrayColor];
    [_scrollview addSubview:_answerLabel];
    
    UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _answerLabel.frame.origin.y+_answerLabel.frame.size.height+5, SCREEN_WIDTH, 0.5)];
    lineLabel.backgroundColor=[UIColor brownColor];
    lineLabel.alpha=0.5;
    [_scrollview addSubview:lineLabel];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, lineLabel.frame.origin.y, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.075)];
    _titleLabel.text=@"Q:如何获得修行？";
    _titleLabel.textColor=[UIColor brownColor];
    _titleLabel.font=[UIFont systemFontOfSize:18];
    [_scrollview addSubview:_titleLabel];
    
    _answerTitle = [[UITextView alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, _titleLabel.frame.origin.y+35, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.169)];
    _answerTitle.text=@"A:方法一，用户使用恭敬礼佛、妙音法洗、智慧文库、菩提佛珠、静心禅修功能时，均能获得修行值。方法二，用户完成每日功课，可随机获得修行值。";
    _answerTitle.editable=NO;
    _answerTitle.scrollEnabled=NO;
    _answerTitle.alwaysBounceVertical = NO;
    _answerTitle.alwaysBounceHorizontal=NO;
    _answerTitle.backgroundColor=[UIColor clearColor];
    _answerTitle.textColor=[UIColor lightGrayColor];
    _answerTitle.font=[UIFont systemFontOfSize:16];
    [_scrollview addSubview:_answerTitle];
    
    UILabel * lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, _answerTitle.frame.origin.y+_answerTitle.frame.size.height+5, SCREEN_WIDTH, 0.5)];
    lineLabel1.backgroundColor=[UIColor brownColor];
    lineLabel1.alpha=0.5;
    [_scrollview addSubview:lineLabel1];
    
    //用于判断设备
    CGFloat width;
    CGFloat height ;
    CGFloat font;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        width = 150;
        height =  115;
        font = 16;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            width = 100;
            height = 115;
            font = 14;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            width = 300;
            height = 100;
            font = 18;
        }
        else
        {
            width = 121;
            height  = 100;
            font = 14;
        }
    }
    
    UILabel * explainLabel = [[UILabel alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, lineLabel1.frame.origin.y+height*0.15, width+width*0.3, height*0.1)];
    explainLabel.text=@"修行值规则说明";
    explainLabel.textColor= [UIColor redColor];
    explainLabel.font=[UIFont systemFontOfSize:font+2];
    [_scrollview addSubview:explainLabel];
    
    UILabel * ruleLabel = [[UILabel alloc]initWithFrame:CGRectMake(explainLabel.frame.origin.x, explainLabel.frame.origin.y+explainLabel.frame.size.height+height*0.1, width*0.4+width, height*0.1)];
    ruleLabel.text=@"一、获取修行值规则";
    ruleLabel.textColor=[UIColor colorWithRed:1 green:0.55 blue:0 alpha:1];
    ruleLabel.font=[UIFont systemFontOfSize:font];
    [_scrollview addSubview:ruleLabel];
    
#pragma mark ----//恭敬礼佛--
    _worshipBuddhaLabel = [[UILabel alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, ruleLabel.frame.origin.y+20, width, height*0.1)];
    _worshipBuddhaLabel.text=@"恭敬礼佛";
    _worshipBuddhaLabel.textColor=[UIColor colorWithRed:1 green:0.55 blue:0 alpha:1];
    _worshipBuddhaLabel.font=[UIFont systemFontOfSize:font];
    [_scrollview addSubview:_worshipBuddhaLabel];
    
    UITextView * worshipBuddhaText = [[UITextView alloc]initWithFrame:CGRectMake(_worshipBuddhaLabel.frame.origin.x+60, _worshipBuddhaLabel.frame.origin.y+_worshipBuddhaLabel.frame.size.height, width+width*0.6, height*0.175+height)];
    worshipBuddhaText.text=@"请佛一次　修行值+50\n敬香一次　修行值+1\n供茶一次　修行值+1至+3\n供品一次　修行值+1至+2\n供花一次　修行值+1至+2\n许愿一次　修行值+2\n还愿一次　修行值+2";
    worshipBuddhaText.textColor=[UIColor colorWithRed:1 green:0.55 blue:0 alpha:1];
    worshipBuddhaText.scrollEnabled=NO;
    worshipBuddhaText.editable=NO;
    worshipBuddhaText.backgroundColor=[UIColor clearColor];
    worshipBuddhaText.font=[UIFont systemFontOfSize:font-2];
    [_scrollview addSubview:worshipBuddhaText];
    
#pragma mark ----妙音法洗--
    
    _wonderfulWashMethodLabel = [[UILabel alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, worshipBuddhaText.frame.origin.y+worshipBuddhaText.frame.size.height-height*0.15, width, height*0.1)];
    _wonderfulWashMethodLabel.text=@"妙音法洗";
    _wonderfulWashMethodLabel.textColor=[UIColor colorWithRed:1 green:0.55 blue:0 alpha:1];
    _wonderfulWashMethodLabel.font=[UIFont systemFontOfSize:14];
    [_scrollview addSubview:_wonderfulWashMethodLabel];
    
    UITextView * wonderfulWashMethodText = [[UITextView alloc]initWithFrame:CGRectMake(_wonderfulWashMethodLabel.frame.origin.x+60, _wonderfulWashMethodLabel.frame.origin.y+_wonderfulWashMethodLabel.frame.size.height, width+width*0.6, height*0.18)];
    wonderfulWashMethodText.text=@"每聆听5分钟　修行值+1";
    wonderfulWashMethodText.textColor=[UIColor colorWithRed:1 green:0.55 blue:0 alpha:1];
    wonderfulWashMethodText.editable=NO;
    wonderfulWashMethodText.backgroundColor=[UIColor clearColor];
    wonderfulWashMethodText.font=[UIFont systemFontOfSize:12];
    [_scrollview addSubview:wonderfulWashMethodText];
    
    UILabel * exLabel = [[UILabel alloc]initWithFrame:CGRectMake(wonderfulWashMethodText.frame.origin.x, wonderfulWashMethodText.frame.origin.y+height*0.24, width*0.8+width, height*0.1)];
    exLabel.text=@"（注：每日上限为20修行值）";
    exLabel.textColor=[UIColor redColor];
    exLabel.font=[UIFont systemFontOfSize:10];
    [_scrollview addSubview:exLabel];
    
#pragma mark ----智慧文库--
    
    _wisdomLibraryLabel = [[UILabel alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, exLabel.frame.origin.y+exLabel.frame.size.height+height*0.08, width, height*0.1)];
    _wisdomLibraryLabel.text=@"智慧文库";
    _wisdomLibraryLabel.textColor=[UIColor colorWithRed:1 green:0.55 blue:0 alpha:1];
    _wisdomLibraryLabel.font=[UIFont systemFontOfSize:14];
    [_scrollview addSubview:_wisdomLibraryLabel];
    
    UILabel * wisdomLibraryText = [[UILabel alloc]initWithFrame:CGRectMake(_wisdomLibraryLabel.frame.origin.x+60, _wisdomLibraryLabel.frame.origin.y+_wisdomLibraryLabel.frame.size.height, width+width*0.6, height*0.18)];
    wisdomLibraryText.text=@"每读经 5分钟　修行值+1\n每抄写50字  　 修行值+1";
    wisdomLibraryText.textColor=[UIColor colorWithRed:1 green:0.55 blue:0 alpha:1];
    wisdomLibraryText.backgroundColor=[UIColor clearColor];
    wisdomLibraryText.font=[UIFont systemFontOfSize:12];
    [_scrollview addSubview:wisdomLibraryText];
    
    UILabel * wisdomLabel = [[UILabel alloc]initWithFrame:CGRectMake(wisdomLibraryText.frame.origin.x, wisdomLibraryText.frame.origin.y+height*0.18, width+width*0.5, height*0.1)];
    wisdomLabel.text=@"（注：每日上限为20修行值）";
    wisdomLabel.textColor=[UIColor redColor];
    wisdomLabel.font=[UIFont systemFontOfSize:10];
    [_scrollview addSubview:wisdomLabel];
    
#pragma mark ---静心修禅----
    _meditationLabel = [[UILabel alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, wisdomLabel.frame.origin.y+wisdomLabel.frame.size.height+height*0.1, width, height*0.1)];
    _meditationLabel.text=@"静心修禅";
    _meditationLabel.textColor=[UIColor colorWithRed:1 green:0.55 blue:0 alpha:1];
    _meditationLabel.font=[UIFont systemFontOfSize:14];
    [_scrollview addSubview:_meditationLabel];
    
    UILabel * meditationText = [[UILabel alloc]initWithFrame:CGRectMake(_meditationLabel.frame.origin.x+60, _meditationLabel.frame.origin.y+_meditationLabel.frame.size.height, width+width*0.5, height*0.18)];
    meditationText.text=@"每修禅5分钟　修行值+1";
    meditationText.textColor=[UIColor colorWithRed:1 green:0.55 blue:0 alpha:1];
    meditationText.backgroundColor=[UIColor clearColor];
    meditationText.font=[UIFont systemFontOfSize:12];
    [_scrollview addSubview:meditationText];
    
    UILabel * meditationLabel = [[UILabel alloc]initWithFrame:CGRectMake(wisdomLibraryText.frame.origin.x, meditationText.frame.origin.y+height*0.2, width+width*0.4, height*0.1)];
    meditationLabel.text=@"（注：每日上限为20修行值）";
    meditationLabel.textColor=[UIColor redColor];
    meditationLabel.font=[UIFont systemFontOfSize:10];
    [_scrollview addSubview:meditationLabel];
    
#pragma mark ---菩提佛珠---
    _bodhiBeadsLabel = [[UILabel alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, meditationLabel.frame.origin.y+meditationLabel.frame.size.height+height*0.1, width, height*0.1)];
    _bodhiBeadsLabel.text=@"菩提佛珠";
    _bodhiBeadsLabel.textColor=[UIColor colorWithRed:1 green:0.55 blue:0 alpha:1];
    _bodhiBeadsLabel.font=[UIFont systemFontOfSize:14];
    [_scrollview addSubview:_bodhiBeadsLabel];
    
    UILabel * bodhiBeadsText = [[UILabel alloc]initWithFrame:CGRectMake(_bodhiBeadsLabel.frame.origin.x+60, _bodhiBeadsLabel.frame.origin.y+_bodhiBeadsLabel.frame.size.height-height*0.3, width+width*0.4, SCREEN_HEIGHT*0.17)];
    bodhiBeadsText.text=@"每拨珠60次　修行值+1";
    bodhiBeadsText.textColor=[UIColor colorWithRed:1 green:0.55 blue:0 alpha:1];
    bodhiBeadsText.backgroundColor=[UIColor clearColor];
    bodhiBeadsText.font=[UIFont systemFontOfSize:12];
    [_scrollview addSubview:bodhiBeadsText];
    
#pragma mark ---每日功课---
    _dailyHomeWorkLabeln= [[UILabel alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, bodhiBeadsText.frame.origin.y+bodhiBeadsText.frame.size.height-height*0.3, width, height*0.1)];
    _dailyHomeWorkLabeln.text=@"每日功课";
    _dailyHomeWorkLabeln.textColor=[UIColor colorWithRed:1 green:0.55 blue:0 alpha:1];
    _dailyHomeWorkLabeln.font=[UIFont systemFontOfSize:14];
    [_scrollview addSubview:_dailyHomeWorkLabeln];
    
    UILabel * dailyHomeWorkText = [[UILabel alloc]initWithFrame:CGRectMake(_dailyHomeWorkLabeln.frame.origin.x+60, _dailyHomeWorkLabeln.frame.origin.y+_dailyHomeWorkLabeln.frame.size.height, width+width*0.8, height*0.17)];
    dailyHomeWorkText.text=@"完成后可随机获得50-100修行值";
    dailyHomeWorkText.textColor=[UIColor colorWithRed:1 green:0.55 blue:0 alpha:1];
    dailyHomeWorkText.backgroundColor=[UIColor clearColor];
    dailyHomeWorkText.font=[UIFont systemFontOfSize:12];
    [_scrollview addSubview:dailyHomeWorkText];
#pragma mark ---第二种说明规则--
    
    UILabel * scendenLabel = [[UILabel alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, dailyHomeWorkText.frame.origin.y+30, width+width*0.8, height*0.1)];
    scendenLabel.text=@"二、每日修行值上限规则";
    scendenLabel.textColor=[UIColor brownColor];
    scendenLabel.font=[UIFont systemFontOfSize:14];
    [_scrollview addSubview:scendenLabel];
    
    UITextView * dayTextview =[[UITextView alloc]initWithFrame:CGRectMake(scendenLabel.frame.origin.x+15, scendenLabel.frame.origin.y+scendenLabel.frame.size.height, width *2, height*0.7)];
    dayTextview.text=@"每个用户每天能获取的修行值有上限，现阶每日上限为 200，超过当日上限后，则当天不能再获取修行值。";
    dayTextview.textColor=[UIColor brownColor];
    dayTextview.backgroundColor=[UIColor clearColor];
    dayTextview.font=[UIFont systemFontOfSize:13];
    [_scrollview addSubview:dayTextview];
    
    UILabel * sendonLabel = [[UILabel alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, dayTextview.frame.origin.y+dayTextview.frame.size.height-height*0.1, width*3, height*0.1)];
    sendonLabel.text=@"（注：请佛及每日功课所获得修行值不计入每用户每日上限）";
    sendonLabel.textColor=[UIColor brownColor];
    sendonLabel.font=[UIFont systemFontOfSize:10];
    [_scrollview addSubview:sendonLabel];
    
}
-(void)buclick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
