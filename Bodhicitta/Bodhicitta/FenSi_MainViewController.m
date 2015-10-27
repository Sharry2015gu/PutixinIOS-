//
//  FenSi_MainViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/15.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "FenSi_MainViewController.h"

@interface FenSi_MainViewController ()

@end

@implementation FenSi_MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 70)];
    view.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"顶部导航背景"]];
    [self.view addSubview:view];
    //    UIImageView *
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(165, 30, 80, 30)];
    title.text=@"粉丝";
    title.font=[UIFont systemFontOfSize:20];
    title.textColor=[UIColor whiteColor];
    [view addSubview:title];
    
    fanhuiBt=[[UIButton alloc]initWithFrame:CGRectMake(6, 33, 25, 25)];
    [fanhuiBt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [fanhuiBt addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhuiBt];
    
    UIView * background=[[UIView alloc]initWithFrame:CGRectMake(0, 70, 380, self.view.frame.size.height)];
    background.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    [self.view addSubview:background];
    
    searchBt=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 375, 50)];
    searchBt.delegate=self;
    searchBt.placeholder=@"搜索";
    searchBt.backgroundImage=[UIImage imageNamed:@"登录背景"];
    [background addSubview:searchBt];
    
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, 375, 550)];
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    [background addSubview:tableview];
    
    //加载文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
    //从加载的文件新建一个字典
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    //把新建的字典分配给disctionary
    dictionary = dict;
    //把字典里的数组按照字母顺序排序
    NSArray *array = [[dictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
    //分配给list
    list = array;

}

-(void)backclick{
    
    [self.sideMenuViewController
     setContentViewController:[[MyMain_MyViewController alloc] init]animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
}
- (void)viewDidUnload {
    
    list = nil;
    dictionary = nil;
}

#pragma mark Table View Data Source Methods

//在tableview中有多少个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //每个数组都有一个分组
    return [list count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //获取分组
    NSString *key = [list objectAtIndex:section];
    //获取分组里面的数组
    NSArray *array =[dictionary objectForKey:key];
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //索引路径
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    //获取分组
    NSString *key = [list objectAtIndex:section];
    //获取分组里面的数组
    NSArray *array =[dictionary objectForKey:key];
    //建立可重用单元标识
    static NSString *customCell = @"customCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             customCell];
    
    if (cell == nil) {
        //如果没有可重用的单元，我们就从nib里面加载一个，
        cell = [[UITableViewCell alloc]
                
                initWithStyle:UITableViewCellStyleDefault
                
                reuseIdentifier:cell];
    }
    
    UILabel * la=[[UILabel alloc]initWithFrame:CGRectMake(100, 13, 100, 20)];
    //    la.text=@"自由者";
    [cell.contentView addSubview:la];
    la.text = [array objectAtIndex:row];
    UIImageView * im=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    im.image=[UIImage imageNamed:@"头像2"];
    [cell.contentView addSubview:im];
    
    tableview.sectionIndexColor = [UIColor grayColor];
    tableview.sectionIndexBackgroundColor=[UIColor clearColor];
    return cell;
}
//获取分组标题并显示
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key = [list objectAtIndex:section];
    return key;
}
//给tableviewcell添加索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return list;
}
//重新设置一下tableviewcell的行高为70
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
