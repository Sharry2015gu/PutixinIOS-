//
//  FenSi_MyViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/13.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "FenSi_MyViewController.h"
#define screenWidth() (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
const static CGFloat kDeleteButtonWidth = 80.f;
const static CGFloat kDeleteButtonHeight = 44.f;



@interface FenSi_MyViewController ()

@end

@implementation FenSi_MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 500) style:UITableViewStyleGrouped];;
    tableview.rowHeight = 48;
    tableview.delegate=self;
    tableview.dataSource=self;
    [self.view addSubview:tableview];
    
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
    
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteButton.frame = CGRectMake(screenWidth(), 0, kDeleteButtonWidth, kDeleteButtonHeight);
    _deleteButton.backgroundColor = [UIColor redColor];
    _deleteButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [_deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
    [_deleteButton addTarget:self action:@selector(deleteItem:) forControlEvents:UIControlEventTouchUpInside];
    [tableview addSubview:_deleteButton];
    
    [tableview setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
}

#pragma mark - Interaciton
- (void)deleteItem:(id)sender {
//    UIButton * deleteButton = (UIButton *)sender;
//    NSIndexPath * indexPath = deleteButton.inputView;
//    
//    [self.dataSource tableView:self commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPath];
    
    _editingIndexPath = nil;
    
    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame = _deleteButton.frame;
        _deleteButton.frame = (CGRect){frame.origin, frame.size.width, 0};
    } completion:^(BOOL finished) {
        CGRect frame = _deleteButton.frame;
        _deleteButton.frame = (CGRect){screenWidth(), frame.origin.y, frame.size.width, kDeleteButtonHeight};
    }];
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
