//
//  XXNeiRongViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/18.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "XXNeiRongViewController.h"
#import "HeaderFile.h"
//#import "XinDengViewController.h"
#include "RESideMenu.h"
#import "EmailViewCell.h"
#import "NewModel.h"
@interface XXNeiRongViewController (){
    EmailViewCell *email;
}
@property(nonatomic,strong)UINavigationBar * bar;
@property(nonatomic,strong)UIScrollView * scrollview;
@end

@implementation XXNeiRongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    
    _bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.1)];
    [_bar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:_bar];
    
    UIButton * bu=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [bu setBackgroundImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(fhclick) forControlEvents:UIControlEventTouchUpInside];
    [_bar addSubview:bu];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"我的消息";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [_bar addSubview:title];
    
    delection=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.85, 0.05*SCREEN_HEIGHT, 0.05*SCREEN_WIDTH+30, 0.08*SCREEN_WIDTH)];
    [delection setTitle:@"删除" forState:UIControlStateNormal];
    [delection setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [delection addTarget:self action:@selector(delectionbt) forControlEvents:UIControlEventTouchUpInside];
    [_bar addSubview:delection];
    _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _bar.frame.origin.y+_bar.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scrollview.contentSize=CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT+130);
    _scrollview.showsHorizontalScrollIndicator=NO;
    _scrollview.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_scrollview];
    
    UIView * bgview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgview.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景.png"]];
    [_scrollview addSubview:bgview];
    
    UILabel * xitong=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, _bar.frame.origin.y+_bar.frame.size.height-50, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.055)];
    xitong.text=@"[系统]";
    xitong.font=[UIFont systemFontOfSize:16];
    [bgview addSubview:xitong];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(xitong.frame.origin.x+60, xitong.frame.origin.y, SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.055)];
    _titleLabel.text=[NSString stringWithFormat:@"%@",self.name];
    _titleLabel.font=[UIFont systemFontOfSize:16];
    [bgview addSubview:_titleLabel];
    
    timer=[[UILabel alloc]initWithFrame:CGRectMake(xitong.frame.origin.x, xitong.frame.origin.y+xitong.frame.size.height-15, SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.055)];
    timer.text = [NSString stringWithFormat:@"%@",self.data];
    timer.font=[UIFont systemFontOfSize:14];
    timer.textColor=[UIColor lightGrayColor];
    [bgview addSubview:timer];
    
    UIImageView * lineImage=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.02, timer.frame.origin.y+timer.frame.size.height, SCREEN_WIDTH*0.95, 1)];
    lineImage.image=[UIImage imageNamed:@"line.png"];
    [bgview addSubview:lineImage];
    
    neirongText=[[UITextView alloc]initWithFrame:CGRectMake(xitong.frame.origin.x, lineImage.frame.origin.y+lineImage.frame.size.height+10, SCREEN_WIDTH*0.8, SCREEN_HEIGHT+100)];
    neirongText.backgroundColor=[UIColor clearColor];
    neirongText.text=[NSString stringWithFormat:@"%@",self.centrol];
    neirongText.editable=NO;
    neirongText.scrollEnabled = NO;
    NSLog(@"----=%@",neirongText.text);
    neirongText.font=[UIFont systemFontOfSize:16];
    neirongText.textColor=[UIColor blackColor];
    [bgview addSubview:neirongText];
    
}
#pragma mark ---按钮事件---
-(void)fhclick{
    
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)delectionbt{
    UIAlertView * alre=[[UIAlertView alloc]initWithTitle:nil message:@"确定删除这条消息吗?"  delegate:self cancelButtonTitle:@"取消"  otherButtonTitles:@"确定",nil];
    [alre show];
}
#pragma mark ---代理---
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else if(buttonIndex==1){
        [self getSetMessageInfon:_model];
//        [self.sideMenuViewController setContentViewController:[[XinXiangViewController alloc]init]animated:YES];
//            [self.sideMenuViewController hideMenuViewController];
//    
    
    }
}
#pragma mark -----消息接口----
-(void)getSetMessageInfon:(NewModel *)model
{
    [ProgressHUD showOnView:self.view];
    NSDictionary * vowdic=@{@"messageID":[NSString stringWithFormat:@"%ld",model.messageID],@"huaienID":[[NSUserDefaults standardUserDefaults] objectForKey:@"huaienID"],@"optType":@"D"};
    NSDictionary * vowDic = @{@"params":[NSString stringWithFormat:@"%@",vowdic]};
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,SetMessgeStatus]  parameters:vowDic success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"消息已读=%@",jsonData);
        
        [_scrollview removeFromSuperview];
        [ProgressHUD hideAfterSuccessOnView:self.view];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}


@end
