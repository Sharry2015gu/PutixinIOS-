//
//  AreaViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/29.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "AreaViewController.h"
#import "Area.h"
#import "GDataXMLNode.h"
#import "AddressViewController.h"
#import "CityViewController.h"
#import "HeaderFile.h"
#import "RESideMenu.h"
@interface AreaViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSMutableArray *areaArray;
@property(nonatomic,strong) UITableView *areaTableView;

@end

@implementation AreaViewController

-(NSMutableArray *)areaArray
{
    if (_areaArray == nil) {
        _areaArray = [[NSMutableArray alloc]init];
    }
    return _areaArray;
}
-(UITableView *)areaTableView
{
    if (_areaTableView == nil) {
        _areaTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+40+40,SCREEN_WIDTH, SCREEN_HEIGHT- 64) style:UITableViewStylePlain];
        _areaTableView.delegate = self;
        _areaTableView.dataSource = self;
    }
    return _areaTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.1)];
    view.backgroundColor=majorityColor;
    [self.view addSubview:view];
    
    UIButton * bu=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [bu setBackgroundImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(buclick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:bu];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"所在地地址";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [view addSubview:title];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT*0.1, SCREEN_WIDTH, 40)];
    NSString *selectedProvice=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedProvice"];
    NSLog(@"选中de 省份＝%@",selectedProvice);
    label1.text = selectedProvice;
    [self.view addSubview:label1];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, 0.5)];
    line.backgroundColor=[UIColor colorWithRed:186.0/255.0 green:184.0/255.0 blue:190.0/255.0 alpha:1.0];
    [self.view addSubview:line];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT*0.1+40, SCREEN_WIDTH, 40)];
    NSLog(@"选中de  市＝%@",self.cityName);
    NSString *str =self.cityName;
    label2.text = str;
    [self.view addSubview:label2];
    [self createTableView];
    
}
-(void)buclick{
    
    
}
-(void)createTableView
{
    [self.areaArray addObjectsFromArray:[self loadData]];
    [self.view addSubview:self.areaTableView];
}
-(NSArray *)loadData
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"arrays" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    //创建文档对象
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    NSArray  *eleArray = [doc nodesForXPath:@"resources/string-array" error:nil];
    for(GDataXMLElement *ele in eleArray)
    {
        NSString *provinceTag = [NSString  stringWithFormat:@"city_item_%@",self.cityID];
        GDataXMLNode *attr = [ele attributeForName:@"name"];
        NSString *attrStr = [attr stringValue];
        if ([provinceTag isEqualToString:attrStr]) {
            NSArray  *itemArray = [ele elementsForName:@"item"];
            for(GDataXMLElement *ele1  in itemArray)
            {
                Area *model = [[Area alloc] init];
                NSString *cityInfo = [ele1 stringValue];
                NSArray *stringArray = [cityInfo  componentsSeparatedByString:@"-"];
                model.areaName= [stringArray objectAtIndex:1];
                model.areaId = [stringArray objectAtIndex:0];
                [array addObject:model];
            }
            //            [self.view addSubview:self.areaTableView];
        }
    }
    return array;
}
#pragma mark -UITableViewDelegate方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return   self.areaArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Area *model = self.areaArray[indexPath.row];
    NSString *cellId = @"tableViewId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = model.areaName;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Area *model = self.areaArray[indexPath.row];
    [[NSUserDefaults standardUserDefaults]setValue:model.areaName forKey:@"area"];
    AddressViewController *resultCtrl =[[AddressViewController alloc]init];
    resultCtrl.resultAdressStr = [NSString stringWithFormat:@"%@%@",self.cityName,model.areaName];
    resultCtrl.createVc =   self.createVc ;
    resultCtrl.areaID=model.areaId;
    [self.navigationController pushViewController:resultCtrl animated:YES];
}
@end
