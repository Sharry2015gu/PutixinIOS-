//
//  ProvinceViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/29.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "ProvinceViewController.h"
#import "GDataXMLNode.h"
#import "Province.h"
#import "CityViewController.h"
#import "HeaderFile.h"
#import "UserInfoEditingViewController.h"

@interface ProvinceViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray  *provinceArray;
@property(nonatomic,strong)UITableView  *provinceTableView;
@end

@implementation ProvinceViewController

#pragma mark -----导航------
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBar];
    [self loadData];
    self.view.backgroundColor = [UIColor whiteColor];
}
-(void)createNavBar
{
    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NAVBARHEIGHT)];
    [navBar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景"] forBarMetrics:UIBarMetricsDefault];
    UINavigationItem *titleItem = [[UINavigationItem alloc]initWithTitle:@"所在地地址"];
    NSDictionary *navTitleArr = [NSDictionary dictionaryWithObjectsAndKeys:
                                 
                                 [UIFont boldSystemFontOfSize:20],UITextAttributeFont,
                                 [UIColor whiteColor],UITextAttributeTextColor ,nil];
    [navBar setTitleTextAttributes:navTitleArr];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(20, 20,30, 25)];
    [leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [titleItem setLeftBarButtonItem:leftItem];
    [navBar pushNavigationItem:titleItem animated:NO];
    [self.view addSubview:navBar];
}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-  (UITableView*)provinceTableView
{
    if (_provinceTableView == nil) {
        _provinceTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NAVBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT- NAVBARHEIGHT) style:UITableViewStylePlain];
        
        _provinceTableView.delegate = self;
        _provinceTableView.dataSource= self;
    }
    return _provinceTableView;
}
-(NSMutableArray *)provinceArray
{
    if (_provinceArray == nil) {
        _provinceArray = [[NSMutableArray alloc]init];
    }
    return _provinceArray;
}
#pragma mark -----主页面数据-----
- (void)loadData
{
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"arrays" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    //创建文档对象
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    NSArray  *eleArray = [doc nodesForXPath:@"resources/string-array" error:nil];
    GDataXMLElement *firstEle = [eleArray objectAtIndex:0];
    NSArray *itemEles = [firstEle elementsForName:@"item"];
    for(GDataXMLElement *ele in itemEles)
    {
        Province *model = [[Province alloc] init];
        NSString *provinceInfo = [ele stringValue];
        NSArray *stringArray = [provinceInfo componentsSeparatedByString:@"-"];
        model.provinceName = [stringArray objectAtIndex:1];
        model.provinceID = [stringArray objectAtIndex:0];
        [self.provinceArray addObject:model];
    }
    
    for(int i = 0 ;  i < self.provinceArray.count;i++)
    {
        Province *model = self.provinceArray[i];
    }
    [self.view addSubview:self.provinceTableView];
}
#pragma mark —-tableView的代理方法-----
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.provinceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Province *model = self.provinceArray[indexPath.row];
    NSString *cellId = @"tableViewId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = model.provinceName;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Province *model = self.provinceArray[indexPath.row];
    [[NSUserDefaults standardUserDefaults] setValue:model.provinceName forKey:@"provice"];
    CityViewController * cityVc =  [[CityViewController alloc]init];
    cityVc.provinceId = model.provinceID;
    cityVc.provinceName = model.provinceName;
    cityVc.createVc = self.createVc;
    [self.navigationController pushViewController:cityVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
