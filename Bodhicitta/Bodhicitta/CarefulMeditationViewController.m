//
//  CarefulMeditationViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/10/26.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "CarefulMeditationViewController.h"
#import "HeaderFile.h"
#import "SimpleAudioEngine.h"
#import "ZuoChanViewController.h"
#import "ZhunBeiViewController.h"
@interface CarefulMeditationViewController ()<UIActionSheetDelegate,UIAlertViewDelegate>{
    
    NSInteger   second;
    BOOL  isOn;
    BOOL isClick;
    
}
@property(nonatomic,strong)UINavigationBar * bar;
@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,strong)UILabel * secondLabel;
@property(nonatomic,strong)UIButton * musicBt;
@property(nonatomic,strong)UIButton * playBtn;
@property(nonatomic,strong)UIImageView * bgview;
@property(nonatomic,strong)UIButton * problemerBtn;
@property(nonatomic,strong)UIButton * fanhuiBtn;
@property(nonatomic,strong)UIButton * voiceBtn;
@property(nonatomic,strong)UIButton * cantelBtn;
@property(nonatomic,strong)UIButton * startBtn;
@end

@implementation CarefulMeditationViewController
//计时
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

- (void)viewDidLoad {
    [super viewDidLoad];
   _bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.1+5)];
    
    [_bar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:_bar];
    
    _fanhuiBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [_fanhuiBtn setBackgroundImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [_fanhuiBtn addTarget:self action:@selector(fanhuiBtnclick) forControlEvents:UIControlEventTouchUpInside];
    [_bar addSubview:_fanhuiBtn];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"精心修禅";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [_bar addSubview:title];
    
    _problemerBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.89, 0.05*SCREEN_HEIGHT, 33, 25)];
    [_problemerBtn setBackgroundImage:[UIImage imageNamed:@"pop_more_choose.png"] forState:UIControlStateNormal];
    [_problemerBtn addTarget:self action:@selector(proClick) forControlEvents:UIControlEventTouchUpInside];
    [_bar addSubview:_problemerBtn];
    
    [self createButtonUI];
    
}
//最迟的返回按钮事件
-(void)fanhuiBtnclick{

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)proClick{

    UIActionSheet * actionsheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"回响",@"坐禅记录",@"为何坐禅",@"坐禅准备", nil];
    [actionsheet showInView:self.view];
}
//主界面
-(void)createButtonUI{
    
    CGFloat width;
    CGFloat height ;
    CGFloat font;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        width = 210;
        height =  148;
        font = 16;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            width = 180;
            height = 125;
            font = 14;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            width = 233;
            height = 160;
            font = 18;
        }
        else
        {
            width = 180;
            height  = 105;
            font = 13;
        }
    }
    _bgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, _bar.frame.origin.y+_bar.frame.size.height, SCREEN_WIDTH, height*4.1)];
    _bgview.image=[UIImage imageNamed:@"no_meditation_bg.jpg"];
    _bgview.userInteractionEnabled=YES;
    [self.view addSubview:_bgview];

    _musicBt=[[UIButton alloc]initWithFrame:CGRectMake(width*1.1, height*3.68, 0.2*width, 0.2*height)];
    [_musicBt setBackgroundImage:[UIImage imageNamed:@"care_music_off"] forState:UIControlStateNormal];
    [_musicBt addTarget:self action:@selector(musicClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgview addSubview:_musicBt];
    
    _playBtn=[[UIButton alloc]initWithFrame:CGRectMake(width*0.78, height*3.1, width*0.21, 0.25*height)];
    [_playBtn setBackgroundImage:[UIImage imageNamed:@"start_meditate"] forState:UIControlStateNormal];
    [_playBtn addTarget:self action:@selector(playBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgview addSubview:_playBtn];


}

#pragma mark -------主页按钮事件
//音乐
-(void)musicClick{

    if (isClick==YES) {
        [_musicBt setBackgroundImage:[UIImage imageNamed:@"care_music_off"] forState:UIControlStateNormal];
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        isClick=NO;
    }else{
        
        [_musicBt setBackgroundImage:[UIImage imageNamed:@"care_music_on"] forState:UIControlStateNormal];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"meditation.mp3"];
        isClick=YES;
    }

}
//计时
-(void)playBtnClick{

    if ((isClick =NO)) {
        _fanhuiBtn.hidden=YES;
        UIButton * backBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_bar addSubview:backBtn];
        isClick=YES;
    }else{
        CGFloat width;
        CGFloat height ;
        CGFloat font;
        if (fabs(SCREEN_HEIGHT-667) < 1) {
            width = 210;
            height =  148;
            font = 16;
        }
        else
        {
            if (fabs(SCREEN_HEIGHT -568) < 1) {
                width = 180;
                height = 125;
                font = 14;
            }
            else if (fabs(SCREEN_HEIGHT - 736) < 1)
            {
                width = 233;
                height = 160;
                font = 18;
            }
            else
            {
                width = 180;
                height  = 105;
                font = 13;
            }
        }

        UIImageView *tintView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH ,SCREEN_HEIGHT)];
        tintView.image=[UIImage imageNamed:@"background.png"];
        tintView.userInteractionEnabled=YES;
        [self.view addSubview:tintView];
        
        UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.25,height*1.5,width*1.3,height*0.3)];
//        self.topImageView = topImageView;
        topImageView.image = [UIImage imageNamed:@"offer_top_bg_dialog"];
        [tintView addSubview:topImageView];
        
        UIImageView * bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(topImageView.frame.origin.x,topImageView.frame.size.height+topImageView.frame.origin.y,width*1.3, 1.2 *height)];
        bottomImageView.image = [UIImage imageNamed:@"offer_bottom_bg_dialog"];
        bottomImageView.userInteractionEnabled=YES;
        [tintView addSubview:bottomImageView];
        
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(width*0.5, 10, width*0.5, height*0.1)];
        titleLabel.text=@"温馨提示";
        titleLabel.textColor=[UIColor whiteColor];
        titleLabel.font=[UIFont systemFontOfSize:18];
        [topImageView addSubview:titleLabel];
        
        UILabel * contenLabel = [[UILabel alloc]initWithFrame:CGRectMake(width*0.1, 20, width*1.5, height*0.2)];
        contenLabel.text=@"寻一舒适的环境，安静的坐下来";
        contenLabel.font=[UIFont systemFontOfSize:16];
        [bottomImageView addSubview:contenLabel];
        
        _voiceBtn = [[UIButton alloc]initWithFrame:CGRectMake(contenLabel.frame.origin.x, contenLabel.frame.origin.y+contenLabel.frame.size.height+height*0.1, 23, 23)];
        [_voiceBtn setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        [_voiceBtn addTarget:self action:@selector(voiceClick) forControlEvents:UIControlEventTouchUpInside];
        [bottomImageView addSubview:_voiceBtn];
        
        UILabel * voiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_voiceBtn.frame.origin.x+_voiceBtn.frame.size.width+10, _voiceBtn.frame.origin.y-5, width*1.1, height*0.2)];
        voiceLabel.text=@"开启语音引导";
        voiceLabel.font=[UIFont systemFontOfSize:16];
        [bottomImageView addSubview:voiceLabel];
        
        _cantelBtn = [[UIButton alloc]initWithFrame:CGRectMake(_voiceBtn.frame.origin.x+_voiceBtn.frame.size.width+6, _voiceBtn.frame.origin.y+_voiceBtn.frame.size.height+20, 70, 30)];
        [_cantelBtn setBackgroundImage:[UIImage imageNamed:@"bt_cancel_offer_bg"] forState:UIControlStateNormal];
        [_cantelBtn  setTitle:@"取消" forState:UIControlStateNormal];
        _cantelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cantelBtn  setTitleColor:cancelColor forState:UIControlStateNormal];
        [_cantelBtn addTarget:self action:@selector(cantelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [bottomImageView addSubview:_cantelBtn];
        
        _startBtn = [[UIButton alloc]initWithFrame:CGRectMake(_cantelBtn.frame.origin.x+_cantelBtn.frame.size.width+20, _cantelBtn.frame.origin.y, 90, 40)];
        [_startBtn setBackgroundImage:[UIImage imageNamed:@"bt_sure_offer_bg"] forState:UIControlStateNormal];
        [_startBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_startBtn setTitle:@"开始坐禅" forState:UIControlStateNormal];
        _startBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bottomImageView addSubview:_startBtn];


//        self.secondLabel=[[UILabel alloc]initWithFrame:CGRectMake(_musicBt.frame.origin.x-SCREEN_WIDTH*0.25, _musicBt.frame.origin.y-5, self.view.frame.size.width, 40)];
////        self.secondLabel.text=@"00:00:00";
//        self.secondLabel.backgroundColor=[UIColor clearColor];
//        self.secondLabel.textColor=[UIColor colorWithRed:201.0f/255.0f green:105.0f/255.0f blue:0.0f/255.0f alpha:1];
//        self.secondLabel.font=[UIFont systemFontOfSize:18.0f];
//        [_bgview addSubview:self.secondLabel];
//        [UIView animateWithDuration:10 animations:^{
//            self.secondLabel.text=@"00:00:00";
//        } completion:^(BOOL finished) {
//            if (!isOn) {
//                [self.timer setFireDate:[NSDate distantPast]];
//                isOn = YES;
//                NSLog(@"打开");
//            }
//            else
//            {
//                [self.timer setFireDate:[NSDate distantFuture]];
////                isOn=NO;
//                NSLog(@"关了");
//            }
//        }];
        
        isClick=NO;
        
    }

}
-(void)backBtnClick{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"你已经坐禅%ld秒啦,确定停止坐禅吗？",second] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
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

#pragma mark ----actionsheet代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex==1) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else if (buttonIndex==2){
        ZuoChanViewController * zuochan = [[ZuoChanViewController alloc]init];
        [self.navigationController pushViewController:zuochan animated:YES];
        
    }else if (buttonIndex==3){
    
        ZhunBeiViewController * zhunbei = [[ZhunBeiViewController alloc]init];
        [self.navigationController pushViewController:zhunbei animated:YES];
        
    }else if (buttonIndex==4){
    
        
    }else if (buttonIndex==5){
    
        
    }

}

@end
