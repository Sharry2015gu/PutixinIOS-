//
//  FaBiao_SYViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/8.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "FaBiao_SYViewController.h"

@interface FaBiao_SYViewController ()

@end

@implementation FaBiao_SYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 70)];
    view.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"顶部导航背景"]];
    [self.view addSubview:view];
    //    UIImageView *
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(125, 30, 120, 30)];
    title.text=@"发布圈动态";
    title.font=[UIFont systemFontOfSize:20];
    title.textColor=[UIColor whiteColor];
    [view addSubview:title];
    
    fanhuiBt=[[UIButton alloc]initWithFrame:CGRectMake(6, 33, 25, 25)];
    [fanhuiBt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [fanhuiBt addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhuiBt];
    
    fabiaoButton=[[UIButton alloc]initWithFrame:CGRectMake(305, 35, 85, 20)];
    [fabiaoButton setTitle:@"发布" forState:UIControlStateNormal];
    [fabiaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [fabiaoButton addTarget:self action:@selector(faBiaobuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fabiaoButton];
    
    UIView * background=[[UIView alloc]initWithFrame:CGRectMake(0, 70, 380, self.view.frame.size.height)];
    background.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    [self.view addSubview:background];
    
    textview=[[UITextView alloc]initWithFrame:CGRectMake(10, 10, 355, 250)];
    textview.text=@"这一刻的想法...";
    textview.font=[UIFont systemFontOfSize:16];
    textview.textColor=[UIColor grayColor];
    textview.delegate=self;
    textview.backgroundColor=[UIColor clearColor];
    [background addSubview:textview];
    
    UIImageView * iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 320, 380, 1)];
    iv.image=[UIImage imageNamed:@"line.png"];
    [background addSubview:iv];
    
    bgButton=[[UIButton alloc]initWithFrame:CGRectMake(20, 260, 50, 50)];
    [bgButton setBackgroundImage:[UIImage imageNamed:@"addtopic_picture"] forState:UIControlStateNormal];
    [background addSubview:bgButton];
    
    dayBt=[[UIButton alloc]initWithFrame:CGRectMake(20, 330, 120, 40)];
    [dayBt setBackgroundColor:[UIColor clearColor]];
    [dayBt addTarget:self action:@selector(dayClick) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:dayBt];
    
    dayImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    dayImage.image=[UIImage imageNamed:@"synchronous_yes"];
    [dayBt addSubview:dayImage];
    
    dayla=[[UILabel alloc]initWithFrame:CGRectMake(30, 10, 90, 20)];
    dayla.text=@"同步到每日一善";
    dayla.font=[UIFont systemFontOfSize:12];
    dayla.textColor=[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f];
    [dayBt addSubview:dayla];
    
}
-(void)backclick{
    
    [self.sideMenuViewController
     setContentViewController:[[ShanYou_DTViewController alloc] init]animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}
-(void)faBiaobuttonClick{
    
    [self.sideMenuViewController
     setContentViewController:[[ShanYou_DTViewController alloc] init]animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dayClick{

    if (isClick==YES) {
        
        dayImage.image=[UIImage imageNamed:@"synchronous_yes"];
        dayla.textColor=[[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f];
        isClick=NO;
    }else{
        
       dayImage.image=[UIImage imageNamed:@"synchronous_no"];
        dayla.textColor=[UIColor grayColor];
        isClick=YES;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchesBegan:withEvent:");
    [textview endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
@end
