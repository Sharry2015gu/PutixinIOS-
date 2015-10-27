//
//  CityViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/28.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "CityViewController.h"
#import "AreaViewController.h"
#import "ProvinceViewController.h"
#import "AddressViewController.h"
#import "CityModel.h"
#import "GDataXMLNode.h"
#import "Province.h"
#import "HeaderFile.h"
#import "RESideMenu.h"

@interface CityViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSMutableArray *cityArray;
@property(nonatomic,strong) UITableView *cityTableView;

@end

@implementation CityViewController

#pragma mark ----自定义------
-(NSMutableArray *)cityArray
{
    if (_cityArray == nil) {
        _cityArray = [[NSMutableArray alloc]init];
    }
    return _cityArray;
}
-(UITableView *)cityTableView
{
    if (_cityTableView == nil) {
        _cityTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NAVBARHEIGHT + 40,SCREEN_WIDTH, SCREEN_HEIGHT- NAVBARHEIGHT - 40)];
        _cityTableView.delegate = self;
        _cityTableView.dataSource = self;
    }
    return _cityTableView;
}

#pragma mark ----主页面UUI-----
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBar];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0,NAVBARHEIGHT, SCREEN_WIDTH, 40)];
    [[NSUserDefaults standardUserDefaults]setObject:self.provinceName forKey:@"selectedProvice"];
    label1.text = self.provinceName;
    [self.view addSubview:label1];
    [self loadData];
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
-(void)buclick{
    ProvinceViewController * provice = [[ProvinceViewController alloc]init];
    [self.sideMenuViewController setContentViewController:provice  animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}
- (void)loadData
{
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"arrays" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    //创建文档对象
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    NSArray  *eleArray = [doc nodesForXPath:@"resources/string-array" error:nil];
    for(GDataXMLElement *ele in eleArray)
    {
        NSString *provinceTag = [NSString  stringWithFormat:@"province_item_%@",self.provinceId];
        GDataXMLNode *attr = [ele attributeForName:@"name"];
        NSString *attrStr = [attr stringValue];
        if ([provinceTag isEqualToString:attrStr]) {
            NSArray  *itemArray = [ele elementsForName:@"item"];
            for(GDataXMLElement *ele1 in itemArray)
            {
                CityModel *model = [[CityModel alloc] init];
                NSString *cityInfo = [ele1 stringValue];
                NSArray *stringArray = [cityInfo  componentsSeparatedByString:@"-"];
                model.cityName= [stringArray objectAtIndex:1];
                model.cityId = [stringArray objectAtIndex:0];
                [self.cityArray addObject:model];
            }
            [self.view addSubview:self.cityTableView];
        }
    }
}
#pragma mark -UITableViewDelegate方法------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  self.cityArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityModel *model = self.cityArray[indexPath.row];
    NSString *cellId = @"tableViewId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = model.cityName;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityModel *model = self.cityArray[indexPath.row];
    [[NSUserDefaults standardUserDefaults]setValue:model.cityName forKey:@"city"];
    AreaViewController *areaVc = [[AreaViewController alloc]init];
    areaVc.createVc = self.createVc;
    areaVc.cityName= [NSString stringWithFormat:@"%@%@",self.provinceName,model.cityName];
    areaVc.cityID = model.cityId;
    NSArray *array = [areaVc loadData];
    if (array.count == 0) {
        AddressViewController *resultVc =[[AddressViewController alloc]init];
        resultVc.createVc = self.createVc;
        resultVc.resultAdressStr = [NSString stringWithFormat:@"%@%@",self.provinceName,model.cityName];
        [self.navigationController pushViewController:resultVc animated:YES];
    }
    else
    {
        [self.navigationController pushViewController:areaVc animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
