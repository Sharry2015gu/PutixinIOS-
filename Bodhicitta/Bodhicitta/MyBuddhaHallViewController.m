//
//  MyBuddhaHallViewController.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/20.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "MyBuddhaHallViewController.h"
#import  "BuddhaInfoView.h"
#import "HeaderFile.h"
#import "Tribute.h"
#import "TempleImage.h"
#import "BuddhaHallView.h"
#import "Please_QFViewController.h"
#import "TeaView.h"
#import "TintView.h"
#import "TestView.h"
#import "SlipModel.h"
#import "SlipView.h"
#import "MakingVowView.h"
#import "BuddhaddRankViewController.h"
#define Start_X 10.0f           // 第一个按钮的X坐标

#define Start_Y 60.0f           // 第一个按钮的Y坐标

#define Width_Space 10.0f        // 2个按钮之间的横间距

#define Height_Space 10.0f      // 竖间距

#define Button_Height 20.0f    // 高

#define Button_Width 68.0f      // 宽

@interface MyBuddhaHallViewController()<UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate,QingFoViewDelegate,BuddhaddRankViewDelegate>
{
    NSInteger  huddhaId;
    BOOL isClick;
    UIImageView * wishImageView;
    UITextField * nameText;
    UIButton * sureBt;
    UIButton * deleteBt;
    UIButton * ImageBt;
    UIButton * choiceBt;
    UILabel  *  choiceLabel;
    UIButton * incenseBt,*offerBt,*forteaBt,*forflowerBt;
    UIImageView * choiceImage;
    PlaceholderTextView *xinyuanText;
    //    NSInteger currentPage;
    BuddhaHallView * emptybuddahaHallView;
    //用于动画后设置摆放
    TributeModel * animatingModel;
    //用于进去之后的佛像名称
    TempleImage * startModel;
    
    
}
@property(nonatomic,strong)MakingVowView *makingVowView;
@property(nonatomic,strong)UIScrollView *buddhaViewScollView;
@property(nonatomic,strong)NSMutableArray *buddhaViewArray;
@property(nonatomic,strong)UINavigationBar * navBar;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UIButton * backBtn;
@property(nonatomic,strong)UIImageView * barImageView;
@property(nonatomic,strong)UIButton * incenseBtn;
@property(nonatomic,strong)UIButton * forteaBtn;
@property(nonatomic,strong)UIButton * offerBtn;
@property(nonatomic,strong)UIButton * forflowerBtn;
@property(nonatomic,strong)UIButton * CliffordBtn;
@property(nonatomic,strong)UIButton * vowBtn;
@property(nonatomic,strong)UIScrollView * scrollviewBar;
@property(nonatomic,strong)UIButton * pushBtn;
@property(nonatomic,strong) UIButton * cancelBtn;
@property(nonatomic,strong) UIButton * sureBtn;
@property(nonatomic,strong) UILabel * coinLabel;
@property(nonatomic,strong) UILabel * nameLabel;
@property(nonatomic,strong) UILabel * moralLabel1;
@property(nonatomic,strong) UILabel * moralLabel2;
@property(nonatomic,strong) NSString * textview;
@property(nonatomic,strong) NSString *contentText;
@property(nonatomic,strong) UIImageView * lastImageView;
@property(nonatomic,strong) UIImageView * backgroundImage;
@property(nonatomic,strong) UIView *maskView;
@property(nonatomic,strong) TeaView * teaView;
@property(nonatomic,strong) UIScrollView *tributeScrollView;
@property(nonatomic,strong) NSMutableArray *teaArray;
@property(nonatomic,strong) NSMutableArray *fruitArray;
@property(nonatomic,strong) NSMutableArray *flowerArrray;
@property(nonatomic,strong) NSMutableArray *incenseArray;
@property(nonatomic,strong) UIImageView * fristImageView;
@property(nonatomic,strong) TributeModel * model;
@property(nonatomic,strong) UILabel * introductionLabel;
@property(nonatomic,strong) UIImageView *foImageView;
@property(nonatomic,strong) UIImageView *foxImageView;
//@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) NSMutableArray  *animationSlipsArray;
@property(nonatomic,strong) UIImageView  *animationImageView;
@property(nonatomic,strong) NSArray  *slipArray;
@property(nonatomic,strong) NSArray  *behaviourArray;
@property(nonatomic,strong) NSDictionary  * userDict;
@property(nonatomic,strong)UIView   *tributeIntroduceView;
@property(nonatomic,strong)UILabel  *tributeIntroduceLabel;
@property(nonatomic,strong)UIView * buddhaIntroduceView;
@property(nonatomic,strong)UISwipeGestureRecognizer  *swipeRight;
@property(nonatomic,strong)UINavigationItem  *titleItem;
@property(nonatomic,strong)BuddhaInfoView *myBuddha;
@property(nonatomic,strong)NSMutableArray *buddaArray;
@property(nonatomic,strong)TempleImage *teModel;
@property(nonatomic,strong) NSMutableArray *flowerArray;
@property(nonatomic,strong)NSMutableArray * incensearray;
@property(nonatomic,strong)NSMutableArray * teaarray;
@property(nonatomic,strong)UIImageView *animatedImageView;
@property(nonatomic,strong)UIImageView *goodsImageView;
@property(nonatomic,strong)UIImageView * incenseImageView;
@property(nonatomic,strong)UIImageView * teaImageView;
@property(nonatomic,strong)UIImageView * offerImageView;
@property(nonatomic,strong)NSMutableArray *nameArray;
@end

@implementation MyBuddhaHallViewController
//香
-(UIImageView *)incenseImageView
{
    if (_incenseImageView== nil) {
        _incenseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(115,SCREEN_HEIGHT*0.35,SCREEN_WIDTH - 2*120,SCREEN_HEIGHT * 0.38)];
        _incenseImageView.animationRepeatCount = 1;
        
    }
    return _incenseImageView;
}
//花
-(NSMutableArray *)flowerArray
{
    if (_flowerArray == nil) {
        _flowerArray = [[NSMutableArray alloc] init];
        for(int i = 1; i < 12; i++)
        {
            NSString *imageName = [NSString stringWithFormat:@"flower_light%02d",i];
            NSString *imageFile = [[NSBundle mainBundle]pathForResource:imageName ofType:@"png"];
            UIImage *image = [UIImage imageWithContentsOfFile:imageFile];
            [_flowerArray addObject:image];
        }
    }
    return _flowerArray;
}
//香
-(NSMutableArray *)incensearray
{
    if (_incensearray == nil) {
        _incensearray = [[NSMutableArray alloc] init];
        for(int i = 12; i < 27; i++)
        {
            NSString *imageName = [NSString stringWithFormat:@"jossstick%02d",i];
            NSString *imageFile = [[NSBundle mainBundle]pathForResource:imageName ofType:@"png"];
            UIImage *image = [UIImage imageWithContentsOfFile:imageFile];
            [_incensearray addObject:image];
        }
    }
    return _incensearray;
}

-(UIImageView *)animatedImageView
{
    if (_animatedImageView == nil) {
        _animatedImageView = [[UIImageView alloc] init];
        _animatedImageView.frame = CGRectMake(40,SCREEN_HEIGHT*0.3,SCREEN_WIDTH - 2*50,SCREEN_HEIGHT * 0.5);
        _animatedImageView.animationRepeatCount = 1;
        _goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(120,SCREEN_HEIGHT*0.1,_animatedImageView.frame.size.width -2*100,SCREEN_HEIGHT*0.2)];
        [_animatedImageView addSubview:_goodsImageView];
        
        _offerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(90,SCREEN_HEIGHT*0.1,_animatedImageView.frame.size.width -2*80,SCREEN_HEIGHT*0.18)];
        [_animatedImageView addSubview:_offerImageView];

        
    }
    return _animatedImageView;
}

//茶
-(UIImageView *)teaImageView
{
    if (_teaImageView== nil) {
        _teaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(140,SCREEN_HEIGHT*0.35,SCREEN_WIDTH - 2*120,SCREEN_HEIGHT * 0.32)];
        _teaImageView.animationRepeatCount = 1;
        
    }
    return _teaImageView;
}
//茶
-(NSMutableArray *)teaarray
{
    if (_teaarray == nil) {
        _teaarray = [[NSMutableArray alloc] init];
        for(int i = 1; i < 24; i++)
        {
            NSString *imageName = [NSString stringWithFormat:@"tea_ani%02d",i];
            NSString *imageFile = [[NSBundle mainBundle]pathForResource:imageName ofType:@"png"];
            UIImage *image = [UIImage imageWithContentsOfFile:imageFile];
            [_teaarray addObject:image];
        }
    }
    return _teaarray;
}


-(NSMutableArray *)buddaArray
{
    if (_buddaArray == nil) {
        _buddaArray = [[NSMutableArray alloc]init];
    }
    return _buddaArray;
}
-(UISwipeGestureRecognizer *)swipeRight
{
    if (_swipeRight == nil) {
        _swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightActivity)];
        _swipeRight.numberOfTouchesRequired = 1;
        _swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    }
    return _swipeRight;
}
//弹出介绍
-(void)showTributeIntroduceLabel
{
    [UIView animateWithDuration:0.2 animations:^{
        self.tributeIntroduceView.frame = CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
    }];
}
-(void)showTributeIntroduceLabel1{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.buddhaIntroduceView.frame = CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
    }];
}
//退出介绍
-(void)swipeRightActivity
{
    [UIView animateWithDuration:0.2 animations:^{
        self.tributeIntroduceView.frame = CGRectMake(SCREEN_WIDTH,0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}
-(UIView *)tributeIntroduceView
{
    if (_tributeIntroduceView == nil) {
        _tributeIntroduceView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
        [self.view addSubview:_tributeIntroduceView];
        UIView  *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.3;
        [view addGestureRecognizer:self.swipeRight];
        [_tributeIntroduceView addSubview:view];
        //添加手势
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 27, 30, 25)];
        [backBtn setImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(dismissBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_tributeIntroduceView addSubview:backBtn];
        [_tributeIntroduceView addSubview:self.tributeIntroduceLabel];
    }
    return _tributeIntroduceView;
}
-(UIView *)buddhaIntroduceView
{
    if (_buddhaIntroduceView == nil) {
        _buddhaIntroduceView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
        [self.view addSubview:_buddhaIntroduceView];
        UIView  *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.3;
        [view addGestureRecognizer:self.swipeRight];
        [_buddhaIntroduceView addSubview:view];
        //添加手势
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 27, 30, 25)];
        [backBtn setImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(dismissBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_buddhaIntroduceView addSubview:backBtn];
        
        UILabel * la = [[UILabel alloc]initWithFrame:CGRectMake(15, 36, 30, 25)];
        la.text=@"heheh";
        la.backgroundColor=[UIColor redColor];
        la.textColor=[UIColor redColor];
        la.font=[UIFont systemFontOfSize:14];
        [_buddhaIntroduceView addSubview:la];
        
    }
    return _tributeIntroduceView;
}

-(void)dismissBtnClick
{
    [self swipeRightActivity];
}
-(UILabel *) tributeIntroduceLabel
{
    if (_tributeIntroduceLabel == nil) {
        CGFloat marginX = 40;
        _tributeIntroduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(marginX,45,SCREEN_WIDTH - 2*marginX,SCREEN_HEIGHT-0)];
        _tributeIntroduceLabel.numberOfLines = 1 ;
        [_tributeIntroduceLabel addGestureRecognizer:self.swipeRight];
        _tributeIntroduceLabel.textColor = [UIColor whiteColor];
        _tributeIntroduceLabel.font = [UIFont systemFontOfSize:18];
        _tributeIntroduceLabel.numberOfLines = 0 ;
    }
    return _tributeIntroduceLabel;
}
-(MakingVowView * )makingVowView
{
    //用于判断设备
    CGFloat height;
    if (fabs(SCREEN_HEIGHT-667) < 1)
    {
        height =  300;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            height = 280;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            height = 320;
        }
        else
        {
            height = 260;
        }
    }
    
    if (_makingVowView == nil) {
        _makingVowView = [[MakingVowView alloc] initWithFrame:CGRectMake(25,NAVBARHEIGHT + 30,
                                                                         SCREEN_WIDTH - 18 * 3,height+40)];
        __weak MakingVowView *weakMakingVowView = _makingVowView;
        WS(weakSelf);
        _makingVowView.deleteBlock =  ^void()
        {
            [weakSelf.maskView removeFromSuperview];
            [weakMakingVowView removeFromSuperview];
        };
        _makingVowView.submitBlock = ^void(NSString *str1, NSString * str2,NSInteger  index)
        {
            //调用许愿接口
            [weakSelf.maskView removeFromSuperview];
            [weakSelf.makingVowView removeFromSuperview];
            
            [weakSelf  postVowContent:str1 withVowContentStr:str2 withVowStyle:index];
        };
    }
    return _makingVowView;
}
-(NSMutableArray *)buddhaViewArray
{
    if (_buddhaViewArray == nil) {
        _buddhaViewArray = [[NSMutableArray alloc] init];
    }
    return _buddhaViewArray;
}
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
    [_backgroundImage removeFromSuperview];
    [self.tributeScrollView removeFromSuperview];
    [_introductionLabel removeFromSuperview];
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
-(void)rebackBtnClick{
    
    _backBtn.hidden=NO;
    _navBar.hidden=NO;
    [againBt removeFromSuperview];
    _titleLabel.hidden=NO;
    retitleLabel.hidden=YES;
    self.foxImageView.hidden=YES;
    scrollImageView.hidden=YES;
    startBtn.hidden=YES;
    explainImageView.hidden=YES;
    explainLabel.hidden=YES;
    divinationImageView.hidden=YES;
    
}
-(void)startClick{
    [scrollImageView removeFromSuperview];
    [startBtn removeFromSuperview];
    [explainImageView removeFromSuperview];
    [divinationImageView removeFromSuperview];
}
#pragma mark - 初始化
-(NSMutableArray *)MyBuddhaArray
{
    if (_MyBuddhaArray == nil) {
        _MyBuddhaArray = [[NSMutableArray alloc] init];
    }
    return _MyBuddhaArray;
}
-(instancetype)init
{
    if (self = [super init]) {
        [self getTempleList];
        [self loadData];
        [self getWishNum];
        
       
    }
    return self;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    //[self getTempleList];
    //默认不是还愿的
    self.isVow = NO ;
    _currentPage = 0 ;
    //默认每一个都正常献供   非还愿时的献供
    self.flagVowStyle = 4 ;
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
    bgImageView.image = [UIImage imageNamed:@"buddha_view_bg480.gif"];//480x800.jpg
    bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:bgImageView];
    self.titleLabel.text=self.nameArray[0];
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
}
#pragma mark -关于界面
-(UIScrollView *)buddhaViewScollView
{
    if (_buddhaViewScollView ==  nil) {
        _buddhaViewScollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
        _buddhaViewScollView.showsHorizontalScrollIndicator=NO;
        _buddhaViewScollView.showsVerticalScrollIndicator=NO;
    }
    return _buddhaViewScollView;
}
#pragma mark ----请佛--
-(void)createUI
{
    //[self.MyBuddhaArray removeLastObject];
    //表示还可以请佛
    
    if (self.MyBuddhaArray.count < 3)
    {
        TempleImage *model = [[TempleImage alloc] init];
        [self.MyBuddhaArray addObject:model];
    }
    for(int i = 0 ; i < self.MyBuddhaArray.count; i++)
    {
        BuddhaHallView *view = [[BuddhaHallView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * i,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
        [self.buddhaViewArray addObject:view];
        WS(weakSelf);
        view.block = ^void()
        {
            Please_QFViewController  *vc = [[Please_QFViewController alloc] init];
            vc.delegate = self;
            vc.vc = self;
            [self.navigationController pushViewController:vc animated:YES];
        };
        //点击佛像进入详情界面
        view.tapBlock = ^void(TempleImage* model)
        {
            //佛像简介
            NSLog(@"描述＝%@----",model.taskDesc);
            NSLog(@"----%@----",model.taskName);
            self.myBuddha=[[BuddhaInfoView alloc]initWithFrame:self.view.bounds WithModel:model];
            [weakSelf.view  addSubview:self.myBuddha];
            self.myBuddha.blockBudd = ^void(){
                [weakSelf rankBtnClick];
            };
            [self getBuddhaIntrol:model];
            
        };
        view.wishBlock = ^void(){
            
            [self cliffordClick];
        };
        view.vowBlock = ^void(){
            
            [weakSelf vowClick];
        };
        view.teaaBlock = ^void(){
            
            [self forteaBtnClick];
            NSLog(@"wojdiehuehuh");
        };
        view.flowerBlock=^void(){
            
            [weakSelf forflowerBtnClick];
            
        };
        view.increntseBlock=^void(){
            
            [weakSelf incenseBtnClick];
            
        };
        view.fruitBliock=^void(){
            
            [weakSelf offerBtnClick];
        };
        
        if (i == self.MyBuddhaArray.count - 1) {
            emptybuddahaHallView  = view;
            //emptybuddahaHallView.btn.hidden = YES;
        }
        TempleImage *model = self.MyBuddhaArray[i];
        [view setModel:model];
        [self.buddhaViewScollView addSubview:view];
    }
    self.buddhaViewScollView.contentSize = CGSizeMake(self.MyBuddhaArray.count * SCREEN_WIDTH,0);
    self.buddhaViewScollView.pagingEnabled = YES;
    self.buddhaViewScollView.bounces = NO;
    self.buddhaViewScollView.delegate = self;
    [self.view addSubview:self.buddhaViewScollView];
}
#pragma mark ----列表接口
-(void)getTempleList{
    AppDelegate *appDelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSNumber * miyaoNum = [appDelegate.accountBasicDict objectForKey:@"secretKey"];
    NSDictionary * dic=@{@"secretKey":miyaoNum,@"huaienID":huaien};
    NSDictionary * mainDic=@{@"params":[NSString stringWithFormat:@"%@",dic]};
    NSLog(@"mainDic=%@",mainDic);
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,TempleList] parameters:mainDic success:^(NSURLSessionDataTask *task, id responseObject){
        
        id jsonDate = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
          NSLog(@"my佛堂信息＝%@",jsonDate);
        NSArray *dictArray = jsonDate[@"data"];//把里面的字典取出来
        self.nameArray=[[NSMutableArray alloc]init];
        NSDictionary *dict=[[NSDictionary alloc]init];
        
        for(int i = 0 ; i < dictArray.count;i++)
        {
            dict = dictArray[i];
            //            NSLog(@"字典=%@",dict);
            [self.nameArray addObject:dict[@"taskName"]];
            TempleImage *model = [[TempleImage alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.buddaArray addObject:model];
        }
        
    } failure:^(NSURLSessionDataTask *task, id responseObject){
    }];
}

#pragma mark -----佛像简介---
-(void)getBuddhaIntrol:(TempleImage *)model
{
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary * dic = @{@"taskCode":model.taskCode};
    NSDictionary * budDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,GetMaterailByIDURL] parameters:budDic success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"佛像＝%@",jsonData);
        self.myBuddha.textview.text=jsonData[@"taskDesc"];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark ----返回---
-(void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ---导航---
-(void)createBar
{
    [self getTribute];
    startModel = _teModel;
    _navBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NAVBARHEIGHT)];
    [_navBar setBackgroundImage:[UIImage imageNamed:@"meditation_top_bg.png"] forBarMetrics:UIBarMetricsDefault];
    _navBar.barStyle = UIBarStyleBlackTranslucent;
    
    _titleItem = [[UINavigationItem alloc]initWithTitle:@""];
    NSLog(@"_titleItem=%@",_titleItem.title);
    NSDictionary *navTitleArr = [NSDictionary dictionaryWithObjectsAndKeys:
                                 
                                 [UIFont boldSystemFontOfSize:20],UITextAttributeFont,
                                 [UIColor whiteColor],UITextAttributeTextColor ,nil];
    [_navBar setTitleTextAttributes:navTitleArr];
    UIButton  *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [_titleItem setLeftBarButtonItem:leftItem];
    [_navBar pushNavigationItem:_titleItem animated:NO];
    [self.view addSubview:_navBar];
//    
//    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 25,SCREEN_WIDTH*0.3 , _navBar.frame.size.height*0.6)];
//    self.titleLabel.font=[UIFont systemFontOfSize:20];
//    self.titleLabel.textColor=[UIColor whiteColor];
//    self.titleLabel.backgroundColor=[UIColor clearColor];
////    self.titleLabel.text=startModel.taskName;
//    NSLog(@"self.titleLabel.text=%@",self.titleLabel.text);
//    [_navBar addSubview:self.titleLabel];
    
}
-(void)backclick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark ---贡品按钮事件---
-(void)incenseBtnClick{
    
    TempleImage  *model = self.MyBuddhaArray[_currentPage];
    if (model.taskName == nil)
    {
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake((SCREEN_WIDTH - 200) / 2, SCREEN_HEIGHT*0.68, 200, 50);
        label.text = @"还没请佛，快去请佛吧";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.backgroundColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:14];
        [self.view addSubview:label];
        
        [UIView animateWithDuration:1.5 animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished)
         {
             [label removeFromSuperview];
         }];
    }else
    {
        [_vowBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_vowBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_forteaBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_forteaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_offerBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_offerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_forflowerBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_forflowerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_CliffordBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_CliffordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_incenseBtn setBackgroundImage:[UIImage imageNamed:@"bt_sure_offer_bg"] forState:UIControlStateNormal];
        [_incenseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.view addSubview:self.maskView];
        _backgroundImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.855, SCREEN_WIDTH, SCREEN_HEIGHT*0.145)];
        _backgroundImage.image=[UIImage imageNamed:@"offerings_bg"];
        _backgroundImage.userInteractionEnabled=YES;
        [self.view addSubview:_backgroundImage];
        
        CGFloat width = SCREEN_WIDTH / 3;
        CGFloat height = 100;
        UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 100,SCREEN_WIDTH,100)];
        self.tributeScrollView=bgScrollView;
        WS(weakSelf);
        for(int i = 0; i < self.incenseArray.count ; i++)
        {
            _model = self.incenseArray[i];
            _teaView = [[TeaView alloc] initWithFrame:CGRectMake(width * i ,0,width,height)];
            [_teaView setModel:_model];
            _teaView.selectBlock = ^void(TributeModel *model)
            {
                TintView *tintView = [[TintView alloc]initWithFrame:CGRectMake(0 ,0, SCREEN_WIDTH,SCREEN_HEIGHT)];
                [tintView setModel:model];
                [weakSelf.view addSubview:tintView];
                __weak UIView  * weakTintView = tintView;
                tintView.removeBlock= ^void()
                {
                    [weakSelf.maskView removeFromSuperview];
                    [weakTintView removeFromSuperview];
                    [weakSelf.tributeScrollView removeFromSuperview];
                    [weakSelf.backgroundImage removeFromSuperview];
                };
                tintView.resignBlock = ^void()
                {
                    [weakSelf.maskView removeFromSuperview];
                    [weakTintView removeFromSuperview];
                    [weakSelf.tributeScrollView removeFromSuperview];
                    [weakSelf.backgroundImage removeFromSuperview];
                };
                

                tintView.submitBlock = ^void(TributeModel *model)
                {
                    if (weakSelf.flagVowStyle == 0) {
                        NSLog(@"^^^^^^");

                        //                        [weakSelf getTempleVowWithBuddhistId:weakSelf.vowModel];
                    }
                    else
                    {
                        [weakSelf PtxAddUserTaskRecord:model];
                       
                    }
                    [weakSelf.maskView removeFromSuperview];
                    [weakTintView removeFromSuperview];
                    [weakSelf.tributeScrollView removeFromSuperview];
                    [weakSelf.backgroundImage removeFromSuperview];
                };
            };
            _teaView.questionBlock = ^void(NSString * shouming)
            {
#pragma mark  ------简介
                [weakSelf.view bringSubviewToFront:weakSelf.tributeIntroduceView];
                weakSelf.tributeIntroduceLabel.text = shouming;
                [weakSelf showTributeIntroduceLabel];
            };
            [bgScrollView addSubview:_teaView];
        }
        bgScrollView.contentSize = CGSizeMake(self.incenseArray.count * width,0);
        [self.view addSubview:bgScrollView];
        
    }
}

-(void)forteaBtnClick
{
    TempleImage  *model = self.MyBuddhaArray[_currentPage];
    if (model.taskName == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake((SCREEN_WIDTH - 200) / 2, SCREEN_HEIGHT*0.68, 200, 50);
        label.text = @"还没请佛，快去请佛吧";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.backgroundColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:14];
        [self.view addSubview:label];
        [UIView animateWithDuration:1.5 animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
        
    }else {
        
        [_incenseBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_incenseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_offerBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_offerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_vowBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_vowBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_forflowerBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_forflowerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_CliffordBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_CliffordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_forteaBtn setBackgroundImage:[UIImage imageNamed:@"bt_sure_offer_bg"] forState:UIControlStateNormal];
        [_forteaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.view addSubview:self.maskView];
        _backgroundImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.855, SCREEN_WIDTH, SCREEN_HEIGHT*0.145)];
        _backgroundImage.image=[UIImage imageNamed:@"offerings_bg"];
        _backgroundImage.userInteractionEnabled=YES;
        [self.view addSubview:_backgroundImage];
        
        CGFloat width = SCREEN_WIDTH / 3;
        CGFloat height = 100;
        UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 100,SCREEN_WIDTH,100)];
        self.tributeScrollView = bgScrollView;
        WS(weakSelf);
        for(int i = 0; i < self.teaArray.count ; i++)
        {
            _model = self.teaArray[i];
            _teaView = [[TeaView alloc] initWithFrame:CGRectMake(width * i ,0,width,height)];
            [_teaView setModel:_model];
            _teaView.selectBlock = ^void(TributeModel *model){
                TintView *tintView = [[TintView alloc]initWithFrame:CGRectMake(0 ,0, SCREEN_WIDTH,SCREEN_HEIGHT)];
                [tintView setModel:model];
                [weakSelf.view addSubview:tintView];
                __weak UIView  * weakTintView = tintView;
                tintView.removeBlock= ^void()
                {
                    [weakSelf.maskView removeFromSuperview];
                    [weakTintView removeFromSuperview];
                    [weakSelf.tributeScrollView removeFromSuperview];
                    [weakSelf.backgroundImage removeFromSuperview];
                };
                tintView.resignBlock = ^void()
                {
                    [weakSelf.maskView removeFromSuperview];
                    [weakTintView removeFromSuperview];
                    [weakSelf.tributeScrollView removeFromSuperview];
                    [weakSelf.backgroundImage removeFromSuperview];
                };
                tintView.submitBlock = ^void(TributeModel *model)
                {
                    if (weakSelf.flagVowStyle == 1) {
                        //                        [weakSelf getTempleVowWithBuddhistId:weakSelf.vowModel];
                    }
                    else
                    {
                        [weakSelf PtxAddUserTaskRecord:model];
                    }
                    [weakSelf.maskView removeFromSuperview];
                    [weakTintView removeFromSuperview];
                    [weakSelf.tributeScrollView removeFromSuperview];
                    [weakSelf.backgroundImage removeFromSuperview];
                };
            };
            _teaView.questionBlock = ^void(NSString * shouming)
            {
                [weakSelf.view bringSubviewToFront:weakSelf.tributeIntroduceView];
                weakSelf.tributeIntroduceLabel.text = shouming;
                [weakSelf showTributeIntroduceLabel];
            };
            [bgScrollView addSubview:_teaView];
        }
        bgScrollView.contentSize = CGSizeMake(self.teaArray.count * width,0);
        [self.view addSubview:bgScrollView];
    }
}
-(void)offerBtnClick{
    TempleImage  *model = self.MyBuddhaArray[_currentPage];
    if (model.taskName == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake((SCREEN_WIDTH - 200) / 2, SCREEN_HEIGHT*0.68, 200, 50);
        label.text = @"还没请佛，快去请佛吧";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.backgroundColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:14];
        [self.view addSubview:label];
        
        [UIView animateWithDuration:1.5 animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished)
         {
             [label removeFromSuperview];
         }];
        
        
    }else {
        
        [_incenseBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_incenseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_forteaBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_forteaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_vowBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_vowBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_forflowerBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_forflowerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_CliffordBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_CliffordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_offerBtn setBackgroundImage:[UIImage imageNamed:@"bt_sure_offer_bg"] forState:UIControlStateNormal];
        [_offerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.view addSubview:self.maskView];
        _backgroundImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.855, SCREEN_WIDTH, SCREEN_HEIGHT*0.145)];
        _backgroundImage.image=[UIImage imageNamed:@"offerings_bg"];
        _backgroundImage.userInteractionEnabled=YES;
        [self.view addSubview:_backgroundImage];
        
        CGFloat width = SCREEN_WIDTH / 3;
        CGFloat height = 100;
        UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 100,SCREEN_WIDTH,100)];
        self.tributeScrollView = bgScrollView;
        WS(weakSelf);
        for(int i = 0; i < self.fruitArray.count ; i++)
        {
            _model = self.fruitArray[i];
            _teaView = [[TeaView alloc] initWithFrame:CGRectMake(width * i ,0,width,height)];
            [_teaView setModel:_model];
            _teaView.selectBlock = ^void(TributeModel *model){
                TintView *tintView = [[TintView alloc]initWithFrame:CGRectMake(0 ,0, SCREEN_WIDTH,SCREEN_HEIGHT)];
                [tintView setModel:model];
                [weakSelf.view addSubview:tintView];
                __weak UIView  * weakTintView = tintView;
                tintView.removeBlock= ^void()
                {
                    [weakSelf.maskView removeFromSuperview];
                    [weakTintView removeFromSuperview];
                    [weakSelf.tributeScrollView removeFromSuperview];
                    [weakSelf.backgroundImage removeFromSuperview];
                };
                tintView.resignBlock = ^void()
                {
                    [weakSelf.maskView removeFromSuperview];
                    [weakTintView removeFromSuperview];
                    [weakSelf.tributeScrollView removeFromSuperview];
                    [weakSelf.backgroundImage removeFromSuperview];
                };
                tintView.submitBlock = ^void(TributeModel *model)
                {
                    if (weakSelf.flagVowStyle == 2) {
                        //                        [weakSelf getTempleVowWithBuddhistId:weakSelf.vowModel];
                    }
                    else
                    {
                        [weakSelf PtxAddUserTaskRecord:model];
                    }
                    [weakSelf.maskView removeFromSuperview];
                    [weakTintView removeFromSuperview];
                    [weakSelf.tributeScrollView removeFromSuperview];
                    [weakSelf.backgroundImage removeFromSuperview];
                };
            };
            _teaView.questionBlock = ^void(NSString * shouming)
            {
                [weakSelf.view bringSubviewToFront:weakSelf.tributeIntroduceView];
                weakSelf.tributeIntroduceLabel.text = shouming;
                [weakSelf showTributeIntroduceLabel];
            };
            [bgScrollView addSubview:_teaView];
        }
        
        bgScrollView.contentSize = CGSizeMake(self.fruitArray.count * width,0);
        [self.view addSubview:bgScrollView];
    }
}

-(void)forflowerBtnClick
{
    TempleImage  *model = self.MyBuddhaArray[_currentPage];
    if (model.taskName == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake((SCREEN_WIDTH - 200) / 2, SCREEN_HEIGHT*0.68, 200, 50);
        label.text = @"还没请佛，快去请佛吧";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.backgroundColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:14];
        [self.view addSubview:label];
        
        [UIView animateWithDuration:1.5 animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
        
        
    }else {
        
        [self.view addSubview:self.maskView];
        [_incenseBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_incenseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_forteaBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_forteaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_vowBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_vowBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_offerBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_offerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_CliffordBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_CliffordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_forflowerBtn setBackgroundImage:[UIImage imageNamed:@"bt_sure_offer_bg"] forState:UIControlStateNormal];
        [_forflowerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.view addSubview:self.maskView];
        _backgroundImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.855, SCREEN_WIDTH, SCREEN_HEIGHT*0.145)];
        _backgroundImage.image=[UIImage imageNamed:@"offerings_bg"];
        _backgroundImage.userInteractionEnabled=YES;
        [self.view addSubview:_backgroundImage];
        
        CGFloat width = SCREEN_WIDTH / 3;
        CGFloat height = 100;
        UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 100,SCREEN_WIDTH,100)];
        self.tributeScrollView = bgScrollView;
        WS(weakSelf);
        [bgScrollView setShowsHorizontalScrollIndicator:NO];
        for(int i = 0; i < self.flowerArrray.count ; i++)
        {
            _model = self.flowerArrray[i];
            TeaView *teaView = [[TeaView alloc] initWithFrame:CGRectMake(width * i ,0,width,height)];
            [teaView setModel:_model];
            teaView.selectBlock = ^void(TributeModel *model){
                TintView *tintView = [[TintView alloc]initWithFrame:CGRectMake(0 ,0, SCREEN_WIDTH,SCREEN_HEIGHT)];
                [tintView setModel:model];
                [weakSelf.view addSubview:tintView];
                __weak UIView  * weakTintView = tintView;
                
                tintView.removeBlock= ^void()
                {
                    [weakSelf.maskView removeFromSuperview];
                    [weakTintView removeFromSuperview];
                    [weakSelf.tributeScrollView removeFromSuperview];
                    [weakSelf.backgroundImage removeFromSuperview];
                };
                tintView.resignBlock = ^void()
                {
                    [weakSelf.maskView removeFromSuperview];
                    [weakTintView removeFromSuperview];
                    [weakSelf.tributeScrollView removeFromSuperview];
                    [weakSelf.backgroundImage removeFromSuperview];
                };
                tintView.submitBlock = ^void(TributeModel *model)
                {
                    if (weakSelf.flagVowStyle == 3) {
                        //                        [weakSelf getTempleVowWithBuddhistId:weakSelf.vowModel];
                    }
                    else
                    {
                        [weakSelf PtxAddUserTaskRecord:model];
                    }
                    [weakSelf.maskView removeFromSuperview];
                    [weakTintView removeFromSuperview];
                    [weakSelf.tributeScrollView removeFromSuperview];
                    [weakSelf.backgroundImage removeFromSuperview];
                };
                
            };
            teaView.questionBlock = ^void(NSString * shouming)
            {
                [weakSelf.view bringSubviewToFront:weakSelf.tributeIntroduceView];
                weakSelf.tributeIntroduceLabel.text = shouming;
                [weakSelf showTributeIntroduceLabel];
            };
            [bgScrollView addSubview:teaView];
        }
        bgScrollView.contentSize = CGSizeMake(self.flowerArrray.count * width,0);
        [self.view addSubview:bgScrollView];
    }
}
#pragma mark ----许愿
-(void)cliffordClick{
    TempleImage  *model = self.MyBuddhaArray[_currentPage];
    [self getWishNum];
    if (model.taskName == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        
        label.frame = CGRectMake(SCREEN_WIDTH*0.2, SCREEN_HEIGHT*0.68, SCREEN_WIDTH*0.6, 30);
        label.text = @"还没请佛，快去请佛吧";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.backgroundColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:14];
        [self.view addSubview:label];
        
        [UIView animateWithDuration:1.5 animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
        
    }else {
        AppDelegate * appdelegta=(AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary * numdic=@{@"secretKey":self.userDict[@"secretKey"],@"huaienID":self.userDict[@"huaienID"]};
        NSDictionary * numDic=@{@"params":[NSString stringWithFormat:@"%@",numdic]};
        [appdelegta.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,WishNumURL] parameters:numDic success:^(NSURLSessionDataTask *task, id responseObject){
            id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //            NSLog(@"许愿的次数=%@",jsonData);
            NSNumber *makeWishQty=jsonData[@"makeWishQty"];
            if ([makeWishQty integerValue]<3){
                
                [_incenseBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                [_incenseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [_forteaBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                [_forteaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [_offerBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                [_offerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [_forflowerBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                [_forflowerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [_vowBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                [_vowBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [_CliffordBtn setBackgroundImage:[UIImage imageNamed:@"bt_sure_offer_bg"] forState:UIControlStateNormal];
                [_CliffordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                //添加遮罩
                [self.view addSubview:self.maskView];
                [self.view addSubview:self.makingVowView];
                
            }else{
                UILabel *label = [[UILabel alloc]init];
                
                label.frame = CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.68, SCREEN_WIDTH*0.8, 30);
                label.text = @"许愿次数超过3次，今天不能许愿了!";
                label.textColor = [UIColor whiteColor];
                label.textAlignment = 1;
                label.backgroundColor = [UIColor blackColor];
                label.font = [UIFont boldSystemFontOfSize:14];
                [self.view addSubview:label];
                
                [UIView animateWithDuration:1.5 animations:^{
                    label.alpha = 0;
                } completion:^(BOOL finished) {
                    [label removeFromSuperview];
                }];
                
            }
        } failure:^(NSURLSessionDataTask *task, id responseObject){
        }];
        
    }
}-(void)deleteClick{
    [self.maskView removeFromSuperview];
    [nameText removeFromSuperview];
    [xinyuanText removeFromSuperview];
    [sureBt removeFromSuperview];
    [choiceBt removeFromSuperview];
    [choiceLabel removeFromSuperview];
    [deleteBt removeFromSuperview];
    [wishImageView removeFromSuperview];
    
}
#pragma mark ----提交许愿信息
-(void)postVowContent:(NSString *) nameStr withVowContentStr:(NSString *) vowContentStr withVowStyle:(NSInteger) vowStyle
{
    TempleImage  *model = self.MyBuddhaArray[_currentPage];
    AppDelegate  *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //在需要的地方获取数据
    NSNumber *loginId = [delegate.accountBasicDict objectForKey:@"userLoginID"];
    NSString *forObjectStr = nameStr;
    NSString *forContentStr = vowContentStr;
    NSNumber * miyaoNum =[delegate.accountBasicDict objectForKey:@"secretKey"];
#pragma warning   -----huaienID  登录的时候有改过？？？
    NSNumber * huaien = [delegate.accountBasicDict objectForKey:@"huaienID"];
    NSArray *keyArray= @[@"secretKey",@"userLoginID",@"huaienID",@"taskCode",@"sceneType",@"buddhistTempleID",@"content",@"fulfileTaskType",@"forObject"];
    NSDictionary * wishdic=@{@"secretKey":miyaoNum,@"userLoginID":loginId,@"huaienID":huaien,@"taskCode":@400,@"sceneType":@1,@"buddhistTempleID":[NSNumber numberWithInteger:model.buddhistTempleID],@"content":forContentStr,@"fulfileTaskType":[NSNumber numberWithInteger:vowStyle],@"forObject":forObjectStr};
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
    //    [ProgressHUD showOnView:self.view];
    AppDelegate * appdelegta=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegta.sessionManager GET:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject){
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //        NSLog(@"许愿信息=%@",jsonData);
        NSNumber  *result = jsonData[@"result"];
#pragma mark  ----提示消耗的祈福币   jsonData有返回   1秒钟消失  如果失败则告知超过当日最大值
        if ([result integerValue] > 0) {
            //            [ProgressHUD  hideAfterSuccessOnView:self.view];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 220) / 2, SCREEN_HEIGHT*0.68, 100, 20)];
            //            label.text = [NSString stringWithFormat:@"修行值+%@",jsonData[@"integral"]];
            label.text=@"修行值已经达到上限";
            label.textColor = [UIColor whiteColor];
            label.textAlignment = 1;
            label.backgroundColor = [UIColor blackColor];
            label.font = [UIFont boldSystemFontOfSize:14];
            [self.view addSubview:label];
            
            [UIView animateWithDuration:1.5 animations:^{
                label.alpha = 0;
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
            }];
            
            
        }
        else
        {
            
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake((SCREEN_WIDTH - 150) / 2, SCREEN_HEIGHT*0.68, 180, 20);
            label.text = jsonData[@"desc"];
            label.textColor = [UIColor whiteColor];
            label.textAlignment = 1;
            label.backgroundColor = [UIColor blackColor];
            label.font = [UIFont boldSystemFontOfSize:14];
            [self.view addSubview:label];
            
            [UIView animateWithDuration:1.5 animations:^{
                label.alpha = 0;
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
            }];
            //            [ProgressHUD hideAfterFailOnView:self.view];
        }
        
    } failure:^(NSURLSessionDataTask *task, id responseObject){
        
    }];
    
}
-(void)vowClick{
    
    TempleImage  *model = self.MyBuddhaArray[_currentPage];
  
    if (model.taskName == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake((SCREEN_WIDTH - 100) / 2, SCREEN_HEIGHT*0.68, 150, 20);
        label.text = @"还没请佛，快去请佛吧";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.backgroundColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:14];
        [self.view addSubview:label];
        
        [UIView animateWithDuration:1.5 animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }else{
        if (self.isVow)
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"确定放弃本次还愿吗？"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.tag =  500;
            alertView.delegate = self;
            [alertView show];
        }
        else
        {
            [_incenseBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [_incenseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_forteaBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [_forteaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_offerBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [_offerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_forflowerBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [_forflowerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_CliffordBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [_CliffordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_vowBtn setBackgroundImage:[UIImage imageNamed:@"bt_sure_offer_bg"] forState:UIControlStateNormal];
            [_vowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            HuanYuan_MainViewController *huanyuanVc = [[HuanYuan_MainViewController alloc] init];
            huanyuanVc.myBuddahaVC = self;
            
            [self.navigationController pushViewController:huanyuanVc animated:YES];
            [huanyuanVc loadDataWithBuddhistId:model.buddhistTempleID];
            //            TempleVow * vow = [[TempleVow alloc]init];
            
            isClick=YES;
        }
    }
    
}


#pragma mark ---键盘以及文本的高度----
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [wishImageView endEditing:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    TempleImage  *model = self.MyBuddhaArray[_currentPage];
    if (model.taskName == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        
        label.frame = CGRectMake((SCREEN_WIDTH - 200) / 2, SCREEN_HEIGHT*0.68, 100, 50);
        label.text = @"还没请佛，快去请佛吧";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.backgroundColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:14];
        [self.view addSubview:label];
        
        [UIView animateWithDuration:1.5 animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }else{
        
        NSTimeInterval animationDuration = 0.50f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
        self.view.frame = rect;
        [UIView commitAnimations];
        [textField resignFirstResponder];
    }
    return YES;
    
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    TempleImage  *model = self.MyBuddhaArray[_currentPage];
    if (model.taskName == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake((SCREEN_WIDTH - 200) / 2, SCREEN_HEIGHT*0.68, 100, 50);
        label.text = @"还没请佛，快去请佛吧";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.backgroundColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:14];
        [self.view addSubview:label];
        
        [UIView animateWithDuration:1.5 animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }else{
        
        CGRect frame = textField.frame;
        int offset = frame.origin.y +150 - (self.view.frame.size.height - 240);//键盘高度216
        NSLog(@"offset is %d",offset);
        NSTimeInterval animationDuration = 0.50f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float width = self.view.frame.size.width;
        float height = self.view.frame.size.height;
        if(offset > 0)
        {
            CGRect rect = CGRectMake(0.0f, offset,width,height);
            wishImageView.frame = rect;
        }
        [UIView commitAnimations];//设置调整界面的动画效果
    }
}
- (BOOL)textViewShouldReturn:(UITextView *)textview{
    [textview resignFirstResponder];
    TempleImage  *model = self.MyBuddhaArray[_currentPage];
    if (model.taskName == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake((SCREEN_WIDTH - 200) / 2, SCREEN_HEIGHT*0.68, 100, 50);
        label.text = @"还没请佛，快去请佛吧";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.backgroundColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:14];
        [self.view addSubview:label];
        
        [UIView animateWithDuration:1.5 animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }else{
        
        NSTimeInterval animationDuration = 0.50f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
        self.view.frame = rect;
        [UIView commitAnimations];
        [textview resignFirstResponder];
    }
    return YES;
    
}
-(void) textViewDidBeginEditing:(UITextView *)textView
{
    TempleImage  *model = self.MyBuddhaArray[_currentPage];
    if (model.taskName == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake((SCREEN_WIDTH - 200) / 2, SCREEN_HEIGHT*0.68, 100, 50);
        label.text = @"还没请佛，快去请佛吧";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.backgroundColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:14];
        [self.view addSubview:label];
        
        [UIView animateWithDuration:1.5 animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }else{
        
        CGRect frame = textView.frame;
        int offset = frame.origin.y +150 - (self.view.frame.size.height - 240);//键盘高度216
        NSTimeInterval animationDuration = 0.50f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float width = self.view.frame.size.width;
        float height = self.view.frame.size.height;
        if(offset > 0)
        {
            CGRect rect = CGRectMake(0.0f, offset,width,height);
            wishImageView.frame = rect;
        }
        [UIView commitAnimations];//设置调整界面的动画效果
    }
}


#pragma mark ---私人佛堂接口-----
//佛堂
-(void)loadData
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.userDict = appDelegate.accountBasicDict;
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@%@",__kBaseURLString,TempleURL];
    NSDictionary  *paramter = @{@"secretKey":self.userDict[@"secretKey"],@"huaienID":self.userDict[@"huaienID"]};
    NSDictionary  *dict = @{@"params":[NSString stringWithFormat:@"%@",paramter]};
    [appDelegate.sessionManager POST: url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"－－－－私人佛堂=%@",jsonData);
        NSArray *dictArray = jsonData[@"data"];
        NSMutableArray *taskNameArray=[[NSMutableArray alloc]init];
        
        TempleImage *model;
        for(int  i = 0 ; i < dictArray.count; i++)
        {
            NSDictionary  *dict = dictArray[i];
            NSNumber * taskcode = dict[@"taskCode"];
            [[NSUserDefaults standardUserDefaults]setObject:taskcode forKey:@"taskCode"];
            NSString *taskName=dict[@"taskName"];
            [taskNameArray addObject:taskName];
            
            model = [[TempleImage alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.MyBuddhaArray addObject:model];
            
            
        }
        [self createUI];
        [self createBar];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 25,SCREEN_WIDTH*0.3 , _navBar.frame.size.height*0.6)];
        self.titleLabel.font=[UIFont systemFontOfSize:20];
        self.titleLabel.textColor=[UIColor whiteColor];
        self.titleLabel.text=taskNameArray[0];
        [self.view addSubview:self.titleLabel];
        [_navBar addSubview:self.titleLabel];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark ---贡品接口----
-(void)getTribute{
    
    NSDictionary * tributedic =@{@"taskType":@1};
    NSDictionary * tributeDic = @{@"params":[NSString stringWithFormat:@"%@",tributedic]};
    AppDelegate * appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
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
#pragma mark ---许愿次数---
-(void)getWishNum{
    
    AppDelegate * appdelegta=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary * numdic=@{@"secretKey":self.userDict[@"secretKey"],@"huaienID":self.userDict[@"huaienID"]};
    NSDictionary * numDic=@{@"params":[NSString stringWithFormat:@"%@",numdic]};
    [appdelegta.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,WishNumURL] parameters:numDic success:^(NSURLSessionDataTask *task, id responseObject){
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"许愿的次数=%@",jsonData);
    } failure:^(NSURLSessionDataTask *task, id responseObject){
    }];
}
#pragma mark  -UIScrollView代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page =  scrollView.contentOffset.x / scrollView.frame.size.width;
    _currentPage =  page;
    TempleImage *model = self.MyBuddhaArray[_currentPage];
    self.titleLabel.text = model.taskName;
   
}
#pragma mark -进贡时调用的接口
-(void)PtxAddUserTaskRecord:(TributeModel *) model
{
    animatingModel= model;
    //动态效果
    if (model.taskType == 1) {
        //敬香
        //可以添加动态效果
         _buddhaViewScollView.scrollEnabled = NO;
        [self.view addSubview:self.incenseImageView];
        _incenseImageView.animationImages = self.incensearray;
        _incenseImageView.animationDuration = self.incensearray.count * 0.2;
        [self.incenseImageView startAnimating];
        [self performSelector:@selector(stopAnimateImageView) withObject:nil afterDelay:self.incenseImageView.animationDuration];
    }
    if (model.taskType == 2) {
        //敬茶
         _buddhaViewScollView.scrollEnabled = NO;
        [self.view addSubview:self.teaImageView];
        _teaImageView.animationImages = self.teaarray;
        _teaImageView.animationDuration = self.teaarray.count * 0.2;
        [self.teaImageView startAnimating];
        [self performSelector:@selector(stopAnimateImageView) withObject:nil afterDelay:self.teaImageView.animationDuration];
    }
    if (model.taskType == 3) {
        //献贡
         _buddhaViewScollView.scrollEnabled = NO;
        [self.view addSubview:self.animatedImageView];
        _animatedImageView.animationImages = self.flowerArray;
        _animatedImageView.animationDuration = self.flowerArray.count * 0.2;
        [self.animatedImageView startAnimating];
        [_offerImageView setImageWithURL:[NSURL URLWithString:model.materialImageUrl]];
        [self performSelector:@selector(stopAnimateImageView) withObject:nil afterDelay:self.animatedImageView.animationDuration];
    }
    if (model.taskType == 4) {
        //供花
         _buddhaViewScollView.scrollEnabled = NO;
        [self.view addSubview:self.animatedImageView];
        _animatedImageView.animationImages = self.flowerArray;
        _animatedImageView.animationDuration = self.flowerArray.count * 0.2;
        [self.animatedImageView startAnimating];
        [_goodsImageView setImageWithURL:[NSURL URLWithString:model.materialImageUrl]];
        [self performSelector:@selector(stopAnimateImageView) withObject:nil afterDelay:self.animatedImageView.animationDuration];
    }
    //调用接口
    TempleImage  *buddhistTemple = self.MyBuddhaArray[_currentPage];
    //取出佛堂ID
    NSNumber *buddhistTempleID = [NSNumber numberWithInteger:buddhistTemple.buddhistTempleID];
    
    NSNumber *loginId = [self.userDict objectForKey:@"userLoginID"];
    NSNumber * huaien = [self.userDict objectForKey:@"huaienID"];
    
    NSArray  *paramsKeyArray = @[@"secretKey",@"userLoginID",@"huaienID",@"taskCode",@"sceneType",@"buddhistTempleID",@"bookID",@"userTaskID",@"beginPostion",@"endPostion"];
    //该在这里
    NSDictionary * wishdic=@{@"secretKey":[self.userDict objectForKey:@"secretKey"],@"userLoginID":loginId,@"huaienID":huaien,@"taskCode":[NSNumber numberWithInteger:model.taskCode+299],@"sceneType":@1,@"buddhistTempleID":buddhistTempleID,@"bookID":@0,@"userTaskID":@0,@"beginPostion":@0,@"endPostion":@0};
    NSString *jsonParamsStr = @"{";
    for(int i = 0 ; i < paramsKeyArray.count; i++)
    {
        NSString *keyValue = paramsKeyArray[i];
        if (i == paramsKeyArray.count- 1) {
            jsonParamsStr = [NSString stringWithFormat:@"%@%@:%@}",jsonParamsStr,keyValue,[wishdic valueForKey:keyValue]];
        }
        else
        {
            jsonParamsStr = [NSString stringWithFormat:@"%@%@:%@,",jsonParamsStr,keyValue,[wishdic valueForKey:keyValue]];
        }
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@%@params=%@",__kBaseURLString,ptxAddUserTaskRecord,jsonParamsStr];
    
    AppDelegate * appdelegta=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegta.sessionManager GET:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject){
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"进贡＝%@",jsonData);
        NSNumber  *result  = jsonData[@"result"];
        if ([result integerValue] > 0) {
#pragma mark ---添加消耗纪念币的标签
            UIView *view=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.35, SCREEN_HEIGHT*0.6, SCREEN_WIDTH*0.35, SCREEN_HEIGHT*0.08)];
            view.backgroundColor=[UIColor blackColor];
                //        view.alpha=0.5;
            UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, -2, view.frame.size.width*0.7, view.frame.size.height)];
            label1.text=@"修行值";
            label1.font=[UIFont systemFontOfSize:20.0f];
            label1.textColor=[UIColor whiteColor];
            UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(2+label1.frame.size.width, label1.frame.origin.y, label1.frame.size.width*0.3, view.frame.size.height)];
            label2.text=@"+4";
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
        else
        {
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake((SCREEN_WIDTH - 200) / 2, SCREEN_HEIGHT*0.68, 200, 50);
            label.text =  jsonData[@"desc"];
            
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
        
        BuddhaHallView * buddView= [[BuddhaHallView alloc]init];
        NSString * str = [appdelegta.accountBasicDict objectForKey:@"levelAndDesignation"];
//        NSArray *array = [str componentsSeparatedByString:@"|"];
        NSMutableArray * arr = [NSMutableArray arrayWithArray:[str componentsSeparatedByString:@"|"]];
        for (int i = 0; i < [arr count]; i++) {
            NSLog(@"string:%@", [arr objectAtIndex:i]);
            
            buddView.gradLabel.text=arr[i+1];
            
//            UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//            view.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"bground"]];
//            //        view.alpha=0.5;
//            UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, -2, view.frame.size.width*0.7, view.frame.size.height)];
//            label1.text=@"修行值";
//            label1.font=[UIFont systemFontOfSize:20.0f];
//            label1.textColor=[UIColor whiteColor];
//            UIImageView *label2=[[UIImageView alloc]initWithFrame:CGRectMake(2+label1.frame.size.width, label1.frame.origin.y+label1.frame.size.height+10, label1.frame.size.width*0.8, view.frame.size.height)];
//            label2.image=[UIImage imageNamed:@"level_update_success_toast"];
////            label2.textColor=[UIColor redColor];
////            label2.font=[UIFont systemFontOfSize:20.0f];
//            [view addSubview:label1];
//            [view addSubview:label2];
//            
//            [UIView animateWithDuration:2 animations:^{
//                view.alpha = 0;
//                [self.view addSubview:view];
//                
//            } completion:^(BOOL finished) {
//                
//                [view removeFromSuperview];
//            }];
//            [lvt setTitle:[NSString stringWithFormat:@"LV%@",array[0]] forState:UIControlStateNormal];
            
        }

    } failure:^(NSURLSessionDataTask *task, id responseObject){
    }];
}
-(void)stopAnimateImageView
{
    BuddhaHallView * view = self.buddhaViewArray[_currentPage];
    [self.maskView removeFromSuperview];
    [self.animatedImageView removeFromSuperview];
    if(animatingModel.taskType==1){
       
        [view.burnerImageView setImageWithURL:[NSURL URLWithString:animatingModel.materialImageUrl]];
         _buddhaViewScollView.scrollEnabled=YES;
    }
    if (animatingModel.taskType == 2) {
        [view.teacupImageView1 setImage:[UIImage imageNamed:@"cup_has_tea"]];
         _buddhaViewScollView.scrollEnabled=YES;
    }
    if (animatingModel.taskType == 3) {
        [view.fruitBowlImageView1 setImageWithURL:[NSURL URLWithString:animatingModel.materialImageUrl]];
        [view.fruitBowlImageView2 setImageWithURL:[NSURL URLWithString:animatingModel.materialImageUrl]];
        _buddhaViewScollView.scrollEnabled=YES;
    }
    if (animatingModel.taskType == 4) {
        
        [view.vaseImageView1 setImageWithURL:[NSURL URLWithString:animatingModel.materialImageUrl]];
        [view.vaseImageView2 setImageWithURL:[NSURL URLWithString:animatingModel.materialImageUrl]];
        _buddhaViewScollView.scrollEnabled=YES;
    }
    
}

#pragma mark ---用于请佛改变图像
-(void)changeBuhhaImage:(TempleImage *) model withInfo:(NSDictionary *) jsonData
{
    if(self.MyBuddhaArray.count == 3)
    {
        BuddhaHallView * budd = emptybuddahaHallView;
        [budd.buddhaImageView setImageWithURL:[NSURL URLWithString:model.materialImageUrl]];
        budd.btn.hidden = YES;
    }
    else
    {
        
        //表示请的佛不满三尊
        BuddhaHallView * view = [[BuddhaHallView alloc] initWithFrame:CGRectMake((self.MyBuddhaArray.count - 2)* SCREEN_WIDTH,0, SCREEN_WIDTH, SCREEN_HEIGHT - 58)];
        emptybuddahaHallView.frame = CGRectMake((self.MyBuddhaArray.count -1) * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 58);
        [self.buddhaViewArray insertObject:view atIndex:self.MyBuddhaArray.count - 2];
        WS(weakSelf);
        view.block = ^void()
        {
            Please_QFViewController  *vc = [[Please_QFViewController alloc] init];
            vc.delegate = self;
            vc.vc = self;
            [self.navigationController pushViewController:vc animated:YES];
        };
        view.tapBlock = ^void(TempleImage* model)
        {
            self.myBuddha=[[BuddhaInfoView alloc]initWithFrame:self.view.bounds WithModel:model];
            [weakSelf.view  addSubview:self.myBuddha];
            [self getBuddhaIntrol:model];
        };
        [view setModel:model];
    }
    TributeModel * tributeModel = [[TributeModel alloc]init];
#pragma mark  -------  jsonData带有请佛成功后返回的信息 还有等级升级的效果
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake((SCREEN_WIDTH - 200) / 2, SCREEN_HEIGHT*0.68, 200, 50);
    label.text = [NSString stringWithFormat:@"请佛成功，消耗了%ld祈福币",tributeModel.prayMoney];
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
-(void)startAnimationImageView:(TempleImage *) model
{
    //开始动画
    //    [self.view addSubview:self.animationImageView];
    //    _animationImageView.animationImages = self.animationSlipsArray;
    //    _animationImageView.animationDuration = self.animationSlipsArray.count * 0.2;
    //    [_animationImageView startAnimating];
    //    [self  performSelector:@selector(getTheSlip:) withObject:model afterDelay:self.animationImageView.animationDuration];
    //    self.foxImageView.image = image;
    //    _navBar.hidden=YES;
    //    isClick = YES;
    //    [self.view addSubview:self.maskView];
    //    rebackBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    //    [rebackBtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    //    [rebackBtn addTarget:self action:@selector(rebackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    [self.bgView addSubview:rebackBtn];
    //
    //    _titleLabel.hidden=YES;
    //    //    _barImageView.hidden=NO;
    //    retitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(150, 33, 90, 25)];
    //    retitleLabel.text=@"求签请佛";
    //    retitleLabel.textColor=[UIColor whiteColor];
    //    retitleLabel.font=[UIFont systemFontOfSize:20];
    //    [self.bgView  addSubview:retitleLabel];
    //
    //    divinationImageView=[[UIImageView alloc]initWithFrame:CGRectMake(125, 85, SCREEN_WIDTH-250, SCREEN_HEIGHT-370)];
    //    divinationImageView.image=[UIImage imageNamed:@"sign_stick_icon"];
    //    [self.bgView addSubview:divinationImageView];
    //
    //    explainImageView=[[UIImageView alloc]initWithFrame:CGRectMake(30, 400, SCREEN_WIDTH-60, SCREEN_HEIGHT-520)];
    //    explainImageView.image=[UIImage imageNamed:@"please_buddha_rule_bg"];
    //    [self.bgView addSubview:explainImageView];
    //
    //    scrollImageView = [[UIScrollView alloc] initWithFrame:CGRectMake(50, 410, SCREEN_WIDTH-100, SCREEN_HEIGHT*0.15)];
    //    [scrollImageView setShowsHorizontalScrollIndicator:NO];
    //    [scrollImageView setShowsVerticalScrollIndicator:NO];
    //    [scrollImageView setContentSize:CGSizeMake(285, 200)];
    //    [scrollImageView setBackgroundColor:[UIColor clearColor]];
    //    scrollImageView.userInteractionEnabled = YES;
    //    [self.bgView addSubview:scrollImageView];
    //
    //    explainLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,10, 100, 20)];
    //    explainLabel.text=@"请佛说明";
    //    explainLabel.font=[UIFont systemFontOfSize:16];
    //    [scrollImageView addSubview:explainLabel];
    //
    //    CGFloat marginX = 40;
    //    CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH - 2*marginX, MAXFLOAT);
    //    CGFloat contentHeight = [self.textview sizeWithFont:[UIFont systemFontOfSize:14] maxSize:textMaxSize].height;
    //    explainConten=[[UILabel alloc]initWithFrame:CGRectMake(marginX-20,30, SCREEN_WIDTH - 2*marginX-40, contentHeight)];
    //    explainConten.text = self.textview;
    //    explainConten.numberOfLines = 0 ;
    //    explainConten.font = [UIFont systemFontOfSize:14];
    //    [scrollImageView addSubview:explainConten];
    //
    //    startBtn=[[UIButton alloc]initWithFrame:CGRectMake(150, 570, 90, 35)];
    //    [startBtn setBackgroundImage:[UIImage imageNamed:@"bt_please_buddha_bg"] forState:UIControlStateNormal];
    //    [startBtn setTitle:@"开始请佛" forState:UIControlStateNormal];
    //    [startBtn setTitleColor:Typeface forState:UIControlStateNormal];
    //    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    //    [self.bgView addSubview:startBtn];
    
    
}


int flag = 0 ;
-(void)getTheSlip:(TempleImage *) model
{
    [self.animationImageView removeFromSuperview];
    
    SlipView *slipView  = self.slipArray[flag];
    __weak SlipView *weakSlipView = slipView;
    slipView.block = ^void(SlipModel * model1)
    {
        if ([model1.title isEqualToString:@"上上签"]|| [model1.title isEqualToString:@"上签"]) {
            BuddhaHallView * currentBuhhaHallView = self.buddhaViewArray[_currentPage];
            [currentBuhhaHallView.buddhaImageView setImageWithURL:[NSURL URLWithString:model.materialImageUrl]];
            currentBuhhaHallView.btn.hidden = YES;
            [weakSlipView removeFromSuperview];
        }
        else
        {
            flag ++;
            [weakSlipView removeFromSuperview];
            
            [self startAnimationImageView:model];
        }
    };
    
    [self.view addSubview:slipView];
}
#pragma mark ----求签的数据
-(NSArray *)loadSlipData
{
    NSArray *titleArray = @[@"上上签",@"上签",@"下签",@"下下签",@"中签"];
    NSArray *contentArray = @[@"彼亦俦中一辈贤,\n劝君特达与周旋。\n此时宾主欢相会,\n他日王侯却并肩。",@"事团圆,\n物周旋,\n一来一往,\n平步青天。",@"春秋直笔照人寒,\n褒贬分明事事难。\n游夏斯时先学圣,\n一毫未敢露词端",@"来路明兮复不明,\n不明莫要与他真。\n坭墙倾跌还城土,\n纵然神扶也难行。",@"天上风,\n天边月。\n月白风清,\n两两相当。"];
    NSArray  *resultArray = @[@"恭喜您！抽到上上签！请佛成功！\n快请神佛入佛堂吧！",@"恭喜您！抽到上上签！请佛成功！\n快请神佛入佛堂吧！",@"很遗憾！请佛失败！",@"很遗憾！请佛失败！",@"很遗憾！请佛失败！"];
    NSArray * btnTitleArray = @[@"请入佛堂",@"请入佛堂",@"再求一次",@"再求一次",@"再求一次"];
    NSArray   *slipsArray =  [self returnSlipsResult];
    NSMutableArray  *slipsResultArray = [[NSMutableArray alloc] init];
    for(int i = 0 ; slipsArray.count ; i ++)
    {
        NSNumber * number = slipsArray[i];
        int flag =  [number intValue];
        SlipModel  * model = [[SlipModel alloc] init];
        model.title = titleArray[flag];
        model.content = contentArray[flag];
        model.result  =  resultArray[flag];
        model.btnTitle = btnTitleArray[flag];
        SlipView * view = [[SlipView alloc] initWithFrame:CGRectMake(0.1 *SCREEN_WIDTH,0.3 *SCREEN_HEIGHT,0.8 * SCREEN_WIDTH,0.4 * SCREEN_HEIGHT)];
        [view setModel:model];
        [slipsResultArray addObject:view];
        if (flag == 0 || flag == 1) {
            break;
        }
    }
    
    return slipsResultArray;
}
#pragma mark ----用于随机结果
-(NSArray *)returnSlipsResult
{
    int f = arc4random() % 2;
    NSNumber * number = [NSNumber numberWithInt:f];
    NSMutableArray  * array = [[NSMutableArray alloc] init];
    [array addObject:number];
    for(int i = 0 ; i < 2; i++)
    {
        f  = arc4random() % 5;
        NSNumber  *number  = [NSNumber numberWithInt:f];
        [array addObject:number];
    }
    for(int i  = 0 ; i < array.count;i++)
    {
        NSNumber *f = array[i];
        for (int j = 0 ; j < array.count; j++) {
            if (arc4random() %2) {
                [array replaceObjectAtIndex:j withObject:f];
            }
        }
    }
    return @[@4,@0,@1];
}
//#pragma mark -----还愿
//-(void)getTempleVowWithBuddhistId:(TempleVow *) model
//{
//    self.isVow = NO;
//    //[ProgressHUD showOnView:self.view];
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSNumber * miyaoNum = [appDelegate.accountBasicDict objectForKey:@"secretKey"];
//    NSNumber * loginid = [appDelegate.accountBasicDict objectForKey:@"userLoginID"];
//    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
//    NSDictionary * vowdic=@{@"secretKey":miyaoNum,@"userLoginID":loginid,@"huaienID":huaien,@"userTaskID":[NSNumber numberWithInteger:model.userTaskID],@"fulfilID":[NSNumber numberWithInteger:model.fulfilID],@"sceneType":@1,@"buddhistTempleID":[NSNumber numberWithInteger:model.buddhistTempleID]};
//    NSLog(@"id=%@",[NSNumber numberWithInteger:model.userTaskID]);
//    NSLog(@"还原id＝%@",vowdic);
//    NSDictionary * vowDic = @{@"params":[NSString stringWithFormat:@"%@",vowdic]};
//    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,VowURL]  parameters:vowDic success:^(NSURLSessionDataTask *task, id responseObject) {
//        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",jsonData);
//        UILabel *label = [[UILabel alloc]init];
//        label.frame = CGRectMake((SCREEN_WIDTH - 200) / 2, SCREEN_HEIGHT*0.68, 150, 20);
//        label.text = [NSString stringWithFormat:@"获取祈福币%@",jsonData[@"prayMoneyFulfil"]];
//        label.textColor = [UIColor whiteColor];
//        label.textAlignment = 1;
//        label.backgroundColor = [UIColor blackColor];
//        label.font = [UIFont boldSystemFontOfSize:12];
//        [self.view addSubview:label];
//
//        [UIView animateWithDuration:1.5 animations:^{
//            label.alpha = 0;
//        } completion:^(BOOL finished) {
//            [label removeFromSuperview];
//            UILabel *label = [[UILabel alloc]init];
//            label.frame = CGRectMake((SCREEN_WIDTH - 200) / 2, SCREEN_HEIGHT*0.68, 150, 50);
//            label.text = [NSString stringWithFormat:@"还愿获取积分数量%@",jsonData[@"integralFulfil"]];
//            label.textColor = [UIColor whiteColor];
//            label.textAlignment = 1;
//            label.backgroundColor = [UIColor blackColor];
//            label.font = [UIFont boldSystemFontOfSize:12];
//            [self.view addSubview:label];
//
//            [UIView animateWithDuration:1.5 animations:^{
//                label.alpha = 0;
//            } completion:^(BOOL finished) {
//                [label removeFromSuperview];
//            }];
//
//        }];
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//    }];
//}
#pragma mark ----UIAlertView 代理方法
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //取消 不需要任何操作
    }
    else
    {
        self.isVow = NO;
        self.flagVowStyle = 4;
        
        [_incenseBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_incenseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_forteaBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_forteaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_offerBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_offerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_forflowerBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_forflowerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_CliffordBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_CliffordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_vowBtn setBackgroundImage:[UIImage imageNamed:@"bt_sure_offer_bg"] forState:UIControlStateNormal];
        [_vowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        TempleImage  *model = self.MyBuddhaArray[_currentPage];
        HuanYuan_MainViewController *huanyuanVc = [[HuanYuan_MainViewController alloc] init];
        huanyuanVc.myBuddahaVC = self;
        [self.navigationController pushViewController:huanyuanVc animated:YES];
        [huanyuanVc loadDataWithBuddhistId:model.buddhistTempleID];
    }
}
#pragma mark  --- 点击排行榜
-(void)rankBtnClick
{
    TempleImage * model = self.MyBuddhaArray[_currentPage];
    BuddhaddRankViewController * rankVC = [[BuddhaddRankViewController alloc]initWithModel:model];
    [self.navigationController pushViewController:rankVC animated:YES];
}
@end
