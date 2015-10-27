//
//  My_syViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/8.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "My_syViewController.h"
#import "ZhuYeMianViewController.h"
#import "RESideMenu.h"

@interface My_syViewController ()

@end

@implementation My_syViewController
@synthesize dataArray;
@synthesize scrollView;
@synthesize selectIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 70)];
    view.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"顶部导航背景"]];
    [self.view addSubview:view];
    //    UIImageView *
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(165, 30, 80, 30)];
    title.text=@"结缘";
    title.font=[UIFont systemFontOfSize:20];
    title.textColor=[UIColor whiteColor];
    [view addSubview:title];
    
    fanhuiBt=[[UIButton alloc]initWithFrame:CGRectMake(6, 33, 25, 25)];
    [fanhuiBt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [fanhuiBt addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhuiBt];
    
    fabuBt=[[UIButton alloc]initWithFrame:CGRectMake(325, 33, 30, 25)];
    [fabuBt setBackgroundImage:[UIImage imageNamed:@"publish_topic"] forState:UIControlStateNormal];
    [fabuBt addTarget:self action:@selector(faBuClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fabuBt];

    UIView * background=[[UIView alloc]initWithFrame:CGRectMake(0, 70, 380, self.view.frame.size.height)];
    background.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    [self.view addSubview:background];
    
    dataArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<20; i++) {
        [dataArray addObject:[NSNumber numberWithInt:i+1]];
    }
    
    UIView * quanziView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 48)];
    quanziView.backgroundColor=[UIColor whiteColor];
    [background addSubview:quanziView];
    
    dongtai_hyBt=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 190, 48)];
    [dongtai_hyBt setTitle:@"好友动态" forState:UIControlStateNormal];
    [dongtai_hyBt setBackgroundImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
    [dongtai_hyBt setTitleColor:[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [dongtai_hyBt addTarget:self action:@selector(dongtai_hyClick) forControlEvents:UIControlEventTouchUpInside];
    [quanziView addSubview:dongtai_hyBt];
    
    guanzhu_fensiBt=[[UIButton alloc]initWithFrame:CGRectMake(190, 0, 190, 48)];
    [guanzhu_fensiBt setTitle:@"关注粉丝" forState:UIControlStateNormal];
    [guanzhu_fensiBt setBackgroundImage:[UIImage imageNamed:@"底部导航背景.jpg"] forState:UIControlStateNormal];
    [guanzhu_fensiBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [guanzhu_fensiBt addTarget:self action:@selector(guanzhu_fensiClick) forControlEvents:UIControlEventTouchUpInside];
    [quanziView addSubview:guanzhu_fensiBt];
    
    UIImageView * iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 49, 380, 0.5)];
    iv.image=[UIImage imageNamed:@"line"];
    [background addSubview:iv];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 49, 380, self.view.frame.size.height)];
    [self.scrollView setBackgroundColor:[UIColor clearColor]];
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setContentSize:CGSizeMake(380, 1200)];
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, 380, 200) animated:NO];
//    [self.scrollView setDelegate:self];
    [background addSubview:self.scrollView];
    
    bgview=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 390, 290)];
    [bgview setBackgroundColor:[UIColor whiteColor]];
    [bgview addTarget:self action:@selector(bgviewClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:bgview];
    
    morenBt=[[UIButton alloc]initWithFrame:CGRectMake(10, 18, 35, 35)];
    [morenBt setBackgroundImage:[UIImage imageNamed:@"publisher_photo_small_icon"] forState:UIControlStateNormal];
    [morenBt addTarget:self action:@selector(morenClick) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:morenBt];
    
    nameLa=[[UILabel alloc]initWithFrame:CGRectMake(50, 15, 80, 20)];
    nameLa.text=@"感恩天下";
    nameLa.textColor=[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f];
    nameLa.font=[UIFont systemFontOfSize:16];
    [bgview addSubview:nameLa];
    
    timeLa=[[UILabel alloc]initWithFrame:CGRectMake(50, 35, 110, 20)];
    timeLa.text=@"2015-4-12 10:24:09";
    timeLa.textColor=[UIColor lightGrayColor];
    timeLa.font=[UIFont systemFontOfSize:12];
    [bgview addSubview:timeLa];
    
    UILabel * chu=[[UILabel alloc]initWithFrame:CGRectMake(170, 35, 40, 20)];
    chu.text=@"来自";
    chu.font=[UIFont systemFontOfSize:12];
    chu.textColor=[UIColor lightGrayColor];
    [bgview addSubview:chu];
    laiyuanLa=[[UILabel alloc]initWithFrame:CGRectMake(200, 35, 100, 20)];
    laiyuanLa.text=@"每日一善";
    laiyuanLa.textColor=[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f];
    laiyuanLa.font=[UIFont systemFontOfSize:12];
    [bgview addSubview:laiyuanLa];
    
    shoucangBt=[[UIButton alloc]initWithFrame:CGRectMake(260, 15, 50, 18)];
    [shoucangBt setBackgroundImage:[UIImage imageNamed:@"collect_no_have"] forState:UIControlStateNormal];
    [shoucangBt addTarget:self action:@selector(shoucangClick) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:shoucangBt];
    
    jubaoBt=[[UIButton alloc]initWithFrame:CGRectMake(315, 15, 50, 18)];
    [jubaoBt setBackgroundImage:[UIImage imageNamed:@"report_no_have"] forState:UIControlStateNormal];
    [jubaoBt addTarget:self action:@selector(jubaoClick) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:jubaoBt];
    
    titleLa=[[UILabel alloc]initWithFrame:CGRectMake(50, 60, 130, 20)];
    titleLa.text=@"佛说父母恩难报经";
    titleLa.font=[UIFont systemFontOfSize:16];
    [bgview addSubview:titleLa];
    
    neirongText=[[UITextView alloc]initWithFrame:CGRectMake(50, 80, 290, 80)];
    neirongText.text=@"闻如是。一时婆伽婆。在舍卫城。袛树给孤独园。尔时世尊。告诸比丘。父母于子。大有曾益。如哺长养。随时将育。四得大成。右肩负父。左肩负母。经历千年....";
    neirongText.textColor=[UIColor lightGrayColor];
    neirongText.font=[UIFont systemFontOfSize:14];
    [bgview addSubview:neirongText];
    
    shangchuanImage=[[UIImageView alloc]initWithFrame:CGRectMake(50, 170, 90, 70)];
    shangchuanImage.image=[UIImage imageNamed:@"bluesky_fozu.jpg"];
    [bgview addSubview:shangchuanImage];
    shangchuanImage1=[[UIImageView alloc]initWithFrame:CGRectMake(150, 170, 90, 70)];
    shangchuanImage1.image=[UIImage imageNamed:@"bluesky_fozu.jpg"];
    [bgview addSubview:shangchuanImage1];
    shangchuanImage2=[[UIImageView alloc]initWithFrame:CGRectMake(250, 170, 90, 70)];
    shangchuanImage2.image=[UIImage imageNamed:@"bluesky_fozu.jpg"];
    [bgview addSubview:shangchuanImage2];
    
    UILabel * dianzanLa=[[UILabel alloc]initWithFrame:CGRectMake(10, 265, 180, 20)];
    dianzanLa.text=@"随缘静修，静心清修等12人点赞";
    dianzanLa.textColor=[UIColor darkGrayColor];
    dianzanLa.font=[UIFont systemFontOfSize:12];
    [bgview addSubview:dianzanLa];
    
    UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(230, 258, 50, 25)];
    imageView.image=[UIImage imageNamed:@"comment_praise_bg"];
    [bgview addSubview:imageView];
    
    dianzanBt=[[UIButton alloc]initWithFrame:CGRectMake(232, 260, 25, 20)];
    [dianzanBt setBackgroundImage:[UIImage imageNamed:@"no_praise"] forState:UIControlStateNormal];
    [dianzanBt addTarget:self action:@selector(dianpingClick) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:dianzanBt];
    
    UILabel * renshuLa=[[UILabel alloc]initWithFrame:CGRectMake(257, 260, 80, 20)];
    renshuLa.text=@"12";
    renshuLa.textColor=[UIColor lightGrayColor];
    renshuLa.font=[UIFont systemFontOfSize:12];
    [bgview addSubview:renshuLa];
    
    UIImageView * pinglunImage=[[UIImageView alloc]initWithFrame:CGRectMake(300, 258, 50, 25)];
    pinglunImage.image=[UIImage imageNamed:@"comment_praise_bg"];
    [bgview addSubview:pinglunImage];
    
    pinglunBt=[[UIButton alloc]initWithFrame:CGRectMake(302, 260, 25, 20)];
    [pinglunBt setBackgroundImage:[UIImage imageNamed:@"小评论灰"] forState:UIControlStateNormal];
    [pinglunBt addTarget:self action:@selector(pinglunClick) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:pinglunBt];
    
    UILabel * renshu=[[UILabel alloc]initWithFrame:CGRectMake(331, 260, 80, 20)];
    renshu.text=@"21";
    renshu.textColor=[UIColor lightGrayColor];
    renshu.font=[UIFont systemFontOfSize:12];
    [bgview addSubview:renshu];
    
    bgview1=[[UIView alloc]initWithFrame:CGRectMake(0, 295, 390, 290)];
    bgview1.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:bgview1];
    
    morenBt=[[UIButton alloc]initWithFrame:CGRectMake(10, 18, 35, 35)];
    [morenBt setBackgroundImage:[UIImage imageNamed:@"publisher_photo_small_icon"] forState:UIControlStateNormal];
    [bgview1 addSubview:morenBt];
    
    nameLa=[[UILabel alloc]initWithFrame:CGRectMake(50, 15, 80, 20)];
    nameLa.text=@"感恩天下";
    nameLa.textColor=[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f];
    nameLa.font=[UIFont systemFontOfSize:16];
    [bgview1 addSubview:nameLa];
    
    timeLa=[[UILabel alloc]initWithFrame:CGRectMake(50, 35, 110, 20)];
    timeLa.text=@"2015-4-12 10:24:09";
    timeLa.textColor=[UIColor lightGrayColor];
    timeLa.font=[UIFont systemFontOfSize:12];
    [bgview1 addSubview:timeLa];
    
    UILabel * chu1=[[UILabel alloc]initWithFrame:CGRectMake(170, 35, 40, 20)];
    chu1.text=@"来自";
    chu1.font=[UIFont systemFontOfSize:12];
    chu1.textColor=[UIColor lightGrayColor];
    [bgview1 addSubview:chu1];
    laiyuanLa=[[UILabel alloc]initWithFrame:CGRectMake(200, 35, 100, 20)];
    laiyuanLa.text=@"每日一善";
    laiyuanLa.textColor=[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f];
    laiyuanLa.font=[UIFont systemFontOfSize:12];
    [bgview1 addSubview:laiyuanLa];
    
    shoucangBt=[[UIButton alloc]initWithFrame:CGRectMake(260, 15, 50, 18)];
    [shoucangBt setBackgroundImage:[UIImage imageNamed:@"collect_no_have"] forState:UIControlStateNormal];
    [shoucangBt addTarget:self action:@selector(shoucangClick) forControlEvents:UIControlEventTouchUpInside];
    [bgview1 addSubview:shoucangBt];
    
    jubaoBt=[[UIButton alloc]initWithFrame:CGRectMake(315, 15, 50, 18)];
    [jubaoBt setBackgroundImage:[UIImage imageNamed:@"report_no_have"] forState:UIControlStateNormal];
    [jubaoBt addTarget:self action:@selector(jubaoClick) forControlEvents:UIControlEventTouchUpInside];
    [bgview1 addSubview:jubaoBt];
    
    titleLa=[[UILabel alloc]initWithFrame:CGRectMake(50, 60, 130, 20)];
    titleLa.text=@"佛说父母恩难报经";
    titleLa.font=[UIFont systemFontOfSize:16];
    [bgview1 addSubview:titleLa];
    
    neirongText=[[UITextView alloc]initWithFrame:CGRectMake(50, 80, 290, 80)];
    neirongText.text=@"闻如是。一时婆伽婆。在舍卫城。袛树给孤独园。尔时世尊。告诸比丘。父母于子。大有曾益。如哺长养。随时将育。四得大成。右肩负父。左肩负母。经历千年....";
    neirongText.textColor=[UIColor lightGrayColor];
    neirongText.font=[UIFont systemFontOfSize:14];
    [bgview1 addSubview:neirongText];
    
    shangchuanImage=[[UIImageView alloc]initWithFrame:CGRectMake(50, 170, 90, 70)];
    shangchuanImage.image=[UIImage imageNamed:@"bluesky_fozu.jpg"];
    [bgview1 addSubview:shangchuanImage];
    shangchuanImage1=[[UIImageView alloc]initWithFrame:CGRectMake(150, 170, 90, 70)];
    shangchuanImage1.image=[UIImage imageNamed:@"bluesky_fozu.jpg"];
    [bgview1 addSubview:shangchuanImage1];
    shangchuanImage2=[[UIImageView alloc]initWithFrame:CGRectMake(250, 170, 90, 70)];
    shangchuanImage2.image=[UIImage imageNamed:@"bluesky_fozu.jpg"];
    [bgview1 addSubview:shangchuanImage2];
    
    UILabel * dianzanLa1=[[UILabel alloc]initWithFrame:CGRectMake(10, 265, 180, 20)];
    dianzanLa1.text=@"随缘静修，静心清修等12人点赞";
    dianzanLa1.textColor=[UIColor darkGrayColor];
    dianzanLa1.font=[UIFont systemFontOfSize:12];
    [bgview1 addSubview:dianzanLa1];
    
    UIImageView * imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(230, 258, 50, 25)];
    imageView1.image=[UIImage imageNamed:@"comment_praise_bg"];
    [bgview1 addSubview:imageView1];
    
    dianzanBt1=[[UIButton alloc]initWithFrame:CGRectMake(232, 260, 25, 20)];
    [dianzanBt1 setBackgroundImage:[UIImage imageNamed:@"no_praise"] forState:UIControlStateNormal];
//    [dianzanBt1 addTarget:self action:@selector(dianping1Click) forControlEvents:UIControlEventTouchUpInside];
    [bgview1 addSubview:dianzanBt1];
    
    UILabel * renshuLa1=[[UILabel alloc]initWithFrame:CGRectMake(257, 260, 80, 20)];
    renshuLa1.text=@"12";
    renshuLa1.textColor=[UIColor lightGrayColor];
    renshuLa1.font=[UIFont systemFontOfSize:12];
    [bgview1 addSubview:renshuLa1];
    
    UIImageView * pinglunImage1=[[UIImageView alloc]initWithFrame:CGRectMake(300, 258, 50, 25)];
    pinglunImage1.image=[UIImage imageNamed:@"comment_praise_bg"];
    [bgview1 addSubview:pinglunImage1];
    
    pinglunBt1=[[UIButton alloc]initWithFrame:CGRectMake(302, 260, 25, 20)];
    [pinglunBt1 setBackgroundImage:[UIImage imageNamed:@"小评论灰"] forState:UIControlStateNormal];
//    [pinglunBt1 addTarget:self action:@selector(pinglun1Click) forControlEvents:UIControlEventTouchUpInside];
    [bgview1 addSubview:pinglunBt1];
    
    UILabel * renshu1=[[UILabel alloc]initWithFrame:CGRectMake(331, 260, 80, 20)];
    renshu1.text=@"21";
    renshu1.textColor=[UIColor lightGrayColor];
    renshu1.font=[UIFont systemFontOfSize:12];
    [bgview1 addSubview:renshu1];
    
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 380, self.view.frame.size.height)];
//    tableview.delegate=self;
//    tableview.dataSource=self;
//    [scrollView addSubview:tableview];
    
    
}
//返回
-(void)backclick{
    
    AppDelegate * appdele = [UIApplication sharedApplication].delegate;
    [self.sideMenuViewController
     setContentViewController:appdele.mainVc animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}
//我的主页
-(void)morenClick{
   
    [self.sideMenuViewController
     setContentViewController:[[MyMain_MyViewController alloc] init]animated:YES];
    [self.sideMenuViewController hideMenuViewController];

}
//说说事件
-(void)bgviewClick{
   
    [self.sideMenuViewController
     setContentViewController:[[ShouCang_JYViewController alloc] init]animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
}
//发布
-(void)faBuClick{
    
    [self.sideMenuViewController
     setContentViewController:[[FaBu_MyViewController alloc] init]animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}
//动态界面
-(void)dongtai_hyClick{
    
    bgview.hidden=NO;
    bgview1.hidden=NO;
    guanzhuView.view.hidden=YES;
    fabuBt.hidden=NO;
//    touxiangBt.hidden=YES;
    [dongtai_hyBt setBackgroundImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
    [dongtai_hyBt setTitleColor:[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [guanzhu_fensiBt setBackgroundImage:[UIImage imageNamed:@"底部导航背景.jpg"] forState:UIControlStateNormal];
    [guanzhu_fensiBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
//关注界面
-(void)guanzhu_fensiClick{
    
    bgview.hidden=YES;
    bgview1.hidden=YES;
    fabuBt.hidden=YES;
    [guanzhu_fensiBt setBackgroundImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
    [guanzhu_fensiBt setTitleColor:[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [dongtai_hyBt setBackgroundImage:[UIImage imageNamed:@"底部导航背景.jpg"] forState:UIControlStateNormal];
    [dongtai_hyBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    mDockMenuBackView_SuiXi = [[DockMenuSubView alloc]initWithFrame:CGRectMake(0, 308, mScrollDockMenuView.frame.size.width, 560)];
    [scrollView addSubview:mDockMenuBackView_SuiXi];
    
    guanzhuView = [[GuanZhu_FenSiViewController alloc] init];
    [self addChildViewController:guanzhuView];
    [self.view addSubview:guanzhuView.view];
    guanzhuView.view.frame = self.view.bounds;
    guanzhuView.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    CGRect rect= mDockMenuBackView_SuiXi.frame;
    rect.size.height = guanzhuView.view.frame.origin.y+guanzhuView.view.frame.size.height+10;
    [mDockMenuBackView_SuiXi setFrame:rect];
    [scrollView addSubview:guanzhuView.view];
    [mDockMenuBackView_SuiXi setHidden:YES];
    
}

#pragma tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.sideMenuViewController
     setContentViewController:[[ShouCang_JYViewController alloc] init]animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
    
}
-(void)dianpingClick{
    
    if (isClick==YES) {
        
        [dianzanBt setBackgroundImage:[UIImage imageNamed:@"praise"] forState:UIControlStateNormal];

        isClick=NO;
    }else{
        [dianzanBt setBackgroundImage:[UIImage imageNamed:@"no_praise"] forState:UIControlStateNormal];
                isClick=YES;
    }
    
    
}
-(void)pinglunClick{
    
    if (isClick==YES) {
        
        [pinglunBt setBackgroundImage:[UIImage imageNamed:@"小评论灰"] forState:UIControlStateNormal];
        pinglunView.hidden=YES;
        bgview1.hidden=NO;
        bgview2.hidden=YES;
        isClick=NO;
        
    }else{
        
        [pinglunBt setBackgroundImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        pinglunView=[[UIView alloc]initWithFrame:CGRectMake(0, 290, 380, 85)];
        pinglunView.backgroundColor=[UIColor clearColor];
        [bgview addSubview:pinglunView];
        
        morenBt=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 35, 35)];
        [morenBt setBackgroundImage:[UIImage imageNamed:@"publisher_photo_small_icon"] forState:UIControlStateNormal];
        [pinglunView addSubview:morenBt];
        
        nameLa=[[UILabel alloc]initWithFrame:CGRectMake(55, 15, 80, 20)];
        nameLa.text=@"感恩天下";
        nameLa.textColor=[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f];
        nameLa.font=[UIFont systemFontOfSize:16];
        [pinglunView addSubview:nameLa];
        
        neirongText=[[UITextView alloc]initWithFrame:CGRectMake(50, 35, 290, 45)];
        neirongText.text=@"闻如是。一时婆伽婆。在舍卫城";
        neirongText.textColor=[UIColor blackColor];
        neirongText.backgroundColor=[UIColor clearColor];
        neirongText.font=[UIFont systemFontOfSize:14];
        [pinglunView addSubview:neirongText];

        timeLa=[[UILabel alloc]initWithFrame:CGRectMake(255, 15, 110, 20)];
        timeLa.text=@"2015-4-12 10:24:09";
        timeLa.textColor=[UIColor lightGrayColor];
        timeLa.font=[UIFont systemFontOfSize:12];
        [pinglunView addSubview:timeLa];
        
        UIButton * huifuBt=[[UIButton alloc]initWithFrame:CGRectMake(320, 55, 50, 25)];
        huifuBt.backgroundColor=[UIColor clearColor];
        [pinglunView addSubview:huifuBt];
        
        UIImageView * huifuim=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 12, 14)];
        huifuim.image=[UIImage imageNamed:@"comment_reply"];
        [huifuBt addSubview:huifuim];
        
        UILabel * huifuLa=[[UILabel alloc]initWithFrame:CGRectMake(22, 3, 70, 20)];
        huifuLa.text=@"回复";
        huifuLa.font=[UIFont systemFontOfSize:12];
        [huifuBt addSubview:huifuLa];
        
        bgview1.hidden=YES;
        bgview2=[[UIView alloc]initWithFrame:CGRectMake(0, 390, 390, 290)];
        bgview2.backgroundColor=[UIColor whiteColor];
        [scrollView addSubview:bgview2];
        
        morenBt=[[UIButton alloc]initWithFrame:CGRectMake(10, 18, 35, 35)];
        [morenBt setBackgroundImage:[UIImage imageNamed:@"publisher_photo_small_icon"] forState:UIControlStateNormal];
        [bgview2 addSubview:morenBt];
        
        nameLa=[[UILabel alloc]initWithFrame:CGRectMake(50, 15, 80, 20)];
        nameLa.text=@"感恩天下";
        nameLa.textColor=[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f];
        nameLa.font=[UIFont systemFontOfSize:16];
        [bgview2 addSubview:nameLa];
        
        timeLa=[[UILabel alloc]initWithFrame:CGRectMake(50, 35, 110, 20)];
        timeLa.text=@"2015-4-12 10:24:09";
        timeLa.textColor=[UIColor lightGrayColor];
        timeLa.font=[UIFont systemFontOfSize:12];
        [bgview2 addSubview:timeLa];
        
        UILabel * chu2=[[UILabel alloc]initWithFrame:CGRectMake(170, 35, 40, 20)];
        chu2.text=@"来自";
        chu2.font=[UIFont systemFontOfSize:12];
        chu2.textColor=[UIColor lightGrayColor];
        [bgview2 addSubview:chu2];
        laiyuanLa=[[UILabel alloc]initWithFrame:CGRectMake(200, 35, 100, 20)];
        laiyuanLa.text=@"每日一善";
        laiyuanLa.textColor=[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f];
        laiyuanLa.font=[UIFont systemFontOfSize:12];
        [bgview2 addSubview:laiyuanLa];
        
        shoucangBt=[[UIButton alloc]initWithFrame:CGRectMake(260, 15, 50, 18)];
        [shoucangBt setBackgroundImage:[UIImage imageNamed:@"collect_no_have"] forState:UIControlStateNormal];
        [shoucangBt addTarget:self action:@selector(shoucangClick) forControlEvents:UIControlEventTouchUpInside];
        [bgview2 addSubview:shoucangBt];
        
        jubaoBt=[[UIButton alloc]initWithFrame:CGRectMake(315, 15, 50, 18)];
        [jubaoBt setBackgroundImage:[UIImage imageNamed:@"report_no_have"] forState:UIControlStateNormal];
        [jubaoBt addTarget:self action:@selector(jubaoClick) forControlEvents:UIControlEventTouchUpInside];
        [bgview2 addSubview:jubaoBt];
        
        titleLa=[[UILabel alloc]initWithFrame:CGRectMake(50, 60, 130, 20)];
        titleLa.text=@"佛说父母恩难报经";
        titleLa.font=[UIFont systemFontOfSize:16];
        [bgview2 addSubview:titleLa];
        
        neirongText=[[UITextView alloc]initWithFrame:CGRectMake(50, 80, 290, 80)];
        neirongText.text=@"闻如是。一时婆伽婆。在舍卫城。袛树给孤独园。尔时世尊。告诸比丘。父母于子。大有曾益。如哺长养。随时将育。四得大成。右肩负父。左肩负母。经历千年....";
        neirongText.textColor=[UIColor lightGrayColor];
        neirongText.font=[UIFont systemFontOfSize:14];
        [bgview2 addSubview:neirongText];
        
        shangchuanImage=[[UIImageView alloc]initWithFrame:CGRectMake(50, 170, 90, 70)];
        shangchuanImage.image=[UIImage imageNamed:@"bluesky_fozu.jpg"];
        [bgview2 addSubview:shangchuanImage];
        shangchuanImage1=[[UIImageView alloc]initWithFrame:CGRectMake(150, 170, 90, 70)];
        shangchuanImage1.image=[UIImage imageNamed:@"bluesky_fozu.jpg"];
        [bgview2 addSubview:shangchuanImage1];
        shangchuanImage2=[[UIImageView alloc]initWithFrame:CGRectMake(250, 170, 90, 70)];
        shangchuanImage2.image=[UIImage imageNamed:@"bluesky_fozu.jpg"];
        [bgview2 addSubview:shangchuanImage2];
        
        UILabel * dianzanLa2=[[UILabel alloc]initWithFrame:CGRectMake(10, 265, 180, 20)];
        dianzanLa2.text=@"随缘静修，静心清修等12人点赞";
        dianzanLa2.textColor=[UIColor darkGrayColor];
        dianzanLa2.font=[UIFont systemFontOfSize:12];
        [bgview2 addSubview:dianzanLa2];
        
        UIImageView * imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(230, 258, 50, 25)];
        imageView2.image=[UIImage imageNamed:@"comment_praise_bg"];
        [bgview2 addSubview:imageView2];
        
        dianzanBt1=[[UIButton alloc]initWithFrame:CGRectMake(232, 260, 25, 20)];
        [dianzanBt1 setBackgroundImage:[UIImage imageNamed:@"no_praise"] forState:UIControlStateNormal];
//        [dianzanBt1 addTarget:self action:@selector(dianping1Click) forControlEvents:UIControlEventTouchUpInside];
        [bgview2 addSubview:dianzanBt1];
        
        UILabel * renshuLa2=[[UILabel alloc]initWithFrame:CGRectMake(257, 260, 80, 20)];
        renshuLa2.text=@"12";
        renshuLa2.textColor=[UIColor lightGrayColor];
        renshuLa2.font=[UIFont systemFontOfSize:12];
        [bgview2 addSubview:renshuLa2];
        
        UIImageView * pinglunImage2=[[UIImageView alloc]initWithFrame:CGRectMake(300, 258, 50, 25)];
        pinglunImage2.image=[UIImage imageNamed:@"comment_praise_bg"];
        [bgview2 addSubview:pinglunImage2];
        
        pinglunBt1=[[UIButton alloc]initWithFrame:CGRectMake(302, 260, 25, 20)];
        [pinglunBt1 setBackgroundImage:[UIImage imageNamed:@"小评论灰"] forState:UIControlStateNormal];
//        [pinglunBt1 addTarget:self action:@selector(pinglun1Click) forControlEvents:UIControlEventTouchUpInside];
        [bgview2 addSubview:pinglunBt1];
        
        UILabel * renshu2=[[UILabel alloc]initWithFrame:CGRectMake(331, 260, 80, 20)];
        renshu2.text=@"21";
        renshu2.textColor=[UIColor lightGrayColor];
        renshu2.font=[UIFont systemFontOfSize:12];
        [bgview2 addSubview:renshu2];

        isClick=YES;
    }
    
    
}
-(void)shoucangClick{
    
    if (isClick==YES) {
        [shoucangBt setBackgroundImage:[UIImage imageNamed:@"collect_no_have"] forState:UIControlStateNormal];
        isClick=NO;
    }else {
        
        [shoucangBt setBackgroundImage:[UIImage imageNamed:@"collect_have"] forState:UIControlStateNormal];
        isClick=YES;
    }
}
-(void)jubaoClick{
    
    if (isClick==YES) {
        [jubaoBt setBackgroundImage:[UIImage imageNamed:@"report_no_have"] forState:UIControlStateNormal];
        isClick=NO;
    }else {
        
        [jubaoBt setBackgroundImage:[UIImage imageNamed:@"report_have"] forState:UIControlStateNormal];
        
        isClick=YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
