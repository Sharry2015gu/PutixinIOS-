//
//  GuanZhu_FenSiViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/13.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "GuanZhu_FenSiViewController.h"

@interface GuanZhu_FenSiViewController ()

@end

@implementation GuanZhu_FenSiViewController
@synthesize segment_title;
@synthesize refreshControl;
@synthesize useCustomCells;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * viewbg=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 48)];
    viewbg.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:viewbg];

    NSArray *segmentTextContent = [NSArray arrayWithObjects:
                                   @"关注",
                                   @"粉丝",
                                   nil];
    
    self.segment_title = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
    self.segment_title.selectedSegmentIndex = 0;
    self.segment_title.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.segment_title.segmentedControlStyle = UISegmentedControlStyleBar;
    
    self.segment_title.tintColor= [[UIColor alloc]initWithRed:218.0f/255.0f green:163.0f/255.0f blue:36.0f/255.0f alpha:1.0f];
    self.segment_title.frame = CGRectMake(120, 5, 150, 35);
    [self.segment_title addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [viewbg addSubview:segment_title];
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 48, 380, self.view.frame.size.height)];
    [scrollview setBackgroundColor:[UIColor clearColor]];
    [scrollview setPagingEnabled:YES];
    [scrollview setShowsHorizontalScrollIndicator:NO];
    [scrollview setContentSize:CGSizeMake(380, 1200)];
    [scrollview scrollRectToVisible:CGRectMake(0, 0, 380, 200) animated:NO];
    [scrollview setDelegate:self];
    [self.view addSubview:scrollview];
    
    tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 500) style:UITableViewStyleGrouped];;
    tableview.rowHeight = 48;
    tableview.delegate=self;
    tableview.dataSource=self;
    [scrollview addSubview:tableview];
    
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

    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(toggleCells:) forControlEvents:UIControlEventValueChanged];
    refreshControl.tintColor = [UIColor blueColor];
    
    self.refreshControl = refreshControl;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
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

- (void)segmentAction:(UISegmentedControl *)paramSender
{
    NSInteger Index = paramSender.selectedSegmentIndex;
//    NSLog(@"Index %i", Index);
    switch (Index) {
        case 0:{
        
            tableview.hidden=NO;
            fensiview.view.hidden=YES;
        }
            break;
        case 1:{
            tableview.hidden=YES;
            
            mDockMenuBackView_SuiXi = [[DockMenuSubView alloc]initWithFrame:CGRectMake(0, 308, mScrollDockMenuView.frame.size.width, 560)];
            [scrollview addSubview:mDockMenuBackView_SuiXi];
            
            fensiview = [[FenSi_MyViewController alloc] init];
            [self addChildViewController:fensiview];
            [scrollview addSubview:fensiview.view];
            fensiview.view.frame = self.view.bounds;
            fensiview.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            
            CGRect rect= mDockMenuBackView_SuiXi.frame;
            rect.size.height = fensiview.view.frame.origin.y+fensiview.view.frame.size.height+10;
            [mDockMenuBackView_SuiXi setFrame:rect];
            [scrollview addSubview:fensiview.view];
            [mDockMenuBackView_SuiXi setHidden:YES];

        }
            break;
        case 2:{
           
            tableview.hidden=NO;
        }
            break;
        default:
            break;
    }
    
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
