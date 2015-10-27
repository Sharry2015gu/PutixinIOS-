//
//  GongXiu_SYViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/9.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "GongXiu_SYViewController.h"

@interface GongXiu_SYViewController ()

@end

@implementation GongXiu_SYViewController
@synthesize dataArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    seachBt=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 375, 50)];
//    [seachBt setBackgroundColor:[UIColor clearColor]];
    seachBt.showsScopeBar = NO;
    seachBt.delegate=self;
    seachBt.placeholder=@"搜索";
    seachBt.backgroundImage=[UIImage imageNamed:@"登录背景"];
    [self.view addSubview:seachBt];
    
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, 380, self.view.frame.size.height)];
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    [self.view addSubview:tableview];
    dataArray = [[NSMutableArray alloc] init];
    
//    for (int i=0; i<20; i++) {
//        [dataArray addObject:[NSNumber numberWithInt:i+1]];
//    }
    
}
//设置tableView的组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
    
}
//设置组数里面各行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger senction = indexPath.section;
    if(senction ==0){
        return 107.0;
    }
    if(senction ==1){
        return 107.0;
    }
    if (senction ==2) {
        return 107.0;
    }
    if (senction ==3) {
        return 95.0;
    }
    if (senction ==4) {
        return 95.0;
    }
    return 100.0;
}
//设置组数里面各行的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section) {
        return dataArray.count == 0 ? 1 :dataArray.count;
    }
    else
        return dataArray.count + 1;
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
        titleLa=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
        titleLa.text=@"我创建的圈子";
        titleLa.textColor=[UIColor grayColor];
        titleLa.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:titleLa];
        
        touxiangButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 35, 60, 60)];
        [touxiangButton setBackgroundImage:[UIImage imageNamed:@"头像.png"] forState:UIControlStateNormal];
        [cell.contentView addSubview:touxiangButton];
        
        quanmingLa=[[UILabel alloc]initWithFrame:CGRectMake(90, 38, 100, 20)];
        quanmingLa.text=@"新手圈子";
        quanmingLa.font=[UIFont systemFontOfSize:16];
        [cell.contentView addSubview:quanmingLa];
        
        UIImageView * huaImage=[[UIImageView alloc]initWithFrame:CGRectMake(170, 38, 10, 19)];
        huaImage.image=[UIImage imageNamed:@"huo.png"];
        [cell.contentView addSubview:huaImage];
        
        jianjie=[[UILabel alloc]initWithFrame:CGRectMake(90, 58, 150, 20)];
        jianjie.text=@"我是简介,这是一个大家的家";
        jianjie.textColor=[UIColor grayColor];
        jianjie.font=[UIFont systemFontOfSize:10];
        [cell.contentView addSubview:jianjie];
        
        guanzhuLa=[[UILabel alloc]initWithFrame:CGRectMake(90, 75, 100, 20)];
        guanzhuLa.text=@"99999人关注";
        guanzhuLa.textColor=[UIColor grayColor];
        guanzhuLa.font=[UIFont systemFontOfSize:10];
        [cell.contentView addSubview:guanzhuLa];
        
        chakanBt1=[[UIButton alloc]initWithFrame:CGRectMake(300, 35, 65, 25)];
        [chakanBt1 setBackgroundImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
        [chakanBt1 setTitle:@"查看" forState:UIControlStateNormal];
        [chakanBt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [chakanBt1 addTarget:self action:@selector(chakan1Click) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:chakanBt1];
        
        guanzhuBt1=[[UIButton alloc]initWithFrame:CGRectMake(300, 65, 65, 25)];
        [guanzhuBt1 setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
        [guanzhuBt1 setTitle:@"加关注" forState:UIControlStateNormal];
        [guanzhuBt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [guanzhuBt1 addTarget:self action:@selector(guanzhu1Click) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:guanzhuBt1];
        
        UIView * imageview=[[UIView alloc]initWithFrame:CGRectMake(0, 105, 380, 3)];
        imageview.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
        [cell.contentView addSubview:imageview];
        
        
        
    }
    if(section==1){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        
        titleLa=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
        titleLa.text=@"我加入的圈子";
        titleLa.textColor=[UIColor grayColor];
        titleLa.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:titleLa];
        
        touxiangButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 35, 60, 60)];
        [touxiangButton setBackgroundImage:[UIImage imageNamed:@"music_icon1.png"] forState:UIControlStateNormal];
        [cell.contentView addSubview:touxiangButton];
        
        quanmingLa=[[UILabel alloc]initWithFrame:CGRectMake(90, 38, 100, 20)];
        quanmingLa.text=@"日行一善";
        quanmingLa.font=[UIFont systemFontOfSize:16];
        [cell.contentView addSubview:quanmingLa];
        
        jianjie=[[UILabel alloc]initWithFrame:CGRectMake(90, 58, 150, 20)];
        jianjie.text=@"我是简介,这是一个大家的家";
        jianjie.textColor=[UIColor grayColor];
        jianjie.font=[UIFont systemFontOfSize:10];
        [cell.contentView addSubview:jianjie];
        
        guanzhuLa=[[UILabel alloc]initWithFrame:CGRectMake(90, 75, 100, 20)];
        guanzhuLa.text=@"99999人关注";
        guanzhuLa.textColor=[UIColor grayColor];
        guanzhuLa.font=[UIFont systemFontOfSize:10];
        [cell.contentView addSubview:guanzhuLa];
        
        chakanBt2=[[UIButton alloc]initWithFrame:CGRectMake(300, 35, 65, 25)];
        [chakanBt2 setBackgroundImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
        [chakanBt2 setTitle:@"查看" forState:UIControlStateNormal];
        [chakanBt2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [chakanBt2 addTarget:self action:@selector(chakan2Click) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:chakanBt2];
        
        guanzhuBt2=[[UIButton alloc]initWithFrame:CGRectMake(300, 65, 65, 25)];
        [guanzhuBt2 setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
        [guanzhuBt2 setTitle:@"加关注" forState:UIControlStateNormal];
        [guanzhuBt2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [guanzhuBt2 addTarget:self action:@selector(guanzhu2Click) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:guanzhuBt2];
        
        UIView * imageview=[[UIView alloc]initWithFrame:CGRectMake(0, 105, 380, 3)];
        imageview.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
        [cell.contentView addSubview:imageview];
        
        
    }
    
    if(section==2){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        
        titleLa=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
        titleLa.text=@"公共圈子";
        titleLa.textColor=[UIColor grayColor];
        titleLa.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:titleLa];
        
        touxiangButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 35, 60, 60)];
        [touxiangButton setBackgroundImage:[UIImage imageNamed:@"music_icon2.png"] forState:UIControlStateNormal];
        [cell.contentView addSubview:touxiangButton];
        
        quanmingLa=[[UILabel alloc]initWithFrame:CGRectMake(90, 38, 100, 20)];
        quanmingLa.text=@"日日面佛";
        quanmingLa.font=[UIFont systemFontOfSize:16];
        [cell.contentView addSubview:quanmingLa];
        
        UIImageView * huaImage=[[UIImageView alloc]initWithFrame:CGRectMake(170, 38, 10, 19)];
        huaImage.image=[UIImage imageNamed:@"huo.png"];
        [cell.contentView addSubview:huaImage];
        
        jianjie=[[UILabel alloc]initWithFrame:CGRectMake(90, 58, 150, 20)];
        jianjie.text=@"我是简介,这是一个大家的家";
        jianjie.textColor=[UIColor grayColor];
        jianjie.font=[UIFont systemFontOfSize:10];
        [cell.contentView addSubview:jianjie];
        
        guanzhuLa=[[UILabel alloc]initWithFrame:CGRectMake(90, 75, 100, 20)];
        guanzhuLa.text=@"99999人关注";
        guanzhuLa.textColor=[UIColor grayColor];
        guanzhuLa.font=[UIFont systemFontOfSize:10];
        [cell.contentView addSubview:guanzhuLa];
        
        chakanBt3=[[UIButton alloc]initWithFrame:CGRectMake(300, 35, 65, 25)];
        [chakanBt3 setBackgroundImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
        [chakanBt3 setTitle:@"查看" forState:UIControlStateNormal];
        [chakanBt3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [chakanBt3 addTarget:self action:@selector(chakan3Click) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:chakanBt3];
        
        guanzhuBt3=[[UIButton alloc]initWithFrame:CGRectMake(300, 65, 65, 25)];
        [guanzhuBt3 setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
        [guanzhuBt3 setTitle:@"加关注" forState:UIControlStateNormal];
        [guanzhuBt3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [guanzhuBt3 addTarget:self action:@selector(guanzhu3Click) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:guanzhuBt3];
        
        UIImageView * xian=[[UIImageView alloc]initWithFrame:CGRectMake(10, 107, 350, 0.5)];
        xian.image=[UIImage imageNamed:@"line.png"];
        [cell.contentView addSubview:xian];
        
        
    }
    if(section==3){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        touxiangButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 17, 60, 60)];
        [touxiangButton setBackgroundImage:[UIImage imageNamed:@"music_icon3.png"] forState:UIControlStateNormal];
        [cell.contentView addSubview:touxiangButton];
        
        quanmingLa=[[UILabel alloc]initWithFrame:CGRectMake(90, 18, 100, 20)];
        quanmingLa.text=@"广结善缘";
        quanmingLa.font=[UIFont systemFontOfSize:16];
        [cell.contentView addSubview:quanmingLa];
        
        jianjie=[[UILabel alloc]initWithFrame:CGRectMake(90, 40, 150, 20)];
        jianjie.text=@"我是简介,这是一个大家的家";
        jianjie.textColor=[UIColor grayColor];
        jianjie.font=[UIFont systemFontOfSize:10];
        [cell.contentView addSubview:jianjie];
        
        guanzhuLa=[[UILabel alloc]initWithFrame:CGRectMake(90, 60, 100, 20)];
        guanzhuLa.text=@"99999人关注";
        guanzhuLa.textColor=[UIColor grayColor];
        guanzhuLa.font=[UIFont systemFontOfSize:10];
        [cell.contentView addSubview:guanzhuLa];
        
        chakanBt4=[[UIButton alloc]initWithFrame:CGRectMake(300, 20, 65, 25)];
        [chakanBt4 setBackgroundImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
        [chakanBt4 setTitle:@"查看" forState:UIControlStateNormal];
        [chakanBt4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [chakanBt4 addTarget:self action:@selector(chakan4Click) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:chakanBt4];
        
        guanzhuBt4=[[UIButton alloc]initWithFrame:CGRectMake(300, 50, 65, 25)];
        [guanzhuBt4 setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
        [guanzhuBt4 setTitle:@"加关注" forState:UIControlStateNormal];
        [guanzhuBt4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [guanzhuBt4 addTarget:self action:@selector(guanzhu4Click) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:guanzhuBt4];
        
        UIImageView * xian=[[UIImageView alloc]initWithFrame:CGRectMake(5, 95, 360, 0.5)];
        xian.image=[UIImage imageNamed:@"line.png"];
        [cell.contentView addSubview:xian];
        
    }
    if(section==4){
        if(cell == nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        
        touxiangButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 17, 60, 60)];
        [touxiangButton setBackgroundImage:[UIImage imageNamed:@"music_icon3.png"] forState:UIControlStateNormal];
        [cell.contentView addSubview:touxiangButton];
        
        quanmingLa=[[UILabel alloc]initWithFrame:CGRectMake(90, 18, 100, 20)];
        quanmingLa.text=@"祈福祝愿";
        quanmingLa.font=[UIFont systemFontOfSize:16];
        [cell.contentView addSubview:quanmingLa];
        
        jianjie=[[UILabel alloc]initWithFrame:CGRectMake(90, 40, 150, 20)];
        jianjie.text=@"我是简介,这是一个大家的家";
        jianjie.textColor=[UIColor grayColor];
        jianjie.font=[UIFont systemFontOfSize:10];
        [cell.contentView addSubview:jianjie];
        
        guanzhuLa=[[UILabel alloc]initWithFrame:CGRectMake(90, 60, 100, 20)];
        guanzhuLa.text=@"99999人关注";
        guanzhuLa.textColor=[UIColor grayColor];
        guanzhuLa.font=[UIFont systemFontOfSize:10];
        [cell.contentView addSubview:guanzhuLa];
        
        chakanBt5=[[UIButton alloc]initWithFrame:CGRectMake(300, 20, 65, 25)];
        [chakanBt5 setBackgroundImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
        [chakanBt5 setTitle:@"查看" forState:UIControlStateNormal];
        [chakanBt5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [chakanBt5 addTarget:self action:@selector(chakan5Click) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:chakanBt5];
        
        guanzhuBt5=[[UIButton alloc]initWithFrame:CGRectMake(300, 50, 65, 25)];
        [guanzhuBt5 setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
        [guanzhuBt5 setTitle:@"加关注" forState:UIControlStateNormal];
        [guanzhuBt5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [guanzhuBt5 addTarget:self action:@selector(guanzhu5Click) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:guanzhuBt5];
        
        UIImageView * xian=[[UIImageView alloc]initWithFrame:CGRectMake(5, 95, 360, 0.5)];
        xian.image=[UIImage imageNamed:@"line.png"];
        [cell.contentView addSubview:xian];
        
    }
    
    
    return cell;
}
-(void)chakan1Click{
    
        [self.sideMenuViewController
         setContentViewController:[[ChaKanViewController alloc] init]animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    
}
-(void)guanzhu1Click{
    
    if (isClick==YES) {
        [guanzhuBt1 setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
        isClick=NO;
    }else{
       
        [guanzhuBt1 setBackgroundImage:[UIImage imageNamed:@"23.png"] forState:UIControlStateNormal];
        isClick=YES;
    }
}
-(void)guanzhu2Click{
    
    if (isClick==YES) {
        [guanzhuBt2 setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
        isClick=NO;
    }else{
        
        [guanzhuBt2 setBackgroundImage:[UIImage imageNamed:@"23.png"] forState:UIControlStateNormal];
        isClick=YES;
    }
}
-(void)guanzhu3Click{
    
    if (isClick==YES) {
        [guanzhuBt3 setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
        isClick=NO;
    }else{
        
        [guanzhuBt3 setBackgroundImage:[UIImage imageNamed:@"23.png"] forState:UIControlStateNormal];
        isClick=YES;
    }
}
-(void)guanzhu4Click{
    
    if (isClick==YES) {
        [guanzhuBt4 setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
        isClick=NO;
    }else{
        
        [guanzhuBt4 setBackgroundImage:[UIImage imageNamed:@"23.png"] forState:UIControlStateNormal];
        isClick=YES;
    }
}
-(void)guanzhu5Click{
    
    if (isClick==YES) {
        [guanzhuBt5 setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
        isClick=NO;
    }else{
        
        [guanzhuBt5 setBackgroundImage:[UIImage imageNamed:@"23.png"] forState:UIControlStateNormal];
        isClick=YES;
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [tableview endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [seachBt resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
