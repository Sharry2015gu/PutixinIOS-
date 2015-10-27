//
//  FaBu_MyViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/10.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "FaBu_MyViewController.h"

@interface FaBu_MyViewController ()

@end

@implementation FaBu_MyViewController

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
    
    backBt=[[UIButton alloc]initWithFrame:CGRectMake(6, 33, 25, 25)];
    [backBt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backBt addTarget:self action:@selector(backbtclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBt];
    
    sender=[[UIButton alloc]initWithFrame:CGRectMake(305, 35, 85, 20)];
    [sender setTitle:@"发布" forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sender addTarget:self action:@selector(senderbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sender];
    
    UIView * background=[[UIView alloc]initWithFrame:CGRectMake(0, 70, 380, self.view.frame.size.height)];
    background.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    [self.view addSubview:background];
    
    textField=[[UITextView alloc]initWithFrame:CGRectMake(10, 10, 355, 250)];
    textField.text=@"这一刻的想法...";
    textField.font=[UIFont systemFontOfSize:16];
    textField.textColor=[UIColor grayColor];
    textField.delegate=self;
    textField.backgroundColor=[UIColor clearColor];
    [background addSubview:textField];
    
    UIImageView * iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 320, 380, 1)];
    iv.image=[UIImage imageNamed:@"line.png"];
    [background addSubview:iv];
    
    photoBt=[[UIButton alloc]initWithFrame:CGRectMake(20, 260, 50, 50)];
    [photoBt setBackgroundImage:[UIImage imageNamed:@"addtopic_picture"] forState:UIControlStateNormal];
    [background addSubview:photoBt];

}
-(void)backbtclick{
    
    [self.sideMenuViewController
     setContentViewController:[[My_syViewController alloc] init]animated:YES];
    [self.sideMenuViewController hideMenuViewController];

}
-(void)senderbuttonClick{
    
    [self.sideMenuViewController
     setContentViewController:[[My_syViewController alloc] init]animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //    NSLog(@"touchesBegan:withEvent:");
    [textField endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
