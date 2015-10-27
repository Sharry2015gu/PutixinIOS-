//
//  PrayerMoneyViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/9/10.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "PrayerMoneyViewController.h"
#import "HeaderFile.h"
#import "NewsViewController.h"
#import "RESideMenu.h"
@interface PrayerMoneyViewController (){

    UINavigationBar * bar;
}
@property(nonatomic,strong)UILabel * prayermoneyLabel;
@property(nonatomic,strong)UILabel * problemeLabel;
@property(nonatomic,strong)UITextView * answerLabel;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UITextView * answerTitle;
@property(nonatomic,strong)UILabel * demandLabel;
@property(nonatomic,strong)UITextView * demanText;
@end

@implementation PrayerMoneyViewController

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
    title.text=@"祈福币";
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
    
    _prayermoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, bar.frame.origin.y+25, SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.074)];
    _prayermoneyLabel.text=@"祈福币";
    _prayermoneyLabel.textColor=[UIColor brownColor];
    _prayermoneyLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:22.f];
    [backGroundView addSubview:_prayermoneyLabel];
    
    _problemeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_prayermoneyLabel.frame.origin.x+20, _prayermoneyLabel.frame.origin.y+50, SCREEN_WIDTH*0.7, SCREEN_WIDTH*0.075)];
    _problemeLabel.text=@"Q:什么是祈福币？";
    _problemeLabel.textColor = [UIColor brownColor];
    _problemeLabel.font=[UIFont systemFontOfSize:18];
    [backGroundView addSubview:_problemeLabel];
    
    _answerLabel = [[UITextView alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, _problemeLabel.frame.origin.y+25, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.12)];
    _answerLabel.text=@"A:祈福币是菩提心中使用的虚拟货币，应用场景包括请佛、礼佛等操作。";
    _answerLabel.editable=NO;
    _answerLabel.scrollEnabled=NO;
    _answerLabel.backgroundColor=[UIColor clearColor];
    _answerLabel.font=[UIFont systemFontOfSize:16];
    _answerLabel.textColor=[UIColor lightGrayColor];
    [backGroundView addSubview:_answerLabel];
    
    UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _answerLabel.frame.origin.y+_answerLabel.frame.size.height+10, SCREEN_WIDTH, 0.5)];
    lineLabel.backgroundColor=[UIColor brownColor];
    lineLabel.alpha=0.5;
    [backGroundView addSubview:lineLabel];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, lineLabel.frame.origin.y, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.075)];
    _titleLabel.text=@"Q:如何获得祈福币？";
    _titleLabel.textColor=[UIColor brownColor];
    _titleLabel.font=[UIFont systemFontOfSize:18];
    [backGroundView addSubview:_titleLabel];
    
    _answerTitle = [[UITextView alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, _titleLabel.frame.origin.y+35, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.17)];
    _answerTitle.text=@"A:新用户注册免费赠送5000祈福币。\n每日第一次登录赠送60祈福币。\n首次完善个人资料赠送200祈福币。\n恭敬礼佛中还原1次，祈福币+20\n（每日限还原三次）";
    _answerTitle.editable=NO;
    _answerTitle.backgroundColor=[UIColor clearColor];
    _answerTitle.textColor=[UIColor lightGrayColor];
    _answerTitle.font=[UIFont systemFontOfSize:16];
    [backGroundView addSubview:_answerTitle];
    
    UILabel * lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, _answerTitle.frame.origin.y+_answerTitle.frame.size.height, SCREEN_WIDTH, 0.5)];
    lineLabel1.backgroundColor=[UIColor brownColor];
    lineLabel1.alpha=0.5;
    [backGroundView addSubview:lineLabel1];

    _demandLabel = [[UILabel alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, lineLabel1.frame.origin.y, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.075)];
    _demandLabel.text=@"Q:如何获得祈福币？";
    _demandLabel.textColor=[UIColor brownColor];
    _demandLabel.font=[UIFont systemFontOfSize:18];
    [backGroundView addSubview:_demandLabel];
    
    _demanText = [[UITextView alloc]initWithFrame:CGRectMake(_problemeLabel.frame.origin.x, _demandLabel.frame.origin.y+35, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.2)];
    _demanText.text=@"A:恭敬礼佛，请佛1次，祈福币-500\n恭敬礼佛，许愿1次，祈福币-20\n恭敬礼佛，敬香1次，祈福币-10\n恭敬礼佛，供茶1次，祈福币-10至-30\n恭敬礼佛，献花1次，祈福币-10至-20\n恭敬礼佛，供品1次，祈福币-10至-20";
    _demanText.editable=NO;
    _demanText.scrollEnabled=NO;
    _demanText.backgroundColor=[UIColor clearColor];
    _demanText.textColor=[UIColor lightGrayColor];
    _demanText.font=[UIFont systemFontOfSize:16];
    [backGroundView addSubview:_demanText];
    
    UILabel * zhushiLabel = [[UILabel alloc]initWithFrame:CGRectMake(_demanText.frame.origin.x+100, _demanText.frame.origin.y+_demanText.frame.size.height-20, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.075)];
    zhushiLabel.text=@"（注供茶、献花、贡品多种档次可选）";
    zhushiLabel.textColor=[UIColor lightGrayColor];
    zhushiLabel.font=[UIFont systemFontOfSize:10];
    [backGroundView addSubview:zhushiLabel];
   
}
-(void)buclick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
