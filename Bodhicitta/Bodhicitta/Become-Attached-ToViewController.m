//
//  Become-Attached-ToViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/3.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "Become-Attached-ToViewController.h"

@interface Become_Attached_ToViewController ()

@end

@implementation Become_Attached_ToViewController
@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 70)];
    view.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"顶部导航背景"]];
    [self.view addSubview:view];
    //    UIImageView *
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(165, 30, 80, 30)];
    title.text=@"结缘";
    title.font=[UIFont systemFontOfSize:20];
    title.textColor=[UIColor whiteColor];
    [view addSubview:title];
    
    UIView * background=[[UIView alloc]initWithFrame:CGRectMake(0, 70, 380, 550)];
    background.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    [self.view addSubview:background];
    UIView * buttonBg=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 85)];
    buttonBg.backgroundColor=[UIColor whiteColor];
    [background addSubview:buttonBg];
    
    shanyouBt=[[UIButton alloc]initWithFrame:CGRectMake(75, 15, 35, 35)];
    [shanyouBt setBackgroundImage:[UIImage imageNamed:@"friend_circle"] forState:UIControlStateNormal];
    [shanyouBt addTarget:self action:@selector(shanyouClick) forControlEvents:UIControlEventTouchUpInside];
    [buttonBg addSubview:shanyouBt];
    
    UILabel * shanyouLa=[[UILabel alloc]initWithFrame:CGRectMake(70, 55, 50, 20)];
    shanyouLa.text=@"善友圈";
    shanyouLa.font=[UIFont systemFontOfSize:15];
    [buttonBg addSubview:shanyouLa];
    
    myBt=[[UIButton alloc]initWithFrame:CGRectMake(255, 15, 35, 35)];
    [myBt setBackgroundImage:[UIImage imageNamed:@"my_friends"] forState:UIControlStateNormal];
    [myBt addTarget:self action:@selector(myClick) forControlEvents:UIControlEventTouchUpInside];
    [buttonBg addSubview:myBt];
    
    UILabel * myLa=[[UILabel alloc]initWithFrame:CGRectMake(245, 55, 90, 20)];
    myLa.text=@"我的善友";
    myLa.font=[UIFont systemFontOfSize:15];
    [buttonBg addSubview:myLa];
    
    dataArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<20; i++) {
        [dataArray addObject:[NSNumber numberWithInt:i+1]];
    }
    
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 95, 380, 600)];
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景.png"]];
    [background addSubview:tableview];
}

-(void)shanyouClick{
    
    [self.sideMenuViewController
     setContentViewController:[[ShanYou_DTViewController alloc] init]animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}
-(void)myClick{
    
    [self.sideMenuViewController
     setContentViewController:[[My_syViewController alloc] init]animated:YES];
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
        [shoucangBt setBackgroundImage:[UIImage imageNamed:@"collect_no_have"] forState:UIControlStateSelected];
        [shoucangBt addTarget:self action:@selector(shoucangClick) forControlEvents:UIControlEventTouchUpInside];
        [cell_ addSubview:shoucangBt];
        
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
        [dianzanBt setBackgroundImage:[UIImage imageNamed:@"praise"] forState:UIControlStateNormal];
        isClick=NO;
    }else {
        
        [dianzanBt setBackgroundImage:[UIImage imageNamed:@"no_praise"] forState:UIControlStateNormal];
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
        vi=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, self.view.frame.size.height)];
        vi.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"background"]];
        [self.view addSubview:vi];
        
        UIButton * jubaoView=[[UIButton alloc]initWithFrame:CGRectMake(60, 100, 260, 320)];
        [jubaoView setBackgroundImage:[UIImage imageNamed:@"report_dialog_bg.jpg"] forState:UIControlStateNormal];
        [vi addSubview:jubaoView];
        
        UILabel * whyLa=[[UILabel alloc]initWithFrame:CGRectMake(70, 15, 120, 20)];
        whyLa.text=@"请选择举报原因";
        whyLa.textColor=[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f];
        whyLa.font=[UIFont systemFontOfSize:16];
        [jubaoView addSubview:whyLa];
        
        UILabel * zongjiaoLa=[[UILabel alloc]initWithFrame:CGRectMake(15, 50, 120, 20)];
        zongjiaoLa.text=@"邪教与非法言论";
        zongjiaoLa.font=[UIFont systemFontOfSize:15];
        [jubaoView addSubview:zongjiaoLa];
        
        zongjiaoBt=[[UIButton alloc]initWithFrame:CGRectMake(230, 50, 20, 20)];
        [zongjiaoBt setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        [zongjiaoBt addTarget:self action:@selector(zongjiaoClick) forControlEvents:UIControlEventTouchUpInside];
        [jubaoView addSubview:zongjiaoBt];
        
        UILabel * baoliLa=[[UILabel alloc]initWithFrame:CGRectMake(15, 83, 120, 20)];
        baoliLa.text=@"暴力色情";
        baoliLa.font=[UIFont systemFontOfSize:15];
        [jubaoView addSubview:baoliLa];
        
        baoliBt=[[UIButton alloc]initWithFrame:CGRectMake(230, 83, 20, 20)];
        [baoliBt setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        [baoliBt addTarget:self action:@selector(baoliClick) forControlEvents:UIControlEventTouchUpInside];
        [jubaoView addSubview:baoliBt];
        
        UILabel * qipianLa=[[UILabel alloc]initWithFrame:CGRectMake(15, 115, 120, 20)];
        qipianLa.text=@"诈骗和虚假信息";
        qipianLa.font=[UIFont systemFontOfSize:15];
        [jubaoView addSubview:qipianLa];
        
        qipianBt=[[UIButton alloc]initWithFrame:CGRectMake(230, 115, 20, 20)];
        [qipianBt setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        [qipianBt addTarget:self action:@selector(qipianClick) forControlEvents:UIControlEventTouchUpInside];
        [jubaoView addSubview:qipianBt];
        
        UILabel * xiemiLa=[[UILabel alloc]initWithFrame:CGRectMake(15, 148, 120, 20)];
        xiemiLa.text=@"泄露我隐私";
        xiemiLa.font=[UIFont systemFontOfSize:15];
        [jubaoView addSubview:xiemiLa];
        
        xiemiBt=[[UIButton alloc]initWithFrame:CGRectMake(230, 148, 20, 20)];
        [xiemiBt setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        [xiemiBt addTarget:self action:@selector(xiemiClick) forControlEvents:UIControlEventTouchUpInside];
        [jubaoView addSubview:xiemiBt];
        
        UILabel * qitaLa=[[UILabel alloc]initWithFrame:CGRectMake(15, 180, 100, 20)];
        qitaLa.text=@"其它原因";
        qitaLa.textColor=[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f];
        qitaLa.font=[UIFont systemFontOfSize:14];
        [jubaoView addSubview:qitaLa];
        
        UIImageView * whyText=[[UIImageView alloc]initWithFrame:CGRectMake(15, 210, 230, 60)];
        whyText.image=[UIImage imageNamed:@"report_reason_input_bg.jpg"];
        [jubaoView addSubview:whyText];
        
        whyTextView=[[UITextView alloc]initWithFrame:CGRectMake(25, 210, 220, 60)];
        whyTextView.backgroundColor=[UIColor clearColor];
        [jubaoView addSubview:whyTextView];
        
        button=[[UIButton alloc]initWithFrame:CGRectMake(100, 280, 50, 20)];
        [button setBackgroundImage:[UIImage imageNamed:@"light_share_friend_normal"] forState:UIControlStateNormal];
        [button setTitle:@"举报" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [jubaoView addSubview:button];
        isClick=YES;
    }
}
-(void)zongjiaoClick{
    
    if (isClick==YES) {
        [zongjiaoBt setBackgroundImage:[UIImage imageNamed:@"report_reason_choosed"] forState:UIControlStateNormal];
        [qipianBt setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        [xiemiBt setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        [baoliBt setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        
        isClick=NO;
    }else{
        [zongjiaoBt setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        isClick=YES;
    }
}
-(void)baoliClick{
    
    if (isClick==YES) {
        [baoliBt setBackgroundImage:[UIImage imageNamed:@"report_reason_choosed"] forState:UIControlStateNormal];
        [zongjiaoBt setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        [qipianBt setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        [xiemiBt setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        
        isClick=NO;
    }else{
        
        [baoliBt setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        
        isClick=YES;
    }
    
    
}
-(void)qipianClick{
    
    if (isClick==YES) {
        [qipianBt setBackgroundImage:[UIImage imageNamed:@"report_reason_choosed"] forState:UIControlStateNormal];
        [zongjiaoBt setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        [baoliBt setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        [xiemiBt setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        
        isClick=NO;
    }else{
        
        [qipianBt setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        
        isClick=YES;
    }
    
}
-(void)xiemiClick{
    
    if (isClick==YES) {
        [xiemiBt setBackgroundImage:[UIImage imageNamed:@"report_reason_choosed"] forState:UIControlStateNormal];
        [zongjiaoBt setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        [baoliBt setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        [qipianBt setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        isClick=NO;
    }else{
        
        [xiemiBt setBackgroundImage:[UIImage imageNamed:@"report_reason_no_choosed"] forState:UIControlStateNormal];
        
        isClick=YES;
    }
    
}

-(void)buttonClick{
    
    vi.hidden=YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
