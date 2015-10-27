//
//  ZhunBeiViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/22.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "ZhunBeiViewController.h"
#import "HeaderFile.h"
@interface ZhunBeiViewController ()

@end

@implementation ZhunBeiViewController

#pragma mark ---主页面UI---
- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBar * bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    [bar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:bar];
    
    UIButton * bu=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [bu setBackgroundImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(buclick) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:bu];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"为何坐禅";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [bar addSubview:title];
    
    fenxiangBt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.89, 0.05*SCREEN_HEIGHT, 25, 25)];
    [fenxiangBt setBackgroundImage:[UIImage imageNamed:@"share_white_icon"] forState:UIControlStateNormal];
    //    [fenxiangBt addTarget:self action:@selector(fenxiangClick) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:fenxiangBt];
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    [self.view addSubview:view];
    
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 70, 380, self.view.frame.size.height)];
    _tableview.backgroundColor=[UIColor clearColor];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    [self.view addSubview:_tableview];
}

-(void)buclick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//设置tableView的组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 7;
    
    
}

//设置组数里面各行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger senction = indexPath.section;
    if(senction ==0){
        return 45.0;
    }
    if(senction ==1){
        return 200.0;
    }
    if (senction ==2) {
        return 45.0;
    }
    if (senction ==3) {
        return 200.0;
    }
    if (senction ==4) {
        return 45.0;
    }
    if (senction ==5) {
        return 200.0;
    }
    if (senction ==6) {
        return 45.0;
    }
    
    return 100.0;
}

//设置组数里面各行的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section) {
        return arrlist.count == 0 ? 1 :arrlist.count;
    }
    else
        return arrlist.count + 1;
}

//tableView 的代理
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    
    static NSString *mycell = @"ViewController";
     UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mycell];
      tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if(section==0){
        if(cell == nil){
            
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 45)];
        imageview.image=[UIImage imageNamed:@"登录背景.png"];
        [cell addSubview:imageview];
        
        UIImageView * bian=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 5, 27)];
        bian.image=[UIImage imageNamed:@"meditation_ready_title_bg.jpg"];
        [imageview addSubview:bian];
        
        UILabel * titleLa=[[UILabel alloc]initWithFrame:CGRectMake(20, 15, 80, 20)];
        titleLa.text=@"环境";
        titleLa.font=[UIFont systemFontOfSize:23];
        [imageview addSubview:titleLa];
        
        
    }
    if(section==1){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 200)];
        imageview.image=[UIImage imageNamed:@"登录背景.png"];
        [cell addSubview:imageview];
        
        UITextView * textview=[[UITextView alloc]initWithFrame:CGRectMake(20, 0, 340, 180)];
        textview.text=@"要选空气好，相对安静，不易被人干扰之处，该开的窗户开；电视，收音机关；关好门，免得他人闯进打扰。这是自然环境。同时，心情要比较平静时，身体状况要心比较正常时如果是心乱如麻时，或身心病痛很严重的，请勿禅从，这是身心环境。环境不好，易走火入魔，比如，你正全身心入静时，谁狠狠的推你一把，你就可能出些问题。心情大乱时禅做，也不易入静，甚至诱发不好的心情，行为";
        textview.backgroundColor=[UIColor clearColor];
        textview.font=[UIFont systemFontOfSize:16];
        [imageview addSubview:textview];
        
    }
    
    if(section==2){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 45)];
        imageview.image=[UIImage imageNamed:@"登录背景.png"];
        [cell addSubview:imageview];
        
        UIImageView * bian=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 5, 27)];
        bian.image=[UIImage imageNamed:@"meditation_ready_title_bg.jpg"];
        [imageview addSubview:bian];
        
        UILabel * titleLa=[[UILabel alloc]initWithFrame:CGRectMake(20, 15, 80, 20)];
        titleLa.text=@"食";
        titleLa.font=[UIFont systemFontOfSize:23];
        [imageview addSubview:titleLa];

    }
    if(section==3){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 200)];
        imageview.image=[UIImage imageNamed:@"登录背景.png"];
        [cell addSubview:imageview];
        
        UITextView * textview=[[UITextView alloc]initWithFrame:CGRectMake(20, 0, 340, 180)];
        textview.text=@"要选空气好，相对安静，不易被人干扰之处，该开的窗户开；电视，收音机关；关好门，免得他人闯进打扰。这是自然环境。同时，心情要比较平静时，身体状况要心比较正常时如果是心乱如麻时，或身心病痛很严重的，请勿禅从，这是身心环境。环境不好，易走火入魔，比如，你正全身心入静时，谁狠狠的推你一把，你就可能出些问题。心情大乱时禅做，也不易入静，甚至诱发不好的心情，行为";
        textview.backgroundColor=[UIColor clearColor];
        textview.font=[UIFont systemFontOfSize:16];
        [imageview addSubview:textview];

    }
    if(section==4){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 45)];
        imageview.image=[UIImage imageNamed:@"登录背景.png"];
        [cell addSubview:imageview];
        
        UIImageView * bian=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 5, 27)];
        bian.image=[UIImage imageNamed:@"meditation_ready_title_bg.jpg"];
        [imageview addSubview:bian];
        
        UILabel * titleLa=[[UILabel alloc]initWithFrame:CGRectMake(20, 15, 80, 20)];
        titleLa.text=@"睡眠";
        titleLa.font=[UIFont systemFontOfSize:23];
        [imageview addSubview:titleLa];

        
    }
    if(section==5){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 200)];
        imageview.image=[UIImage imageNamed:@"登录背景.png"];
        [cell addSubview:imageview];
        
        UITextView * textview=[[UITextView alloc]initWithFrame:CGRectMake(20, 0, 340, 180)];
        textview.text=@"要选空气好，相对安静，不易被人干扰之处，该开的窗户开；电视，收音机关；关好门，免得他人闯进打扰。这是自然环境。同时，心情要比较平静时，身体状况要心比较正常时如果是心乱如麻时，或身心病痛很严重的，请勿禅从，这是身心环境。环境不好，易走火入魔，比如，你正全身心入静时，谁狠狠的推你一把，你就可能出些问题。心情大乱时禅做，也不易入静，甚至诱发不好的心情，行为";
        textview.backgroundColor=[UIColor clearColor];
        textview.font=[UIFont systemFontOfSize:16];
        [imageview addSubview:textview];

    }
    if(section==6){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
                
        
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
