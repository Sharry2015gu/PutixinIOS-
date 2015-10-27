//
//  ShouCang_JYViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/7.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "ShouCang_JYViewController.h"

@interface ShouCang_JYViewController ()

@end

@implementation ShouCang_JYViewController

@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 70)];
    view.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"顶部导航背景"]];
    [self.view addSubview:view];
    //    UIImageView *
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(155, 30, 80, 30)];
    title.text=@"圈动态";
    title.font=[UIFont systemFontOfSize:20];
    title.textColor=[UIColor whiteColor];
    [view addSubview:title];
    
    fanhuiBt=[[UIButton alloc]initWithFrame:CGRectMake(6, 33, 25, 25)];
    [fanhuiBt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [fanhuiBt addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhuiBt];
    
    fenxiangBt=[[UIButton alloc]initWithFrame:CGRectMake(315, 33, 55, 25)];
    [fenxiangBt setTitle:@"分享" forState:UIControlStateNormal];
    [fenxiangBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [fenxiangBt addTarget:self action:@selector(fenxiangClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fenxiangBt];
    
    UIView * background=[[UIView alloc]initWithFrame:CGRectMake(0, 70, 380, self.view.frame.size.height)];
    background.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    [self.view addSubview:background];
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 380, self.view.frame.size.height)];
    [scrollview setBackgroundColor:[UIColor clearColor]];
    [scrollview setPagingEnabled:YES];
    [scrollview setShowsHorizontalScrollIndicator:NO];
    [scrollview setContentSize:CGSizeMake(380, 1510)];
    [scrollview scrollRectToVisible:CGRectMake(380, 0, 380, 1500) animated:NO];
    [scrollview setDelegate:self];
    [background addSubview:scrollview];
    
    backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 280)];
    backgroundview.backgroundColor=[UIColor whiteColor];
    [scrollview addSubview:backgroundview];
    
    morenBt=[[UIButton alloc]initWithFrame:CGRectMake(10, 18, 35, 35)];
    [morenBt setBackgroundImage:[UIImage imageNamed:@"publisher_photo_small_icon"] forState:UIControlStateNormal];
    [backgroundview addSubview:morenBt];
    
    nameLa=[[UILabel alloc]initWithFrame:CGRectMake(50, 15, 80, 20)];
    nameLa.text=@"感恩天下";
    nameLa.textColor=[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f];
    nameLa.font=[UIFont systemFontOfSize:16];
    [backgroundview addSubview:nameLa];
    
    timeLa=[[UILabel alloc]initWithFrame:CGRectMake(50, 35, 110, 20)];
    timeLa.text=@"2015-4-12 10:24:09";
    timeLa.textColor=[UIColor lightGrayColor];
    timeLa.font=[UIFont systemFontOfSize:12];
    [backgroundview addSubview:timeLa];
    
    UILabel * chu=[[UILabel alloc]initWithFrame:CGRectMake(170, 35, 40, 20)];
    chu.text=@"来自";
    chu.font=[UIFont systemFontOfSize:12];
    chu.textColor=[UIColor lightGrayColor];
    [backgroundview addSubview:chu];
    laiyuanLa=[[UILabel alloc]initWithFrame:CGRectMake(200, 35, 100, 20)];
    laiyuanLa.text=@"每日一善";
    laiyuanLa.textColor=[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f];
    laiyuanLa.font=[UIFont systemFontOfSize:12];
    [backgroundview addSubview:laiyuanLa];
    
    shoucangBt=[[UIButton alloc]initWithFrame:CGRectMake(260, 15, 50, 18)];
    [shoucangBt setBackgroundImage:[UIImage imageNamed:@"collect_no_have"] forState:UIControlStateNormal];
    [shoucangBt setBackgroundImage:[UIImage imageNamed:@"collect_no_have"] forState:UIControlStateSelected];
    [shoucangBt addTarget:self action:@selector(shoucangClick) forControlEvents:UIControlEventTouchUpInside];
    [backgroundview addSubview:shoucangBt];
    
    jubaoBt=[[UIButton alloc]initWithFrame:CGRectMake(315, 15, 50, 18)];
    [jubaoBt setBackgroundImage:[UIImage imageNamed:@"report_no_have"] forState:UIControlStateNormal];
    [jubaoBt addTarget:self action:@selector(jubaoClick) forControlEvents:UIControlEventTouchUpInside];
    [backgroundview addSubview:jubaoBt];
    
    titleLa=[[UILabel alloc]initWithFrame:CGRectMake(50, 60, 130, 20)];
    titleLa.text=@"佛说父母恩难报经";
    titleLa.font=[UIFont systemFontOfSize:16];
    [backgroundview addSubview:titleLa];
    
    neirongText=[[UITextView alloc]initWithFrame:CGRectMake(50, 80, 290, 100)];
    neirongText.text=@"闻如是。一时婆伽婆。在舍卫城。袛树给孤独园。尔时世尊。告诸比丘。父母于子。大有曾益。如哺长养。随时将育。四得大成。右肩负父。左肩负母。经历千年。正使便利背上。然无有怨心于父母。此子犹不足.......";
    neirongText.textColor=[UIColor lightGrayColor];
    neirongText.font=[UIFont systemFontOfSize:14];
    [backgroundview addSubview:neirongText];
    
    shangchuanImage=[[UIImageView alloc]initWithFrame:CGRectMake(50, 190, 90, 70)];
    shangchuanImage.image=[UIImage imageNamed:@"bluesky_fozu.jpg"];
    [backgroundview addSubview:shangchuanImage];
    shangchuanImage1=[[UIImageView alloc]initWithFrame:CGRectMake(150, 190, 90, 70)];
    shangchuanImage1.image=[UIImage imageNamed:@"bluesky_fozu.jpg"];
    [backgroundview addSubview:shangchuanImage1];
    shangchuanImage2=[[UIImageView alloc]initWithFrame:CGRectMake(250, 190, 90, 70)];
    shangchuanImage2.image=[UIImage imageNamed:@"bluesky_fozu.jpg"];
    [backgroundview addSubview:shangchuanImage2];
    
    dataArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<20; i++) {
        [dataArray addObject:[NSNumber numberWithInt:i+1]];
    }
    
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 280, 380, 600)];
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.backgroundColor=[UIColor clearColor];
    [scrollview addSubview:tableview];
    
    UIImageView * bgImageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 558, 380, 40)];
    bgImageview.image=[UIImage imageNamed:@"topic_detail_bottom_bg"];
    [background addSubview:bgImageview];
    
    UIView * xian=[[UIView alloc]initWithFrame:CGRectMake(190, 0, 1, 38)];
    xian.backgroundColor=[UIColor whiteColor];
    [bgImageview addSubview:xian];
    
    dianzanBt=[[UIButton alloc]initWithFrame:CGRectMake(72, 638, 25, 20)];
    [dianzanBt setBackgroundImage:[UIImage imageNamed:@"no_praise"] forState:UIControlStateNormal];
    [dianzanBt addTarget:self action:@selector(dianpingClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dianzanBt];
    
    UILabel * renshuLa=[[UILabel alloc]initWithFrame:CGRectMake(97, 8, 80, 20)];
    renshuLa.text=@"赞";
    renshuLa.textColor=[UIColor whiteColor];
    renshuLa.font=[UIFont systemFontOfSize:12];
    [bgImageview addSubview:renshuLa];
    
    pinglunBt=[[UIButton alloc]initWithFrame:CGRectMake(262, 638, 25, 20)];
    [pinglunBt setBackgroundImage:[UIImage imageNamed:@"小评论灰"] forState:UIControlStateNormal];
    [pinglunBt addTarget:self action:@selector(pinglunClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pinglunBt];
    
    UILabel * renshu=[[UILabel alloc]initWithFrame:CGRectMake(291, 8, 80, 20)];
    renshu.text=@"评论";
    renshu.textColor=[UIColor whiteColor];
    renshu.font=[UIFont systemFontOfSize:12];
    [bgImageview addSubview:renshu];

}

-(void)backclick{
    
    [self.sideMenuViewController
     setContentViewController:[[ZhuYeMianViewController alloc] init]animated:YES];
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
        [pinglunBt setBackgroundImage:[UIImage imageNamed:@"小评论灰"] forState:UIControlStateNormal];
        isClick=NO;
    }else{
        
        [pinglunBt setBackgroundImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        pinglunView1=[[UIView alloc]initWithFrame:CGRectMake(0, 360, 380, 45)];
        pinglunView1.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:pinglunView1];
        senderBt=[[UIButton alloc]initWithFrame:CGRectMake(320, 15, 50, 20)];
        [senderBt setTitle:@"发送" forState:UIControlStateNormal];
        [senderBt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [senderBt addTarget:self action:@selector(senderClick) forControlEvents:UIControlEventTouchUpInside];
        [pinglunView1 addSubview:senderBt];
        
        senderText=[[UITextField alloc]initWithFrame:CGRectMake(20, 8, 290, 33)];
        senderText.placeholder=@"说点什么吧...";
        senderText.backgroundColor=[UIColor grayColor];
        senderText.font=[UIFont systemFontOfSize:14];
        senderText.delegate=self;
        [pinglunView1 addSubview:senderText];
        isClick=YES;
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [pinglunView1 endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    pinglunView1.hidden=YES;
    pinglunView2=[[UIView alloc]initWithFrame:CGRectMake(0, 620, 380, 55)];
    pinglunView2.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:pinglunView2];
    senderBt=[[UIButton alloc]initWithFrame:CGRectMake(320, 15, 50, 20)];
    [senderBt setTitle:@"发送" forState:UIControlStateNormal];
    [senderBt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [senderBt addTarget:self action:@selector(senderClick) forControlEvents:UIControlEventTouchUpInside];
    [pinglunView2 addSubview:senderBt];
    
    senderText=[[UITextField alloc]initWithFrame:CGRectMake(20, 8, 290, 33)];
    senderText.placeholder=@"说点什么吧...";
    senderText.backgroundColor=[UIColor grayColor];
    senderText.font=[UIFont systemFontOfSize:14];
    senderText.delegate=self;
    [pinglunView2 addSubview:senderText];
    return YES;
}
-(void)senderClick{
    
    pinglunView1.hidden=YES;
    pinglunView2.hidden=YES;
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
    
    return 85;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //判断cell是否处于选中状态，并且用不同的identifier标记重用;
    //选中的cell改变高度，同时在cell的下方添加背景图片和需要的button;
    //选中状态
    static NSString *identifier_ = @"cell_";
    UITableViewCell *cell_ = [tableView dequeueReusableCellWithIdentifier:identifier_];
    if (cell_ == nil){
        cell_ = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_] ;
        
        UIView * bgImage=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 85)];
        bgImage.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景.png"]];
        [cell_.contentView addSubview:bgImage];
        
        morenBt=[[UIButton alloc]initWithFrame:CGRectMake(10, 12, 25, 25)];
        [morenBt setBackgroundImage:[UIImage imageNamed:@"publisher_photo_small_icon"] forState:UIControlStateNormal];
        [bgImage addSubview:morenBt];
        
        nameLa=[[UILabel alloc]initWithFrame:CGRectMake(40, 12, 80, 20)];
        nameLa.text=@"感恩天下";
        nameLa.textColor=[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f];
        nameLa.font=[UIFont systemFontOfSize:16];
        [bgImage addSubview:nameLa];
        
        timeLa=[[UILabel alloc]initWithFrame:CGRectMake(240, 12, 110, 20)];
        timeLa.text=@"2015-4-12 10:24:09";
        timeLa.textColor=[UIColor lightGrayColor];
        timeLa.font=[UIFont systemFontOfSize:12];
        [bgImage addSubview:timeLa];
        
        neirongText=[[UITextView alloc]initWithFrame:CGRectMake(40, 30, 290, 40)];
        neirongText.text=@"闻如是。一时婆伽婆。在舍卫城。袛树给孤独园。尔时世尊。告诸比丘。父母于子。大有曾益";
        neirongText.textColor=[UIColor blackColor];
        neirongText.backgroundColor=[UIColor clearColor];
        neirongText.font=[UIFont systemFontOfSize:11];
        [bgImage addSubview:neirongText];
        
        UIButton * huifuBt=[[UIButton alloc]initWithFrame:CGRectMake(320, 55, 50, 25)];
        huifuBt.backgroundColor=[UIColor clearColor];
        [bgImage addSubview:huifuBt];
        
        UIImageView * huifuim=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 12, 14)];
        huifuim.image=[UIImage imageNamed:@"comment_reply"];
        [huifuBt addSubview:huifuim];
        
        UILabel * huifuLa=[[UILabel alloc]initWithFrame:CGRectMake(22, 3, 70, 20)];
        huifuLa.text=@"回复";
        huifuLa.font=[UIFont systemFontOfSize:12];
        [huifuBt addSubview:huifuLa];
        
    }
    cell_.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell_;
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
        vi.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"bg"]];
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
//    [jubaoBt setBackgroundImage:[UIImage imageNamed:@"report_no_have"] forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
