//
//  ZhuYeMianViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/6.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "ZhuYeMianViewController.h"
#import "HeaderFile.h"
#import "UIImageView+WebCache.h"
#import "MyBuddhaHallViewController.h"
#import "FoZhuViewController.h"
#import "JingXinViewController.h"
#import "MiaoYinViewController.h"
#import "ShuJia_MyViewController.h"
#import "HomeWorkViewController.h"
#import "LeftViewController.h"
#import "UserLoginViewController.h"
#import "AppDelegate.h"
#import "PracticeViewController.h"
#import "CarefulMeditationViewController.h"
#define EACH_W(A) ([UIScreen mainScreen].bounds.size.width/A)
#define EACH_H (self.tabBar.bounds.size.height)
#define BTNTAG 10000
@interface ZhuYeMianViewController (){
    
    float _startPointX;
    UIView *_selectTabV;
    UIView *_navView;
    UIView *_topNaviV;
    UIScrollView *_scrollV;
    
    UIScrollView *_navScrollV;
    UIView *_navBgV;
    UIButton * left;

}
@property(nonatomic,strong)UIImageView * buddhaImageView;
@property(nonatomic,strong)UIButton * worshipBuddhaBtn;
@property(nonatomic,strong)UIButton * practiceRankBtn;
@property(nonatomic,strong)UIButton * bodhiBeadsBtn;
@property(nonatomic,strong)UIButton * meditationBtn;
@property(nonatomic,strong)UIButton * wonderfulWashMethodBtn;
@property(nonatomic,strong)UIButton * wisdomLibraryBtn;
@property(nonatomic,strong)UIButton * dailyHomeWorkBtn;
@property(nonatomic,strong)UILabel * nickLabel;
@property(nonatomic,strong)UILabel * nameLlabel;
@property(nonatomic,strong)UILabel * gradeLabel;
@property(nonatomic,strong)UIButton * gradeImageView;
@property(nonatomic,strong)UILabel * practiceValueLabel;
@property(nonatomic,strong)UILabel *  ValueLabel;
@property(nonatomic,strong)NSMutableDictionary * userDic;
@property(nonatomic,strong)UIButton *btn;

@end

@implementation ZhuYeMianViewController
-(NSMutableDictionary *) userDic
{
    if(_userDic ==  nil)
    {
        _userDic = [[NSMutableDictionary alloc] init];
    }
    return _userDic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.hidden = YES;
    self.view.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    
    [self createSubView];
    [self loadResginView];

}
#pragma mark 签到
- (void)loadResginView
{
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

    self.btn =[[UIButton alloc]initWithFrame:CGRectMake(width*0.9+SCREEN_WIDTH*0.3, 10, width*0.1, height*0.75)];
    [self.view addSubview:self.btn];
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSDictionary * resginDic=@{@"huaienID":huaien};
    NSDictionary * resginDic1 = @{@"params":[NSString stringWithFormat:@"%@",resginDic]};
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,ptxJudgeGetLoginRewardByID] parameters:resginDic1 success:^(NSURLSessionDataTask *task, id responseObject) {
        id  jsonData =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"是否签到＝%@",jsonData);
        NSString *ifGetLoginReward=jsonData[@"ifGetLoginReward"];
        if ([ifGetLoginReward isEqualToString:@"N"]){
            [self.btn  setBackgroundImage:[UIImage imageNamed:@"sign_in_icon.png"] forState:UIControlStateNormal];
            [self.btn  addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
            
        }else
        {
            
            [self.btn  setBackgroundImage:[UIImage imageNamed:@"on_sign_in_icon.png"] forState:UIControlStateNormal];
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark 点击按钮改变状态
- (void)btnClick
{
    [self.btn  setBackgroundImage:[UIImage imageNamed:@"on_sign_in_icon.png"] forState:UIControlStateNormal];
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * miyaoNum = [appDelegate.accountBasicDict  objectForKey:@"secretKey"];
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSNumber * userLoginID= [appDelegate.accountBasicDict objectForKey:@"userLoginID"];
    NSDictionary * resginDict=@{@"secretKey":miyaoNum,@"huaienID":huaien,@"userLoginID":userLoginID};
    NSDictionary * resginDict1 = @{@"params":[NSString stringWithFormat:@"%@",resginDict]};
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,ptxGetLoginRewardByID] parameters:resginDict1 success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"签到奖励＝%@",jsonData);
        NSNumber *result =jsonData[@"result"];
        if ([result integerValue]==0){
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(SCREEN_WIDTH *0.2, SCREEN_HEIGHT*0.68,SCREEN_WIDTH*0.6, 30);
            //@"签到成功,获得祈福币%@",jsonData[@"prayMoney"]
            label.text =[NSString stringWithFormat:@"签到成功,获得祈福币%@",jsonData[@"prayMoney"]] ;
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
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
#pragma mark ----界面视图控件----
-(void)createSubView{
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
            width = 230;
            height = 155;
        }
        else
        {
            width = 175;
            height  = 120;
        }
    }

    left=[[UIButton alloc]initWithFrame:CGRectMake(width*0.01,height*0.1+10,0.09 * self.view.frame.size.height,0.09 * self.view.frame.size.height)];
//    [left setBackgroundImage:[UIImage imageNamed:@"default_head_photo"] forState:UIControlStateNormal];
    [left setImage:[UIImage imageNamed:@"default_head_photo"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(leftItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:left];
    
    _nickLabel = [[UILabel alloc]initWithFrame:CGRectMake(left.frame.origin.x+left.frame.size.width+10, 25, 100, 20)];
    _nickLabel.text=@"菩提";
    _nickLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:_nickLabel];
    
    _gradeImageView=[[UIButton alloc]initWithFrame:CGRectMake(left.frame.origin.x+left.frame.size.width+10, _nickLabel.frame.origin.y+_nickLabel.frame.size.height+2, 25, 10)];
    [_gradeImageView setBackgroundImage:[UIImage imageNamed:@"LV背景"] forState:UIControlStateNormal];
    [_gradeImageView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _gradeImageView.titleLabel.font=[UIFont boldSystemFontOfSize:8];
    [self.view addSubview:_gradeImageView];
    
    _nameLlabel = [[UILabel alloc]initWithFrame:CGRectMake(_gradeImageView.frame.origin.x+_gradeImageView.frame.size.width+5, _gradeImageView.frame.origin.y-5, 100, 20)];
    _nameLlabel.text=@"善士";
    _nameLlabel.font=[UIFont systemFontOfSize:12];
    _nameLlabel.textColor=majorityColor;
    [self.view addSubview:_nameLlabel];
    
    _practiceValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(left.frame.origin.x+left.frame.size.width+10, _gradeImageView.frame.origin.y+_gradeImageView.frame.size.height+2, 100, 20)];
    _practiceValueLabel.text=@"修行值";
    _practiceValueLabel.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:_practiceValueLabel];
    
    _ValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(_practiceValueLabel.frame.origin.x+_practiceValueLabel.frame.size.width-58, _practiceValueLabel.frame.origin.y, 100, 20)];
    _ValueLabel.text=@"147";
    _ValueLabel.font=[UIFont systemFontOfSize:13];
    _ValueLabel.textColor=[UIColor blackColor];
    [self.view addSubview:_ValueLabel];
    
       _dailyHomeWorkBtn = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.origin.x-width*0.05+SCREEN_WIDTH*0.35), height*0.9+SCREEN_HEIGHT*0.6, width*0.9+10, height*0.7)];
    [_dailyHomeWorkBtn setBackgroundImage:[UIImage imageNamed:@"每日功课"] forState:UIControlStateNormal];
    [_dailyHomeWorkBtn addTarget:self action:@selector(dailyHomeWorkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_dailyHomeWorkBtn];
    
    _meditationBtn = [[UIButton alloc]initWithFrame:CGRectMake(_dailyHomeWorkBtn.frame.origin.x-width*0.1-SCREEN_WIDTH*0.2, _dailyHomeWorkBtn.frame.origin.y+height*0.01-SCREEN_HEIGHT*0.099-5, width*0.4, height*0.4)];
    [_meditationBtn setBackgroundImage:[UIImage imageNamed:@"静心禅修"] forState:UIControlStateNormal];
    [_meditationBtn addTarget:self action:@selector(meditationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_meditationBtn];
    
    _wonderfulWashMethodBtn = [[UIButton alloc]initWithFrame:CGRectMake(_meditationBtn.frame.origin.x+_meditationBtn.frame.size.width/3+width*0.4, _meditationBtn.frame.origin.y, width*0.5, height*0.4)];
    [_wonderfulWashMethodBtn setBackgroundImage:[UIImage imageNamed:@"妙音法洗"] forState:UIControlStateNormal];
    [_wonderfulWashMethodBtn addTarget:self action:@selector(wonderfulWashMethodBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_wonderfulWashMethodBtn];
    
    _wisdomLibraryBtn = [[UIButton alloc]initWithFrame:CGRectMake(_wonderfulWashMethodBtn.frame.origin.x+_wonderfulWashMethodBtn.frame.size.width/3+width*0.45, _meditationBtn.frame.origin.y, width*0.55, height*0.4)];
    [_wisdomLibraryBtn setBackgroundImage:[UIImage imageNamed:@"智慧文库1"] forState:UIControlStateNormal];
    [_wisdomLibraryBtn addTarget:self action:@selector(wisdomLibraryBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_wisdomLibraryBtn];
    
    _worshipBuddhaBtn = [[UIButton alloc]initWithFrame:CGRectMake(_meditationBtn.frame.origin.x, _meditationBtn.frame.origin.y+_meditationBtn.frame.size.height-height*0.9, width*0.4, height*0.4)];
    [_worshipBuddhaBtn setBackgroundImage:[UIImage imageNamed:@"恭敬礼佛"] forState:UIControlStateNormal];
    [_worshipBuddhaBtn addTarget:self action:@selector(worshipBuddhaBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_worshipBuddhaBtn];
    
    _practiceRankBtn = [[UIButton alloc]initWithFrame:CGRectMake(_worshipBuddhaBtn.frame.origin.x+_worshipBuddhaBtn.frame.size.width/3+width*0.4,_worshipBuddhaBtn.frame.origin.y+5, width*0.5, height*0.35)];
    [_practiceRankBtn setBackgroundImage:[UIImage imageNamed:@"修行排行"] forState:UIControlStateNormal];
    [_practiceRankBtn addTarget:self action:@selector(practiceRankClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_practiceRankBtn];
    
    _bodhiBeadsBtn = [[UIButton alloc]initWithFrame:CGRectMake(_practiceRankBtn.frame.origin.x+_practiceRankBtn.frame.size.width/3+width*0.43, _worshipBuddhaBtn.frame.origin.y, width*0.5, height*0.4)];
    [_bodhiBeadsBtn setBackgroundImage:[UIImage imageNamed:@"菩提佛珠_main"] forState:UIControlStateNormal];
    [_bodhiBeadsBtn addTarget:self action:@selector(bodhiBeadsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bodhiBeadsBtn];

    
    _buddhaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_buddhaImageView.frame.origin.x-width*0.01+SCREEN_WIDTH*0.1, _bodhiBeadsBtn.frame.origin.y-height*0.01-SCREEN_HEIGHT*0.52, (self.view.frame.origin.x-width*0.09)+SCREEN_WIDTH*0.9, height*0.9+SCREEN_HEIGHT*0.3)];
    _buddhaImageView.image=[UIImage imageNamed:@"佛像"];
    [self.view addSubview:_buddhaImageView];
    
    
    
   
    [self setPerson];
}

#pragma mark -------模块化分------
//礼佛
-(void)worshipBuddhaBtnClick{

    MyBuddhaHallViewController * gongjing = [[MyBuddhaHallViewController alloc]init];
    [self.navigationController pushViewController:gongjing animated:YES];
}
//佛珠
-(void)bodhiBeadsBtnClick{
    
    FoZhuViewController * fozhu = [[FoZhuViewController alloc]init];
    [self.navigationController pushViewController:fozhu animated:YES];
}
//禅修
-(void)meditationBtnClick{
    
    CarefulMeditationViewController * care = [[CarefulMeditationViewController alloc]init];
//    JingXinViewController * jingxin = [[JingXinViewController alloc]init];
    [self.navigationController pushViewController:care animated:YES];
}
//修行
-(void)practiceRankClick{
    
    PracticeViewController * pra = [[PracticeViewController alloc]init];
    [self.navigationController pushViewController:pra animated:YES];
}
//妙音
-(void)wonderfulWashMethodBtnClick{

    MiaoYinViewController * miaoyin = [[MiaoYinViewController alloc]init];
    [self.navigationController pushViewController:miaoyin animated:YES];
}
//智慧
-(void)wisdomLibraryBtnClick{
    
    ShuJia_MyViewController * shujia = [[ShuJia_MyViewController alloc]init];
    [self.navigationController pushViewController:shujia animated:YES];

}
//每日
-(void)dailyHomeWorkBtnClick{
    HomeWorkViewController * homework =[[HomeWorkViewController alloc]init];
    MyBuddhaHallViewController  *myBuddhaHallVc = [[MyBuddhaHallViewController alloc] init];
    homework.myBuddahaVC = myBuddhaHallVc;;
    ShuJia_MyViewController * shujiaVc = [[ShuJia_MyViewController alloc] init];
    homework.myShuajiaVC = shujiaVc;
    MusicViewController  * myMusicVc = [[MusicViewController alloc] init];
    homework.myMusicPlayerVc = myMusicVc;
    JingXinViewController * jingxin = [[JingXinViewController alloc]init];
    homework.myJingXinVC=jingxin;
    FoZhuViewController * fozhuVc = [[FoZhuViewController alloc] init];
    homework.fozhuVc  = fozhuVc;
    [self.navigationController pushViewController:homework animated:YES];
}

-(void)setPerson{

    AppDelegate *delegate =(AppDelegate*)[UIApplication sharedApplication].delegate ;
    NSString * str = [delegate.accountBasicDict objectForKey:@"levelAndDesignation"];
    NSArray *array = [str componentsSeparatedByString:@"|"];
    for (int i = 0; i < [array count]; i++) {
        NSLog(@"string:%@", [array objectAtIndex:i]);
        [_gradeImageView setTitle:[NSString stringWithFormat:@"LV%@",array[0]] forState:UIControlStateNormal];
         _nameLlabel.text=array[1];
        
    }
    NSString * str1 =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"totalIntegral"]];
    _ValueLabel.text=str1;
    NSLog(@"_ValueLabel.text=%@",_ValueLabel.text);
    _nickLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"name"];    
}

@end
