//
//  MusicViewController.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/6.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "MusicViewController.h"
//#import "WisdomModel.h"
#import "HMSegmentedControl.h"
#import "MiaoYinViewController.h"
@interface MusicViewController()<UITableViewDataSource,UITableViewDelegate>
{
    //0表示顺序播放  1表示单曲循环  2随机播放  默认顺序播放
    NSInteger playStyle;
    BOOL isPlay;
    //BOOL isCircle;
    BOOL musitTableViewHidden;
    //选择播放的音乐下标
    NSInteger musicArrayNumber;
    NSInteger lrcLineNumber;
    UINavigationItem  * myTitleItem;
    //用于防止 刷新数据时  多用一个播放器
    BOOL  isExist;
}
@property(nonatomic,strong)UITableView  *lrcTableView;
@property(nonatomic,strong)UISlider  *slider;
@property(nonatomic,strong)UIButton  *menuBtn;
@property(nonatomic,strong)UIButton  *lastBtn;
@property(nonatomic,strong)UIButton  *playOrStopBtn;
@property(nonatomic,strong)UIButton  *nextBtn;
@property(nonatomic,strong)UIButton  *circleBtn;
@property(nonatomic,strong)NSMutableArray   *classicMusicArray;
@property(nonatomic,strong)NSMutableArray   *confuctionMusicArray;
@property(nonatomic,strong)NSMutableArray   *musicArray;
@property(nonatomic,strong)NSMutableArray  *timeArray;
@property(nonatomic,strong)UITableView *menuTableView1;
@property(nonatomic,strong)UITableView *menuTableView2;
@property(nonatomic,strong)UILabel  *currentTimeLabel;
@property(nonatomic,strong)UILabel  *totalTimeLabel;
@property(nonatomic,strong)NSMutableDictionary *LRCDictionary;
@property(nonatomic,strong)UIView *menuView;
@property(nonatomic,strong)HMSegmentedControl *segmentControl;
@property(nonatomic,strong)UIScrollView  *scrollView;
@property(nonatomic,strong)UIView * setPlayModelView;
@end
@implementation MusicViewController
#pragma mark -----初始化
-(UIView *)setPlayModelView
{
    if (_setPlayModelView == nil) {
        _setPlayModelView = [[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT - 30 * 4, SCREEN_WIDTH, 30 * 4)];
        _setPlayModelView.backgroundColor = [UIColor blackColor];
        NSArray  * titleArray = @[@"顺序播放",@"单曲播放",@"随机播放",@"关闭"];
        for(int i = 0 ; i  < titleArray.count; i++)
        {
            UIButton  *titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,30 * i,SCREEN_WIDTH, 30)];
            titleBtn.tag =  200 + i ;
            [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [titleBtn setTitle:titleArray[i] forState:UIControlStateNormal];
            titleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            titleBtn.backgroundColor = [UIColor blackColor];
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,29.5,SCREEN_WIDTH,0.5)];
            lineView.backgroundColor = [UIColor whiteColor];
            [titleBtn addSubview:lineView];
            [_setPlayModelView addSubview:titleBtn];
        }
    }
    return _setPlayModelView;
}
-(UIView *)menuView
{
    if (_menuView == nil) {
        _menuView = [[UIView alloc] initWithFrame:CGRectMake(0,0.4 * SCREEN_HEIGHT,SCREEN_WIDTH, 0.6 * SCREEN_HEIGHT)];
        _menuView.backgroundColor = [UIColor blackColor];
        [_menuView addSubview:self.segmentControl];
        [_menuView addSubview:self.scrollView];
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0.6 *SCREEN_HEIGHT - 40,SCREEN_WIDTH, 40)];
        [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        closeBtn.titleLabel.textColor = [UIColor whiteColor];
        [closeBtn setBackgroundColor:[UIColor blackColor]];
        closeBtn.titleLabel.font = [UIFont boldSystemFontOfSize: 18];
        [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_menuView addSubview:closeBtn];
    }
    return _menuView;
}
-(HMSegmentedControl *)segmentControl
{
    if (_segmentControl == nil) {
        _segmentControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, 50)];
        [_segmentControl  setSectionTitles:@[@"经典",@"诵经"]];
        [_segmentControl  setSelectedSegmentIndex:0];
        [_segmentControl  setBackgroundColor:[UIColor blackColor]];
        [_segmentControl  setTextColor:[UIColor whiteColor]];
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
-(UITableView *)menuTableView1
{
    if (_menuTableView1  ==  nil) {
        _menuTableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,0.6 * SCREEN_HEIGHT - 50-40) style:UITableViewStylePlain];
        _menuTableView1.backgroundColor = [UIColor blackColor];
        _menuTableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
        _menuTableView1.delegate = self;
        _menuTableView1.dataSource = self;
    }
    return _menuTableView1;
}
-(UITableView *) menuTableView2
{
    if (_menuTableView2 == nil) {
        _menuTableView2 = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH,0,SCREEN_WIDTH, 0.6 * SCREEN_HEIGHT - 50 - 40) style:UITableViewStylePlain];
        _menuTableView2.backgroundColor = [UIColor blackColor];
        _menuTableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
        _menuTableView2.delegate = self;
        _menuTableView2.dataSource = self;
    }
    return _menuTableView2;
}
-(UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50,SCREEN_WIDTH,0.6 * SCREEN_HEIGHT - 40)];
        [_scrollView addSubview:self.menuTableView1];
        [_scrollView addSubview:self.menuTableView2];
    }
    return  _scrollView;
}
-(NSMutableDictionary *)LRCDictionary
{
    if (_LRCDictionary == nil) {
        _LRCDictionary = [[NSMutableDictionary alloc] initWithCapacity:10];
    }
    return _LRCDictionary;
}
-(NSMutableArray *)timeArray
{
    if (_timeArray == nil) {
        _timeArray = [[NSMutableArray alloc] init];
    }
    return _timeArray;
}
-(NSMutableArray *) musicArray
{
    if (_musicArray == nil) {
        _musicArray = [[NSMutableArray alloc] init];
    }
    return _musicArray;
}
-(NSMutableArray *)classicMusicArray
{
    if (_classicMusicArray == nil) {
        _classicMusicArray = [[NSMutableArray alloc] init];
    }
    return _classicMusicArray;
}
-(NSMutableArray *)confuctionMusicArray
{
    if (_confuctionMusicArray == nil) {
        _confuctionMusicArray = [[NSMutableArray alloc]init];
    }
    return _confuctionMusicArray;
}
-(UITableView *)lrcTableView
{
    if (_lrcTableView == nil) {
        _lrcTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVBARHEIGHT, SCREEN_WIDTH,SCREEN_HEIGHT - NAVBARHEIGHT - 85)];
        _lrcTableView.backgroundColor = [UIColor clearColor];
        _lrcTableView.delegate = self;
        _lrcTableView.dataSource = self;
        _lrcTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _lrcTableView;
}
-(instancetype)init
{
    if (self = [super init]) {
        [self  createNavBar];
        [self  createUI];
        isExist = NO;
        [self loadMusicArray];
        isPlay = YES;
        playStyle = 0;
        // isCircle = YES;
        musicArrayNumber = 0 ;
        lrcLineNumber = 0 ;
        self.view.backgroundColor = [UIColor whiteColor];
        //设置监控 每秒刷新一次时间
        [NSTimer scheduledTimerWithTimeInterval:0.1f
                                         target:self
                                       selector:@selector(showTime)
                                       userInfo:nil
                                        repeats:YES];
#pragma mark ------创建通知的监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playMusicWithIndex:) name:@"PlayMusicNotification" object:nil];
        [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(refreshLocalMusicList) name:@"RefreshMLocalMusicNotification" object:nil];
    }
    return self;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    //    [self  createNavBar];
    //    [self  createUI];
    //   // [self loadMusicArray];
    //    isPlay = YES;
    //    playStyle = 0;
    //   // isCircle = YES;
    //    musicArrayNumber = 0 ;
    //    lrcLineNumber = 0 ;
    //    self.view.backgroundColor = [UIColor whiteColor];
    //    //设置监控 每秒刷新一次时间
    //    [NSTimer scheduledTimerWithTimeInterval:0.1f
    //                                     target:self
    //                                   selector:@selector(showTime)
    //                                   userInfo:nil
    //                                    repeats:YES];
    //    #pragma mark ------创建通知的监听
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playMusicWithIndex:) name:@"PlayMusicNotification" object:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self loadMusicArray];
}
#pragma mark ------播放指定的音乐的
-(void)playMusicWithIndex:(NSNotification *) not
{
    NSDictionary  * originalDict = not.userInfo;
    NSMutableDictionary  * userInfo = [[NSMutableDictionary alloc]initWithDictionary:originalDict];
    NSNumber *musicIndex = [userInfo objectForKey:@"musicIndexKey"];
    
    musicArrayNumber = [musicIndex  integerValue];
    [self updatePlayerSetting];
    [self playBtnClick];
}
#pragma mark ------UI界面
-(void)createNavBar
{
    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NAVBARHEIGHT)];
    [navBar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    UINavigationItem *titleItem = [[UINavigationItem alloc]initWithTitle:self.model.title];
    myTitleItem = titleItem;
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
    
    MiaoYinViewController *miaoYinVc = (MiaoYinViewController *)self.tabBarController;
    [miaoYinVc btnSelect:self.selectBtn];
    [miaoYinVc showTabBar];
}
-(void)createUI
{
    UIImageView  *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,NAVBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT - NAVBARHEIGHT - 85)];
    bgImageView.image = [UIImage imageNamed:@"player_main_bg"];
    [self.view addSubview:bgImageView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT - 85,SCREEN_WIDTH,85)];
    view.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:view];
    
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(0,10,SCREEN_WIDTH,20)];
    self.slider.thumbTintColor = [UIColor colorWithRed: 32 / 255.0 green: 210 / 255.0 blue: 59 / 255.0 alpha:1];
    [self.slider  addTarget:self action:@selector(progressChange) forControlEvents:UIControlEventValueChanged];
    self.slider.minimumTrackTintColor = [UIColor colorWithRed: 32 / 255.0 green: 210 / 255.0 blue: 59 / 255.0 alpha:1];
    [self.slider setThumbImage:[UIImage imageNamed:@"进度@2x"] forState:UIControlStateNormal];
    [self.slider setThumbImage:[UIImage imageNamed:@"进度@2x"] forState:UIControlStateHighlighted];
    [view addSubview:self.slider];
    self.currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,CGRectGetMaxY(self.slider.frame),60, 10)];
    self.currentTimeLabel.font = [UIFont systemFontOfSize:10];
    self.currentTimeLabel.text = @"00:00";
    [view addSubview:self.currentTimeLabel];
    
    self.totalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 5 - 20,self.currentTimeLabel.frame.origin.y, 60,10)];
    self.totalTimeLabel.font = [UIFont systemFontOfSize:10];
    self.totalTimeLabel.text = @"00:00";
    [view addSubview:self.totalTimeLabel];
    
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(15,view.frame.size.height - 10 - 40, 40,40)];
    [menuBtn setImage:[UIImage imageNamed:@"music_list_click"] forState:UIControlStateNormal];
    self.menuBtn = menuBtn;
    [self.menuBtn addTarget:self action:@selector(menuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:menuBtn];
    
    UIButton *previousBtn = [[UIButton alloc] initWithFrame:CGRectMake(menuBtn.frame.size.width +menuBtn.frame.origin.x + 10,menuBtn.frame.origin.y,40, 40)];
    [previousBtn addTarget:self action:@selector(previousBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.lastBtn = previousBtn;
    [previousBtn setImage:[UIImage imageNamed:@"preious_music"] forState:UIControlStateNormal];
    [view addSubview:previousBtn];
    
    UIButton *playBtn = [[UIButton alloc] initWithFrame:CGRectMake(view.center.x - 25, previousBtn.frame.origin.y, 50, 50)];
    [playBtn setImage:[UIImage imageNamed:@"playing_music"] forState:UIControlStateNormal];
    self.playOrStopBtn = playBtn;
    [playBtn addTarget:self action:@selector(playBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:playBtn];
    
    UIButton *circleBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40 - 15,playBtn.frame.origin.y, 40, 40)];
    [circleBtn setImage:[UIImage imageNamed:@"list_play_all"] forState:UIControlStateNormal];
    [circleBtn addTarget:self action:@selector(circleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.circleBtn = circleBtn;
    [view addSubview:circleBtn];
    
    UIButton * nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMidX(circleBtn.frame)-15 - 40 - 10, circleBtn.frame.origin.y,40,40)];
    [nextBtn setImage:[UIImage imageNamed:@"next_music"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn = nextBtn;
    [view addSubview:nextBtn];
}
#pragma mark ------ 设置播放模式
-(void)circleBtnClick
{
    [self.view addSubview:self.setPlayModelView];
}
#pragma mark ------歌曲菜单
-(void)menuBtnClick
{
    [self.view addSubview:self.menuView];
}
#pragma mark ------歌曲菜单消失
-(void)closeBtnClick
{
    [self.menuView removeFromSuperview];
}
#pragma mark ------音乐列表
-(void)randomPlay
{
    musicArrayNumber = random() %(self.musicArray.count);
    [self updatePlayerSetting];
}
#pragma mark -------单曲播放
-(void)sigalSongPlay
{
    
    [self updatePlayerSetting];
}
#pragma mark  --------顺序播放
#pragma mark ------前一首歌
-(void)previousBtnClick
{
    if (playStyle == 0) {
        if (musicArrayNumber == 0)
        {
            musicArrayNumber = self.musicArray.count;
        }
        musicArrayNumber -- ;
        [self updatePlayerSetting];
    }
    else
    {
        if (playStyle == 1) {
            [self  sigalSongPlay];
        }
        else
        {
            [self randomPlay];
        }
    }
}

-(void)nextBtnClick
{
    if (playStyle == 0) {
        if (musicArrayNumber == self.musicArray.count - 1)
        {
            musicArrayNumber = - 1;
        }
        musicArrayNumber ++;
        [self updatePlayerSetting];
    }
    else
    {
        if (playStyle == 1) {
            [self  sigalSongPlay];
        }
        else
        {
            [self randomPlay];
        }
    }
}
-(void)loadMusicArray
{
    [_classicMusicArray removeAllObjects];
    [_confuctionMusicArray removeAllObjects];
    NSMutableArray * modelArray = [[NSUserDefaults standardUserDefaults] objectForKey:StoreMusic];
    NSString    *  archievrStr = [NSString stringWithFormat:@"%@",modelArray];
    //如果没有本地的  那么先实例可变数组
    if ([archievrStr isEqualToString:@"(null)"]) {
        
    }
    else
    {
        for(int i = 0 ; i < modelArray.count ; i++)
        {
            NSMutableDictionary *modelDict = modelArray[i];
            if (i == 0 && isExist == NO)
            {
                musicArrayNumber  =  0 ;
                NSString  * title = [modelDict objectForKey:MusicName];
                [myTitleItem setTitle:title];
                [self initLRCWithModel:title];
                [audioPlayer pause];
                audioPlayer = nil;
                audioPlayer = [[AVAudioPlayer alloc] initWithData:[self readMP3FileWithTitle:title] error:nil];
                audioPlayer.volume = 0.8;
                MiaoYinViewController  *  miaoYinVC  = (MiaoYinViewController*) self.tabBarController;
                miaoYinVC.audioPlayer  = audioPlayer;
                [audioPlayer prepareToPlay];
                isExist = YES;
            }
            NSNumber  *number =  [modelDict objectForKey:@"MusicType"];
            if ([number integerValue] == 6) {
                [self.classicMusicArray addObject:modelDict];
            }
            else
            {
                [self.confuctionMusicArray addObject:modelDict];
            }
            [self.menuTableView1 reloadData];
            [self.menuTableView2 reloadData];
        }
        self.musicArray = modelArray;
    }
}
#pragma mark ----读出mp3Data
-(NSData  *)readMP3FileWithTitle:(NSString *) title
{
    NSString *txtName = [NSString stringWithFormat:@"%@.mp3",title];
    NSMutableArray  * lrcOrMp3Array = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Array",@"mp3"]];
    NSString  *lrcArrayStr  = [NSString stringWithFormat:@"%@",lrcOrMp3Array];
    if ([lrcArrayStr isEqualToString:@"(null)"]) {
    }
    else
    {
        for(int i = 0 ;i < lrcOrMp3Array.count; i++)
        {
            NSDictionary  * dict  = lrcOrMp3Array[i];
            NSString * keyStr = [dict allKeys][0];
            if ([keyStr isEqualToString:txtName]) {
                NSData  * data = [dict objectForKey:keyStr];
                return data;
            }
        }
    }
    return nil;
}
#pragma mark  ------读出Document中的文件取出歌词
-(NSString *)readFileWith:(NSString  * ) title
{
    NSString *txtName = [NSString stringWithFormat:@"%@.lrc",title];
    NSMutableArray  * lrcOrMp3Array = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Array",@"lrc"]];
    NSString  *lrcArrayStr  = [NSString stringWithFormat:@"%@",lrcOrMp3Array];
    if ([lrcArrayStr isEqualToString:@"(null)"]) {
    }
    else
    {
        for(int i = 0 ;i < lrcOrMp3Array.count; i++)
        {
            NSDictionary  * dict  = lrcOrMp3Array[i];
            NSString * keyStr = [dict allKeys][0];
            if ([keyStr isEqualToString:txtName]) {
                NSData  * data = [dict objectForKey:keyStr];
                NSString  * dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                return   [self returnStandardWithString:dataStr];
            }
        }
    }
    return @"";
}
#pragma mark --------返回标准的LRC文件
-(NSString *)returnStandardWithString:(NSString *) str
{
    NSString  *resultStr = @"";
    NSArray *lineArray = [str componentsSeparatedByString:@"\n"];
    NSMutableArray  *tempMutableArray = [[NSMutableArray alloc] init];
    for(int  i = 0 ; i < lineArray.count ; i++)
    {
        NSString *lineStr = lineArray[i];
        NSArray  *tempArray = [lineStr componentsSeparatedByString:@"]"];
        for(int j = 0; j < tempArray.count - 1;j++)
        {
            NSString  *timeStr = tempArray[j];
            NSString *lrcStr  = [tempArray lastObject];
            timeStr = [timeStr stringByAppendingString:[NSString stringWithFormat:@"]%@\n",lrcStr]];
            [tempMutableArray addObject:timeStr];
        }
    }
    //开始进行排序
    for(int  i = 0 ; i < tempMutableArray.count - 1; i++)
    {
        for(int  j =  i + 1 ; j < tempMutableArray.count; j++)
        {
            NSString  * str1 = tempMutableArray[i];
            NSString  *str11 = [str1 componentsSeparatedByString:@"]"][0];
            NSString  * str2 = tempMutableArray[j];
            NSString  *str22 = [str2 componentsSeparatedByString:@"]"][0];
            if ([str11 compare:str22] >  0 ) {
                [tempMutableArray exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    for(int i = 0 ;i < tempMutableArray.count ; i++)
    {
        NSString * str1 = tempMutableArray[i];
        resultStr = [NSString stringWithFormat:@"%@\n%@",resultStr,str1];
    }
    return resultStr;
}
#pragma mark -------得到歌词
-(void)initLRCWithModel:(NSString *) title
{
    [self.LRCDictionary removeAllObjects];
    [self.timeArray removeAllObjects];
    NSString  *contentStr = [self readFileWith:title];
    NSArray *array = [contentStr componentsSeparatedByString:@"\n"];
    for (int i = 0; i < [array count]; i++) {
        NSString *linStr = [array objectAtIndex:i];
        NSArray *lineArray = [linStr componentsSeparatedByString:@"]"];
        if ([lineArray[0] length] > 8) {
            NSString *str1 = [linStr substringWithRange:NSMakeRange(3, 1)];
            NSString *str2 = [linStr substringWithRange:NSMakeRange(6, 1)];
            if ([str1 isEqualToString:@":"] && [str2 isEqualToString:@"."]) {
                NSString *lrcStr = [lineArray objectAtIndex:1];
                NSString *timeStr = [[lineArray objectAtIndex:0] substringWithRange:NSMakeRange(1, 5)];//分割区间求歌词时间
                [self.LRCDictionary setObject:lrcStr forKey:timeStr];
                [self.timeArray addObject:timeStr];//timeArray的count就是行数
            }
        }
    }
    [self.view addSubview:self.lrcTableView];
}
#pragma mark -----读出mp3文件
//-(NSString *)readMP3FileSourceWith:(NSString  *) title
//{
//    NSLog(@"读mp3");
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"Music"];
//    [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
//    NSString *txtName = [NSString stringWithFormat:@"%@.mp3",title];
//    NSString *txtPath = [testDirectory stringByAppendingPathComponent:txtName];
//    return  txtPath;
//}
#pragma mark  ---表视图
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.lrcTableView) {
        return  self.timeArray.count;
    }
    else
    {
        if (tableView == self.menuTableView1) {
            return self.classicMusicArray.count;
        }
        else
        {
            return self.confuctionMusicArray.count;
        }
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.lrcTableView) {
        static  NSString *cellId = @"cellID";
        UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        if (indexPath.row == lrcLineNumber) {
            //NSLog(@"hahaha%@",self.LRCDictionary[self.timeArray[indexPath.row]]);
            cell.textLabel.text = self.LRCDictionary[self.timeArray[indexPath.row]];
            cell.textLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"顶部导航背景.png"]];
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        } else {
            cell.textLabel.text = self.LRCDictionary[self.timeArray[indexPath.row]];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:13];
        }
        cell.textLabel.backgroundColor = [UIColor clearColor];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        return cell;
        
    }
    else
    {
        NSString *cellId  = @"cellID";
        NSMutableDictionary * modelDict;
        if (tableView == self.menuTableView1)
        {
            modelDict = self.classicMusicArray[indexPath.row];
        }
        else
        {
            modelDict = self.confuctionMusicArray[indexPath.row];
        }
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor blackColor];
        cell.textLabel.text = [modelDict objectForKey:@"MusicName"];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary * modelDict;
    if (tableView == self.menuTableView1) {
        modelDict =  self.classicMusicArray[indexPath.row];
        musicArrayNumber = [self.musicArray indexOfObject:modelDict];
        [self updatePlayerSetting];
        [self.menuView removeFromSuperview];
        [self.playOrStopBtn setImage:[UIImage imageNamed:@"stopping_music"] forState:UIControlStateNormal];
    }
    if (tableView == self.menuTableView2) {
        modelDict = self.confuctionMusicArray[indexPath.row];
        musicArrayNumber = [self.musicArray indexOfObject:modelDict];
        [self updatePlayerSetting];
        [self.menuView removeFromSuperview];
        [self.playOrStopBtn setImage:[UIImage imageNamed:@"stopping_music"] forState:UIControlStateNormal];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
-(void)titleBtnClick:(UIButton *) btn
{
    NSInteger previousPlayStyle = playStyle;
    playStyle  = btn.tag - 200;
    if (playStyle == 3)
    {   playStyle = previousPlayStyle;
        [self.setPlayModelView removeFromSuperview];
    }
    else
    {
        NSArray  * titleArray = @[@"list_play_all",@"single_play_one",@"random_play_all"];
        NSString *imageName  = titleArray[playStyle];
        [self.circleBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self.setPlayModelView removeFromSuperview];
    }
}

#pragma mark ----播放音乐
-(void)playBtnClick
{
    
    if (isPlay) {
        [audioPlayer play];
        [self.playOrStopBtn setImage:[UIImage imageNamed:@"stopping_music"] forState:UIControlStateNormal];
        isPlay = NO;
    }
    else
    {
        [audioPlayer pause];
        [self.playOrStopBtn setImage:[UIImage imageNamed:@"playing_music"] forState:UIControlStateNormal];
        isPlay = YES;
    }
}
#pragma mark 0.1秒一次更新 播放时间 播放进度条 歌词 歌曲 自动播放下一首
- (void)showTime {
    //动态更新进度条时间
    if ((int)audioPlayer.currentTime % 60 < 10) {
        self.currentTimeLabel.text = [NSString stringWithFormat:@"%d:0%d",(int)audioPlayer.currentTime / 60, (int)audioPlayer.currentTime % 60];
    } else {
        self.currentTimeLabel.text = [NSString stringWithFormat:@"%d:%d",(int)audioPlayer.currentTime / 60, (int)audioPlayer.currentTime % 60];
    }
    //
    if ((int)audioPlayer.duration % 60 < 10) {
        self.totalTimeLabel.text = [NSString stringWithFormat:@"%d:0%d",(int)audioPlayer.duration / 60, (int)audioPlayer.duration % 60];
    } else {
        self.totalTimeLabel.text = [NSString stringWithFormat:@"%d:%d",(int)audioPlayer.duration / 60, (int)audioPlayer.duration % 60];
    }
    self.slider.value = audioPlayer.currentTime / audioPlayer.duration;
    
    [self displaySondWord:audioPlayer.currentTime];//调用歌词函数
    
    //如果播放完，调用自动播放下一首
    if (self.slider.value > 0.999) {
        [self autoPlay];
    }
    
}
#pragma mark 自动进入下一首
- (void)autoPlay {
    //判断是否允许循环播放
    if(playStyle == 0){
        [self nextBtnClick];
    }
    else
    {
        if (playStyle == 1){
            [self  sigalSongPlay];
        }
        else
        {
            [self randomPlay];
        }
    }
}
//更新播放器设置
- (void)updatePlayerSetting {
    NSMutableDictionary  *modelDict = self.musicArray[musicArrayNumber];
    NSString * title = [modelDict objectForKey:MusicName];
    [myTitleItem setTitle:title];
    //更新播放按钮状态
    [self.playOrStopBtn setBackgroundImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    //isPlay = NO;
    //[self readMP3FileSourceWith:title];
    [self initLRCWithModel:title];
    [audioPlayer pause];
    audioPlayer = [[AVAudioPlayer alloc] initWithData:[self readMP3FileWithTitle:title] error:nil];
    audioPlayer.volume = 0.8;
    if (!isPlay) {
        [audioPlayer play];
    }
}
#pragma mark 动态显示歌词
- (void)displaySondWord:(NSUInteger)time {
    //    NSLog(@"time = %u",time);
    for (int i = 0; i < [self.timeArray count]; i++) {
        
        NSArray *array = [self.timeArray[i] componentsSeparatedByString:@":"];//把时间转换成秒
        NSUInteger currentTime = [array[0] intValue] * 60 + [array[1] intValue];
        if (i == [self.timeArray count]-1) {
            //求最后一句歌词的时间点
            NSArray *array1 = [self.timeArray[self.timeArray.count-1] componentsSeparatedByString:@":"];
            NSUInteger currentTime1 = [array1[0] intValue] * 60 + [array1[1] intValue];
            if (time > currentTime1) {
                [self updateLrcTableView:i];
                break;
            }
        } else {
            //求出第一句的时间点，在第一句显示前的时间内一直加载第一句
            NSArray *array2 = [self.timeArray[0] componentsSeparatedByString:@":"];
            NSUInteger currentTime2 = [array2[0] intValue] * 60 + [array2[1] intValue];
            if (time < currentTime2) {
                [self updateLrcTableView:0];
                //  NSLog(@"马上到第一句");
                break;
            }
            //求出下一步的歌词时间点，然后计算区间
            NSArray *array3 = [self.timeArray[i+1] componentsSeparatedByString:@":"];
            NSUInteger currentTime3 = [array3[0] intValue] * 60 + [array3[1] intValue];
            if (time >= currentTime && time <= currentTime3) {
                [self updateLrcTableView:i];
                break;
            }
            
        }
    }
}
#pragma mark 动态更新歌词表歌词
- (void)updateLrcTableView:(NSUInteger)lineNumber {
    lrcLineNumber = lineNumber;
    [self.lrcTableView reloadData];
    //使被选中的行移到中
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lineNumber inSection:0];
    [self.lrcTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    // NSLog(@"%i",lineNumber);
}
- (IBAction)progressChange{
    audioPlayer.currentTime = self.slider.value * audioPlayer.duration;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
