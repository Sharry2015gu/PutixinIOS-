//
//  JingXinViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/22.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "JingXinViewController.h"
#import "ZhuYeMianViewController.h"
#import "HeaderFile.h"

@interface JingXinViewController (){
    
    UILabel  * myLevelLabel;
    UILabel  * myValueLabel;
    NSInteger   second;
    BOOL  isOn;
}
@property(nonatomic,strong)UIButton * maskButton;
@property(nonatomic,strong)UIButton * maskRankBtn;
@property(nonatomic,strong)UILabel * gradeRankNice;
@property(nonatomic,strong)UILabel * gradeLabel;
@property(nonatomic,strong)UILabel * practiceValueNice;
@property(nonatomic,strong)UILabel * practiceValueLabel;
@property(nonatomic,strong)UIButton * bgview;
@property(nonatomic,strong)UIButton * hintBtn;
@property(nonatomic,strong)UILabel *levelLabel;
@property(nonatomic,strong)UILabel *valueLabel;
@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,strong)UILabel * secondLabel;

@end

@implementation JingXinViewController
-(NSTimer *)timer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(internalChanged) userInfo:nil repeats:YES];
    }
    return _timer;
}
-(void)internalChanged
{
    ++ second;
    self.secondLabel.text = [NSString stringWithFormat:@"%0.2ld : %0.2ld :%0.2ld",second / 3600,second / 60 - (second/ 3600)* 60,second  % 60];
    if (second%180==0){
        UIView *showView=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.5, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.08)];
        
        showView.backgroundColor=[UIColor blackColor];
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, -2, showView.frame.size.width*0.7, showView.frame.size.height)];
        label1.text=@"修行值";
        
        label1.font=[UIFont systemFontOfSize:20.0f];
        label1.textColor=[UIColor whiteColor];
        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(2+label1.frame.size.width, label1.frame.origin.y, label1.frame.size.width*0.3, showView.frame.size.height)];
        label2.text=@"+1";
        label2.textColor=[UIColor redColor];
        label2.font=[UIFont systemFontOfSize:20.0f];
        [showView addSubview:label1];
        [showView addSubview:label2];
        
        [UIView animateWithDuration:2 animations:^{
            showView.alpha = 0;
            [self.view addSubview:showView];
            
        } completion:^(BOOL finished) {
            
            [showView removeFromSuperview];
        }];
        
        
        
    }
    
    
}
-(void)jishiClick{
    
    if ((isClick =NO)) {
        bgImage.image=[UIImage imageNamed:@"no_meditation_bg.jpg"];
        
        isClick=YES;
    }else{
        
        bgImage.image=[UIImage imageNamed:@"meditating_bg.jpg"];
        bgImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTapped)];
        [bgImage addGestureRecognizer:singleTap];//点击图片事件
        [jishiBt removeFromSuperview];
        [bar removeFromSuperview];
        
        self.secondLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4, 585, self.view.frame.size.width, 40)];
        //self.secondLabel.text=@"00:00:00";
        self.secondLabel.backgroundColor=[UIColor clearColor];
        self.secondLabel.textColor=[UIColor whiteColor];
        self.secondLabel.font=[UIFont systemFontOfSize:18.0f];
        [bgImage addSubview:self.secondLabel];
        [UIView animateWithDuration:10 animations:^{
            self.secondLabel.text=@"00:00:00";
        } completion:^(BOOL finished) {
            if (!isOn) {
                [self.timer setFireDate:[NSDate distantPast]];
                isOn = YES;
                NSLog(@"打开");
            }
            else
            {
                [self.timer setFireDate:[NSDate distantFuture]];
            }
        }];
        
        isClick=NO;
        
    }
    
}

-(void)photoTapped{
    
    if (isClick==YES) {
        
        [bar removeFromSuperview];
        isClick=NO;
        view.hidden=YES;
        
    }else{
        [bar removeFromSuperview];
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
        view.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"meditation_top_bg.png"]];
        [self.view addSubview:view];
        
        UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
        title.text=@"精心禅修";
        title.textColor=[UIColor whiteColor];
        title.font=[UIFont systemFontOfSize:20];
        [view addSubview:title];
        
        UIButton * backBt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
        [backBt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
        [backBt addTarget:self action:@selector(backBt) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:backBt];
        
        UIButton * rankingBt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.85, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
        [rankingBt setBackgroundImage:[UIImage imageNamed:@"排行1.png"] forState:UIControlStateNormal];
        [rankingBt addTarget:self action:@selector(changjianClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:rankingBt];
        
        isClick=YES;
    }
    
}

-(UIButton *)hintBtn{
    
    if (_hintBtn == nil) {
        _hintBtn  = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 120,NAVBARHEIGHT + 10,110,80)];
        [_hintBtn  setBackgroundImage:[UIImage scaleFromImage:[UIImage imageNamed:@"level_designation_bg"] toSize:CGSizeMake(_hintBtn.frame.size.width,_hintBtn.frame.size.height)] forState:UIControlStateNormal];
        //        [_hintBtn addTarget:self action:@selector(hintClick) forControlEvents:UIControlEventTouchUpInside];
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0,10,110,60)];
        [_hintBtn addSubview:contentView];
        CGSize maxSize = CGSizeMake(MAXFLOAT,MAXFLOAT);
        NSString * rankName = @"坐禅排行榜";
        CGFloat rankNameWidth = [rankName sizeWithFont:[UIFont systemFontOfSize:12] maxSize:maxSize].width;
        UIImageView * labelBGImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_hintBtn.frame.size.width*0.5 - (rankNameWidth + 4)/ 2,2,(rankNameWidth + 4),25)];
        labelBGImageView.userInteractionEnabled=YES;
        labelBGImageView.image = [UIImage imageNamed:@"03"];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        [labelBGImageView addGestureRecognizer:tap];
        [contentView addSubview:labelBGImageView];
        UILabel *rankLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, labelBGImageView.frame.size.width,labelBGImageView.frame.size.height)];
        rankLabel.textAlignment = NSTextAlignmentCenter;
        rankLabel.font = [UIFont systemFontOfSize:12];
        rankLabel.textColor = majorityColor;
        rankLabel.text = rankName;
        [labelBGImageView addSubview:rankLabel];
        NSString * currentLevelStr = @"当前等级";
        CGFloat  currentLavelStrWidth = [currentLevelStr sizeWithFont:[UIFont systemFontOfSize:10] maxSize:maxSize].width;
        UILabel *currentLevelLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelBGImageView.frame.origin.x,CGRectGetMaxY(labelBGImageView.frame)+2,currentLavelStrWidth,15)];
        currentLevelLabel.text = currentLevelStr;
        //currentLevelLabel.backgroundColor = [UIColor blueColor];
        currentLevelLabel.textColor = [UIColor whiteColor];
        currentLevelLabel.font = [UIFont systemFontOfSize:10];
        [contentView addSubview:currentLevelLabel];
        
        NSString *levelStr = @"Lv100";
        CGFloat  levelWidth  = [levelStr sizeWithFont:[UIFont systemFontOfSize:10] maxSize:maxSize].width;
        self.levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(currentLevelLabel.frame)+2,currentLevelLabel.frame.origin.y+1.5,levelWidth,12)];
        //         self.levelLabel .text = @"Lv100";
        myLevelLabel =  self.levelLabel ;
        myLevelLabel.font = [UIFont systemFontOfSize:10];
        self.levelLabel .backgroundColor = [UIColor orangeColor];
        self.levelLabel .textColor = [UIColor whiteColor];
        CALayer  *levelLabelLayer = self.levelLabel .layer;
        levelLabelLayer.cornerRadius = 3;
        levelLabelLayer.masksToBounds = YES;
        [contentView addSubview: self.levelLabel ];
        
        UILabel *valueHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(currentLevelLabel.frame.origin.x,CGRectGetMaxY(currentLevelLabel.frame),currentLevelLabel.frame.size.width,15)];
        valueHintLabel.text = @"修行值";
        //valueHintLabel.backgroundColor = [UIColor orangeColor];
        valueHintLabel.font = [UIFont systemFontOfSize:10];
        valueHintLabel.textColor = [UIColor whiteColor];
        [contentView addSubview:valueHintLabel];
        
        self.valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(valueHintLabel.frame),valueHintLabel.frame.origin.y,myLevelLabel.frame.size.width,15)];
        self.valueLabel.textColor = [UIColor whiteColor];
        //valueLabel.backgroundColor = [UIColor redColor];
        self.valueLabel.font = [UIFont systemFontOfSize:10];
        self.valueLabel.textAlignment = NSTextAlignmentLeft;
        //        self.valueLabel.text = @"177";
        myLevelLabel = self.valueLabel;
        [contentView addSubview:self.valueLabel];
        [self setPerson];
        //        [self setPerson];
    }
    return _hintBtn;
    
    
}
-(void)tapClick{
    
    PeiHangViewController * rank = [[PeiHangViewController alloc]init];
    [rank getMeditionRankInfo];
    [self.navigationController pushViewController:rank animated:YES];
    
}
#pragma mark ----主页面-----
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadRankData];
    UIView * bgview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, self.view.frame.size.height)];
    bgview.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景.png"]];
    [self.view addSubview:bgview];
    
    bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height)];
    bgImage.image=[UIImage imageNamed:@"no_meditation_bg.jpg"];
    [bgview addSubview:bgImage];
    
    bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    
    [bar setBackgroundImage:[UIImage imageNamed:@"meditation_top_bg.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:bar];
    
    fanhuiBt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [fanhuiBt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [fanhuiBt addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:fanhuiBt];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"精心禅修";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [bar addSubview:title];
    
    changjianBt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.85, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [changjianBt setBackgroundImage:[UIImage imageNamed:@"常见问题.png"] forState:UIControlStateNormal];
    [changjianBt addTarget:self action:@selector(changjianClick) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:changjianBt];
    
    [self createButtonUI];
    
    
    
}
-(void)createButtonUI{
    [self.view addSubview:self.hintBtn];
    musicBt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.85, SCREEN_HEIGHT*0.85, 0.06*SCREEN_WIDTH, 0.06*SCREEN_WIDTH)];
    [musicBt setBackgroundImage:[UIImage imageNamed:@"meditation_music_off"] forState:UIControlStateNormal];
    [musicBt addTarget:self action:@selector(musicClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:musicBt];
    
    jishiBt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.45, SCREEN_HEIGHT*0.7, SCREEN_WIDTH*0.095, 0.06*SCREEN_HEIGHT)];
    [jishiBt setBackgroundImage:[UIImage imageNamed:@"start_meditate"] forState:UIControlStateNormal];
    [jishiBt addTarget:self action:@selector(jishiClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jishiBt];
    
    yuanyinBt =[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.92, 80, 30)];
    [yuanyinBt setTitle:@"为何坐禅" forState:UIControlStateNormal];
    [yuanyinBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yuanyinBt setBackgroundImage:[UIImage imageNamed:@"sit_meditation_bg"] forState:UIControlStateNormal];
    yuanyinBt.titleLabel.font = [UIFont systemFontOfSize:16];
    [yuanyinBt addTarget:self action:@selector(yuanyinClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yuanyinBt];
    
    zhunbeiBt =[[UIButton alloc]initWithFrame:CGRectMake(yuanyinBt.frame.size.width+yuanyinBt.frame.origin.x-1.5,SCREEN_HEIGHT*0.92, 80, 30)];
    [zhunbeiBt setTitle:@"坐禅准备" forState:UIControlStateNormal];
    [zhunbeiBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [zhunbeiBt setBackgroundImage:[UIImage imageNamed:@"sit_meditation_bg"] forState:UIControlStateNormal];
    [zhunbeiBt addTarget:self action:@selector(zhunbeiBt) forControlEvents:UIControlEventTouchUpInside];
    zhunbeiBt.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:zhunbeiBt];
}
#pragma mark ----按钮事件----
-(void)backclick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backBt{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"你已经坐禅%ld秒啦,确定停止坐禅吗？",second] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

-(void)yuanyinClick{
    
    ZuoChanViewController * zuochan = [[ZuoChanViewController alloc]init];
    [self.navigationController pushViewController:zuochan animated:YES];
    
}
-(void)zhunbeiBt{
    
    ZhunBeiViewController * zhunbei = [[ZhunBeiViewController alloc]init];
    [self.navigationController pushViewController:zhunbei animated:YES];
}

-(void)changjianClick{
    UIActionSheet * sheetaction=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"排行",@"分享", nil];
    [sheetaction showInView:self.view];
    
}
-(void)musicClick{
    if (isClick==YES) {
        [musicBt setBackgroundImage:[UIImage imageNamed:@"meditation_music_off"] forState:UIControlStateNormal];
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        isClick=NO;
    }else{
        
        [musicBt setBackgroundImage:[UIImage imageNamed:@"meditation_music_on"] forState:UIControlStateNormal];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"meditation.mp3"];
        
        
        isClick=YES;
    }
    
}
-(void)maskRankClick{
    
    PeiHangViewController * rank = [[PeiHangViewController alloc]init];
    [rank getMeditionRankInfo];
    [self.navigationController pushViewController:rank animated:YES];
    
}
#pragma mark ---alertView代理  坐禅提交接口---
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else if(buttonIndex==1){
        
        [self.navigationController popViewControllerAnimated:YES];
        AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
        NSNumber * userLogin=[appDelegate.accountBasicDict objectForKey:@"userLoginID"];
        NSNumber *miyaoNum  = [appDelegate.accountBasicDict objectForKey:@"secretKey"];
        NSDictionary * dic = @{@"secretKey":miyaoNum,@"userLoginID":userLogin,@"huaienID":huaien,@"userTaskID":@0,@"taskCode":@700,@"sceneType":@1,@"buddhistTempleID":@0,@"bookID":@0,@"beginPostion":@"11",@"endPostion":@0};
        NSDictionary * meditionDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
        AppDelegate * medition = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [medition.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,SubmitSitMeditationURL] parameters:meditionDic success:^(NSURLSessionDataTask *task, id responseObject) {
            
            id jsonMedition = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"提交坐禅=%@",jsonMedition);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    }
}

#pragma mark－－ 获取修行值
- (void)loadRankData
{
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSNumber *secretKey =[appDelegate.accountBasicDict objectForKey:@"secretKey"];
    NSDictionary * rankDic=@{@"huaienID":huaien,@"secretKey":secretKey};
    NSLog(@"字典＝%@",rankDic);
    NSDictionary * rankDic1 = @{@"params":[NSString stringWithFormat:@"%@",rankDic]};
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,ptxGetUserLevel] parameters:rankDic1 success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"等级＝%@",jsonData);
        NSNumber *result =jsonData[@"result"];
        if ([result integerValue]==0){
            NSNumber *totalIntegral=jsonData[@"totalIntegral"];
            [[NSUserDefaults standardUserDefaults]setObject:totalIntegral forKey:@"Integral"];
            NSLog(@"分数＝%@",totalIntegral);
            NSNumber *levelAndDesignation=jsonData[@"levelAndDesignation"];
            [[NSUserDefaults standardUserDefaults]setObject:levelAndDesignation forKey:@"levelAndDesignation"];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
- (void)setPerson
{
    //等级
    NSString *levelStr =[[NSUserDefaults standardUserDefaults]objectForKey:@"levelAndDesignation"];
    NSArray *array = [levelStr componentsSeparatedByString:@"|"];
    for (int i=0;i<array.count;i++){
        self.levelLabel.text =[NSString stringWithFormat:@" LV%@",array[0]];
    }
    NSNumber *totalIntegral=[[NSUserDefaults standardUserDefaults]objectForKey:@"Integral"];
    NSLog(@"数据%@",totalIntegral);
    NSString *str1 =[totalIntegral stringValue];
    NSLog(@"str1=%@",str1);
    
    self.valueLabel.text=str1;
    
}


#pragma mark ----actionsheet代理方法---
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        
        PeiHangViewController * rank = [[PeiHangViewController alloc]init];
        [rank getMeditionRankInfo];
        [self.navigationController pushViewController:rank animated:YES];
        
    }else if(buttonIndex==1){
        
    }else if(buttonIndex==2){
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}



@end
