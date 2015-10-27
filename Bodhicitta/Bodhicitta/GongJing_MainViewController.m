//
//  GongJing_MainViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/20.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//
#import "TeaView.h"
#import "GongJing_MainViewController.h"
#import "HeaderFile.h"
#import "PrayMoneyView.h"

#define Start_X 10.0f           // 第一个按钮的X坐标

#define Start_Y 60.0f           // 第一个按钮的Y坐标

#define Width_Space 10.0f        // 2个按钮之间的横间距

#define Height_Space 10.0f      // 竖间距

#define Button_Height 20.0f    // 高

#define Button_Width 68.0f      // 宽


@interface GongJing_MainViewController ()<QingFoViewDelegate>
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView *foImageView;
@property(nonatomic,strong) UIImageView *foxImageView;
@property(nonatomic,strong) NSString *textview;
@property(nonatomic,strong) NSString *contentText;
@property(nonatomic,strong) NSString *jianjieText;
@property(nonatomic,strong) NSMutableArray *teaArray;
@property(nonatomic,strong) NSMutableArray *fruitArray;
@property(nonatomic,strong) NSMutableArray *flowerArrray;
@property(nonatomic,strong) NSMutableArray *incenseArray;
@property(nonatomic,strong) UIImageView * fristImageView;
@property(nonatomic,strong) UIButton * cancelBtn;
@property(nonatomic,strong) UIButton * sureBtn;
@property(nonatomic,strong) UILabel * coinLabel;
@property(nonatomic,strong) UILabel * nameLabel;
@property(nonatomic,strong) UILabel * moralLabel1;
@property(nonatomic,strong) UILabel * moralLabel2;
@property(nonatomic,strong) UIImageView * lastImageView;
@property(nonatomic,strong) UILabel * titleLabel;
@property(nonatomic,strong) UIView *maskView;
@property(nonatomic,strong) TeaView * teaView;
@property(nonatomic,strong) PrayMoneyView * prayMoneyView;
@property(nonatomic,strong)UIScrollView *tributeScrollView;
@property(nonatomic,strong) TributeModel * model;
@end

//计算字的高度
@interface NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end
@implementation NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
@implementation GongJing_MainViewController
-(UIView *)maskView
{
    if (_maskView == nil) {
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [_maskView addGestureRecognizer:tapGes];
        _maskView.alpha = 0.5;
    }
    return _maskView;
}
-(void)tapClick
{
    [_maskView removeFromSuperview];
    [backgroundImage removeFromSuperview];
    [self.tributeScrollView removeFromSuperview];
    [jianjie removeFromSuperview];
    [self.fristImageView removeFromSuperview];
    [self.lastImageView removeFromSuperview];
    [self.cancelBtn removeFromSuperview];
    [self.sureBtn removeFromSuperview];
}
-(NSMutableArray *)teaArray
{
    if (_teaArray == nil) {
        _teaArray = [[NSMutableArray alloc] init];
    }
    return _teaArray;
}
-(NSMutableArray *)flowerArrray
{
    if (_flowerArrray == nil) {
        _flowerArrray = [[NSMutableArray alloc] init];
    }
    return _flowerArrray;
}
-(NSMutableArray *)incenseArray{

    if (_incenseArray == nil) {
        
        _incenseArray=[[NSMutableArray alloc]init];
    }
    return _incenseArray;
}
-(NSMutableArray *)fruitArray{

    if (_fruitArray == nil) {
        _fruitArray = [[NSMutableArray alloc]init];
    }
    return _fruitArray;
}
@synthesize selectedNumber;
@synthesize backfugei;
@synthesize titlefugeiLa;
@synthesize scrollfugai;
@synthesize imagefugai;
@synthesize shuomingfugai;
@synthesize imageLa;
@synthesize shuomingLa;
@synthesize startBt;
@synthesize againBt;
@synthesize qianName;
@synthesize content;
@synthesize chouqianImage;
@synthesize markImage;
@synthesize Signpaper;
@synthesize tishi;
@synthesize jianjie;
@synthesize jianjiebgImage;

-(void)takeAction:(NSString *)name takeImage:(UIImage *)image
{
    
    self.foxImageView.image = image;
    NSLog(@"lalalala%@",self.foxImageView);
    bar.hidden=YES;
    isClick = YES;
    backfugei=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [backfugei setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backfugei addTarget:self action:@selector(backfugeiclick) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:backfugei];
    
    titlefugeiLa=[[UILabel alloc]initWithFrame:CGRectMake(150, 33, 90, 25)];
    titlefugeiLa.text=@"求签请佛";
    titlefugeiLa.textColor=[UIColor whiteColor];
    titlefugeiLa.font=[UIFont systemFontOfSize:20];
    [self.bgView  addSubview:titlefugeiLa];
    
    imagefugai=[[UIImageView alloc]initWithFrame:CGRectMake(125, 85, SCREEN_WIDTH-250, SCREEN_HEIGHT-370)];
    imagefugai.image=[UIImage imageNamed:@"sign_stick_icon"];
    [self.bgView addSubview:imagefugai];
    
    shuomingfugai=[[UIImageView alloc]initWithFrame:CGRectMake(30, 400, SCREEN_WIDTH-60, SCREEN_HEIGHT-520)];
    shuomingfugai.image=[UIImage imageNamed:@"please_buddha_rule_bg"];
    [self.bgView addSubview:shuomingfugai];
    
    scrollfugai = [[UIScrollView alloc] initWithFrame:CGRectMake(50, 410, SCREEN_WIDTH-100, SCREEN_HEIGHT*0.15)];
    [scrollfugai setShowsHorizontalScrollIndicator:NO];
    [scrollfugai setShowsVerticalScrollIndicator:NO];
    [scrollfugai setContentSize:CGSizeMake(285, 200)];
    [scrollfugai setBackgroundColor:[UIColor clearColor]];
    scrollfugai.userInteractionEnabled = YES;
    [self.bgView addSubview:scrollfugai];
    
    imageLa=[[UILabel alloc]initWithFrame:CGRectMake(0,10, 100, 20)];
    imageLa.text=@"请佛说明";
    imageLa.font=[UIFont systemFontOfSize:16];
    [scrollfugai addSubview:imageLa];
    
    CGFloat marginX = 40;
    CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH - 2*marginX, MAXFLOAT);
    CGFloat contentHeight = [self.textview sizeWithFont:[UIFont systemFontOfSize:14] maxSize:textMaxSize].height;
    shuomingLa=[[UILabel alloc]initWithFrame:CGRectMake(marginX-20,30, SCREEN_WIDTH - 2*marginX-40, contentHeight)];
    shuomingLa.text = self.textview;
    shuomingLa.numberOfLines = 0 ;
    shuomingLa.font = [UIFont systemFontOfSize:14];
    [scrollfugai addSubview:shuomingLa];
    
    startBt=[[UIButton alloc]initWithFrame:CGRectMake(150, 570, 90, 35)];
    [startBt setBackgroundImage:[UIImage imageNamed:@"bt_please_buddha_bg"] forState:UIControlStateNormal];
    [startBt setTitle:@"开始请佛" forState:UIControlStateNormal];
    [startBt setTitleColor:Typeface forState:UIControlStateNormal];
    [startBt addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:startBt];
    
}

-(NSString *)textview{

    if (_textview==nil) {
        _textview=@"1.求到“上签”或“上上签”即可成功请佛。2.成功请佛1次，将消耗祈福币500个  。      3.每日最多可求签3次，不成功不扣币。    4.每位用户最多可请3尊神佛。";
    }
    
    if (_contentText==nil) {
        _contentText=@"彼亦俦中一辈贤，劝军特达与周旋。此时宾主欢相会，他日王侯却并肩。";
    }
    return _textview;
}
-(void)backfugeiclick{
    
    fanhuiBt.hidden=NO;
    backfugei.hidden=NO;
    bar.hidden=NO;
    titlefugeiLa.hidden=YES;
    self.foxImageView.hidden=YES;
    scrollfugai.hidden=YES;
    startBt.hidden=YES;
    imagefugai.hidden=YES;
    shuomingfugai.hidden=YES;
    chouqianImage.hidden=YES;
    
}
-(void)startClick{

    scrollfugai.hidden=YES;
    startBt.hidden=YES;
    imagefugai.hidden=YES;
    shuomingfugai.hidden=YES;
    
    chouqianImage=[[UIImageView alloc]initWithFrame:CGRectMake(35, 230, SCREEN_WIDTH-70, SCREEN_HEIGHT-450)];
    chouqianImage.image=[UIImage imageNamed:@"please_buddha_rule_bg"];
    [self.bgView addSubview:chouqianImage];
    
    markImage=[[UIImageView alloc]initWithFrame:CGRectMake(40, 20, 15, 130)];
    markImage.image=[UIImage imageNamed:@"sign_stick_stick"];
    [chouqianImage addSubview:markImage];
    
    qianName=[[UILabel alloc]initWithFrame:CGRectMake(140, 20, 100, 20)];
    qianName.text=@"上上签";
    qianName.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
    [chouqianImage addSubview:qianName];
    
    Signpaper=[[UILabel alloc]initWithFrame:CGRectMake(120, 60, 80, 10)];
    Signpaper.text=@"签文 :";
    Signpaper.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
    [chouqianImage addSubview:Signpaper];
    
    CGFloat marginX = 40;
    CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH - 2*marginX, MAXFLOAT);
    CGFloat contentHeight = [self.textview sizeWithFont:[UIFont systemFontOfSize:14] maxSize:textMaxSize].height;
    content=[[UILabel alloc]initWithFrame:CGRectMake(marginX+80,80, SCREEN_WIDTH - 2*marginX-180, contentHeight)];
    content.text = self.contentText;
    content.numberOfLines = 0 ;
    content.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [chouqianImage addSubview:content];
    
    tishi=[[UITextView alloc]initWithFrame:CGRectMake(marginX-5,150, SCREEN_WIDTH - 2*marginX-80, contentHeight-10)];
    tishi.text=@"恭喜您！抽到上上签！请佛成功！快请神佛入佛堂吧！";
    [tishi setEditable:NO];
    tishi.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
    tishi.backgroundColor=[UIColor clearColor];
    [chouqianImage addSubview:tishi];
    
    againBt=[[UIButton alloc]initWithFrame:CGRectMake(150, 500, 80, 30)];
    [againBt setTitle:@"请入佛堂" forState:UIControlStateNormal];
    [againBt setBackgroundImage:[UIImage imageNamed:@"bt_please_buddha_bg"] forState:UIControlStateNormal];
    [againBt setTitleColor:Typeface forState:UIControlStateNormal];
    [againBt addTarget:self action:@selector(againClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:againBt];
    
}

-(void)againClick{
   
    fanhuiBt.hidden=NO;
    backfugei.hidden=NO;
    bar.hidden=NO;
    scrollfugai.hidden=YES;
    startBt.hidden=YES;
    imagefugai.hidden=YES;
    shuomingfugai.hidden=YES;
    chouqianImage.hidden=YES;
    againBt.hidden=YES;
    self.foxImageView.hidden=YES;

    self.foImageView.image=[UIImage imageNamed:@"佛"];
    qingfoBt.hidden=YES;
    
    scrollviewImage = [[UIScrollView alloc] initWithFrame:CGRectMake(50, 410, 285, 155)];
    [scrollviewImage setShowsHorizontalScrollIndicator:NO];
    [scrollviewImage setShowsVerticalScrollIndicator:NO];
    [scrollviewImage setContentSize:CGSizeMake(1285, 200)];
    [scrollviewImage setBackgroundColor:[UIColor clearColor]];
    scrollfugai.userInteractionEnabled = YES;
    [self.view addSubview:scrollviewImage];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self getTribute];
    isClick = NO;
    backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, self.view.frame.size.height)];
    backgroundview.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景.png"]];
    [self.view addSubview:backgroundview];
    self.bgView = backgroundview;
    
    bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 380, self.view.frame.size.height)];
    bgImage.userInteractionEnabled = YES;
    bgImage.image=[UIImage imageNamed:@"480x800.jpg"];
    [backgroundview addSubview:bgImage];
    
    bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 375, 70)];
    
    [bar setBackgroundImage:[UIImage imageNamed:@"meditation_top_bg.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:bar];
    
    fanhuiBt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [fanhuiBt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [fanhuiBt addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:fanhuiBt];
    
    title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"恭敬礼佛";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [bar addSubview:title];
    
    qingfoScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.13, SCREEN_WIDTH, SCREEN_HEIGHT*0.9)];
    [qingfoScroll setShowsHorizontalScrollIndicator:NO];
    [qingfoScroll setDelegate:self];
    [qingfoScroll setBackgroundColor:[UIColor clearColor]];
    [backgroundview addSubview:qingfoScroll];

    self.foImageView=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, 0, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.59)];
    NSLog(@"hahaha%@",self.foImageView);
    self.foImageView.image=[UIImage imageNamed:@"480佛"];
    [qingfoScroll addSubview:self.foImageView];
    
    
#pragma view覆盖界面
    //反弹出来的付给界面所需要的....
    self.foxImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    NSLog(@"hahaha%@",self.foxImageView);
    self.foxImageView.image=[UIImage imageNamed:@" "];
    [backgroundview addSubview:self.foxImageView];
    
    qingfoBt=[[UIButton alloc]initWithFrame:CGRectMake(145, 250, 90, 90)];
    [qingfoBt setBackgroundImage:[UIImage imageNamed:@"gjlf"] forState:UIControlStateNormal];
    qingfoBt.userInteractionEnabled=YES;
    [qingfoBt addTarget:self action:@selector(qingfoClick) forControlEvents:UIControlEventTouchUpInside];
    [qingfoScroll addSubview:qingfoBt];
    
    UILabel * qingfoLa=[[UILabel alloc]initWithFrame:CGRectMake(20, 15, 150, 30)];
    qingfoLa.text=@"恭请";
    qingfoLa.font=[UIFont fontWithName:@"Helvetica-Bold" size:25];
    qingfoLa.textColor=[UIColor whiteColor];
    [qingfoBt addSubview:qingfoLa];
    UILabel * qingfoLa1=[[UILabel alloc]initWithFrame:CGRectMake(20, 45, 150, 30)];
    qingfoLa1.text=@"佛像";
    qingfoLa1.font=[UIFont fontWithName:@"Helvetica-Bold" size:25];
    qingfoLa1.textColor=[UIColor whiteColor];
    [qingfoBt addSubview:qingfoLa1];
    
    gongpingImage1=[[UIImageView alloc]initWithFrame:CGRectMake(20, 380, 50, 100)];
    gongpingImage1.image=[UIImage imageNamed:@"花瓶"];
    [qingfoScroll addSubview:gongpingImage1];
    
    gongpingImage2=[[UIImageView alloc]initWithFrame:CGRectMake(305, 380, 50, 100)];
    gongpingImage2.image=[UIImage imageNamed:@"花瓶"];
    [qingfoScroll addSubview:gongpingImage2];
    
    dengImage1=[[UIImageView alloc]initWithFrame:CGRectMake(75, 403, 45, 80)];
    dengImage1.image=[UIImage imageNamed:@"灯"];
    [qingfoScroll addSubview:dengImage1];
    
    dengImage2=[[UIImageView alloc]initWithFrame:CGRectMake(255, 403, 45, 80)];
    dengImage2.image=[UIImage imageNamed:@"灯"];
    [qingfoScroll addSubview:dengImage2];
    
    xiangluImage=[[UIImageView alloc]initWithFrame:CGRectMake(140, 435, 90, 80)];
    xiangluImage.image=[UIImage imageNamed:@"香炉"];
    [qingfoScroll addSubview:xiangluImage];
    
    xiangImage=[[UIImageView alloc]initWithFrame:CGRectMake(173, 365, 20, 80)];
    xiangImage.image=[UIImage imageNamed:@""];
    [qingfoScroll addSubview:xiangImage];
    
    guobanImage1=[[UIImageView alloc]initWithFrame:CGRectMake(50, 475, 80, 60)];
    guobanImage1.image=[UIImage imageNamed:@"果盘"];
    [qingfoScroll addSubview:guobanImage1];
    
    guobanImage2=[[UIImageView alloc]initWithFrame:CGRectMake(240, 475, 80, 60)];
    guobanImage2.image=[UIImage imageNamed:@"果盘"];
    [qingfoScroll addSubview:guobanImage2];
    
    chaImage1=[[UIImageView alloc]initWithFrame:CGRectMake(140, 504, 30, 30)];
    chaImage1.image=[UIImage imageNamed:@"茶杯"];
    [qingfoScroll addSubview:chaImage1];
    
    chaImage2=[[UIImageView alloc]initWithFrame:CGRectMake(170, 504, 30, 30)];
    chaImage2.image=[UIImage imageNamed:@"茶杯"];
    [qingfoScroll addSubview:chaImage2];
    
    chaImage3=[[UIImageView alloc]initWithFrame:CGRectMake(200, 504, 30, 30)];
    chaImage3.image=[UIImage imageNamed:@"茶杯"];
    [qingfoScroll addSubview:chaImage3];
    
    barImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 620, 375, 48)];
    barImage.image=[UIImage imageNamed:@"导航"];
    [bgImage addSubview:barImage];
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 626, 330, 35)];
    [scrollview setShowsHorizontalScrollIndicator:NO];
    [scrollview setContentSize:CGSizeMake(400, 0)];
    [scrollview setDelegate:self];
    [scrollview setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:scrollview];
    
    jingxiangBt=[[UIButton alloc]initWithFrame:CGRectMake(10, 0, 65, 35)];
    [jingxiangBt setTitle:@"敬香" forState:UIControlStateNormal];
    [jingxiangBt setBackgroundColor:[UIColor clearColor]];
    [jingxiangBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    jingxiangBt.tag=1;
    [jingxiangBt addTarget:self action:@selector(jingxiangClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:jingxiangBt];
    
    gongchaBt=[[UIButton alloc]initWithFrame:CGRectMake(75, 0, 65, 35)];
    gongchaBt.tag=2;
    [gongchaBt setTitle:@"供茶" forState:UIControlStateNormal];
    [gongchaBt setBackgroundColor:[UIColor clearColor]];
    [gongchaBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [gongchaBt addTarget:self action:@selector(gongchaClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:gongchaBt];
    
    xiangongBt=[[UIButton alloc]initWithFrame:CGRectMake(140, 0, 65, 35)];
    xiangongBt.tag=3;
    [xiangongBt setTitle:@"献供" forState:UIControlStateNormal];
    [xiangongBt setBackgroundColor:[UIColor clearColor]];
    [xiangongBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xiangongBt addTarget:self action:@selector(xiangongClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:xiangongBt];
    
    gonghuaBt=[[UIButton alloc]initWithFrame:CGRectMake(205, 0, 65, 35)];
    gonghuaBt.tag=4;
    [gonghuaBt setTitle:@"供花" forState:UIControlStateNormal];
    [gonghuaBt setBackgroundColor:[UIColor clearColor]];
    [gonghuaBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [gonghuaBt addTarget:self action:@selector(gonghuaClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:gonghuaBt];
    
    xuyuanBt=[[UIButton alloc]initWithFrame:CGRectMake(265, 0, 65, 35)];
    [xuyuanBt setTitle:@"许愿" forState:UIControlStateNormal];
    [xuyuanBt setBackgroundColor:[UIColor clearColor]];
    [xuyuanBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xuyuanBt addTarget:self action:@selector(xuyuanClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:xuyuanBt];
    
    huanyuanBt=[[UIButton alloc]initWithFrame:CGRectMake(330, 0, 65, 35)];
    [huanyuanBt setTitle:@"还愿" forState:UIControlStateNormal];
    [huanyuanBt setBackgroundColor:[UIColor clearColor]];
    [huanyuanBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [huanyuanBt addTarget:self action:@selector(huanyuanClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:huanyuanBt];
    
}
-(void)backclick{
    
    AppDelegate * appdele=[UIApplication sharedApplication].delegate;
    [self.sideMenuViewController
     setContentViewController:appdele.mainVc animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex==0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (buttonIndex==1){
    
        [self.sideMenuViewController
         setContentViewController:[[ZhuYeMianViewController alloc] init]animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
}

-(void)qingfoClick{
    
    Please_QFViewController  *vc = [[Please_QFViewController alloc] init];
    vc.delegate = self;
    vc.vc = self;
   //[self.navigationController pushViewController:vc animated:YES];
    [self.sideMenuViewController
     setContentViewController:vc  animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
    [vc getTempleList];
    
}

-(void)jingxiangClick{
    if (!isClick) {
        
        UIAlertView * aler=[[UIAlertView alloc]initWithTitle:@"还没请佛，快去请佛" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        
        [NSTimer scheduledTimerWithTimeInterval:1.5f
                                         target:self
                                       selector:@selector(timerFireMethod:)
                                       userInfo:aler
                                        repeats:YES];
        [aler show];
        
        
    }else {
        [huanyuanBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [huanyuanBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [gongchaBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [gongchaBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [xiangongBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [xiangongBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [gonghuaBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [gonghuaBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [xuyuanBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [xuyuanBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [jingxiangBt setBackgroundImage:[UIImage imageNamed:@"bt_sure_offer_bg"] forState:UIControlStateNormal];
        [jingxiangBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.view addSubview:self.maskView];
        backgroundImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.855, SCREEN_WIDTH, SCREEN_HEIGHT*0.145)];
        backgroundImage.image=[UIImage imageNamed:@"offerings_bg"];
        backgroundImage.userInteractionEnabled=YES;
        [self.view addSubview:backgroundImage];
        
        CGFloat width = SCREEN_WIDTH / 3;
        CGFloat height = 100;
        UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 100,SCREEN_WIDTH,100)];
        self.tributeScrollView=bgScrollView;
        for(int i = 0; i < self.incenseArray.count ; i++)
        {
            _model = self.incenseArray[i];
            NSLog(@"%@",_model.tasklName);
            _teaView = [[TeaView alloc] initWithFrame:CGRectMake(width * i ,0,width,height)];
            [_teaView setModel:_model];
            _teaView.selectBlock = ^void(TributeModel *model){
                //弹出框框
                NSLog(@"%@",model.tasklName);
                _fristImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.17*SCREEN_WIDTH,SCREEN_HEIGHT*0.25,0.75*SCREEN_WIDTH,SCREEN_HEIGHT* 0.15 - 50)];
                _fristImageView.image=[UIImage imageNamed:@"offer_top_bg_dialog"];
                [self.view addSubview:_fristImageView];
                
                UILabel * tishiLa=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.25, 10, 100, 20)];
                tishiLa.text=@"随喜提示";
                tishiLa.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
                tishiLa.textColor=[UIColor whiteColor];
                [self.fristImageView addSubview:tishiLa];
                
                _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.29 *SCREEN_WIDTH,SCREEN_HEIGHT*0.3+120,80,35)];
                [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"bt_cancel_offer_bg"] forState:UIControlStateNormal];
                [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
                [_cancelBtn setTitleColor:cancelColor forState:UIControlStateNormal];
                [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
                
                _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.59 *SCREEN_WIDTH,SCREEN_HEIGHT*0.3+120,80,35)];
                [_sureBtn setBackgroundImage:[UIImage imageNamed:@"bt_sure_offer_bg"] forState:UIControlStateNormal];
                [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
                [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _sureBtn.tag=1;
                [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
                
                _lastImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.17 * SCREEN_WIDTH,CGRectGetMaxY(self.fristImageView.frame),0.75*SCREEN_WIDTH,SCREEN_HEIGHT*0.25)];
                _lastImageView.image = [UIImage imageNamed:@"offer_bottom_bg_dialog"];
                [self.view addSubview:self.lastImageView];
                
                _moralLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.09, SCREEN_HEIGHT*0.01, SCREEN_WIDTH*0.9, SCREEN_HEIGHT*0.07)];
                _moralLabel1.text=@"神佛庇佑,供奉               ,随喜奉上";
                _moralLabel1.textColor = [UIColor blackColor];
                _moralLabel1.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
                [self.lastImageView addSubview:self.moralLabel1];
                
                _moralLabel2=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.045, SCREEN_HEIGHT*0.06, SCREEN_WIDTH*0.9, SCREEN_HEIGHT*0.07)];
                _moralLabel2.text = @"祈福币        个,佛渡有缘人,阿弥陀佛!";
               _moralLabel2.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
                _moralLabel2.textColor = [UIColor blackColor];
                [self.lastImageView addSubview:self.moralLabel2];
                
                _coinLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.2 * SCREEN_WIDTH,SCREEN_HEIGHT*0.045,0.3*SCREEN_WIDTH,SCREEN_HEIGHT*0.1)];
                _coinLabel.font = [UIFont systemFontOfSize:16];
                _coinLabel.textColor = [UIColor redColor];
                _coinLabel.text=[NSString stringWithFormat:@"%ld", (long)model.prayMoney];
                [self.lastImageView addSubview:self.coinLabel];
                
               _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.2 * SCREEN_WIDTH,SCREEN_HEIGHT*0.001-5,0.5*SCREEN_WIDTH,SCREEN_HEIGHT*0.1)];
                _nameLabel.text = model.tasklName;
                _nameLabel.font = [UIFont systemFontOfSize:16];
                _nameLabel.textColor= [UIColor redColor];
                self.nameLabel.textAlignment = NSTextAlignmentCenter;
                [self.lastImageView addSubview:self.nameLabel];
                
                 [self.view addSubview:self.cancelBtn];
                 [self.view addSubview:self.sureBtn];

            };
            _teaView.questionBlock = ^void(NSString * shouming)
            {  //介绍
                NSLog(@"%@",shouming);
                
                CGFloat marginX = 40;
                CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH - 2*marginX, MAXFLOAT);
                CGFloat contentHeight = [self.textview sizeWithFont:[UIFont systemFontOfSize:14] maxSize:textMaxSize].height;
                jianjie=[[UILabel alloc]initWithFrame:CGRectMake(marginX,130, SCREEN_WIDTH - 2*marginX, contentHeight+200)];
                jianjie.text = _model.meaning;
                jianjie.numberOfLines = 0 ;
                jianjie.textColor=[UIColor whiteColor];
                jianjie.font = [UIFont systemFontOfSize:18];
                [self.view addSubview:jianjie];

            };
            [bgScrollView addSubview:_teaView];
        }
        bgScrollView.contentSize = CGSizeMake(self.incenseArray.count * width,0);
        [self.view addSubview:bgScrollView];
    }
}

-(void)cancelBtnClick{

    [self.fristImageView removeFromSuperview];
    [self.lastImageView removeFromSuperview];
    [self.cancelBtn removeFromSuperview];
    [self.sureBtn removeFromSuperview];
}
-(void)sureBtnClick{
    
    [xiangluImage setImageWithURL:[NSURL URLWithString:_model.materialImageUrl]];
    [gongpingImage1 setImageWithURL:[NSURL URLWithString:_model.materialImageUrl]];
    [gongpingImage2 setImageWithURL:[NSURL URLWithString:_model.materialImageUrl]];
    [guobanImage1 setImageWithURL:[NSURL URLWithString:_model.materialImageUrl]];
    [guobanImage2 setImageWithURL:[NSURL URLWithString:_model.materialImageUrl]];
    [self.cancelBtn removeFromSuperview];
    [self.fristImageView removeFromSuperview];
    [self.sureBtn removeFromSuperview];
    [self.lastImageView removeFromSuperview];
    [self.maskView removeFromSuperview];
    [self.tributeScrollView removeFromSuperview];
    [backgroundImage removeFromSuperview];
    
}
- (void)timerFireMethod:(NSTimer*)theTimer//弹出框时间
{
    UIAlertView *aler = (UIAlertView*)[theTimer userInfo];
    [aler dismissWithClickedButtonIndex:0.5 animated:NO];
    aler =NULL;
}

-(void)gongchaClick
{
    
    [jingxiangBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [jingxiangBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xiangongBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [xiangongBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [huanyuanBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [huanyuanBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [gonghuaBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [gonghuaBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xuyuanBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [xuyuanBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [gongchaBt setBackgroundImage:[UIImage imageNamed:@"bt_sure_offer_bg"] forState:UIControlStateNormal];
    [gongchaBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:self.maskView];
    backgroundImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.855, SCREEN_WIDTH, SCREEN_HEIGHT*0.145)];
    backgroundImage.image=[UIImage imageNamed:@"offerings_bg"];
    backgroundImage.userInteractionEnabled=YES;
    [self.view addSubview:backgroundImage];

    CGFloat width = SCREEN_WIDTH / 3;
    CGFloat height = 100;
    UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 100,SCREEN_WIDTH,100)];
    self.tributeScrollView = bgScrollView;
    for(int i = 0; i < self.teaArray.count ; i++)
    {
        _model = self.teaArray[i];
        NSLog(@"%@",_model.tasklName);
        _teaView = [[TeaView alloc] initWithFrame:CGRectMake(width * i ,0,width,height)];
        [_teaView setModel:_model];
           _teaView.selectBlock = ^void(TributeModel *model){
            //弹出框框
               _model = model;
            NSLog(@"%@",model.tasklName);
               _fristImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.17*SCREEN_WIDTH,SCREEN_HEIGHT*0.25,0.75*SCREEN_WIDTH,SCREEN_HEIGHT* 0.15 - 50)];
               _fristImageView.image=[UIImage imageNamed:@"offer_top_bg_dialog"];
               [self.view addSubview:_fristImageView];
               
               UILabel * tishiLa=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.25, 10, 100, 20)];
               tishiLa.text=@"随喜提示";
               tishiLa.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
               tishiLa.textColor=[UIColor whiteColor];
               [self.fristImageView addSubview:tishiLa];
               
               _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.29 *SCREEN_WIDTH,SCREEN_HEIGHT*0.3+120,80,35)];
               [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"bt_cancel_offer_bg"] forState:UIControlStateNormal];
               [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
               [_cancelBtn setTitleColor:cancelColor forState:UIControlStateNormal];
               [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
               
               _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.59 *SCREEN_WIDTH,SCREEN_HEIGHT*0.3+120,80,35)];
               [_sureBtn setBackgroundImage:[UIImage imageNamed:@"bt_sure_offer_bg"] forState:UIControlStateNormal];
               [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
               [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
               
               [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
               
               _lastImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.17 * SCREEN_WIDTH,CGRectGetMaxY(self.fristImageView.frame),0.75*SCREEN_WIDTH,SCREEN_HEIGHT*0.25)];
               _lastImageView.image = [UIImage imageNamed:@"offer_bottom_bg_dialog"];
               [self.view addSubview:self.lastImageView];
               
               _moralLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.09, SCREEN_HEIGHT*0.01, SCREEN_WIDTH*0.9, SCREEN_HEIGHT*0.07)];
               _moralLabel1.text=@"神佛庇佑,供奉               ,随喜奉上";
               _moralLabel1.textColor = [UIColor blackColor];
               _moralLabel1.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
               [self.lastImageView addSubview:self.moralLabel1];
               
               _moralLabel2=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.045, SCREEN_HEIGHT*0.06, SCREEN_WIDTH*0.9, SCREEN_HEIGHT*0.07)];
               _moralLabel2.text = @"祈福币        个,佛渡有缘人,阿弥陀佛!";
               _moralLabel2.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
               _moralLabel2.textColor = [UIColor blackColor];
               [self.lastImageView addSubview:self.moralLabel2];
               
               _coinLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.2 * SCREEN_WIDTH,SCREEN_HEIGHT*0.045,0.3*SCREEN_WIDTH,SCREEN_HEIGHT*0.1)];
               _coinLabel.font = [UIFont systemFontOfSize:16];
               _coinLabel.textColor = [UIColor redColor];
               _coinLabel.text=[NSString stringWithFormat:@"%ld", (long)model.prayMoney];
               [self.lastImageView addSubview:self.coinLabel];
               
               _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.2 * SCREEN_WIDTH,SCREEN_HEIGHT*0.001-5,0.5*SCREEN_WIDTH,SCREEN_HEIGHT*0.1)];
               _nameLabel.text = model.tasklName;
               _nameLabel.font = [UIFont systemFontOfSize:16];
               _nameLabel.textColor= [UIColor redColor];
               self.nameLabel.textAlignment = NSTextAlignmentCenter;
               [self.lastImageView addSubview:self.nameLabel];
               
               [self.view addSubview:self.cancelBtn];
               [self.view addSubview:self.sureBtn];
               
        };
        _teaView.questionBlock = ^void(NSString * shouming)
        {  //介绍
            NSLog(@"%@",shouming);
            
            CGFloat marginX = 40;
            CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH - 2*marginX, MAXFLOAT);
            CGFloat contentHeight = [self.textview sizeWithFont:[UIFont systemFontOfSize:14] maxSize:textMaxSize].height;
            jianjie=[[UILabel alloc]initWithFrame:CGRectMake(marginX,130, SCREEN_WIDTH - 2*marginX, contentHeight+200)];
            jianjie.text = _model.meaning;
            jianjie.numberOfLines = 0 ;
            jianjie.textColor=[UIColor whiteColor];
            jianjie.font = [UIFont systemFontOfSize:18];
            [jianjiebgImage addSubview:jianjie];

        };
        [bgScrollView addSubview:_teaView];
    }
    bgScrollView.contentSize = CGSizeMake(self.teaArray.count * width,0);
    [self.view addSubview:bgScrollView];
}

-(void)xiangongClick{
    
    [jingxiangBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [jingxiangBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [gongchaBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [gongchaBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [huanyuanBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [huanyuanBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [gonghuaBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [gonghuaBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xuyuanBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [xuyuanBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xiangongBt setBackgroundImage:[UIImage imageNamed:@"bt_sure_offer_bg"] forState:UIControlStateNormal];
    [xiangongBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:self.maskView];
    backgroundImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.855, SCREEN_WIDTH, SCREEN_HEIGHT*0.145)];
    backgroundImage.image=[UIImage imageNamed:@"offerings_bg"];
    backgroundImage.userInteractionEnabled=YES;
    [self.view addSubview:backgroundImage];
    
    CGFloat width = SCREEN_WIDTH / 3;
    CGFloat height = 100;
    UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 100,SCREEN_WIDTH,100)];
    self.tributeScrollView = bgScrollView;
    for(int i = 0; i < self.fruitArray.count ; i++)
    {
        _model = self.fruitArray[i];
        NSLog(@"%@",_model.tasklName);
        _teaView = [[TeaView alloc] initWithFrame:CGRectMake(width * i ,0,width,height)];
        [_teaView setModel:_model];
        _teaView.selectBlock = ^void(TributeModel *model){
            //弹出框框
            NSLog(@"%@",model.tasklName);
            _fristImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.17*SCREEN_WIDTH,SCREEN_HEIGHT*0.25,0.75*SCREEN_WIDTH,SCREEN_HEIGHT* 0.15 - 50)];
            _fristImageView.image=[UIImage imageNamed:@"offer_top_bg_dialog"];
            [self.view addSubview:_fristImageView];
            
            UILabel * tishiLa=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.25, 10, 100, 20)];
            tishiLa.text=@"随喜提示";
            tishiLa.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
            tishiLa.textColor=[UIColor whiteColor];
            [self.fristImageView addSubview:tishiLa];
            
            _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.29 *SCREEN_WIDTH,SCREEN_HEIGHT*0.3+120,80,35)];
            [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"bt_cancel_offer_bg"] forState:UIControlStateNormal];
            [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
            [_cancelBtn setTitleColor:cancelColor forState:UIControlStateNormal];
            [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.59 *SCREEN_WIDTH,SCREEN_HEIGHT*0.3+120,80,35)];
            [_sureBtn setBackgroundImage:[UIImage imageNamed:@"bt_sure_offer_bg"] forState:UIControlStateNormal];
            [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
            [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            _lastImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.17 * SCREEN_WIDTH,CGRectGetMaxY(self.fristImageView.frame),0.75*SCREEN_WIDTH,SCREEN_HEIGHT*0.25)];
            _lastImageView.image = [UIImage imageNamed:@"offer_bottom_bg_dialog"];
            [self.view addSubview:self.lastImageView];
            
            _moralLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.09, SCREEN_HEIGHT*0.01, SCREEN_WIDTH*0.9, SCREEN_HEIGHT*0.07)];
            _moralLabel1.text=@"神佛庇佑,供奉               ,随喜奉上";
            _moralLabel1.textColor = [UIColor blackColor];
            _moralLabel1.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
            [self.lastImageView addSubview:self.moralLabel1];
            
            _moralLabel2=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.045, SCREEN_HEIGHT*0.06, SCREEN_WIDTH*0.9, SCREEN_HEIGHT*0.07)];
            _moralLabel2.text = @"祈福币        个,佛渡有缘人,阿弥陀佛!";
            _moralLabel2.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
            _moralLabel2.textColor = [UIColor blackColor];
            [self.lastImageView addSubview:self.moralLabel2];
            
            _coinLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.2 * SCREEN_WIDTH,SCREEN_HEIGHT*0.045,0.3*SCREEN_WIDTH,SCREEN_HEIGHT*0.1)];
            _coinLabel.font = [UIFont systemFontOfSize:16];
            _coinLabel.textColor = [UIColor redColor];
            _coinLabel.text=[NSString stringWithFormat:@"%ld", (long)model.prayMoney];
            [self.lastImageView addSubview:self.coinLabel];
            
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.2 * SCREEN_WIDTH,SCREEN_HEIGHT*0.001-5,0.5*SCREEN_WIDTH,SCREEN_HEIGHT*0.1)];
            _nameLabel.text = model.tasklName;
            _nameLabel.font = [UIFont systemFontOfSize:16];
            _nameLabel.textColor= [UIColor redColor];
            self.nameLabel.textAlignment = NSTextAlignmentCenter;
            [self.lastImageView addSubview:self.nameLabel];
            
            [self.view addSubview:self.cancelBtn];
            [self.view addSubview:self.sureBtn];
        };
        _teaView.questionBlock = ^void(NSString * shouming)
        {  //介绍
            NSLog(@"%@",shouming);
            fugeiImage.hidden=YES;
            jianjiebgImage=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [jianjiebgImage setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
            [jianjiebgImage addTarget:self action:@selector(jianjiebgImageClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:jianjiebgImage];
            
            CGFloat marginX = 40;
            CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH - 2*marginX, MAXFLOAT);
            CGFloat contentHeight = [self.textview sizeWithFont:[UIFont systemFontOfSize:14] maxSize:textMaxSize].height;
            jianjie=[[UILabel alloc]initWithFrame:CGRectMake(marginX,130, SCREEN_WIDTH - 2*marginX, contentHeight+200)];
            jianjie.text = _model.meaning;
            jianjie.numberOfLines = 0 ;
            jianjie.textColor=[UIColor whiteColor];
            jianjie.font = [UIFont systemFontOfSize:18];
            [jianjiebgImage addSubview:jianjie];

        };
        [bgScrollView addSubview:_teaView];
    }
    
      bgScrollView.contentSize = CGSizeMake(self.fruitArray.count * width,0);
      [self.view addSubview:bgScrollView];

}

-(void)gonghuaClick
{
    [self.view addSubview:self.maskView];
    [jingxiangBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [jingxiangBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [gongchaBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [gongchaBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [huanyuanBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [huanyuanBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xiangongBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [xiangongBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xuyuanBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [xuyuanBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [gonghuaBt setBackgroundImage:[UIImage imageNamed:@"bt_sure_offer_bg"] forState:UIControlStateNormal];
    [gonghuaBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [self.view addSubview:self.maskView];
    backgroundImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.855, SCREEN_WIDTH, SCREEN_HEIGHT*0.145)];
    backgroundImage.image=[UIImage imageNamed:@"offerings_bg"];
    backgroundImage.userInteractionEnabled=YES;
    [self.view addSubview:backgroundImage];

    CGFloat width = SCREEN_WIDTH / 3;
    CGFloat height = 100;
    UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 100,SCREEN_WIDTH,100)];
    self.tributeScrollView = bgScrollView;
    [bgScrollView setShowsHorizontalScrollIndicator:NO];
    for(int i = 0; i < self.flowerArrray.count ; i++)
    {
        _model = self.flowerArrray[i];
        NSLog(@"%@",_model.tasklName);
        TeaView *teaView = [[TeaView alloc] initWithFrame:CGRectMake(width * i ,0,width,height)];
        [teaView setModel:_model];
        teaView.selectBlock = ^void(TributeModel *model){
            NSLog(@"%@",model.tasklName);
            _fristImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.17*SCREEN_WIDTH,SCREEN_HEIGHT*0.25,0.75*SCREEN_WIDTH,SCREEN_HEIGHT* 0.15 - 50)];
            _fristImageView.image=[UIImage imageNamed:@"offer_top_bg_dialog"];
            [self.view addSubview:_fristImageView];
            
            UILabel * tishiLa=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.25, 10, 100, 20)];
            tishiLa.text=@"随喜提示";
            tishiLa.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
            tishiLa.textColor=[UIColor whiteColor];
            [self.fristImageView addSubview:tishiLa];
            
            _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.29 *SCREEN_WIDTH,SCREEN_HEIGHT*0.3+120,80,35)];
            [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"bt_cancel_offer_bg"] forState:UIControlStateNormal];
            [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
            [_cancelBtn setTitleColor:cancelColor forState:UIControlStateNormal];
            [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.59 *SCREEN_WIDTH,SCREEN_HEIGHT*0.3+120,80,35)];
            [_sureBtn setBackgroundImage:[UIImage imageNamed:@"bt_sure_offer_bg"] forState:UIControlStateNormal];
            [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
            [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            _lastImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.17 * SCREEN_WIDTH,CGRectGetMaxY(self.fristImageView.frame),0.75*SCREEN_WIDTH,SCREEN_HEIGHT*0.25)];
            _lastImageView.image = [UIImage imageNamed:@"offer_bottom_bg_dialog"];
            [self.view addSubview:self.lastImageView];
            
            _moralLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.09, SCREEN_HEIGHT*0.01, SCREEN_WIDTH*0.9, SCREEN_HEIGHT*0.07)];
            _moralLabel1.text=@"神佛庇佑,供奉               ,随喜奉上";
            _moralLabel1.textColor = [UIColor blackColor];
            _moralLabel1.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
            [self.lastImageView addSubview:self.moralLabel1];
            
            _moralLabel2=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.045, SCREEN_HEIGHT*0.06, SCREEN_WIDTH*0.9, SCREEN_HEIGHT*0.07)];
            _moralLabel2.text = @"祈福币        个,佛渡有缘人,阿弥陀佛!";
            _moralLabel2.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
            _moralLabel2.textColor = [UIColor blackColor];
            [self.lastImageView addSubview:self.moralLabel2];
            
            _coinLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.2 * SCREEN_WIDTH,SCREEN_HEIGHT*0.045,0.3*SCREEN_WIDTH,SCREEN_HEIGHT*0.1)];
            _coinLabel.font = [UIFont systemFontOfSize:16];
            _coinLabel.textColor = [UIColor redColor];
            _coinLabel.text=[NSString stringWithFormat:@"%ld", (long)model.prayMoney];
            [self.lastImageView addSubview:self.coinLabel];
            
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.2 * SCREEN_WIDTH,SCREEN_HEIGHT*0.001-5,0.5*SCREEN_WIDTH,SCREEN_HEIGHT*0.1)];
            _nameLabel.text = model.tasklName;
            _nameLabel.font = [UIFont systemFontOfSize:16];
            _nameLabel.textColor= [UIColor redColor];
            self.nameLabel.textAlignment = NSTextAlignmentCenter;
            [self.lastImageView addSubview:self.nameLabel];
            
            [self.view addSubview:self.cancelBtn];
            [self.view addSubview:self.sureBtn];
        
        };
        teaView.questionBlock = ^void(NSString * shouming)
        {
            CGFloat marginX = 40;
            CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH - 2*marginX, MAXFLOAT);
            CGFloat contentHeight = [self.textview sizeWithFont:[UIFont systemFontOfSize:14] maxSize:textMaxSize].height;
            jianjie=[[UILabel alloc]initWithFrame:CGRectMake(marginX,130, SCREEN_WIDTH - 2*marginX, contentHeight+200)];
            jianjie.text = _model.meaning;
            jianjie.numberOfLines = 0 ;
            jianjie.textColor=[UIColor whiteColor];
            jianjie.font = [UIFont systemFontOfSize:18];
            [self.view addSubview:jianjie];

        };
        [bgScrollView addSubview:teaView];
    }
    bgScrollView.contentSize = CGSizeMake(self.flowerArrray.count * width,0);
    [self.view addSubview:bgScrollView];
 
}

-(void)xuyuanClick{
//    int i;
    HuanYuan_MainViewController * huan = [[HuanYuan_MainViewController alloc]init];
//    if (huan.num > 3) {
//        UIAlertView * alrea = [[UIAlertView alloc]initWithTitle:nil message:@"您已经许愿三次了！" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
//        
//        [NSTimer scheduledTimerWithTimeInterval:1.5f
//                                         target:self
//                                       selector:@selector(timerFireMethod:)
//                                       userInfo:alrea
//                                        repeats:YES];
//            [alrea show];
//        
//    }else if(huan.num < 3){
//        
        [self getWishInfo];
        
    [jingxiangBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [jingxiangBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [gongchaBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [gongchaBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xiangongBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [xiangongBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [gonghuaBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [gonghuaBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [huanyuanBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [huanyuanBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xuyuanBt setBackgroundImage:[UIImage imageNamed:@"bt_sure_offer_bg"] forState:UIControlStateNormal];
    [xuyuanBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    fugeiImage1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 380, self.view.frame.size.height)];
    [fugeiImage1 setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
    [fugeiImage1 addTarget:self action:@selector(fugei1Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fugeiImage1];
    
    xuyuanView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 150, 335, 360)];
    xuyuanView.image=[UIImage imageNamed:@"点心灯弹窗背景"];
    [fugeiImage1 addSubview:xuyuanView];
    
    UILabel * xuyuanLa=[[UILabel alloc]initWithFrame:CGRectMake(150, 40, 100, 20)];
    xuyuanLa.text=@"许愿";
    xuyuanLa.textColor=majorityColor;
    xuyuanLa.font=[UIFont systemFontOfSize:19];
    [xuyuanView addSubview:xuyuanLa];
    
    UILabel * xuyuanName=[[UILabel alloc]initWithFrame:CGRectMake(20, 80, 50, 20)];
    xuyuanName.text=@"姓名";
    xuyuanName.textColor=majorityColor;
    xuyuanName.font=[UIFont systemFontOfSize:14];
    [xuyuanView addSubview:xuyuanName];
    
    UIImageView * nameImage=[[UIImageView alloc]initWithFrame:CGRectMake(60, 78, 120, 25)];
    nameImage.image=[UIImage imageNamed:@"make_wish_name_bg"];
    [xuyuanView addSubview:nameImage];
    
    nameText=[[UITextField alloc]initWithFrame:CGRectMake(90, 228, 100, 25)];
    nameText.placeholder=@"请输入你的名字";
    nameText.delegate=self;
    nameText.font=[UIFont systemFontOfSize:13];
    nameText.backgroundColor=[UIColor clearColor];
    [self.view addSubview:nameText];
    
    UILabel * xinyuanLa=[[UILabel alloc]initWithFrame:CGRectMake(20, 125, 50, 20)];
    xinyuanLa.text=@"心愿";
    xinyuanLa.font=[UIFont systemFontOfSize:14];
    xinyuanLa.textColor=majorityColor;
    [xuyuanView addSubview:xinyuanLa];
    
    UIImageView * xinyuanImage=[[UIImageView alloc]initWithFrame:CGRectMake(60, 120, 260, 100)];
    xinyuanImage.image=[UIImage imageNamed:@"make_wish_name_bg"];
    [xuyuanView addSubview:xinyuanImage];
    
    xinyuanText=[[PlaceholderTextView alloc]initWithFrame:CGRectMake(85, 270, 250, 100)];
    xinyuanText.backgroundColor=[UIColor clearColor];
    xinyuanText.placeholder=@"请输入你的愿望...";
    xinyuanText.placeholderFont=[UIFont systemFontOfSize:11];
    xinyuanText.textColor=[UIColor lightGrayColor];
    xinyuanText.font=[UIFont systemFontOfSize:13];
    xinyuanText.delegate=self;
    [self.view addSubview:xinyuanText];
    
    UILabel * huanyuanLa=[[UILabel alloc]initWithFrame:CGRectMake(20, 235, 50, 20)];
    huanyuanLa.text=@"还愿";
    huanyuanLa.textColor=majorityColor;
    huanyuanLa.font=[UIFont systemFontOfSize:14];
    [xuyuanView addSubview:huanyuanLa];
    
    xuanzeBt=[[UIButton alloc]initWithFrame:CGRectMake(80, 385, 80, 25)];
    [xuanzeBt setBackgroundImage:[UIImage imageNamed:@"votive_wish_type_bg"] forState:UIControlStateNormal];
    [xuanzeBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xuanzeBt addTarget:self action:@selector(xuanzeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xuanzeBt];
    
    xuanzeLa=[[UILabel alloc]initWithFrame:CGRectMake(10, 3, 80, 20)];
    xuanzeLa.text=@"选择类别";
    xuanzeLa.font=[UIFont systemFontOfSize:13];
    [xuanzeBt addSubview:xuanzeLa];
    
    deleteBt=[[UIButton alloc]initWithFrame:CGRectMake(330, 158, 20, 20)];
    [deleteBt setBackgroundImage:[UIImage imageNamed:@"bookshelf_delete"] forState:UIControlStateNormal];
    [deleteBt addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBt];
    
    sureBt=[[UIButton alloc]initWithFrame:CGRectMake(160, 440, 60, 30)];
    [sureBt setTitle:@"确定" forState:UIControlStateNormal];
    [sureBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBt setBackgroundImage:[UIImage imageNamed:@"light_share_friend_normal"] forState:UIControlStateNormal];
    [sureBt addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBt];
        
//    }
}

-(void)deleteClick{
    
    fugeiImage1.hidden=YES;
    nameText.hidden=YES;
    xinyuanText.hidden=YES;
    deleteBt.hidden=YES;
    sureBt.hidden=YES;
    xuanzeLa.hidden=YES;
    xuanzeBt.hidden=YES;
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)sureClick{
    if ([nameText.text isEqualToString:@""] || xinyuanText.text ==nil) {
        
        UIAlertView * alrea=[[UIAlertView alloc]initWithTitle:@"名字或心愿不能为空" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alrea show];
        
        
    }else {
        
        fugeiImage1.hidden=YES;
        nameText.hidden=YES;
        xinyuanText.hidden=YES;
        deleteBt.hidden=YES;
        sureBt.hidden=YES;
        xuanzeLa.hidden=YES;
        xuanzeBt.hidden=YES;
        
        [self getWishNum];
        
    }
    
}
-(void)xuanzeClick{
    
    xuanzeImage=[[UIImageView alloc]initWithFrame:CGRectMake(60, 255, 80, 90)];
    xuanzeImage.image=[UIImage imageNamed:@"make_wish_name_bg"];
    [xuyuanView addSubview:xuanzeImage];
    
    sxBt=[[UIButton alloc]initWithFrame:CGRectMake(80, 410, 80, 25)];
    [sxBt setTitle:@"上香" forState:UIControlStateNormal];
    [sxBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sxBt addTarget:self action:@selector(shangxiangClick) forControlEvents:UIControlEventTouchUpInside];
    sxBt.titleLabel.font = [UIFont boldSystemFontOfSize:14];

    [self.view addSubview:sxBt];
    
    xgBt=[[UIButton alloc]initWithFrame:CGRectMake(80, 430, 80, 25)];
    [xgBt setTitle:@"献供" forState:UIControlStateNormal];
    [xgBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xgBt addTarget:self action:@selector(xgClick) forControlEvents:UIControlEventTouchUpInside];
    xgBt.titleLabel.font = [UIFont boldSystemFontOfSize:14];

    [self.view addSubview:xgBt];
    
    gcBt=[[UIButton alloc]initWithFrame:CGRectMake(80, 450, 80, 25)];
    [gcBt setTitle:@"供茶" forState:UIControlStateNormal];
    [gcBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [gcBt addTarget:self action:@selector(gcClick) forControlEvents:UIControlEventTouchUpInside];
    gcBt.titleLabel.font = [UIFont boldSystemFontOfSize:14];

    [self.view addSubview:gcBt];
    
    ghBt=[[UIButton alloc]initWithFrame:CGRectMake(80, 470, 80, 25)];
    [ghBt setTitle:@"供花" forState:UIControlStateNormal];
    [ghBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ghBt addTarget:self action:@selector(ghClick) forControlEvents:UIControlEventTouchUpInside];
    ghBt.titleLabel.font = [UIFont boldSystemFontOfSize:14];

    [self.view addSubview:ghBt];
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    CGRect frame = textField.frame;
    int offset = frame.origin.y +282 - (self.view.frame.size.height - 240);//键盘高度216
    NSLog(@"offset is %d",offset);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
    

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    [xuyuanView endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
//    [textField resignFirstResponder];
    return YES;
    
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [xinyuanText resignFirstResponder];
        return NO;
    }
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    CGRect frame = textView.frame;
    int offset = frame.origin.y +282 - (self.view.frame.size.height - 240);//键盘高度216
    NSLog(@"offset is %d",offset);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
    return YES;
}
- (BOOL)textViewShouldReturn:(UITextView *)textview {

    [textview resignFirstResponder];
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
//    [textview resignFirstResponder];
    return YES;

}

-(void)huanyuanClick{
    
    if (isClick==YES) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"确定放弃本次还愿吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        isClick=NO;
    }else{
    
    [jingxiangBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [jingxiangBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [gongchaBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [gongchaBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xiangongBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [xiangongBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [gonghuaBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [gonghuaBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xuyuanBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [xuyuanBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [huanyuanBt setBackgroundImage:[UIImage imageNamed:@"bt_sure_offer_bg"] forState:UIControlStateNormal];
    [huanyuanBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    HuanYuan_MainViewController *huanyuanVc = [[HuanYuan_MainViewController alloc] init];
//        huanyuanVc.up = self;
    [self.sideMenuViewController
     setContentViewController:huanyuanVc animated:YES];
    [self.sideMenuViewController  hideMenuViewController];
        
     [huanyuanVc getTempleVow];
        
        isClick=YES;
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)shangxiangClick{
    
    xuanzeLa.text=@"上香";
    sxBt.hidden=YES;
    xgBt.hidden=YES;
    gcBt.hidden=YES;
    ghBt.hidden=YES;
    xuanzeImage.hidden=YES;
}
-(void)xgClick{
    
    xuanzeLa.text=@"献供";
    sxBt.hidden=YES;
    xgBt.hidden=YES;
    gcBt.hidden=YES;
    ghBt.hidden=YES;
    xuanzeImage.hidden=YES;
    
}
-(void)gcClick{
    
    xuanzeLa.text=@"供茶";
    sxBt.hidden=YES;
    xgBt.hidden=YES;
    gcBt.hidden=YES;
    ghBt.hidden=YES;
    xuanzeImage.hidden=YES;
    
}
-(void)ghClick{
    
    xuanzeLa.text=@"供花";
    sxBt.hidden=YES;
    xgBt.hidden=YES;
    gcBt.hidden=YES;
    ghBt.hidden=YES;
    xuanzeImage.hidden=YES;
    
}


-(void)fugeibuttonClick{
    
    tanchuang.hidden=YES;
    
}


-(void)getTempleImage{
    
    AppDelegate * delegate = [UIApplication sharedApplication].delegate;
    delegate.templeimage=[[TempleImage alloc]init];
    NSNumber * miyaoNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"secretKey"];
    NSDictionary * dic=@{@"secretKey":miyaoNum,@"huaienID":@"1195370"};
    NSDictionary * mainDic=@{@"params":[NSString stringWithFormat:@"%@",dic]};
    AppDelegate * appdelegate = [UIApplication sharedApplication].delegate;
    
    [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,TempleURL] parameters:mainDic success:^(NSURLSessionDataTask *task, id responseObject){
        qingfoBt.hidden=YES;
        id jsonDate = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *dictArray = jsonDate[@"data"];
        for(int i = 0 ; i < dictArray.count;i++)
        {
//            NSDictionary *dict = dictArray[i];
//            TempleImage *model = [[TempleImage alloc]init];
//            [model setValuesForKeysWithDictionary:dict];
////            [self.buddaArray addObject:model];
//
//        //图片
//        [self.foImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:delegate.templeimage.materialImageUrl]]]];
        }
         self.foImageView.image=[UIImage imageNamed:@"佛"];
        [qingfoScroll setContentSize:CGSizeMake(760, 0)];
        self.foImageView=[[UIImageView alloc]initWithFrame:CGRectMake(420, 0, 300, 400)];
//        NSLog(@"hahaha%@",self.foImageView);
        self.foImageView.image=[UIImage imageNamed:@"480佛"];
        [qingfoScroll addSubview:self.foImageView];
        
        qingfoBt=[[UIButton alloc]initWithFrame:CGRectMake(525, 175, 90, 90)];
        [qingfoBt setBackgroundImage:[UIImage imageNamed:@"gjlf"] forState:UIControlStateNormal];
        qingfoBt.userInteractionEnabled=YES;
        [qingfoBt addTarget:self action:@selector(qingfoClick) forControlEvents:UIControlEventTouchUpInside];
        [qingfoScroll addSubview:qingfoBt];
        
        UILabel * qingfoLa=[[UILabel alloc]initWithFrame:CGRectMake(20, 15, 150, 30)];
        qingfoLa.text=@"恭请";
        qingfoLa.font=[UIFont fontWithName:@"Helvetica-Bold" size:25];
        qingfoLa.textColor=[UIColor whiteColor];
        [qingfoBt addSubview:qingfoLa];
        UILabel * qingfoLa1=[[UILabel alloc]initWithFrame:CGRectMake(20, 45, 150, 30)];
        qingfoLa1.text=@"佛像";
        qingfoLa1.font=[UIFont fontWithName:@"Helvetica-Bold" size:25];
        qingfoLa1.textColor=[UIColor whiteColor];
        [qingfoBt addSubview:qingfoLa1];
        
        gongpingImage1=[[UIImageView alloc]initWithFrame:CGRectMake(400, 380, 50, 100)];
        gongpingImage1.image=[UIImage imageNamed:@"花瓶"];
        [qingfoScroll addSubview:gongpingImage1];
        
        gongpingImage2=[[UIImageView alloc]initWithFrame:CGRectMake(685, 380, 50, 100)];
        gongpingImage2.image=[UIImage imageNamed:@"花瓶"];
        [qingfoScroll addSubview:gongpingImage2];
        
        huaImage1=[[UIImageView alloc]initWithFrame:CGRectMake(420, 315, 50, 80)];
        huaImage1.image=[UIImage imageNamed:@""];
        [qingfoScroll addSubview:huaImage1];
        
        dengImage1=[[UIImageView alloc]initWithFrame:CGRectMake(455, 403, 45, 80)];
        dengImage1.image=[UIImage imageNamed:@"灯"];
        [qingfoScroll addSubview:dengImage1];
        
        dengImage2=[[UIImageView alloc]initWithFrame:CGRectMake(635, 403, 45, 80)];
        dengImage2.image=[UIImage imageNamed:@"灯"];
        [qingfoScroll addSubview:dengImage2];
        
        xiangluImage=[[UIImageView alloc]initWithFrame:CGRectMake(520, 435, 90, 80)];
        xiangluImage.image=[UIImage imageNamed:@"香炉"];
        [qingfoScroll addSubview:xiangluImage];
        
        xiangImage=[[UIImageView alloc]initWithFrame:CGRectMake(553, 365, 20, 80)];
        xiangImage.image=[UIImage imageNamed:@""];
        [qingfoScroll addSubview:xiangImage];
        
        guobanImage1=[[UIImageView alloc]initWithFrame:CGRectMake(430, 475, 80, 60)];
        guobanImage1.image=[UIImage imageNamed:@"果盘"];
        [qingfoScroll addSubview:guobanImage1];
        
        guobanImage2=[[UIImageView alloc]initWithFrame:CGRectMake(620, 475, 80, 60)];
        guobanImage2.image=[UIImage imageNamed:@"果盘"];
        [qingfoScroll addSubview:guobanImage2];
        
        chaImage1=[[UIImageView alloc]initWithFrame:CGRectMake(520, 504, 30, 30)];
        chaImage1.image=[UIImage imageNamed:@"茶杯"];
        [qingfoScroll addSubview:chaImage1];
        
        chaImage2=[[UIImageView alloc]initWithFrame:CGRectMake(550, 504, 30, 30)];
        chaImage2.image=[UIImage imageNamed:@"茶杯"];
        [qingfoScroll addSubview:chaImage2];
        
        chaImage3=[[UIImageView alloc]initWithFrame:CGRectMake(580, 504, 30, 30)];
        chaImage3.image=[UIImage imageNamed:@"茶杯"];
        [qingfoScroll addSubview:chaImage3];
        
        //反弹出来的付给界面所需要的....
        
        scrollfugai.hidden=YES;
        startBt.hidden=YES;
        imagefugai.hidden=YES;
        shuomingfugai.hidden=YES;

        
    } failure:^(NSURLSessionDataTask *task, id responseObject){
    
    
    }];
    
}

//许愿信息
-(void)getWishInfo{

    //在需要的地方获取数据
    //    NSNumber *loginNumber = [NSNumber numberWithInteger:appdelegta.user.userLoginID];
    NSNumber *loginId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userLoginID"];
    NSString *forObjectStr = @"保密";
    NSString *forContentStr = @"啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦哈哈哈哈哈哈哈哈哈哈哈啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦哈哈哈哈哈哈哈哈哈哈哈";
    NSNumber * miyaoNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"secretKey"];
    NSArray *keyArray= @[@"secretKey",@"userLoginID",@"huaienID",@"taskCode",@"sceneType",@"buddhistTempleID",@"content",@"fulfileTaskType",@"forObject"];
       NSDictionary * wishdic=@{@"secretKey":miyaoNum,@"userLoginID":loginId,@"huaienID":@"1195370",@"taskCode":@400,@"sceneType":@1,@"buddhistTempleID":@0,@"content":forContentStr,@"fulfileTaskType":@01,@"forObject":forObjectStr};
    NSString *jsonParamsStr = @"{";
    for(int i = 0 ; i < keyArray.count; i++)
    {
        NSString *keyValue = keyArray[i];
        if (i == keyArray.count- 1) {
        jsonParamsStr = [NSString stringWithFormat:@"%@%@:%@}",jsonParamsStr,keyValue,[wishdic valueForKey:keyValue]];
        }
        else
        {
        jsonParamsStr = [NSString stringWithFormat:@"%@%@:%@,",jsonParamsStr,keyValue,[wishdic valueForKey:keyValue]];
        }
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@%@params=%@",__kBaseURLString,WishURL,jsonParamsStr];
    NSLog(@"urlStr====%@",urlStr);
    AppDelegate * appdelegta=[UIApplication sharedApplication].delegate;
    [appdelegta.sessionManager GET:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject){
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"jsonData%@",jsonData);
        NSLog(@"许愿结果%@",jsonData[@"desc"]);
    } failure:^(NSURLSessionDataTask *task, id responseObject){
        
        
    }];
}
//许愿次数
-(void)getWishNum{

//    NSNumber *loginId = [[NSUserDefaults gstandardUserDefaults]objectForKey:@"userLoginID"];
    NSNumber * miyaoNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"secretKey"];
    NSDictionary * numdic=@{@"secretKey":miyaoNum,@"huaienID":@"1195370"};
    NSDictionary * numDic=@{@"params":[NSString stringWithFormat:@"%@",numdic]};
    
    NSLog(@"我我我^^^^^%@",numDic);
    AppDelegate * appdelegta=[UIApplication sharedApplication].delegate;
    
    [appdelegta.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,WishNumURL] parameters:numDic success:^(NSURLSessionDataTask *task, id responseObject){
        
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"我我我我哦我我我我 : %@",jsonData);
        
    } failure:^(NSURLSessionDataTask *task, id responseObject){
        
        
    }];
}
//贡品接口
-(void)getTribute{

    NSDictionary * tributedic =@{@"taskType":@1};
    NSDictionary * tributeDic = @{@"params":[NSString stringWithFormat:@"%@",tributedic]};
    AppDelegate * appdele = [UIApplication sharedApplication].delegate;
    [appdele.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,TributeURL] parameters:tributeDic success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsondata = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * tributeArray = jsondata[@"data"];
        for (int i = 0 ; i < tributeArray.count; i++) {
            NSDictionary * tridic =tributeArray[i];
            TributeModel * trimodel = [[TributeModel alloc]init];
            NSString *typeStr = tridic[@"taskType"];
           [trimodel setValuesForKeysWithDictionary:tridic];
            NSInteger  typeId = [typeStr integerValue];
            if (typeId == 1) {
                [self.incenseArray addObject:trimodel];
            }
            if (typeId == 2) {
                [self.teaArray addObject:trimodel];
            }
            if (typeId == 3) {
                [self.fruitArray addObject:trimodel];
            }
            if (typeId == 4) {
                [self.flowerArrray addObject:trimodel];
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}
@end
