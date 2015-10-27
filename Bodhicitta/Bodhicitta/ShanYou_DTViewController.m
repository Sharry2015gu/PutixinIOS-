//
//  ShanYou_DTViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/8.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "ShanYou_DTViewController.h"

@interface ShanYou_DTViewController ()

@end

@implementation ShanYou_DTViewController
@synthesize dataArray;
@synthesize scrollView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 70)];
    view.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"顶部导航背景"]];
    [self.view addSubview:view];
    //    UIImageView *
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(165, 30, 80, 30)];
    title.text=@"善友圈";
    title.font=[UIFont systemFontOfSize:20];
    title.textColor=[UIColor whiteColor];
    [view addSubview:title];
    
    fanhuiBt=[[UIButton alloc]initWithFrame:CGRectMake(6, 33, 25, 25)];
    [fanhuiBt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [fanhuiBt addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhuiBt];
    
    fabiaoBt=[[UIButton alloc]initWithFrame:CGRectMake(325, 33, 30, 25)];
    [fabiaoBt setBackgroundImage:[UIImage imageNamed:@"publish_topic"] forState:UIControlStateNormal];
    [fabiaoBt addTarget:self action:@selector(faBiaoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fabiaoBt];
    
    UIView * background=[[UIView alloc]initWithFrame:CGRectMake(0, 70, 380, self.view.frame.size.height)];
    background.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    [self.view addSubview:background];
    
    UIView * quanziView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 48)];
    quanziView.backgroundColor=[UIColor whiteColor];
    [background addSubview:quanziView];
    
    dongtai_qzBt=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 190, 48)];
    [dongtai_qzBt setTitle:@"圈子动态" forState:UIControlStateNormal];
    [dongtai_qzBt setBackgroundImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
    [dongtai_qzBt setTitleColor:[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [dongtai_qzBt addTarget:self action:@selector(dongtaiClick) forControlEvents:UIControlEventTouchUpInside];
    [quanziView addSubview:dongtai_qzBt];
    
    gongxiu_qzBt=[[UIButton alloc]initWithFrame:CGRectMake(190, 0, 190, 48)];
    [gongxiu_qzBt setTitle:@"共修圈子" forState:UIControlStateNormal];
    [gongxiu_qzBt setBackgroundImage:[UIImage imageNamed:@"底部导航背景.jpg"] forState:UIControlStateNormal];
    [gongxiu_qzBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [gongxiu_qzBt addTarget:self action:@selector(gongxiuClick) forControlEvents:UIControlEventTouchUpInside];
    [quanziView addSubview:gongxiu_qzBt];
    
    dataArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<20; i++) {
        [dataArray addObject:[NSNumber numberWithInt:i+1]];
    }

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 48, 380, self.view.frame.size.height)];
    [self.scrollView setBackgroundColor:[UIColor clearColor]];
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setContentSize:CGSizeMake(380, 1200)];
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, 380, 200) animated:NO];
    [self.scrollView setDelegate:self];
    [background addSubview:self.scrollView];
    
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 380, self.view.frame.size.height)];
    tableview.delegate=self;
    tableview.dataSource=self;
    [scrollView addSubview:tableview];
    
    UIImageView * iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 118, 380, 1)];
    iv.image=[UIImage imageNamed:@"line.png"];
    [self.view addSubview:iv];


}
-(void)backclick{
    
    AppDelegate * delegate=[UIApplication sharedApplication].delegate;
    [self.sideMenuViewController
     setContentViewController:delegate.mainVc   animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}
-(void)faBiaoClick{
    
    [self.sideMenuViewController
     setContentViewController:[[FaBiao_SYViewController alloc] init]animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}
-(void)dongtaiClick{
   
    tableview.hidden=NO;
    gongxiuView.view.hidden=YES;
    fabiaoBt.hidden=NO;
    touxiangBt.hidden=YES;
    [dongtai_qzBt setBackgroundImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
    [dongtai_qzBt setTitleColor:[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [gongxiu_qzBt setBackgroundImage:[UIImage imageNamed:@"底部导航背景.jpg"] forState:UIControlStateNormal];
    [gongxiu_qzBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
-(void)gongxiuClick{

    tableview.hidden=YES;
    [gongxiu_qzBt setBackgroundImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
    [gongxiu_qzBt setTitleColor:[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [dongtai_qzBt setBackgroundImage:[UIImage imageNamed:@"底部导航背景.jpg"] forState:UIControlStateNormal];
    [dongtai_qzBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    fabiaoBt.hidden=YES;
    touxiangBt=[[UIButton alloc]initWithFrame:CGRectMake(330, 33, 25, 25)];
    [touxiangBt setBackgroundImage:[UIImage imageNamed:@"make_circle"] forState:UIControlStateNormal];
    [touxiangBt addTarget:self action:@selector(touxiangClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:touxiangBt];
    
    mDockMenuBackView_SuiXi = [[DockMenuSubView alloc]initWithFrame:CGRectMake(0, 308, mScrollDockMenuView.frame.size.width, 560)];
    [scrollView addSubview:mDockMenuBackView_SuiXi];
    
    gongxiuView = [[GongXiu_SYViewController alloc] init];
    [self addChildViewController:gongxiuView];
    [self.view addSubview:gongxiuView.view];
    gongxiuView.view.frame = self.view.bounds;
    gongxiuView.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    CGRect rect= mDockMenuBackView_SuiXi.frame;
    rect.size.height = gongxiuView.view.frame.origin.y+gongxiuView.view.frame.size.height+10;
    [mDockMenuBackView_SuiXi setFrame:rect];
    [scrollView addSubview:gongxiuView.view];
    [mDockMenuBackView_SuiXi setHidden:YES];
    
}
- (void)touxiangClick{
    
    [self.sideMenuViewController
     setContentViewController:[[TouXiang_GXViewController alloc] init]animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(void)viewDidLayoutSubviews
{
    if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,1)];
    }
    
    if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 300;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //判断cell是否处于选中状态，并且用不同的identifier标记重用;
    //选中的cell改变高度，同时在cell的下方添加背景图片和需要的button;
    //选中状态
    static NSString *identifier_ = @"cell_";
    UITableViewCell *cell_ = [tableView dequeueReusableCellWithIdentifier:identifier_];
    if (cell_ == nil){
        cell_ = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_] ;
        
        UIView  * bgview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 390, 290)];
        bgview.backgroundColor=[UIColor whiteColor];
        //        imageview.backgroundColor=[UIColor whiteColor];
        [cell_ addSubview:bgview];
        
        morenBt=[[UIButton alloc]initWithFrame:CGRectMake(10, 18, 35, 35)];
        [morenBt setBackgroundImage:[UIImage imageNamed:@"publisher_photo_small_icon"] forState:UIControlStateNormal];
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
        [cell_ addSubview:shoucangBt];
        
        jubaoBt=[[UIButton alloc]initWithFrame:CGRectMake(315, 15, 50, 18)];
        [jubaoBt setBackgroundImage:[UIImage imageNamed:@"report_no_have"] forState:UIControlStateNormal];
        [jubaoBt addTarget:self action:@selector(jubaoClick) forControlEvents:UIControlEventTouchUpInside];
        [cell_ addSubview:jubaoBt];
        
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
        [cell_ addSubview:dianzanBt];
        
        UILabel * renshuLa=[[UILabel alloc]initWithFrame:CGRectMake(257, 260, 80, 20)];
        renshuLa.text=@"12";
        renshuLa.textColor=[UIColor lightGrayColor];
        renshuLa.font=[UIFont systemFontOfSize:12];
        [cell_ addSubview:renshuLa];
        
        UIImageView * pinglunImage=[[UIImageView alloc]initWithFrame:CGRectMake(300, 258, 50, 25)];
        pinglunImage.image=[UIImage imageNamed:@"comment_praise_bg"];
        [bgview addSubview:pinglunImage];
        
        pinglunBt=[[UIButton alloc]initWithFrame:CGRectMake(302, 260, 25, 20)];
        [pinglunBt setBackgroundImage:[UIImage imageNamed:@"小评论灰"] forState:UIControlStateNormal];
        [pinglunBt addTarget:self action:@selector(pinglunClick) forControlEvents:UIControlEventTouchUpInside];
        [cell_ addSubview:pinglunBt];
        
        UILabel * renshu=[[UILabel alloc]initWithFrame:CGRectMake(331, 260, 80, 20)];
        renshu.text=@"21";
        renshu.textColor=[UIColor lightGrayColor];
        renshu.font=[UIFont systemFontOfSize:12];
        [cell_ addSubview:renshu];
        
        UIImageView * jiange=[[UIImageView alloc]initWithFrame:CGRectMake(0, 290, 380, 10)];
        jiange.image=[UIImage imageNamed:@"登录背景.png"];
        [cell_.contentView addSubview:jiange];
    
    }

    cell_.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell_;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.sideMenuViewController
     setContentViewController:[[ShouCang_JYViewController alloc] init]animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
    
}
-(void)dianpingClick{
    
    if (isClick==YES) {
        [dianzanBt setBackgroundImage:[UIImage imageNamed:@"no_praise"] forState:UIControlStateNormal];
        isClick=NO;
    }else{
        
        [dianzanBt setBackgroundImage:[UIImage imageNamed:@"praise"] forState:UIControlStateNormal];
        isClick=YES;
    }
    
    
}
-(void)pinglunClick{
    
    if (isClick==YES) {
        [pinglunBt setBackgroundImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        isClick=NO;
    }else{
        
        [pinglunBt setBackgroundImage:[UIImage imageNamed:@"小评论灰"] forState:UIControlStateNormal];
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
