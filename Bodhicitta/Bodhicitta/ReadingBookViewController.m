
//
//  ReadingBookViewController.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/28.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "ReadingBookViewController.h"
#import "HeaderFile.h"
#import "ProgressHUD.h"
#import "NetWorking.h"
#import "DuJing_PHViewController.h"
@interface ReadingBookViewController()<UIScrollViewDelegate,UITextFieldDelegate>
{
    NSInteger  currentPage;
    NSInteger  location;
    NSInteger  sumLocation;
    NSInteger  thisTime;
    NSInteger  todayTime;
    NSInteger  sumTime;
    
}
@property(nonatomic,strong)UINavigationItem *navItem;
@property(nonatomic,strong)NSString *contentStr;
@property(nonatomic,strong)UIView  *bgView;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *pageLabel;
@property(nonatomic,strong)UIView  *bottomView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *contentArray;
@property(nonatomic,strong)UILabel  *thisTimeLabel;
@property(nonatomic,strong)UILabel  *todayTimeLabel;
@property(nonatomic,strong)UILabel  *sumTimeLabel;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)UIButton * maskButton;
@property(nonatomic,strong)UIButton * maskRankBtn;
@property(nonatomic,strong)UILabel * gradeRankNice;
@property(nonatomic,strong)UILabel * gradeLabel;
@property(nonatomic,strong)UILabel * practiceValueNice;
@property(nonatomic,strong)UILabel * practiceValueLabel;
@property(nonatomic,strong)UIButton * bgview;
@property(nonatomic,strong)UIView * maskView;
@property(nonatomic,strong)UIImageView * bgImageView;
@property(nonatomic,strong)UITextField * nameText;
@property(nonatomic,strong)UIButton * sureBtn;
@property(nonatomic,strong)UIButton * controlBtn;
@property(nonatomic,strong)NSMutableArray * contentViewArray;
////时间
//@property(nonatomic,assign)NSInteger hour;
//@property(nonatomic,assign)NSInteger minute;
//@property(nonatomic,assign)NSInteger second;
@end

@implementation ReadingBookViewController
#pragma mark -初始化
#pragma mark ---把每一页的内容放在UIView上
-(NSMutableArray *)contentViewArray
{
    if (_contentViewArray == nil) {
        _contentViewArray = [[NSMutableArray alloc] init];
    }
    return _contentViewArray;
}
-(NSMutableArray *)contentArray
{
    if (_contentArray == nil) {
        _contentArray = [[NSMutableArray alloc]init];
    }
    return _contentArray;
}
-(UIScrollView *)scrollView
{
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,NAVBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT - 55)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
-(UIView *)bgView
{
    if (_bgView == nil) {
        _bgView = [[UILabel alloc] initWithFrame:CGRectMake(0,NAVBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT - NAVBARHEIGHT - 55)];
    }
    return _bgView;
}
-(UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, NAVBARHEIGHT, SCREEN_WIDTH - 30,SCREEN_HEIGHT - NAVBARHEIGHT - 55 -30)];
        _contentLabel.textColor = [UIColor darkGrayColor];
        _contentLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"read_book_main_bg.jpg"]];
        _contentLabel.font = [UIFont boldSystemFontOfSize:16];
        _contentLabel.numberOfLines = 0 ;
    }
    return _contentLabel;
}
-(UILabel *)pageLabel
{
    if (_pageLabel == nil) {
        _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT - 55 - 20 , SCREEN_WIDTH, 20)];
        _pageLabel.textAlignment = NSTextAlignmentCenter;
        _pageLabel.text = [NSString stringWithFormat:@"1/%ld",(long)self.contentViewArray.count];
        _pageLabel.textColor = [UIColor grayColor];
    }
    return _pageLabel;
}
-(UIView *)bottomView
{
    
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT - 55, SCREEN_WIDTH,55)];
        _bottomView.backgroundColor = [UIColor colorWithRed: 244 / 255.0 green:230 / 255.0 blue:193 / 255.0 alpha:1];
        
        CGFloat width;
        
        CGFloat font;
        if (fabs(SCREEN_HEIGHT-667) < 1) {
            width = 215;
            
            font = 16;
        }
        else
        {
            if (fabs(SCREEN_HEIGHT -568) < 1) {
                width = 170;
                font = 14;
            }
            else if (fabs(SCREEN_HEIGHT - 736) < 1)
            {
                width = 230;
                
                font = 18;
            }
            else
            {
                width = 175;
                
                font = 12;
            }
        }
        //本次阅读
        UILabel *thisRead =[[UILabel alloc]initWithFrame:CGRectMake(width*0.1, 10, width*0.4, 20)];
        
        thisRead.text =@"本次阅读:";
        thisRead.font=[UIFont systemFontOfSize:font];
        thisRead.textColor=[UIColor darkGrayColor];
        [_bottomView addSubview:thisRead];
        self.thisTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(thisRead.frame.origin.x+thisRead.frame.size.width-5, thisRead.frame.origin.y, width*0.4, 20)];
        self.thisTimeLabel.text=@"0分钟0秒";
        self.thisTimeLabel.font=[UIFont systemFontOfSize:font];
        self.thisTimeLabel.textColor=[UIColor darkGrayColor];
        [_bottomView addSubview:self.thisTimeLabel];
        //今日阅读
        UILabel *todayRead =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-self.thisTimeLabel.frame.size.width-self.thisTimeLabel.frame.origin.x, self.thisTimeLabel.frame.origin.y, width*0.4, 20)];
        todayRead.text =@"今日阅读:";
        todayRead.font=[UIFont systemFontOfSize:font];
        todayRead.textColor=[UIColor darkGrayColor];
        [_bottomView addSubview:todayRead];
        self.todayTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(todayRead.frame.origin.x+todayRead.frame.size.width-5,todayRead.frame.origin.y, width*0.45, 20)];
        self.todayTimeLabel.font=[UIFont systemFontOfSize:font];
        self.todayTimeLabel.textColor=[UIColor darkGrayColor];
        self.todayTimeLabel.text=@"0分钟0秒";
        [_bottomView addSubview: self.todayTimeLabel];
        //累计阅读
        UILabel *totalRead =[[UILabel alloc]initWithFrame:CGRectMake(thisRead.frame.origin.x, thisRead.frame.origin.y+thisRead.frame.size.height+2, width*0.4, 20)];
        
        totalRead.text =@"累计阅读:";
        totalRead.font=[UIFont systemFontOfSize:font];
        todayRead.textColor=[UIColor darkGrayColor];
        [_bottomView addSubview:totalRead];
        self.sumTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.thisTimeLabel.frame.origin.x,self.thisTimeLabel.frame.origin.y+self.thisTimeLabel.frame.size.height+2, width*0.45, 20)];
        self.sumTimeLabel.text=@"0分钟0秒";
        self.sumTimeLabel.font=[UIFont systemFontOfSize:font];
        self.sumTimeLabel.textColor=[UIColor darkGrayColor];
        [_bottomView addSubview:self.sumTimeLabel];
        
        
    }
    return _bottomView;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self loadCurrentData];
    
    thisTime = 0 ;
    todayTime = 0 ;
    sumTime = 0;
    currentPage  = 1;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"read_book_main_bg.jpg"]];
    location = 0 ;
    sumLocation = 0 ;
    [self createNavBar];
    [self.view addSubview:self.bottomView];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _timeline				= [[EasyTimeline alloc] init];
    _timeline.duration		= 1.0;
    _timeline.tickPeriod	= 1.0;
    _timeline.willLoop		= YES;
    _timeline.delegate		= self;
    [_timeline start];
}
#pragma mark EasyTimelineDelegate

- (void)tickAt:(NSTimeInterval)time forTimeline:(EasyTimeline *)timeline
{
    NSString * Nowtimer = [NSString stringWithFormat:@"%f",time];
    if ([self isBlankString:Nowtimer]==NO) {
        now +=1;
    }
    //本次阅读时间
    if(now>=60){
        minute = now / 60;//分钟
        second = now % 60;
        self.thisTimeLabel.text = [NSString stringWithFormat:@"%d分钟%d秒",minute, second];
    }else{
        self.thisTimeLabel.text = [NSString stringWithFormat:@"0分钟%d秒", now];
    }
    if (++todayTime%180==0){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.5, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.08)];
        
        view.backgroundColor=[UIColor blackColor];
        //        view.alpha=0.5;
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, -2, view.frame.size.width*0.7, view.frame.size.height)];
        label1.text=@"修行值";
        
        label1.font=[UIFont systemFontOfSize:20.0f];
        label1.textColor=[UIColor whiteColor];
        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(2+label1.frame.size.width, label1.frame.origin.y, label1.frame.size.width*0.3, view.frame.size.height)];
        label2.text=@"+2";
        label2.textColor=[UIColor redColor];
        label2.font=[UIFont systemFontOfSize:20.0f];
        [view addSubview:label1];
        [view addSubview:label2];
        
        [UIView animateWithDuration:2 animations:^{
            view.alpha = 0;
            [self.view addSubview:view];
            
        } completion:^(BOOL finished) {
            
            [view removeFromSuperview];
        }];
        
        
    }
    
    
    //累计时间
    if( [self isBlankString:[[NSUserDefaults standardUserDefaults] objectForKey:@"totalTimer"]]==YES ){
        NSLog(@"----------------------");
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",now] forKey:@"totalTimer"];
        if(now>=60){
            minute = now / 60;//分钟
            second = now % 60;
            
            self.sumTimeLabel.text = [NSString stringWithFormat:@"%d分钟%d秒",minute, second];
        }else{
            
            self.sumTimeLabel.text = [NSString stringWithFormat:@"0分钟%d秒", now];
        }
        
    }else{
        
        int nowTotalTimer =[[[NSUserDefaults standardUserDefaults] objectForKey:@"totalTimer"] intValue];
        nowTotalTimer =nowTotalTimer + 1;
        if(nowTotalTimer>=60){
            minute = nowTotalTimer / 60;
            second = nowTotalTimer % 60;
            self.sumTimeLabel.text = [NSString stringWithFormat:@"%d分钟%d秒",minute, second];
        }else{
            self.sumTimeLabel.text = [NSString stringWithFormat:@"0分钟%d秒", nowTotalTimer];
        }
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",nowTotalTimer] forKey:@"totalTimer"];
        
    }
    
    if( [self isBlankString:[[NSUserDefaults standardUserDefaults] objectForKey:@"nowDayTimer"]]==YES ){
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",now] forKey:@"nowDayTimer"];
        if(now>=60){
            minute = now /60;
            second = now % 60;
            self.todayTimeLabel.text = [NSString stringWithFormat:@"%d分钟%d秒",minute, second];
        }else{
            
            self.todayTimeLabel.text = [NSString stringWithFormat:@"0分钟%d秒", now];
        }
        
    }else{
        
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"HH"];
        NSString *  locationString=[dateformatter stringFromDate:senddate];
        if ([locationString isEqualToString:@"24"] || [locationString isEqualToString:@"0"]) {//判断当前时间是否是24小时
            int nowTotalTimer =[[[NSUserDefaults standardUserDefaults] objectForKey:@"nowDayTimer"] intValue];
            nowTotalTimer =0 + now;
            if(nowTotalTimer>=60){
                minute = nowTotalTimer / 60;
                second = nowTotalTimer % 60;
                self.todayTimeLabel.text = [NSString stringWithFormat:@"%d分钟%d秒",minute,second];
            }else{
                self.todayTimeLabel.text = [NSString stringWithFormat:@"0分钟%d秒", nowTotalTimer];
            }
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",nowTotalTimer] forKey:@"nowDayTimer"];
        }else{
            int nowTotalTimer =[[[NSUserDefaults standardUserDefaults] objectForKey:@"nowDayTimer"] intValue];
            nowTotalTimer =nowTotalTimer + 1;
            if(nowTotalTimer>=60){
                minute = nowTotalTimer / 60;
                second = nowTotalTimer % 60;
                self.todayTimeLabel.text = [NSString stringWithFormat:@"%d分钟%d秒",minute, second];
            }else{
                self.todayTimeLabel.text = [NSString stringWithFormat:@"0分钟%d秒", nowTotalTimer];
            }
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",nowTotalTimer] forKey:@"nowDayTimer"];
            
        }
        
        
    }
    
}

- (void)finishedTimeLine:(EasyTimeline *)timeline
{
    
}

- (BOOL) isBlankString:(NSString *)string {//字符串为空处理
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


#pragma mark ----隐藏的排行----
-(void)maskClick{
    _maskButton.hidden=YES;
    _bgview = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.72, SCREEN_HEIGHT*0.11, SCREEN_WIDTH*0.27, SCREEN_HEIGHT*0.14)];
    [_bgview setBackgroundImage:[UIImage imageNamed:@"level_designation_bg_2"] forState:UIControlStateNormal];
    [_bgview addTarget:self action:@selector(bgViewClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bgview];
    
    _maskRankBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, _bgview.frame.origin.y-55, SCREEN_WIDTH*0.17, 25)];
    [_maskRankBtn setBackgroundImage:[UIImage imageNamed:@"03"] forState:UIControlStateNormal];
    [_maskRankBtn setTitle:@"读经排行榜" forState:UIControlStateNormal];
    _maskRankBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [_maskRankBtn addTarget:self action:@selector(maskRankClick) forControlEvents:UIControlEventTouchUpInside];
    [_maskRankBtn setTitleColor:majorityColor forState:UIControlStateNormal];
    [_bgview addSubview:_maskRankBtn];
    
    _gradeRankNice = [[UILabel alloc]initWithFrame:CGRectMake(_maskRankBtn.frame.origin.x, _maskRankBtn.frame.origin.y+_maskRankBtn.frame.size.height+5, 50, 20)];
    _gradeRankNice.text=@"当前等级";
    _gradeRankNice.textColor=[UIColor whiteColor];
    _gradeRankNice.font=[UIFont systemFontOfSize:10];
    [_bgview addSubview:_gradeRankNice];
    
    UIImageView * gradeImage = [[UIImageView alloc]initWithFrame:CGRectMake(_gradeRankNice.frame.origin.x+_gradeRankNice.frame.size.width-5, _maskRankBtn.frame.origin.y+_maskRankBtn.frame.size.height+9, 22, 13)];
    gradeImage.image=[UIImage imageNamed:@"level_bg"];
    [_bgview addSubview:gradeImage];
    _gradeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,1, 30, 10)];
    _gradeLabel.text=@"LV15";
    _gradeLabel.textColor=[UIColor whiteColor];
    _gradeLabel.font=[UIFont systemFontOfSize:9];
    [gradeImage addSubview:_gradeLabel];
    
    _practiceValueNice = [[UILabel alloc]initWithFrame:CGRectMake(_maskRankBtn.frame.origin.x,_gradeRankNice.frame.origin.y+_gradeRankNice.frame.size.height-3, 50, 20)];
    _practiceValueNice.text=@"修行者";
    _practiceValueNice.textColor=[UIColor whiteColor];
    _practiceValueNice.font=[UIFont systemFontOfSize:11];
    [_bgview addSubview:_practiceValueNice];
    
    _practiceValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(_practiceValueNice.frame.origin.x+_practiceValueNice.frame.size.width-5,_gradeRankNice.frame.origin.y+_gradeRankNice.frame.size.height-3, 50, 20)];
    _practiceValueLabel.text=@"622";
    _practiceValueLabel.textColor=[UIColor whiteColor];
    _practiceValueLabel.font=[UIFont systemFontOfSize:11];
    [_bgview addSubview:_practiceValueLabel];
    
}
-(void)bgViewClick{
    
    [_bgview removeFromSuperview];
    _maskButton.hidden=NO;
}
-(void)maskRankClick{
    
    DuJing_PHViewController * dujing = [[DuJing_PHViewController alloc]init];
    [self.navigationController pushViewController:dujing animated:YES];
}
#pragma mark ------关于排字

#pragma mark ------用于刷页
-(void)createScrollPageView
{
    [ProgressHUD hideAfterSuccessOnView:self.view];
    for(int i  = 0 ; i <  self.contentArray.count;i++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i,0,SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT - 55 - 30)];
        UILabel *contentLabel =[[UILabel alloc] initWithFrame:CGRectMake(15,0, SCREEN_WIDTH - 30,SCREEN_HEIGHT - NAVBARHEIGHT - 55 -30)];
        NSString *contentStr = self.contentArray[i];
        contentLabel.text = contentStr;
        contentLabel.textColor = [UIColor darkGrayColor];
        contentLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"read_book_main_bg.jpg"]];
        contentLabel.font = [UIFont boldSystemFontOfSize:16];
        contentLabel.numberOfLines = 0 ;
        [view addSubview:contentLabel];
        [self.scrollView addSubview:view];
    }
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.contentArray.count,0);
    self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)currentPage,(long)self.contentArray.count];
    [self.view addSubview:self.pageLabel];
    //    [self createTimer];
}
-(void)createNavBar
{
    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NAVBARHEIGHT)];
    [navBar setBackgroundImage:[UIImage imageNamed:@"puti_beads_top_title_bg.png"] forBarMetrics:UIBarMetricsDefault];
    UINavigationItem *titleItem = [[UINavigationItem alloc]initWithTitle:self.model.title];
    self.navItem = titleItem;
    NSDictionary *navTitleArr = [NSDictionary dictionaryWithObjectsAndKeys:
                                 
                                 [UIFont boldSystemFontOfSize:18],UITextAttributeFont,
                                 [UIColor whiteColor],UITextAttributeTextColor ,nil];
    [navBar setTitleTextAttributes:navTitleArr];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(20, 20,30, 25)];
    [leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [titleItem setLeftBarButtonItem:leftItem];
    [navBar pushNavigationItem:titleItem animated:NO];
    [self.view addSubview:navBar];
    
    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.9, 30, 25, 25)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"share_white_icon"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
}
#pragma mark -----在出去之前提示  并且输入自己的修行情况
-(void)backBtnClick
{
    if ([self.thisTimeLabel.text isEqualToString:@""]) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIAlertView * alrea = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"您本次已经读经%@秒啦,确定要停止读经吗?",self.thisTimeLabel.text] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alrea show];
        
        
    }
}
-(void)rightClick{
    
    _maskView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _maskView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [self.view addSubview:_maskView];
    
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.3, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.35)];
    _bgImageView.image = [UIImage imageNamed:@"share_dialog_bg"];
    _bgImageView.userInteractionEnabled=YES;
    [_maskView addSubview:_bgImageView];
    
    UIImageView * name = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.27, 30, SCREEN_WIDTH*0.25, SCREEN_HEIGHT*0.055)];
    name.image = [UIImage imageNamed:@"iv_title_share_dilog"];
    [_bgImageView addSubview:name];
    
    UIImageView * imageText = [[UIImageView alloc]initWithFrame:CGRectMake(name.frame.origin.x-35, name.frame.origin.y+name.frame.size.height+20, SCREEN_WIDTH*0.45, 30)];
    imageText.image=[UIImage imageNamed:@"edit_input_share_dialog"];
    [_bgImageView addSubview:imageText];
    
    _nameText = [[UITextField alloc]initWithFrame:CGRectMake(imageText.frame.origin.x+60, imageText.frame.origin.y+imageText.frame.size.height+170, SCREEN_WIDTH*0.4, 30)];
    _nameText.backgroundColor=[UIColor clearColor];
    _nameText.placeholder=@"请输入你的名字";
    _nameText.delegate=self;
    _nameText.font=[UIFont systemFontOfSize:14];
    [_maskView addSubview:_nameText];
    
    _controlBtn = [[UIButton alloc]initWithFrame:CGRectMake(imageText.frame.origin.x+10, imageText.frame.origin.y+imageText.frame.size.height+SCREEN_HEIGHT *0.35, SCREEN_WIDTH*0.28, 30)];
    [_controlBtn setBackgroundImage:[UIImage imageNamed:@"bt_cancel_share_dialog"] forState:UIControlStateNormal];
    _controlBtn.userInteractionEnabled=YES;
    [_controlBtn addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    [_maskView  addSubview:_controlBtn];
    
    _sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(_controlBtn.frame.origin.x+_controlBtn.frame.size.width+15, _controlBtn.frame.origin.y, SCREEN_WIDTH*0.28, 30)];
    [_sureBtn setBackgroundImage:[UIImage imageNamed:@"bt_sure_share_dialog"] forState:UIControlStateNormal];
    _sureBtn.userInteractionEnabled=YES;
    [_sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [_maskView  addSubview:_sureBtn];
}
#pragma mark ----回想中的按钮事件---
-(void)controlClick{
    
    
}
-(void)sureClick{
    
    
}
#pragma mark ---alertview代理---
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (buttonIndex == 1 ){// [ProgressHUD showOnView:self.view];
        AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
        NSNumber *miyaoNum= [appDelegate.accountBasicDict objectForKey:@"secretKey"];
        NSNumber * userLoginID= [appDelegate.accountBasicDict objectForKey:@"userLoginID"];
        //这里的bookID要传什么值，为什么0也是对的
        NSDictionary * dic = @{@"secretKey":miyaoNum,@"userLoginID":userLoginID,@"huaienID":huaien,@"userTaskID":@0,@"taskCode":@500,@"sceneType":@1,@"buddhistTempleID":@0,@"bookID":@0,@"beginPostion":@0,@"endPostion":@0};
        NSDictionary * meditionDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
        
        AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,SubmitSitMeditationURL] parameters:meditionDic success:^(NSURLSessionDataTask *task, id responseObject) {
            
            id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"提交数据=%@",jsonData);
            NSNumber *result =jsonData[@"result"];
            NSString *desc =jsonData[@"desc"];
            if([result integerValue]>0){
                UILabel *label = [[UILabel alloc]init];
                label.frame = CGRectMake(SCREEN_WIDTH *0.3, SCREEN_HEIGHT*0.8,SCREEN_WIDTH*0.4, 30);
                //@"签到成功,获得祈福币%@",jsonData[@"prayMoney"]
                label.text =@"提交成功";
                label.textColor = [UIColor whiteColor];
                label.textAlignment = 1;
                label.backgroundColor = [UIColor blackColor];
                label.font = [UIFont boldSystemFontOfSize:12];
                [UIView animateWithDuration:1.5 animations:^{
                    label.alpha = 0;
                    [self.view addSubview:label];
                    
                } completion:^(BOOL finished) {
                    [self.navigationController popViewControllerAnimated:YES];
                    [label removeFromSuperview];
                }];
            }
            else{
                UILabel *label = [[UILabel alloc]init];
                label.frame = CGRectMake(SCREEN_WIDTH *0.3, SCREEN_HEIGHT*0.8,SCREEN_WIDTH*0.4, 30);
                //@"签到成功,获得祈福币%@",jsonData[@"prayMoney"]
                label.text =desc;
                label.textColor = [UIColor whiteColor];
                label.textAlignment = 1;
                label.backgroundColor = [UIColor blackColor];
                label.font = [UIFont boldSystemFontOfSize:12];
                [UIView animateWithDuration:1.5 animations:^{
                    label.alpha = 0;
                    [self.view addSubview:label];
                    
                } completion:^(BOOL finished) {
                    [self.navigationController popViewControllerAnimated:YES];
                    [label removeFromSuperview];
                }];
                
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
}
#pragma mark  ------读出Document中的文件
-(NSString *)readFileWith:(CollectModel  * ) readModel
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"Book_ForReading"];
    [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *txtName = [NSString stringWithFormat:@"%ldreading.txt",(long)readModel.collectID];
    NSString *txtPath = [testDirectory stringByAppendingPathComponent:txtName];
    return [NSString stringWithContentsOfFile:txtPath encoding:NSUTF8StringEncoding error:nil];
}
-(void)prepareContentViewArray
{
    //关于字体大小
    NSInteger fontSize = 24;
    NSString  *singleStr = @"晴";
    CGSize  size   =  CGSizeMake(MAXFLOAT,MAXFLOAT);
    //当前的View
    UIView * contentView  = [[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT - 55 - NAVBARHEIGHT)];
    CGFloat singleHeight =  [singleStr sizeWithFont:[UIFont systemFontOfSize:fontSize] maxSize:size].height;
    CGFloat singleWidth = [singleStr  sizeWithFont:[UIFont systemFontOfSize:fontSize] maxSize:size].width;
    //先确定有多少行 有多少列
    NSInteger columns = SCREEN_WIDTH /  singleWidth - 1;
    CGFloat marginX  = (SCREEN_WIDTH - (columns * singleWidth)) / 2;
    NSInteger ranks  =  contentView.frame.size.height / singleHeight - 1;
    NSString *contentStr = self.contentStr;
    NSArray  *contentStrArray = [contentStr  componentsSeparatedByString:@"\n"];
    // 表示从第一段开始
    int  index = 0 ;
    //当最后一段时跳出
    NSInteger flagColumn = 0 ;
    NSInteger flagRank  = 0 ;
    NSInteger flagPage = 0 ;
    while (index != contentStrArray.count)
    {
        NSString  *paragraphStr = contentStrArray[index++];
        for(int i = 0 ; i < paragraphStr.length ; i++)
        {
            NSString * singleStr = [NSString stringWithFormat:@"%C",[paragraphStr characterAtIndex:i]];
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(marginX+ singleWidth * flagColumn++,singleHeight * flagRank, singleWidth,singleHeight)];
            label.font = [UIFont systemFontOfSize:fontSize];
            label.text =  singleStr;
            label.textColor=[UIColor colorWithRed:118.0f/255.0f green:75.0f/255.0f blue:17.0f/255.0f alpha:0.5f];
            //label.backgroundColor = [UIColor yellowColor];
            [contentView addSubview:label];
            if (flagColumn == columns)
            {
                flagColumn = 0 ;
                if (i == paragraphStr.length - 1) {
                    
                }
                else
                {
                    flagRank ++;
                }
            }
            if (flagRank == ranks) {
                [self.contentViewArray addObject:contentView];
                contentView = [[UIView alloc] initWithFrame:CGRectMake((++flagPage)*SCREEN_WIDTH,0,SCREEN_WIDTH,SCREEN_HEIGHT - NAVBARHEIGHT - 55)];
                contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"read_book_main_bg.jpg"]];
                flagColumn = 0 ;
                flagRank = 0;
            }
        }
        flagRank ++;
        flagColumn = 0 ;
        if (index == contentStrArray.count) {
            [self.contentViewArray addObject:contentView];
        }
    }
    for( int i = 0 ; i < self.contentViewArray.count ; i++)
    {
        UIView *  view = self.contentViewArray[i];
        [self.scrollView addSubview:view];
    }
    self.scrollView.contentSize = CGSizeMake(self.contentViewArray.count * SCREEN_WIDTH,0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageLabel];
    [ProgressHUD hideAfterSuccessOnView:self.view];
    
}
#pragma mark ------返回每一页的视图
-(UIView *)createPerContentView
{
    //关于字体大小
    NSInteger fontSize = 24;
    NSString  *singleStr = @"晴";
    CGSize  size   =  CGSizeMake(MAXFLOAT,MAXFLOAT);
    UIView * contentView  = [[UIView alloc]initWithFrame:CGRectMake(0,NAVBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT - 55 - NAVBARHEIGHT)];
    CGFloat singleHeight =  [singleStr sizeWithFont:[UIFont systemFontOfSize:fontSize] maxSize:size].height;
    CGFloat singleWidth = [singleStr  sizeWithFont:[UIFont systemFontOfSize:fontSize] maxSize:size].width;
    contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"read_book_main_bg.jpg"]];
    //先确定有多少行 有多少列
    NSInteger columns = SCREEN_WIDTH /  singleWidth - 1;
    CGFloat marginX  = (SCREEN_WIDTH - (columns * singleWidth)) / 2;
    NSInteger ranks  =  contentView.frame.size.height / singleHeight - 1;
    
    NSString *contentStr = [self readFileWith:self.model];
    NSArray  *contentStrArray = [contentStr  componentsSeparatedByString:@"\n"];
    
    NSInteger  flagColumn = 0 ;
    NSInteger  flagRank   = 0 ;
    BOOL isFull = NO;
    for(int i = 0 ; i < contentStrArray.count ;i++)
    {
        NSString * paragreaphStr = contentStrArray[i];
        if (paragreaphStr.length % columns == 0) {
            isFull = YES;
        }
        for(int j = 0 ; j < paragreaphStr.length;j++)
        {
            NSString * str = [NSString stringWithFormat:@"%C",[paragreaphStr characterAtIndex:j]];
            UILabel  * label = [[UILabel alloc]initWithFrame:CGRectMake(marginX +singleWidth *(flagColumn++),singleHeight * flagRank,singleWidth, singleHeight)];
            //label.backgroundColor = [UIColor yellowColor];
            label.font = [UIFont systemFontOfSize:fontSize];
            label.text = str;
            label.textColor=[UIColor colorWithRed:118.0f/255.0f green:75.0f/255.0f blue:17.0f/255.0f alpha:0.5f];
            
            [contentView addSubview:label];
            if (flagColumn == columns)
            {
                flagColumn = 0 ;
                flagRank ++;
            }
            if (flagRank == ranks) {
                return contentView;
            }
        }
        //表示上一行满的
        if (isFull) {
            flagRank --;
        }
        else
        {
            flagRank ++;
        }
        isFull =  NO;
        flagColumn = 0 ;
    }
    return contentView;
}
#pragma mark -----返回每一页的内容
//表示每一页从location开始
-(NSString *)currentBookContent:(NSString *) content
{
    CGSize  maxSize = CGSizeMake(SCREEN_WIDTH - 30 , MAXFLOAT);
    NSString  * contentStr =  [content substringFromIndex:sumLocation];
    NSString * tempStr;
    NSString * testStr = @"测试";
    CGFloat  sigalLineHeight = [testStr sizeWithFont:[UIFont boldSystemFontOfSize:16] maxSize:maxSize].height;
    CGFloat contentLabelHeight = self.contentLabel.frame.size.height+sigalLineHeight;
    for(int i = 0 ; i < contentStr.length; i++)
    {
        tempStr = [contentStr substringToIndex:i];
        CGFloat  height =  [tempStr sizeWithFont:[UIFont boldSystemFontOfSize:16] maxSize:maxSize].height;
        if (fabs(contentLabelHeight - height) <= sigalLineHeight ||i == contentStr.length - 1 ) {
            location = i ;
            sumLocation +=location;
            break;
        }
    }
    return tempStr;
}
static int i = 0 ;
#pragma mark --------切割TXT文本
-(void)cutTheTXTString
{
    self.contentStr = [self readFileWith:self.model];
    NSString *currentStr;
    while (sumLocation != self.contentStr.length - 1)
    {
        currentStr = [self currentBookContent:self.contentStr];
        [self.contentArray addObject:currentStr];
    }
    [self createScrollPageView];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    currentPage= scrollView.contentOffset.x / scrollView.frame.size.width;
    self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)currentPage+1,(long)self.contentViewArray.count];
}
//#pragma mark -----创建定时器
//-(void)createTimer
//{
//    self.timer  = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(changeTheTime) userInfo:nil repeats:YES];
//}
#pragma mark ------用于改变时间标签
//-(void)changeTheTime
//{
//    self.thisTimeLabel.text = [NSString stringWithFormat:@"%ld分钟",(long)thisTime++];
//    self.todayTimeLabel.text = [NSString stringWithFormat:@"%ld分钟",(long)todayTime++];
//    self.sumTimeLabel.text =  [NSString stringWithFormat:@"%ld分钟",(long)sumTime++];
//}
#pragma mark --------处理下载经书
-(void)downLoadBookData:(CollectModel *) model1 WithUrl:(NSString *) downloadURL IsReading:(BOOL)isReading
{
    [ProgressHUD showOnView:self.view];
    
    NSString *url = [downloadURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [NetWorking sendAsynchronousRequestWithURLString:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30 completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError == nil) {
            self.contentStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            // [self.view addSubview:[self createPerContentView]];
            [self prepareContentViewArray];
            //截取到数据后一方面存起来  另则展示
            //[self cutTheTXTString];
            //[self selectAllFileWith:model1 WithData:data IsReading:isReading];
        }
    }];
}
#pragma mark ------在Document里创建文件
-(void)selectAllFileWith:(CollectModel *) model1 WithData:(NSData *)data IsReading:(BOOL)isReading
{
    NSString *flagStr;
    if (isReading) {
        flagStr  = @"reading";
    }
    else
    {
        flagStr  = @"writing";
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"Book_ForReading"];
    [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *txtName = [NSString stringWithFormat:@"%ld%@.txt",(long)model1.collectID,flagStr];
    NSString *txtPath = [testDirectory stringByAppendingPathComponent:txtName];
    [fileManager createFileAtPath:txtPath contents:data attributes:nil];
}

#pragma mark ---键盘隐藏---
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {  // 这个方法是
    if (theTextField == _nameText) {
        [theTextField resignFirstResponder]; //这句代码可以隐藏 键盘
    }
    return YES;
}
#pragma mark 累积数
-(void)loadCurrentData
{
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * miyaoNum = [appDelegate.accountBasicDict  objectForKey:@"secretKey"];
    NSLog(@"密码＝%@",miyaoNum);
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSLog(@"ID＝%@",huaien);
    NSDictionary * currentDict=@{@"secretKey":miyaoNum,@"huaienID":huaien,@"taskCode":@500};
    NSDictionary * currentDict1 = @{@"params":[NSString stringWithFormat:@"%@",currentDict]};
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,ptxGetUserTaskCurrentStatInfo]  parameters:currentDict1 success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"累积数＝%@",jsonData);
        NSNumber *currentQty=jsonData[@"currentQty"];
        int currentTime=[currentQty intValue];
        [[NSUserDefaults standardUserDefaults]setObject:currentQty forKey:@"currentQty"];
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",currentTime] forKey:@"nowDayTime"];
        NSNumber * totalQty=jsonData[@"totalQty"];
        int totalTime=[totalQty intValue];
        [[NSUserDefaults standardUserDefaults]setObject:totalQty forKey:@"totalQty"];
        
        [[NSUserDefaults standardUserDefaults]setValue: [NSString stringWithFormat:@"%d",totalTime] forKey:@"totalTimer"];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

@end
