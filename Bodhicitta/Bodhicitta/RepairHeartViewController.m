//
//  RepairHeartViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/3.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "RepairHeartViewController.h"
#import "MyBuddhaHallViewController.h"
@interface RepairHeartViewController ()

@end

@implementation RepairHeartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 70)];
    view.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"顶部导航背景"]];
    [self.view addSubview:view];
    //    UIImageView *
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(165, 30, 80, 30)];
    title.text=@"修心";
    title.font=[UIFont systemFontOfSize:20];
    title.textColor=[UIColor whiteColor];
    [view addSubview:title];
    
    UIView * background=[[UIView alloc]initWithFrame:CGRectMake(0, 70, 380, 550)];
    background.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    [self.view addSubview:background];
    
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 380, 550)];
    tableview.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"默认背景.png"]];
    tableview.delegate=self;
    tableview.dataSource=self;
    
    [background addSubview:tableview];
    



}

//设置tableView的组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
    
    
}

//设置组数里面各行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger senction = indexPath.section;
    if(senction ==0){
        return 62.0;
    }
    if(senction ==1){
        return 62.0;
    }
    if (senction ==2) {
        return 62.0;
    }
    if (senction ==3) {
        return 62.0;
    }
    if (senction ==4) {
        return 62.0;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mycell];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if(section==0){
        if(cell == nil){
            
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 62)];
        imageview.image=[UIImage imageNamed:@"默认背景.png"];
        [cell addSubview:imageview];
        
        UIImageView * gongjing=[[UIImageView alloc]initWithFrame:CGRectMake(20, 12, 40, 40)];
        gongjing.image=[UIImage imageNamed:@"恭敬礼佛左边的图片"];
        [imageview addSubview:gongjing];
        UILabel * onetext=[[UILabel alloc]initWithFrame:CGRectMake(90, 20, 90, 25)];
        onetext.text=@"恭敬礼佛";
        onetext.font=[UIFont systemFontOfSize:16];
        [imageview addSubview:onetext];
        
        UIImageView * xiantiao=[[UIImageView alloc]initWithFrame:CGRectMake(0, 62, 390, 1)];
        xiantiao.image=[UIImage imageNamed:@"线条.png"];
        [imageview addSubview:xiantiao];
        
    }
    if(section==1){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 62)];
        imageview.image=[UIImage imageNamed:@"默认背景.png"];
        [cell addSubview:imageview];
        
        UIImageView * gongjing=[[UIImageView alloc]initWithFrame:CGRectMake(20, 12, 40, 40)];
        gongjing.image=[UIImage imageNamed:@"智慧文库"];
        [imageview addSubview:gongjing];
        UILabel * onetext=[[UILabel alloc]initWithFrame:CGRectMake(90, 20, 90, 25)];
        onetext.text=@"智慧文库";
        onetext.font=[UIFont systemFontOfSize:16];
        [imageview addSubview:onetext];
        
        UIImageView * xiantiao=[[UIImageView alloc]initWithFrame:CGRectMake(0, 62, 390, 1)];
        xiantiao.image=[UIImage imageNamed:@"线条.png"];
        [cell addSubview:xiantiao];
    }
    
    if(section==2){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 62)];
        imageview.image=[UIImage imageNamed:@"默认背景.png"];
        [cell addSubview:imageview];
        
        UIImageView * gongjing=[[UIImageView alloc]initWithFrame:CGRectMake(20, 12, 40, 40)];
        gongjing.image=[UIImage imageNamed:@"妙音法洗"];
        [imageview addSubview:gongjing];
        UILabel * onetext=[[UILabel alloc]initWithFrame:CGRectMake(90, 20, 90, 25)];
        onetext.text=@"妙音法洗";
        onetext.font=[UIFont systemFontOfSize:16];
        [imageview addSubview:onetext];
        
        UIImageView * xiantiao=[[UIImageView alloc]initWithFrame:CGRectMake(0, 62, 390, 1)];
        xiantiao.image=[UIImage imageNamed:@"线条.png"];
        [cell addSubview:xiantiao];
    }
    if(section==3){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 62)];
        imageview.image=[UIImage imageNamed:@"默认背景.png"];
        [cell addSubview:imageview];
        
        UIImageView * gongjing=[[UIImageView alloc]initWithFrame:CGRectMake(20, 12, 40, 40)];
        gongjing.image=[UIImage imageNamed:@"净心禅修"];
        [imageview addSubview:gongjing];
        UILabel * onetext=[[UILabel alloc]initWithFrame:CGRectMake(90, 20, 90, 25)];
        onetext.text=@"静心禅修";
        onetext.font=[UIFont systemFontOfSize:16];
        [imageview addSubview:onetext];
        
        UIImageView * xiantiao=[[UIImageView alloc]initWithFrame:CGRectMake(0, 62, 390, 1)];
        xiantiao.image=[UIImage imageNamed:@"线条.png"];
        [cell addSubview:xiantiao];
    }
    if(section==4){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 390, 62)];
        imageview.image=[UIImage imageNamed:@"默认背景.png"];
        [cell addSubview:imageview];
        
        UIImageView * gongjing=[[UIImageView alloc]initWithFrame:CGRectMake(20, 12, 40, 40)];
        gongjing.image=[UIImage imageNamed:@"菩提佛珠"];
        [imageview addSubview:gongjing];
        UILabel * onetext=[[UILabel alloc]initWithFrame:CGRectMake(90, 20, 90, 25)];
        onetext.text=@"菩提佛珠";
        onetext.font=[UIFont systemFontOfSize:16];
        [imageview addSubview:onetext];
        
        UIImageView * xiantiao=[[UIImageView alloc]initWithFrame:CGRectMake(0, 62, 390, 1)];
        xiantiao.image=[UIImage imageNamed:@"线条.png"];
        [cell addSubview:xiantiao];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger senction = indexPath.section;
    if(senction == 0){
        
        MyBuddhaHallViewController * gongjing = [[MyBuddhaHallViewController alloc]init];
        [self.sideMenuViewController setContentViewController:gongjing
                                                     animated:YES];
        [self.sideMenuViewController hideMenuViewController];

        
    }
    else
        if(senction == 1){
            WisdomMathViewController * wis = [[WisdomMathViewController alloc]init];
            
            [self.sideMenuViewController
             setContentViewController:wis animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
        else
            if(senction == 2){
                [self.sideMenuViewController
                 setContentViewController:[[MiaoYinViewController alloc] init]
                 animated:YES];
                [self.sideMenuViewController hideMenuViewController];
            }
            else
                if(senction == 3){
                    [self.sideMenuViewController
                     setContentViewController:[[JingXinViewController alloc] init]
                     animated:YES];
                    [self.sideMenuViewController hideMenuViewController];
                    
                }
                else
                    if(senction == 4){
                        
                        [self.sideMenuViewController
                         setContentViewController:[[FoZhuViewController alloc] init]
                         animated:YES];
                        [self.sideMenuViewController hideMenuViewController];
                }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
