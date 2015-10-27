//
//  MyMain_MyViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/15.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "MyMain_MyViewController.h"

@interface MyMain_MyViewController ()

@end

@implementation MyMain_MyViewController
@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * background=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    background.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    [self.view addSubview:background];
    
    UIImageView * bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 380, 215)];
    bgImage.image=[UIImage imageNamed:@"背景.jpg"];
    [self.view addSubview:bgImage];
    
    fanhuiBt=[[UIButton alloc]initWithFrame:CGRectMake(6, 33, 25, 25)];
    [fanhuiBt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [fanhuiBt addTarget:self action:@selector(fanhuiclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhuiBt];

    
    touxiangBt=[[UIButton alloc]initWithFrame:CGRectMake(160, 45, 55, 55)];
    [touxiangBt setBackgroundImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
//    [touxiangBt addTarget:self action:@selector(touxiangBuuton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:touxiangBt];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(155, 100, 140, 30)];
    title.text=@"大善之人";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:18];
    [bgImage addSubview:title];
    
    UIButton * button=[[UIButton alloc]initWithFrame:CGRectMake(50, 135, 380, 30)];
    [button setBackgroundColor:[UIColor clearColor]];
//    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIImageView * yindaoiv=[[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 20, 20)];
    yindaoiv.image=[UIImage imageNamed:@"引号"];
    [button addSubview:yindaoiv];
    
    UILabel * titlebt=[[UILabel alloc]initWithFrame:CGRectMake(50, 5, 300, 20)];
    titlebt.text=@"大悲无泪,大悟无言,大笑无声。";
    titlebt.textColor=[UIColor whiteColor];
    titlebt.font=[UIFont systemFontOfSize:16];
    [button addSubview:titlebt];
    
    guanzhuBt=[[UIButton alloc]initWithFrame:CGRectMake(140, 175, 90, 25)];
    [guanzhuBt setTitle:@"＋加关注" forState:UIControlStateNormal];
    [guanzhuBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [guanzhuBt setBackgroundImage:[UIImage imageNamed:@"44"] forState:UIControlStateNormal];
    [guanzhuBt addTarget:self action:@selector(guanzhuClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:guanzhuBt];
    
    UIView * ziliaoLa=[[UIView alloc]initWithFrame:CGRectMake(0, 215, 380, 48)];
    ziliaoLa.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:ziliaoLa];
    
    quanziBt=[[UIButton alloc]initWithFrame:CGRectMake(0, 215, 126, 48)];
    [quanziBt setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:quanziBt];
    
     qzLa=[[UILabel alloc]initWithFrame:CGRectMake(60, 5, 120, 20)];
    qzLa.text=@"1";
    qzLa.textColor=[UIColor blackColor];
    qzLa.font=[UIFont systemFontOfSize:16];
    [quanziBt addSubview:qzLa];
    
    qzText=[[UILabel alloc]initWithFrame:CGRectMake(50, 25, 120, 20)];
    qzText.text=@"动态";
    qzText.textColor=[UIColor grayColor];
    qzText.font=[UIFont systemFontOfSize:16];
    [quanziBt addSubview:qzText];

    
    UIImageView * iv=[[UIImageView alloc]initWithFrame:CGRectMake(126, 8, 0.5, 30)];
    iv.image=[UIImage imageNamed:@"line1"];
    [ziliaoLa addSubview:iv];
    
    gzButton=[[UIButton alloc]initWithFrame:CGRectMake(126, 215, 126, 48)];
    [gzButton setBackgroundColor:[UIColor clearColor]];
    [gzButton addTarget:self action:@selector(gzClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gzButton];
    
    gzLa=[[UILabel alloc]initWithFrame:CGRectMake(50, 5, 120, 20)];
    gzLa.text=@"121";
    gzLa.textColor=[UIColor blackColor];
    gzLa.font=[UIFont systemFontOfSize:16];
    [gzButton addSubview:gzLa];
    
    gzText=[[UILabel alloc]initWithFrame:CGRectMake(50, 25, 120, 20)];
    gzText.text=@"关注";
    gzText.textColor=[UIColor grayColor];
    gzText.font=[UIFont systemFontOfSize:16];
    [gzButton addSubview:gzText];

    
    UIImageView * iv1=[[UIImageView alloc]initWithFrame:CGRectMake(252, 8, 0.5, 30)];
    iv1.image=[UIImage imageNamed:@"line1"];
    [ziliaoLa addSubview:iv1];

    fsBurron=[[UIButton alloc]initWithFrame:CGRectMake(252, 215, 125, 48)];
    [fsBurron setBackgroundColor:[UIColor clearColor]];
    [fsBurron addTarget:self action:@selector(fsClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fsBurron];
    
    fsLa=[[UILabel alloc]initWithFrame:CGRectMake(45, 5, 120, 20)];
    fsLa.text=@"1314";
    fsLa.textColor=[UIColor blackColor];
    fsLa.font=[UIFont systemFontOfSize:16];
    [fsBurron addSubview:fsLa];
    
    fsText=[[UILabel alloc]initWithFrame:CGRectMake(50, 25, 120, 20)];
    fsText.text=@"粉丝";
    fsText.textColor=[UIColor grayColor];
    fsText.font=[UIFont systemFontOfSize:16];
    [fsBurron addSubview:fsText];
    
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 275, 380, self.view.frame.size.height)];
    tableview.delegate=self;
    tableview.dataSource=self;
    [background addSubview:tableview];
    
    dataArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<20; i++) {
        [dataArray addObject:[NSNumber numberWithInt:i+1]];
    }

}

-(void)fanhuiclick{
    
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
-(void)guanzhuClick{
   
    if (isClick==YES) {
        [guanzhuBt setBackgroundImage:[UIImage imageNamed:@"44"] forState:UIControlStateNormal];
        [guanzhuBt setTitle:@"＋已关注" forState:UIControlStateNormal];
        isClick=NO;
    }else{
        
        [guanzhuBt setBackgroundImage:[UIImage imageNamed:@"55"] forState:UIControlStateNormal];
        [guanzhuBt setTitle:@"已关注" forState:UIControlStateNormal];

        isClick=YES;
    }

}
-(void)gzClick{
   
    [self.sideMenuViewController
     setContentViewController:[[GuanZhu_MainViewController alloc] init]animated:YES];
    [self.sideMenuViewController hideMenuViewController];

}
-(void)fsClick{

    [self.sideMenuViewController
     setContentViewController:[[FenSi_MainViewController alloc] init]animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
