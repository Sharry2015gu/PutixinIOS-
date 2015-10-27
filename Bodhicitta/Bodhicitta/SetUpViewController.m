//
//  SetUpViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/15.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "SetUpViewController.h"
#import "HeaderFile.h"
#import "UserLoginViewController.h"
#import "Change_PasswordViewController.h"
#import "Welcome_PageViewController.h"
@interface SetUpViewController ()

@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar * bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.1+5)];
    
    [bar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:bar];
    
    UIButton * bu=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [bu setBackgroundImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(shezhiclick) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:bu];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.45,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"设置";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [bar addSubview:title];
    
    UIView * bgview=[[UIView alloc]initWithFrame:CGRectMake(0, bar.frame.origin.y+bar.frame.size.height, SCREEN_WIDTH, self.view.frame.size.height)];
    bgview.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景.png"]];
    [self.view addSubview:bgview];
    
    //用于判断设备
    
    CGFloat height ;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        
        height =  118;
        
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            
            height = 115;
            
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            
            height = 118;
            
        }
        else
        {
            
            height  = 118;
            
        }
    }
    
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, bar.frame.origin.y+bar.frame.size.height, SCREEN_WIDTH, height+height*0.99+5)];
    _tableview.scrollEnabled=NO;
    _tableview.delegate=self;
    _tableview.dataSource=self;
    [self.view addSubview:_tableview];
    
    dengluBt =[[UIButton alloc]initWithFrame:CGRectMake(0, _tableview.frame.origin.y+_tableview.frame.size.height+40, SCREEN_WIDTH, 45)];
    [dengluBt setTitle:@"退出登录" forState:UIControlStateNormal];
    [dengluBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dengluBt setBackgroundImage:[UIImage imageNamed:@"底部导航背景.jpg"] forState:UIControlStateNormal];
    [dengluBt addTarget:self action:@selector(dengluClick) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:dengluBt];
    
}
#pragma mark ----按钮事件---
-(void)shezhiclick{
    AppDelegate * delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.sideMenuViewController setContentViewController:delegate.mainVc
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
}

-(void)dengluClick{
    
    UIAlertView * alre=[[UIAlertView alloc]initWithTitle:nil message:@"确定要退出吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alre show];
    
}
#pragma mark ---alertView代理----
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex==0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if(buttonIndex ==1){
        
        UserLoginViewController * login = [[UserLoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        
    }
}
#pragma mark ----tableView代理-----
//设置tableView的组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
    
    
}
//设置组数里面各行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger senction = indexPath.section;
    if(senction ==0){
        return 48.0;
    }
    if(senction ==1){
        return 48.0;
    }
    if (senction ==2) {
        return 48.0;
    }
    if (senction ==3) {
        return 48.0;
    }
    if (senction ==4) {
        return 48.0;
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
#pragma mark ----tableView 的代理----
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    
    static NSString *mycell = @"ViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mycell];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if(section==0){
        if(cell == nil){
            
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
        imageview.image=[UIImage imageNamed:@"个人中心菜单背景.png"];
        [cell addSubview:imageview];
        
        banbenLa=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, 10, SCREEN_WIDTH*0.3, 25)];
        banbenLa.text=@"当前版本";
        banbenLa.font=[UIFont systemFontOfSize:16];
        banbenLa.textColor=[UIColor blackColor];
        [imageview addSubview:banbenLa];
        
        sumLa=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.85, 10, SCREEN_WIDTH*0.3, SCREEN_WIDTH*0.075)];
        sumLa.font=[UIFont systemFontOfSize:16];
        //         NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
        sumLa.text=[[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"];
        [imageview addSubview:sumLa];
        
    }
    if(section==1){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
        imageview.image=[UIImage imageNamed:@"个人中心菜单背景.png"];
        [cell addSubview:imageview];
        
        gengxinLa=[[UILabel alloc]initWithFrame:CGRectMake(banbenLa.frame.origin.x, 10, SCREEN_WIDTH*0.3, SCREEN_WIDTH*0.075)];
        gengxinLa.text=@"检查更新";
        gengxinLa.font=[UIFont systemFontOfSize:16];
        [imageview addSubview:gengxinLa];
        
        zuixinLa=[[UILabel alloc]initWithFrame:CGRectMake(sumLa.frame.origin.x, 10, SCREEN_WIDTH*0.3, SCREEN_WIDTH*0.075)];
        zuixinLa.text=@"最新版";
        zuixinLa.textColor=[UIColor blackColor];
        zuixinLa.font=[UIFont systemFontOfSize:16];
        [imageview addSubview:zuixinLa];
        
        
    }
    
    if(section==2){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
        imageview.image=[UIImage imageNamed:@"个人中心菜单背景.png"];
        [cell addSubview:imageview];
        
        fankuiLa=[[UILabel alloc]initWithFrame:CGRectMake(banbenLa.frame.origin.x, 0, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.075)];
        fankuiLa.text=@"意见反馈";
        fankuiLa.font=[UIFont systemFontOfSize:16];
        [imageview addSubview:fankuiLa];
        
        UIImageView * im=[[UIImageView alloc]initWithFrame:CGRectMake(sumLa.frame.origin.x+15, 17, SCREEN_WIDTH*0.05, SCREEN_WIDTH*0.05)];
        im.image=[UIImage imageNamed:@"箭头图标"];
        [imageview addSubview:im];
        
        
    }
    if(section==3){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
        imageview.image=[UIImage imageNamed:@"个人中心菜单背景.png"];
        [cell addSubview:imageview];
        
        xiugaiLa=[[UILabel alloc]initWithFrame:CGRectMake(banbenLa.frame.origin.x, 0, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.075)];
        xiugaiLa.text=@"修改密码";
        xiugaiLa.font=[UIFont systemFontOfSize:16];
        [imageview addSubview:xiugaiLa];
        
        UIImageView * im=[[UIImageView alloc]initWithFrame:CGRectMake(sumLa.frame.origin.x+15, 17, SCREEN_WIDTH*0.05, SCREEN_WIDTH*0.05)];
        im.image=[UIImage imageNamed:@"箭头图标"];
        [imageview addSubview:im];
        
    }
    if(section==4){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
        imageview.image=[UIImage imageNamed:@"个人中心菜单背景.png"];
        [cell addSubview:imageview];
        
        huaanyingyeLa=[[UILabel alloc]initWithFrame:CGRectMake(banbenLa.frame.origin.x, 0, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.075)];
        huaanyingyeLa.text=@"欢迎页";
        huaanyingyeLa.font=[UIFont systemFontOfSize:16];
        [imageview addSubview:huaanyingyeLa];
        
        UIImageView * im=[[UIImageView alloc]initWithFrame:CGRectMake(sumLa.frame.origin.x+15, 17, SCREEN_WIDTH*0.05, SCREEN_WIDTH*0.05)];
        im.image=[UIImage imageNamed:@"箭头图标"];
        [imageview addSubview:im];
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    NSInteger senction = indexPath.section;
    if(senction == 1){
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.78, SCREEN_WIDTH*0.5, 30)];
        label.text = @"当前已经是最新版";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.backgroundColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:12];
        [self.view addSubview:label];
        
        [UIView animateWithDuration:1.5 animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
        
    }
    else
        if(senction == 2){
            FanKuiViewController * fankuai = [[FanKuiViewController alloc]init];
            [self.navigationController pushViewController:fankuai animated:YES];
        }
        else if (senction == 3){
            
            Change_PasswordViewController * change = [[Change_PasswordViewController alloc]init];
            [self.navigationController pushViewController:change animated:YES];
        }
        else if (senction == 4){
            
            Welcome_PageViewController * welcome = [[Welcome_PageViewController alloc]init];
            [self.navigationController pushViewController:welcome animated:YES];
        }
}

#pragma mark ----按钮事件---
- (IBAction)switchAction:(id)sender {
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"能听见");
    }else {
        NSLog(@"听不见");
    }
    
}
- (IBAction)xxswichAction:(id)sender {
    UISwitch *xxswitchButton = (UISwitch*)sender;
    BOOL isButtonOn = [xxswitchButton isOn];
    if (isButtonOn) {
        NSLog(@"能听见");
    }else {
        NSLog(@"听不见");
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
