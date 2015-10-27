//
//  MusicOnlineViewController.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/10/6.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "MusicOnlineViewController.h"
#import "HMSegmentedControl.h"
#import "HeaderFile.h"
#import "WisdomModel.h"
#import "OnlineMusicTableViewCell.h"
#import "SearchBookOrMusicViewController.h"
@interface MusicOnlineViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int flag1;
    int flag2;
    NSInteger classicBookPage;
    NSInteger goodBookPage;
    
}
@property(nonatomic,strong)HMSegmentedControl * segmentControl;
@property(nonatomic,strong)UIScrollView  * scrollView;
@property(nonatomic,strong)UITableView   * classicMusicTableView;
@property(nonatomic,strong)UITableView   *  confuctionMusicTableView;
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)NSMutableArray  *  classicArray;
@property(nonatomic,strong)NSMutableArray  *  confuctionArray;
@property(nonatomic,strong)UIImageView * backgroundImage;

@end

@implementation MusicOnlineViewController
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
        _classicArray  =  [[NSMutableArray  alloc] init];
    }
    return _classicArray;
}
-(NSMutableArray *) confuctionArray
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
        //[_scrollView addSubview:self.classicMusicTableView];
        //[_scrollView addSubview:self.confuctionMusicTableView];
        //_scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2,0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}
-(UITableView *)classicMusicTableView
{
    if (_classicMusicTableView == nil) {
        _classicMusicTableView =  [[UITableView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT - 55 - 50 - NAVBARHEIGHT)];
        _classicMusicTableView.tag = 200;
        _classicMusicTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _classicMusicTableView.showsHorizontalScrollIndicator=NO;
        _classicMusicTableView.showsVerticalScrollIndicator=NO;
        _classicMusicTableView.delegate = self;
        _classicMusicTableView.dataSource = self;
        WS(weakself);
        [_classicMusicTableView addHeaderWithCallback:^{
            [weakself getBookShelfInfoWithCategory:6 isRefresh:YES];
        }];
        [_classicMusicTableView addFooterWithCallback:^{
            [weakself getBookShelfInfoWithCategory:6 isRefresh:NO];
        }];
        
        //        [_classicMusicTableView addHeaderWithCallback:^{
        //            [weakself getBookShelfInfoWithCategory:[[NSNumber numberWithInteger:1]integerValue] isRefresh:YES];
        //        }];
        //        [_classicMusicTableView addFooterWithCallback:^{
        //            [weakself getBookShelfInfoWithCategory:[[NSNumber numberWithInteger:1]integerValue] isRefresh:NO];
        //        }];
        
    }
    return _classicMusicTableView;
}
-(UITableView  *)confuctionMusicTableView
{
    if (_confuctionMusicTableView == nil) {
        _confuctionMusicTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH ,0, SCREEN_WIDTH, SCREEN_HEIGHT - 55 - 50 - NAVBARHEIGHT)];
        _confuctionMusicTableView.tag = 201;
        _confuctionMusicTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _confuctionMusicTableView.showsVerticalScrollIndicator=NO;
        _confuctionMusicTableView.showsHorizontalScrollIndicator=NO;
        _confuctionMusicTableView.dataSource = self;
        _confuctionMusicTableView.delegate = self;
        //        WS(weakself);
        //        [_confuctionMusicTableView addHeaderWithCallback:^{
        //            [weakself getBookShelfInfoWithCategory:@2 isRefresh:YES];
        //        }];
        //        [_confuctionMusicTableView addFooterWithCallback:^{
        //            [weakself getBookShelfInfoWithCategory:@2 isRefresh:NO];
        //        }];
        
    }
    return _confuctionMusicTableView;
}
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
#pragma mark 关于初始化  为了就算不viewDidLoad 也要调用播放的功能
-(instancetype)init
{
    if (self = [super init]) {
        [self createNavBar];
        [self.view addSubview:self.scrollView];
        flag1 = 0;
        flag2 = 0;
        [self.view addSubview:self.segmentControl];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mrak ----- 申请网络数据请求

-(void)getBookShelfInfoWithCategory:(NSInteger) category isRefresh:(BOOL) isRefresh

{
    NSInteger page;
    if (category  == 1) {
        if (isRefresh) {
            classicBookPage = 0 ;
        }
        else
        {
            classicBookPage ++;
        }
        page = classicBookPage;
    }
    else
    {
        if (isRefresh) {
            goodBookPage = 0 ;
        }
        else
        {
            goodBookPage ++;
        }
        page = goodBookPage;
    }
    NSLog(@"page====%ld",page);
    [ProgressHUD showOnView:self.view];
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * miyaoNum = [appdelegate.accountBasicDict objectForKey:@"secretKey"];
    NSNumber * huaien = [appdelegate.accountBasicDict objectForKey:@"huaienID"];
    NSDictionary * dic =@{@"secretKey":miyaoNum,@"huaienID":huaien,@"category":[NSNumber numberWithInteger:category],@"bookType":@2};
    NSDictionary * bookDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,ClassicURL] parameters:bookDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [_classicMusicTableView headerEndRefreshing];
        [_classicMusicTableView footerEndRefreshing];
        
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"jsonData=%@",jsonData);
        NSArray * bookArray = jsonData[@"data"];
        
        //        NSInteger integer = [category integerValue];
        //        NSInteger inte=integer-6;
        NSInteger index = category - 6;
        NSArray *dataArray1 = self.dataArray;
        NSLog(@"index=%ld",index);
        NSLog(@"dataArray1=%@",dataArray1);
        
        NSMutableArray *array = self.dataArray[category - 6];
        NSLog(@"&&&&&=%@",@"要有这个对象");
        for (int i = 0; i<bookArray.count; i++) {
            NSDictionary * arrdic =bookArray[i];
            WisdomModel * model = [[WisdomModel alloc]init];
            [model setValuesForKeysWithDictionary:arrdic];
            if (category == 6) {
                model.category = 6;
                //isDownLoad  = 0 :表示未下载或者已经下载 具体看 持久化中有没有数据
                // 1 表示正在下载中 但是设置为1是要在点击下载后 等到下载完成把值改为0
                NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithDictionary:@{@"model":model,@"isDownLoad":@0}];
                [array addObject:dict];
            }
            else
            {
                NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithDictionary:@{@"model":model,@"isDownLoad":@0}];
                model.category = 7 ;
                [array addObject:dict];
            }
        }
        if (category  == 6)
        {
            flag1 = 1;
            [self.scrollView addSubview:self.classicMusicTableView];
            [self.classicMusicTableView headerEndRefreshing];
            [self.classicMusicTableView  footerEndRefreshing];
            
        }
        else
        {
            flag2 = 1;
            [self.scrollView addSubview:self.confuctionMusicTableView];
            [self.confuctionMusicTableView headerEndRefreshing];
            [self.confuctionMusicTableView  footerEndRefreshing];
            
        }
        if (flag2&&flag1)
        {
            
            [ProgressHUD hideAfterSuccessOnView:self.view];
            //[self.view addSubview:self.scrollView];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark ----UItableView的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat height ;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        height =  150;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            height = 95;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            height = 100;
        }
        else
        {
            height  = 100;
        }
    }
    
    if (indexPath.row == 0) return height;
    return 58;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray  * array  = self.dataArray[tableView.tag - 200];
    return array.count;
    //    if (tableView == self.classicMusicTableView)
    //    {
    //        return self.classicArray.count + 1;
    //    }
    //    else
    //    {
    //        return self.confuctionArray.count + 1;
    //    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        CGFloat height ;
        if (fabs(SCREEN_HEIGHT-667) < 1) {
            height =  150;
        }
        else
        {
            if (fabs(SCREEN_HEIGHT -568) < 1) {
                height = 95;
            }
            else if (fabs(SCREEN_HEIGHT - 736) < 1)
            {
                height = 100;
            }
            else
            {
                height  = 100;
                
            }
        }
        static NSString *identifier_ = @"cell_";
        UITableViewCell *cell_ = [tableView dequeueReusableCellWithIdentifier:identifier_];
        if (cell_ == nil) {
            
            cell_ = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_] ;
            _backgroundImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
            _backgroundImage.image=[UIImage imageNamed:@"classical_music_bg.jpg"];
            [cell_.contentView addSubview:_backgroundImage];
            
        }
        cell_.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell_;
        
    }
    WisdomModel * model;
    if (tableView == self.classicMusicTableView) {
        model = self.classicArray[indexPath.row - 1];
    }
    else
    {
        model = self.confuctionArray[indexPath.row - 1];
    }
    
    NSMutableArray  * array  = self.dataArray[tableView.tag - 200];
    NSMutableDictionary  * dict = array[indexPath.row];
    NSString * cellID  = @"MusicCellID";
    OnlineMusicTableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[OnlineMusicTableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setMusicInfoDictionary:dict];
    cell.block =  ^void(WisdomModel * model)
    {
        //做开始下载的处理
        [self downLoadFileWithModel:model WithIndexPath:indexPath];
    };
    cell.hintBlock = ^void(WisdomModel * model)
    {
        [self showHintHasDownLoadWithModel:model];
    };
    return cell;
}
//下载歌词及歌曲
//用于歌词和歌曲都下载完的标记
int flagDownLoadMusic1 = 0 ;
int flagDownLoadLysic1 = 0 ;
-(void)downLoadFileWithModel:(WisdomModel * )model WithIndexPath:(NSIndexPath *) indexPath
{
    NSString  *url1 =  [model.downloadUrl_r stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [NetWorking sendAsynchronousRequestWithURLString:url1 completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError == nil) {
            flagDownLoadMusic1 = 1;
            [self selectAllFileWith:model WithData:data Islyrics:NO];
            [self showHintLabelWithModel:model WithIndexPath:indexPath];
        }
    }];
    NSString  *url2  = [model.downloadUrl_w stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [NetWorking sendAsynchronousRequestWithURLString:url2 completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError == nil) {
            flagDownLoadLysic1 = 1;
            [self selectAllFileWith:model WithData:data Islyrics:YES];
            [self showHintLabelWithModel:model WithIndexPath:indexPath];
        }
    }];
}
#pragma mark ----用于显示已经下载完
-(void)showHintLabelWithModel:(WisdomModel *) model WithIndexPath:(NSIndexPath *) indexPath
{
    if (flagDownLoadLysic1 && flagDownLoadMusic1) {
        flagDownLoadLysic1  = 0 ;
        flagDownLoadMusic1  = 0 ;
        [self storeSongWithModel:model];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200) / 2, SCREEN_HEIGHT*0.78, 200, 30)];
        label.text = [NSString stringWithFormat:@"%@已经下载完",model.title];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.backgroundColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:12];
        [self.view addSubview:label];
        [UIView animateWithDuration:1.5 animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
            //下载完后 按钮要变成下载完的样子 并且对应字典要改变 且对应的cell要刷新 不再显示正在刷新中
            if (model.category == 6) {
                NSMutableDictionary  * dict = self.classicArray[indexPath.row];
                [dict setObject:@0 forKey:@"isDownLoad"];
                [self.classicMusicTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
            }
            else
            {
                NSMutableDictionary  * dict = self.confuctionArray[indexPath.row];
                [dict setObject:@0 forKey:@"isDownLoad"];
                [self.confuctionMusicTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
            }
        }];
    }
}
#pragma mark ----提示已经下载过了
-(void)showHintHasDownLoadWithModel:(WisdomModel *) model
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200) / 2, SCREEN_HEIGHT*0.78, 200, 30)];
    label.text = [NSString stringWithFormat:@"%@已经下载过了",model.title];
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
#pragma mark ------在Document里创建文件
-(void)selectAllFileWith:(WisdomModel *) model1 WithData:(NSData *)data Islyrics:(BOOL)lyrics
{
    NSString *flagStr;
    if (lyrics) {
        flagStr  = @"lrc";
    }
    else
    {
        flagStr  = @"mp3";
    }
    NSString *txtName = [NSString stringWithFormat:@"%@.%@",model1.title,flagStr];
    //用户持久化中存入歌词以及歌曲
    NSArray  * lrcOrMp3Array = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Array",flagStr]];
    NSMutableArray * lrcOrMp3MutableArray = [[NSMutableArray alloc] initWithArray:lrcOrMp3Array];
    NSString  *lrcArrayStr  = [NSString stringWithFormat:@"%@",lrcOrMp3MutableArray];
    if ([lrcArrayStr isEqualToString:@"(null)"]) {
        NSMutableArray * lrcOrMp3MutableArray = [[NSMutableArray alloc] init];
        NSDictionary * dict1 =  @{txtName:data};
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithDictionary:dict1];
        [lrcOrMp3MutableArray  addObject:dict];
        [[NSUserDefaults standardUserDefaults] setObject:lrcOrMp3Array forKey:[NSString stringWithFormat:@"%@Array",flagStr]];
    }
    else
    {
        NSDictionary * dict1 =  @{txtName:data};
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithDictionary:dict1];
        [lrcOrMp3MutableArray  addObject:dict];
        [[NSUserDefaults standardUserDefaults] setObject:lrcOrMp3MutableArray forKey:[NSString stringWithFormat:@"%@Array",flagStr]];
    }
}
//存入歌词与歌曲都存好的歌对象
-(void)storeSongWithModel:(WisdomModel *) model
{
    NSArray * musicArray = [[NSUserDefaults standardUserDefaults] objectForKey:StoreMusic];
    NSMutableArray *  musicMutableArray = [[NSMutableArray alloc] initWithArray:musicArray];
    NSString * muiscArrayStr = [NSString stringWithFormat:@"%@",musicArray];
    if ( [muiscArrayStr isEqualToString:@"(null)"]) {
        NSMutableArray  *  musicArray = [[NSMutableArray alloc]init];
        NSMutableDictionary * dict  = [[NSMutableDictionary alloc]initWithDictionary: @{MusicType:[NSNumber numberWithInteger:model.category],MusicName:model.title,MusicWordClicks:[NSNumber numberWithInteger:model.clicks],MusicWordTotal:[NSNumber numberWithInteger:model.wordTotal]}];
        [musicMutableArray addObject:dict];
        [[NSUserDefaults standardUserDefaults] setObject:musicArray forKey:StoreMusic];
    }
    else
    {
        NSMutableDictionary * dict  = [[NSMutableDictionary alloc]initWithDictionary: @{MusicType:[NSNumber numberWithInteger:model.category],MusicName:model.title,MusicWordClicks:[NSNumber numberWithInteger:model.clicks],MusicWordTotal:[NSNumber numberWithInteger:model.wordTotal]}];
        [musicMutableArray addObject:dict];
        [[NSUserDefaults standardUserDefaults] setObject:musicMutableArray forKey:StoreMusic];
    }
}
@end