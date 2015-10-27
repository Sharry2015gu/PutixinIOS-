
//
//  LocalMusicViewController.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/4.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "LocalMusicViewController.h"
#import "HMSegmentedControl.h"
#import "HeaderFile.h"
#import "MusicTableViewCell.h"
#import "WisdomModel.h"
#import "SearchBookOrMusicViewController.h"
@interface LocalMusicViewController()<UITableViewDataSource,UITableViewDelegate>
{
    MusicTableViewCell  *selectCell;
    MusicTableViewCell  *lastCell;
}
@property(nonatomic,strong)NSMutableArray  *classicArray;
@property(nonatomic,strong)NSMutableArray  *confuctionArray;
@property(nonatomic,strong)NSMutableArray  *flagArray;
@property(nonatomic,strong)HMSegmentedControl  *segmentControl;
@property(nonatomic,strong)UIScrollView  *scrollView;
@property(nonatomic,strong)UITableView *classicMusicTableView;
@property(nonatomic,strong)UITableView *confuctionMusicTableView;
@property(nonatomic,strong)NSArray  *dataArray;
@property(nonatomic,strong)UILabel *tintLabel;
@end
@implementation LocalMusicViewController
#pragma mark -------------------初始化
-(NSMutableArray *)flagArray
{
    if (_flagArray == nil) {
        _flagArray = [[NSMutableArray alloc] init];
    }
    return _flagArray;
}
-(UILabel *)tintLabel
{
    if (_tintLabel == nil) {
        _tintLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,NAVBARHEIGHT + 50, SCREEN_WIDTH,30)];
        _tintLabel.text = @"本地暂无音乐，请去在线音乐添加";
    }
    return _tintLabel;
}
-(NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSArray alloc] initWithObjects:self.classicArray,self.confuctionArray,nil];
    }
    return _dataArray;
}
-(NSMutableArray *)classicArray
{
    if (_classicArray == nil) {
        _classicArray = [[NSMutableArray alloc] init];
    }
    return _classicArray;
}
-(NSMutableArray *)confuctionArray
{
    if (_confuctionArray == nil) {
        _confuctionArray = [[NSMutableArray alloc] init];
    }
    return _confuctionArray;
}
-(HMSegmentedControl *)segmentControl
{
    if (_segmentControl == nil) {
        _segmentControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0,NAVBARHEIGHT,SCREEN_WIDTH, 50)];
        [_segmentControl  setSectionTitles:@[@"经典",@"诵经"]];
        [_segmentControl  setSelectedSegmentIndex:0];
        [_segmentControl  setBackgroundColor:[UIColor whiteColor]];
        [_segmentControl  setTextColor:[UIColor blackColor]];
        [_segmentControl  setSelectedTextColor:majorityColor];
        [_segmentControl  setSelectionStyle:HMSegmentedControlSelectionStyleBox];
        [_segmentControl  setSelectionIndicatorColor:majorityColor];
        [_segmentControl setSelectionIndicatorLocation:HMSegmentedControlSelectionIndicatorLocationDown];
        _segmentControl.scrollEnabled = YES;
        [_segmentControl setTag:2];
        WS(weakSelf);
        [_segmentControl setIndexChangeBlock:^(NSInteger index) {
            weakSelf.scrollView.contentOffset = CGPointMake(index * SCREEN_WIDTH,0);
            
        }];
    }
    return _segmentControl;
}
-(UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVBARHEIGHT+ 50,SCREEN_WIDTH,SCREEN_HEIGHT - 50 - 55)];
        //_scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2,0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}
-(UITableView *)classicMusicTableView
{
    if (_classicMusicTableView == nil) {
        _classicMusicTableView =  [[UITableView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT * 0.75)];
        _classicMusicTableView.tag = 200;
        _classicMusicTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _classicMusicTableView.showsHorizontalScrollIndicator=NO;
        _classicMusicTableView.showsVerticalScrollIndicator=NO;
        _classicMusicTableView.delegate = self;
        _classicMusicTableView.dataSource = self;
    }
    return _classicMusicTableView;
}
-(UITableView  *)confuctionMusicTableView
{
    if (_confuctionMusicTableView == nil) {
        _confuctionMusicTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH ,0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.75)];
        _confuctionMusicTableView.tag = 201;
        _confuctionMusicTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _confuctionMusicTableView.showsVerticalScrollIndicator=NO;
        _confuctionMusicTableView.showsHorizontalScrollIndicator=NO;
        _confuctionMusicTableView.dataSource = self;
        _confuctionMusicTableView.delegate = self;
    }
    return _confuctionMusicTableView;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self createNavBar];
    [self.view addSubview:self.segmentControl];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    //[self loadLocalMusicList];
}
#pragma mark  ----当页面显示时重新刷一次数据
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.tintLabel removeFromSuperview];
    [self.scrollView removeFromSuperview];
    [self loadLocalMusicList];
}
#pragma mark  ---关于UI
-(void)createNavBar
{
    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NAVBARHEIGHT)];
    [navBar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    UINavigationItem *titleItem = [[UINavigationItem alloc]initWithTitle:@"妙音法洗"];
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
    
    UIButton * seachBt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.8, 0.05*SCREEN_HEIGHT, 0.085*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [seachBt setBackgroundImage:[UIImage imageNamed:@"search_music"] forState:UIControlStateNormal];
    [seachBt addTarget:self action:@selector(seachClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem =[[UIBarButtonItem alloc]initWithCustomView:seachBt];
    [titleItem setRightBarButtonItem:rightItem];
    
    [self.view addSubview:navBar];
}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)seachClick{
    SearchBookOrMusicViewController  * search = [[SearchBookOrMusicViewController alloc]init];
    search.searchType = YES;
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark  ------关于加载数据
-(void)loadLocalMusicList
{
    [self.classicArray removeAllObjects];
    [self.confuctionArray removeAllObjects];
    //归档路径
    /*
     NSString *filePath  = [NSHomeDirectory() stringByAppendingPathComponent:WisdomModelArchiver];
     NSLog(@"---%@---",filePath);
     NSMutableArray  *modelArray = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
     NSString * archievrStr =  [NSString stringWithFormat:@"%@",modelArray];
     //如果没有本地的  那么先实例可变数组
     if ([archievrStr isEqualToString:@"(null)"]) {
     modelArray = [[NSMutableArray alloc] init];
     }
     [modelArray addObject:model];
     BOOL success = [NSKeyedArchiver archiveRootObject:modelArray toFile:filePath];
     if (success) {
     NSLog(@"保存成功");
     }
     ///var/mobile/Containers/Data/Application/15E0F0E8-A65E-4D7A-8483-B3E549B09F7E/WisdomModel2.archiver
     //
     */
    //    NSString *filePath  = [NSHomeDirectory() stringByAppendingPathComponent:WisdomModelArchiver];
    //    NSMutableArray  *modelArray = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    //    NSString * archievrStr = [NSString stringWithFormat:@"%@",modelArray];
    //    //如果没有本地的  那么先实例可变数组
    //    if ([archievrStr isEqualToString:@"(null)"]) {
    //        [self.view addSubview:self.tintLabel];
    //    }
    //    else
    //    {
    //        for(int i = 0 ; i < modelArray.count ; i++)
    //        {
    //            WisdomModel *model = modelArray[i];
    //            [self.flagArray addObject:model];
    //            if (model.category == 6) {
    //                [self.classicArray addObject:model];
    //            }
    //            else
    //            {
    //                [self.confuctionArray addObject:model];
    //            }
    //        }
    //         [self.view addSubview:self.scrollView];
    //    }
    NSMutableArray * musicArray = [[NSUserDefaults standardUserDefaults] objectForKey:StoreMusic];
    NSString * muiscArrayStr = [NSString stringWithFormat:@"%@",musicArray];
    if ( [muiscArrayStr isEqualToString:@"(null)"]) {
        [self.view addSubview:self.tintLabel];
    }
    else
    {
        for(int i = 0 ; i < musicArray.count ; i++)
        {
            NSDictionary * modelDict = musicArray[i];
            [self.flagArray addObject:modelDict];
            NSNumber  * typeNumber =  [modelDict  objectForKey:MusicType];
            if ( [typeNumber integerValue]  == 6) {
                NSMutableDictionary * playDict = [[NSMutableDictionary alloc] initWithDictionary:modelDict];
                //0 默认都没有播放
                [playDict setObject:@0 forKey:@"IsPlaying"];
                [self.classicArray addObject:modelDict];
                
            }
            else
            {
                NSMutableDictionary *playDict = [[NSMutableDictionary alloc] initWithDictionary:modelDict];
                [playDict setObject:@0 forKey:@"IsPlaying"];
                [self.confuctionArray addObject:modelDict];
            }
        }
        [self.view addSubview:self.scrollView];
        [self.scrollView addSubview:self.classicMusicTableView];
        [self.scrollView addSubview:self.confuctionMusicTableView];
    }
}
#pragma mark------ UITableView的代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray  * array = self.dataArray[tableView.tag - 200];
    NSMutableDictionary *modelDict  =  array[indexPath.row];
    NSString *cellID = @"MusicCellID";
    MusicTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell  = [[MusicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __weak MusicTableViewCell *weakCell = cell;
    cell.block = ^void(NSMutableDictionary * dict)
    {
        NSLog(@"yudgiuj");
        lastCell = selectCell;
        selectCell = weakCell;
        [self changeSelectBtnAndPlayMusicWithDict:dict];
    };
       NSLog(@"------");
    [cell setMusicPlayDict:modelDict];
    return cell;
}
#pragma mark ----改变播放的音乐 以及选择的cell 要设置不一样的按钮  播放时按钮是红色的 在播放时被点击要提示正在播放 播放完后按钮变黄 选择的cell也没了
-(void)changeSelectBtnAndPlayMusicWithDict:(NSMutableDictionary *) dict
{
    if (selectCell.downButton == lastCell.downButton) {
        
    }
    else
    {
        [selectCell.downButton setImage:[UIImage imageNamed:@"music_is_playing_list"] forState:UIControlStateNormal];
        [lastCell.downButton setImage:[UIImage imageNamed:@"music_no_play_list"] forState:UIControlStateNormal];
        NSInteger  modelIndex = [self.flagArray indexOfObject:dict];
        NSDictionary  *dict1 = @{@"musicIndexKey":[NSNumber numberWithInteger:modelIndex]};
         NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithDictionary:dict1];
        //NSNotification *not  = [[NSNotification alloc] initWithName:@"PlayMusicNotification" object:nil userInfo:dict];
        //[[NSNotificationCenter defaultCenter] postNotification:not];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayMusicNotification" object:nil userInfo:dict];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray  * array = self.dataArray[tableView.tag - 200];
    return array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}
@end
