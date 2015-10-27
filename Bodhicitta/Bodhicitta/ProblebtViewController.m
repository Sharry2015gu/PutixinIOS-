//
//  ProblebtViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/5/5.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "ProblebtViewController.h"
#import "ILBarButtonItem.h"
#import "UserLoginViewController.h"


#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
@interface ProblebtViewController ()

@end

@implementation ProblebtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * la=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 15, 15)];
    la.text=@"短信找回";
    la.textColor=[UIColor whiteColor];
    self.navigationItem.titleView=la;
    ILBarButtonItem *settingsBtn =
    [ILBarButtonItem barItemWithImage:[UIImage imageNamed:@"返回上级.png"]
                        selectedImage:[UIImage imageNamed:@"返回上级按下.png"]
                               target:self
                               action:@selector(leftTapped:)];
    
    self.navigationItem.leftBarButtonItem=settingsBtn;
    
    UIImageView * megvi=[[UIImageView alloc]initWithFrame:CGRectMake(23, 35, 330, 47)];
    megvi.image=[UIImage imageNamed:@"登录文本框.png"];
    [self.view addSubview:megvi];
    megtext=[[UITextField alloc]initWithFrame:CGRectMake(30, 35, 330, 47)];
//    megtext.background=[UIImage imageNamed:@"登录文本框.png"];
    megtext.placeholder=@"请输入你的手机号";
    [self.view addSubview:megtext];
    
    nextstepbt=[[UIButton alloc]initWithFrame:CGRectMake(23, 200, 330, 47)];
    [nextstepbt setBackgroundImage:[UIImage imageNamed:@"下一步.png"] forState:UIControlStateNormal];
    [nextstepbt addTarget:self action:@selector(nextstepbtClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextstepbt];
    
    }

-(void)nextstepbtClick{
    
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)leftTapped:(id)sender {
//    ViewController * view=[[ViewController alloc]init];
//    [self.navigationController pushViewController:view animated:YES];
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [megtext resignFirstResponder];
    
}


@end
