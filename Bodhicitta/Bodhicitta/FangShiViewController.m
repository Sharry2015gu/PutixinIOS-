//
//  FangShiViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/1.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "FangShiViewController.h"
#import "HeaderFile.h"
@interface FangShiViewController ()

@end

@implementation FangShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    backbt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01-30, SCREEN_HEIGHT*0.01+40, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.1)];
    [backbt setTitleColor:majorityColor forState:UIControlStateNormal];
    [backbt setTitle:@"返回" forState:UIControlStateNormal];
    [backbt addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbt];
    
    title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.1, 0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"找回密码方式";
    title.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:title];
    
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, title.frame.origin.y+80, SCREEN_WIDTH, SCREEN_HEIGHT*0.2+5)];
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.scrollEnabled =NO; //设置tableview 不能滚动
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:tableview];
}

#pragma mark ---设置tableView的代理以及按钮事件---
-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
//设置tableView的组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}
//设置组数里面各行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger senction = indexPath.section;
    if(senction ==0){
        return SCREEN_HEIGHT*0.071;
    }
    if(senction ==1){
        return SCREEN_HEIGHT*0.071;
    }
    if (senction ==2) {
        return SCREEN_HEIGHT*0.071;
    }
        return 100.0;
}
//设置组数里面各行的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section) {
        return arrllist.count == 0 ? 1 :arrllist.count;
    }
    else
        return arrllist.count + 1;
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
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.071)];
        imageview.image=[UIImage imageNamed:@"个人中心菜单背景.png"];
        [cell addSubview:imageview];
        
        UILabel * onetext=[[UILabel alloc]initWithFrame:CGRectMake(20, 11, 130, 25)];
        onetext.text=@"手机找回密码";
        onetext.font=[UIFont systemFontOfSize:18];
        [imageview addSubview:onetext];
        
    }
    if(section==1){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.071)];
        imageview.image=[UIImage imageNamed:@"个人中心菜单背景.png"];
        [cell addSubview:imageview];
        UILabel * twotext=[[UILabel alloc]initWithFrame:CGRectMake(20, 11, 140, 25)];
        twotext.text=@"邮箱找回密码";
        twotext.font=[UIFont systemFontOfSize:18];
        [imageview addSubview:twotext];
        
    }
    
    if(section==2){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.071)];
        imageview.image=[UIImage imageNamed:@"个人中心菜单背景.png"];
        [cell addSubview:imageview];
        
        UILabel * threetext=[[UILabel alloc]initWithFrame:CGRectMake(20, 11, 130, 25)];
        threetext.text=@"密保找回密码";
        threetext.font=[UIFont systemFontOfSize:18];
        [imageview addSubview:threetext];
        
    }
        
    
    UIButton * bt=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    bt.frame=CGRectMake(SCREEN_WIDTH*0.9, SCREEN_HEIGHT*0.02, 18, 18);
    [bt setBackgroundImage:[UIImage imageNamed:@"箭头图标.png"] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(myBtnClick:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:bt];
    return cell;
}
-(void)myBtnClick:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];   // 把触摸的事件放到集合里
    
    UITouch *touch = [touches anyObject];   //把事件放到触摸的对象了
    
    CGPoint currentTouchPosition = [touch locationInView:tableview]; //把触发的这个点转成二位坐标
    
    NSIndexPath *indexPath = [tableview indexPathForRowAtPoint:currentTouchPosition]; //匹配坐标点
    if(indexPath !=nil)
    {
        }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    NSInteger senction = indexPath.section;
    if(senction == 0)
    {
        TelePhoneViewController *teleViewController = [[TelePhoneViewController alloc]init];
        [self.navigationController pushViewController:teleViewController animated:YES];
    }else if(senction == 1)
    {
        EmailViewController * email=[[EmailViewController alloc]init];
        [self.navigationController pushViewController:email animated:YES];
        
    }else if(senction == 2)
    {
        MiBaoViewController * mibao=[MiBaoViewController alloc];
        [self.navigationController pushViewController:mibao animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}


@end
