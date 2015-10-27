//
//  WritingBookViewController.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/8/28.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "WritingBookViewController.h"
#import "HeaderFile.h"
#import "ChaoJing_PHViewController.h"
#import "WisdomModel.h"
@interface WritingBookViewController()
{
    NSInteger currentPage;
    //每一页的最大字数
    int  perPageNumber;
    NSInteger page;
    NSInteger rank;
    NSInteger column;
    CGFloat marginX;
    CGFloat marginY;
    CGFloat width;
    CGFloat height;
    int  writingFlag;
    //抄经的次数
    NSInteger recentWriteTimes;
    NSInteger todayWriteTimes;
    NSInteger totalWriteTimes;
}

@property(nonatomic,strong)UILabel  * pageLabel;
@property(nonatomic,strong)UINavigationItem *navItem;
@property(nonatomic,strong)NSString *contentStr;
@property(nonatomic,strong)NSMutableArray *sysLabelArray;
@property(nonatomic,strong)NSMutableArray *userLabelArray;
@property(nonatomic,strong)NSString *currentStr;
@property(nonatomic,strong)NSMutableArray  *imageArray;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UILabel  *thisTimeLabel;
@property(nonatomic,strong)UILabel  *todayTimeLabel;
@property(nonatomic,strong)UILabel  *sumTimeLabel;
@property(nonatomic,strong)NSMutableArray *btnArray;
@property(nonatomic,strong)UIButton * maskButton;
@property(nonatomic,strong)UIButton * maskRankBtn;
@property(nonatomic,strong)UILabel * gradeRankNice;
@property(nonatomic,strong)UILabel * gradeLabel;
@property(nonatomic,strong)UILabel * practiceValueNice;
@property(nonatomic,strong)UILabel * practiceValueLabel;
@property(nonatomic,strong)UIButton * bgview;

@end
@implementation WritingBookViewController
#pragma mark ------初始化
-(UIView *)bottomView
{
    
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT - 55, SCREEN_WIDTH,55)];
        _bottomView.backgroundColor = [UIColor colorWithRed: 244 / 255.0 green:230 / 255.0 blue:193 / 255.0 alpha:1];
        
        CGFloat width1;
        CGFloat font;
        if (fabs(SCREEN_HEIGHT-667) < 1) {
            width1 = 205;
            
            font = 16;
        }
        else
        {
            if (fabs(SCREEN_HEIGHT -568) < 1) {
                width1 = 170;
                font = 14;
            }
            else if (fabs(SCREEN_HEIGHT - 736) < 1)
            {
                width1 = 230;
                
                font = 18;
            }
            else
            {
                width1 = 175;
                
                font = 12;
            }
        }
        //本次阅读
        UILabel *thisRead =[[UILabel alloc]initWithFrame:CGRectMake(width1*0.1, 10, width1*0.4, 20)];
        thisRead.text =@"本次抄经:";
        thisRead.font=[UIFont systemFontOfSize:font];
        thisRead.textColor=[UIColor darkGrayColor];
        [_bottomView addSubview:thisRead];
        self.thisTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(thisRead.frame.origin.x+thisRead.frame.size.width-5, thisRead.frame.origin.y, width1*0.4, 20)];
        self.thisTimeLabel.text=@"0字";
        self.thisTimeLabel.font=[UIFont systemFontOfSize:font];
        self.thisTimeLabel.textColor=[UIColor darkGrayColor];
        [_bottomView addSubview:self.thisTimeLabel];
        //今日阅读
        UILabel *todayRead =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-self.thisTimeLabel.frame.size.width-self.thisTimeLabel.frame.origin.x-15, self.thisTimeLabel.frame.origin.y, width1*0.4, 20)];
        todayRead.text =@"今日抄经:";
        todayRead.font=[UIFont systemFontOfSize:font];
        todayRead.textColor=[UIColor darkGrayColor];
        
        [_bottomView addSubview:todayRead];
        self.todayTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(todayRead.frame.origin.x+todayRead.frame.size.width,todayRead.frame.origin.y, width1*0.4, 20)];
        self.todayTimeLabel.font=[UIFont systemFontOfSize:font];
        self.todayTimeLabel.textColor=[UIColor darkGrayColor];
        self.todayTimeLabel.text=[NSString stringWithFormat:@"%ld字",todayWriteTimes];
        [_bottomView addSubview: self.todayTimeLabel];
        //累计阅读
        UILabel *totalRead =[[UILabel alloc]initWithFrame:CGRectMake(thisRead.frame.origin.x, thisRead.frame.origin.y+thisRead.frame.size.height+2, width1*0.40, 20)];
        totalRead.text =@"累计抄经:";
        totalRead.font=[UIFont systemFontOfSize:font];
        todayRead.textColor=[UIColor darkGrayColor];
        [_bottomView addSubview:totalRead];
        self.sumTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.thisTimeLabel.frame.origin.x,self.thisTimeLabel.frame.origin.y+self.thisTimeLabel.frame.size.height+2, 80, 20)];
        self.sumTimeLabel.text=[NSString stringWithFormat:@"%ld字",totalWriteTimes];
        self.sumTimeLabel.font=[UIFont systemFontOfSize:font];
        self.sumTimeLabel.textColor=[UIColor darkGrayColor];
        [_bottomView addSubview:self.sumTimeLabel];
        
    }
    return _bottomView;
}-(NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}

//存放系统给定字的label
-(NSMutableArray *)sysLabelArray
{
    if (_sysLabelArray == nil) {
        _sysLabelArray = [[NSMutableArray alloc] init];
    }
    return _sysLabelArray;
}
//存放用户输入的字的label
-(NSMutableArray *)userLabelArray
{
    if (_userLabelArray ==  nil) {
        _userLabelArray  = [[NSMutableArray alloc] init];
    }
    return _userLabelArray;
}
-(NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [[NSMutableArray  alloc] init];
    }
    return _imageArray;
}
-(UILabel*)pageLabel
{
    if (_pageLabel == nil) {
        _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT - 55 - 20,SCREEN_WIDTH,20)];
        _pageLabel.textAlignment = NSTextAlignmentCenter;
        _pageLabel.font = [UIFont boldSystemFontOfSize:12];
    }
    return _pageLabel;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self createNavBar];
    NSString *writeStr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"todayWriteNumber"]];
    NSLog(@"numberStr =%@",writeStr);
    //NSString *totalStr =[NSString stringWithFormat:@"%@",[NSUserDefaults standardUserDefaults]]
    if ([writeStr isEqualToString:@"(null)"]) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        NSDate * date = [NSDate date];
        NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"YYYY/MM/dd"];
        NSString  *dateString  = [dateFormatter stringFromDate:date];
        [dict setObject:@0 forKey:@"todayWriteNumber"];
        [dict setObject:dateString forKey:@"dateString"];
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"todayWriteNumber"];
        totalWriteTimes =  0 ;
        NSLog(@"1111");
    }
    else
    {
        NSDictionary  *dict1 =  [[NSUserDefaults standardUserDefaults]objectForKey:@"todayWriteNumber"];
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithDictionary:dict1];
        NSNumber *  number = [dict objectForKey:@"todayWriteNumber"];
        NSLog(@"-----%ld",[number integerValue]);
        NSString * dateString = [dict objectForKey:@"dateString"];
        NSDate * date = [NSDate date];
        NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"YYYY/MM/dd"];
        NSString  *currentDateString  = [dateFormatter stringFromDate:date];
        
        if ([currentDateString isEqualToString:dateString]) {
            todayWriteTimes = [number integerValue];
        }
        else
        {
            [dict setValue:currentDateString forKey:@"dateString"];
            todayWriteTimes = 0 ;
            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"todayWriteNumber"];
        }
        
    }
    
    [self loadCurrentData];
    recentWriteTimes=0;
    currentPage  = 1;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"read_book_main_bg.jpg"]];
    //[self.view addSubview:self.bottomView];
    
    _maskButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.97, SCREEN_HEIGHT*0.11, 12, SCREEN_HEIGHT*0.1)];
    [_maskButton setBackgroundImage:[UIImage imageNamed:@"level_designation_right_bg"] forState:UIControlStateNormal];
    [_maskButton addTarget:self action:@selector(maskClick) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:_maskButton];
}

#pragma mark ----隐藏的排行----
-(void)maskClick{
    _maskButton.hidden=YES;
    _bgview = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.72, SCREEN_HEIGHT*0.11, SCREEN_WIDTH*0.27, SCREEN_HEIGHT*0.14)];
    [_bgview setBackgroundImage:[UIImage imageNamed:@"level_designation_bg_2"] forState:UIControlStateNormal];
    [_bgview addTarget:self action:@selector(bgViewClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bgview];
    
    _maskRankBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, _bgview.frame.origin.y-55, SCREEN_WIDTH*0.17, 25)];
    [_maskRankBtn setBackgroundImage:[UIImage imageNamed:@"03"] forState:UIControlStateNormal];
    [_maskRankBtn setTitle:@"抄经排行榜" forState:UIControlStateNormal];
    _maskRankBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [_maskRankBtn addTarget:self action:@selector(maskRankClick) forControlEvents:UIControlEventTouchUpInside];
    [_maskRankBtn setTitleColor:majorityColor forState:UIControlStateNormal];
    [_bgview addSubview:_maskRankBtn];
    
    _gradeRankNice = [[UILabel alloc]initWithFrame:CGRectMake(_maskRankBtn.frame.origin.x, _maskRankBtn.frame.origin.y+_maskRankBtn.frame.size.height+5, 50, 20)];
    _gradeRankNice.text=@"当前等级";
    _gradeRankNice.textColor=[UIColor whiteColor];
    _gradeRankNice.font=[UIFont systemFontOfSize:10];
    [_bgview addSubview:_gradeRankNice];
    
    UIImageView * gradeImage = [[UIImageView alloc]initWithFrame:CGRectMake(_gradeRankNice.frame.origin.x+_gradeRankNice.frame.size.width-5, _maskRankBtn.frame.origin.y+_maskRankBtn.frame.size.height+9, 22, 13)];
    gradeImage.image=[UIImage imageNamed:@"level_bg"];
    [_bgview addSubview:gradeImage];
    _gradeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,1, 30, 10)];
    _gradeLabel.text=@"LV15";
    _gradeLabel.textColor=[UIColor whiteColor];
    _gradeLabel.font=[UIFont systemFontOfSize:9];
    [gradeImage addSubview:_gradeLabel];
    
    _practiceValueNice = [[UILabel alloc]initWithFrame:CGRectMake(_maskRankBtn.frame.origin.x,_gradeRankNice.frame.origin.y+_gradeRankNice.frame.size.height-3, 50, 20)];
    _practiceValueNice.text=@"修行者";
    _practiceValueNice.textColor=[UIColor whiteColor];
    _practiceValueNice.font=[UIFont systemFontOfSize:11];
    [_bgview addSubview:_practiceValueNice];
    
    _practiceValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(_practiceValueNice.frame.origin.x+_practiceValueNice.frame.size.width-5,_gradeRankNice.frame.origin.y+_gradeRankNice.frame.size.height-3, 50, 20)];
    _practiceValueLabel.text=@"622";
    _practiceValueLabel.textColor=[UIColor whiteColor];
    _practiceValueLabel.font=[UIFont systemFontOfSize:11];
    [_bgview addSubview:_practiceValueLabel];
    
}
#pragma mark ----隐藏排行中的按钮事件---
-(void)bgViewClick{
    
    [_bgview removeFromSuperview];
    _maskButton.hidden=NO;
}
-(void)maskRankClick{
    
    ChaoJing_PHViewController * chaojing = [[ChaoJing_PHViewController alloc]init];
    [self.navigationController pushViewController:chaojing animated:YES];
}
#pragma mark --------创建导航栏
-(void)createNavBar
{
    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NAVBARHEIGHT)];
    [navBar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    UINavigationItem *titleItem = [[UINavigationItem alloc]initWithTitle:self.model.title];
    self.navItem = titleItem;
    NSDictionary *navTitleArr = [NSDictionary dictionaryWithObjectsAndKeys:
                                 
                                 [UIFont boldSystemFontOfSize:20],UITextAttributeFont,
                                 [UIColor whiteColor],UITextAttributeTextColor ,nil];
    [navBar setTitleTextAttributes:navTitleArr];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(10, 20,30, 25)];
    [leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [titleItem setLeftBarButtonItem:leftItem];
    [navBar pushNavigationItem:titleItem animated:NO];
    [self.view addSubview:navBar];
    
    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.9, 30, 25, 25)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"share_white_icon"] forState:UIControlStateNormal];
    [self.view addSubview:rightBtn];
}
#pragma mark 返回
-(void)backBtnClick
{
    
    
    if ([self.thisTimeLabel.text isEqualToString:@""]) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        NSMutableDictionary *dict1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"todayWriteNumber"];
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithDictionary:dict1];
        NSLog(@"%@",dict);
        NSLog(@"返回数据%ld",totalWriteTimes);
        [dict setObject:[NSNumber numberWithInteger:todayWriteTimes] forKey:@"todayWriteNumber"];
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"todayWriteNumber"];
        
        UIAlertView * alrea = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"本次你已经抄经%@啦,确定要退出抄经吗?",self.thisTimeLabel.text] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alrea show];
        
    }
    
}
#pragma mark-依据怀恩ID及经书ID读取最近一次的位置
//-(void)getLastPosition:(WisdomModel*)model
//{
//    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
//    NSNumber *miyaoNum= [appDelegate.accountBasicDict objectForKey:@"secretKey"];
//    NSDictionary * dic = @{@"secretKey":miyaoNum,@"bookID":model.bookId,@"huaienID":huaien,@"taskCode":@501};
//
//
//}
#pragma mark ---alertview代理---
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (buttonIndex == 1 ){// [ProgressHUD showOnView:self.view];
        AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
        NSNumber *miyaoNum= [appDelegate.accountBasicDict objectForKey:@"secretKey"];
        NSNumber * userLoginID= [appDelegate.accountBasicDict objectForKey:@"userLoginID"];
        //这里的bookID要传什么值，为什么0也是对的
        NSDictionary * dic = @{@"secretKey":miyaoNum,@"userLoginID":userLoginID,@"huaienID":huaien,@"userTaskID":@0,@"taskCode":@501,@"sceneType":@1,@"buddhistTempleID":@0,@"bookID":@0,@"beginPostion":[NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:totalWriteTimes]],@"endPostion":[NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:(totalWriteTimes+recentWriteTimes)]]};
        NSDictionary * meditionDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
        
        AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,SubmitSitMeditationURL] parameters:meditionDic success:^(NSURLSessionDataTask *task, id responseObject) {
            
            id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"提交数据=%@",jsonData);
            NSNumber *result =jsonData[@"result"];
            NSString *desc =jsonData[@"desc"];
            if([result integerValue]>0){
                UILabel *label = [[UILabel alloc]init];
                label.frame = CGRectMake(SCREEN_WIDTH *0.3, SCREEN_HEIGHT*0.8,SCREEN_WIDTH*0.4, 30);
                //@"签到成功,获得祈福币%@",jsonData[@"prayMoney"]
                label.text =@"提交成功";
                label.textColor = [UIColor whiteColor];
                label.textAlignment = 1;
                label.backgroundColor = [UIColor blackColor];
                label.font = [UIFont boldSystemFontOfSize:12];
                [UIView animateWithDuration:1.5 animations:^{
                    label.alpha = 0;
                    [self.view addSubview:label];
                    
                } completion:^(BOOL finished) {
                    [self.navigationController popViewControllerAnimated:YES];
                    [label removeFromSuperview];
                }];
            }
            else{
                UILabel *label = [[UILabel alloc]init];
                label.frame = CGRectMake(SCREEN_WIDTH *0.1, SCREEN_HEIGHT*0.8,SCREEN_WIDTH*0.8, 30);
                //@"签到成功,获得祈福币%@",jsonData[@"prayMoney"]
                label.text =desc;
                label.textColor = [UIColor whiteColor];
                label.textAlignment = 1;
                label.backgroundColor = [UIColor blackColor];
                label.font = [UIFont boldSystemFontOfSize:12];
                [UIView animateWithDuration:1.5 animations:^{
                    label.alpha = 0;
                    [self.view addSubview:label];
                    
                } completion:^(BOOL finished) {
                    [self.navigationController popViewControllerAnimated:YES];
                    [label removeFromSuperview];
                }];
                
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
}

-(void)getPrompt{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.68, 100, 30)];
    label.text = @"提交成功";
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
#pragma mark  ------读出Document中的文件
-(NSString *)readFileWith:(CollectModel  * ) readModel
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"Book_ForReading"];
    [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *txtName = [NSString stringWithFormat:@"%ld.txt",(long)readModel.collectID];
    NSString *txtPath = [testDirectory stringByAppendingPathComponent:txtName];
    return [NSString stringWithContentsOfFile:txtPath encoding:NSUTF8StringEncoding error:nil];
}
-(void)createUIWith:(NSData *) data
{
    self.contentStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",self.contentStr);
    width  =  28;
    int number = (SCREEN_WIDTH / width) - 1 ;
    //表示一行几列
    column = number;
    //间距
    marginX = (SCREEN_WIDTH  - width * number) / 2;
    //第一行距离上面的间距
    marginY =  0;
    //一排的高度
    height = 2*(width + marginY);
    
    int clumn = (SCREEN_HEIGHT - 55 -  NAVBARHEIGHT) / height ;
    int numberOfThePage = (clumn - 1) * number;
    perPageNumber = numberOfThePage;
    
    rank = clumn;
    
    page  = ((int)self.contentStr.length / numberOfThePage);
    self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)currentPage,(long)page+1];
    [self.view addSubview:self.pageLabel];
    [self createCurrentPage:1 WithPerNumber:numberOfThePage];
    
}
-(void)getPageInfo{
    
    UIImageView * view =[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.38, 100, 100)];
    view.image=[UIImage imageNamed:@"show_page_bg"];
    [self.view addSubview:view];
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 0, 100, 100);
    label.text = [NSString stringWithFormat:@"%ld",(long)currentPage];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:78];
    [view addSubview:label];
    
    [UIView animateWithDuration:1.5 animations:^{
        label.alpha = 0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
        [view removeFromSuperview];
    }];
    
}
#pragma mark --------用于生成每一页的文字
-(void)createCurrentPage:(int) currentPage1 WithPerNumber:(int) number
{
    [self getPageInfo];
    self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)currentPage,(long)page+1];
    self.pageLabel.textColor=[UIColor grayColor];
    if (_sysLabelArray != nil) {
        for (int i = 0 ; i < _sysLabelArray.count; i++) {
            UILabel *label = _sysLabelArray[i];
            [label removeFromSuperview];
        }
        [_sysLabelArray removeAllObjects];
    }
    if (_userLabelArray != nil) {
        for (int i = 0 ; i < _userLabelArray.count; i++) {
            UILabel *label = _userLabelArray[i];
            [label removeFromSuperview];
        }
        [_userLabelArray removeAllObjects];
    }
    if (_imageArray != nil) {
        for(int i = 0 ; i < _imageArray.count; i++)
        {
            UIImageView *imageView = _imageArray[i];
            [imageView removeFromSuperview];
        }
        [_imageArray removeAllObjects];
    }
    
    int  location =  (currentPage1 - 1) *  number;
    self.currentStr = [self.contentStr  substringFromIndex:location];
    if (currentPage1 == page) {
        
    }
    else
    {
        self.currentStr = [self.currentStr substringToIndex:number];
    }
    for(int  i = 0 ; i < self.currentStr.length; i++)
    {
        UILabel *label1  = [[UILabel alloc]initWithFrame:CGRectMake(marginX+width * (i % column), marginY +height * (i / column)+NAVBARHEIGHT,width,width)];
        label1.text  = [NSString stringWithFormat:@"%C",[self.currentStr characterAtIndex:i]];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.font = [UIFont boldSystemFontOfSize:15];
        [self.view addSubview:label1];
        [self.sysLabelArray addObject:label1];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(label1.frame.origin.x + 2,CGRectGetMaxY(label1.frame)+2,width-4,width-4)];
        imageView.image = [UIImage imageNamed:@"write_book_every_table_bg"];
        [self.imageArray addObject:imageView];
        
        [self.view addSubview:imageView];
        UILabel  *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0,0,imageView.frame.size.width, imageView.frame.size.height)];
        label2.font = [UIFont boldSystemFontOfSize:15];
        label2.textAlignment = NSTextAlignmentCenter;
        [imageView addSubview:label2];
        [self.view addSubview:imageView];
        [self.userLabelArray addObject:label2];
    }
    [self createCards];
}
#pragma mark ----用于随机卡片
-(void)createCards
{
    if (_btnArray != nil) {
        for(int i = 0 ; i < self.btnArray.count ; i++)
        {
            UIButton *btn = _btnArray[i];
            [btn  removeFromSuperview];
        }
        [_btnArray removeAllObjects];
    }
    int randomNumber = arc4random()% 4;
    CGFloat  btnMarginX = marginX + 20;
    CGFloat  btnWidth   =  50;
    CGFloat  btnRelativeWidth = (SCREEN_WIDTH - 2 * btnMarginX -  4 * btnWidth) / 3;
    for(int  i = 0 ; i < 4; i ++)
    {
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(btnMarginX+(btnRelativeWidth + btnWidth) * i,SCREEN_HEIGHT - 55 - 20 - btnWidth,btnWidth, btnWidth)];
        btn.backgroundColor = [UIColor whiteColor];
        if (i == randomNumber) {
            [btn setTitle:[NSString stringWithFormat:@"%C",[self.currentStr characterAtIndex:writingFlag]] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(changeSelectWord) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            [btn setImage:[self OriginImage:[UIImage imageNamed:@"lotus_icon_table"] scaleToSize:CGSizeMake(btn.frame.size.height - 10,btn.frame.size.height - 10)] forState:UIControlStateNormal];
            btn.userInteractionEnabled = NO;
        }
        CALayer  *btnLayer = btn.layer;
        btnLayer.borderWidth = 2;
        btnLayer.cornerRadius  = 2;
        btnLayer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.btnArray addObject:btn];
        [self.view addSubview:btn];
    }
}

#pragma mark --------处理选中一个字后
-(void)changeSelectWord
{
    recentWriteTimes++;
    
    self.thisTimeLabel.text = [NSString stringWithFormat:@"%ld字",recentWriteTimes];
    self.todayTimeLabel.text = [NSString stringWithFormat:@"%ld字",++todayWriteTimes];
    self.sumTimeLabel.text =  [NSString stringWithFormat:@"%ld字",++totalWriteTimes];
    NSLog(@"今日字数＝%ld",todayWriteTimes);
    if (todayWriteTimes%100==0){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.6, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.08)];
        
        view.backgroundColor=[UIColor blackColor];
        //        view.alpha=0.5;
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, -2, view.frame.size.width*0.7, view.frame.size.height)];
        label1.text=@"修行值";
        
        label1.font=[UIFont systemFontOfSize:20.0f];
        label1.textColor=[UIColor whiteColor];
        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(2+label1.frame.size.width, label1.frame.origin.y, label1.frame.size.width*0.3, view.frame.size.height)];
        label2.text=@"+2";
        label2.textColor=[UIColor redColor];
        label2.font=[UIFont systemFontOfSize:20.0f];
        [view addSubview:label1];
        [view addSubview:label2];
        
        [UIView animateWithDuration:2 animations:^{
            view.alpha = 0;
            [self.view addSubview:view];
            
        } completion:^(BOOL finished) {
            
            [view removeFromSuperview];
        }];
    }
    UILabel  *sysLabel = self.sysLabelArray[writingFlag];
    sysLabel.textColor = [UIColor lightGrayColor];
    UILabel  *userLabel = self.userLabelArray[writingFlag];
    userLabel.text = [NSString stringWithFormat:@"%C",[self.currentStr characterAtIndex:writingFlag]];
    writingFlag ++;
    if (writingFlag == perPageNumber) {
        writingFlag = 0 ;
        currentPage ++;
        [self createCurrentPage:currentPage WithPerNumber:perPageNumber];
    }
    else
    {
        [self createCards];
    }
    
}
#pragma mark --------处理下载经书
-(void)downLoadBookData:(CollectModel *) model1 WithUrl:(NSString *) downloadURL IsReading:(BOOL)isReading
{
    //[ProgressHUD showOnView:self.view];
    NSLog(@"%@",downloadURL);
    NSString *url = [downloadURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [NetWorking sendAsynchronousRequestWithURLString:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30 completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError == nil) {
            [self createUIWith:data];
            [self selectAllFileWith:model1 WithData:data IsReading:isReading];
        }
        else
        {
        }
    }];
}
#pragma mark ------在Document里创建文件
-(void)selectAllFileWith:(CollectModel *) model1 WithData:(NSData *)data IsReading:(BOOL)isReading
{
    NSString *flagStr;
    if (isReading) {
        flagStr  = @"reading";
    }
    else
    {
        flagStr  = @"writing";
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"Book_ForReading"];
    [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *txtName = [NSString stringWithFormat:@"%d%@.txt",model1.collectID,flagStr];
    NSString *txtPath = [testDirectory stringByAppendingPathComponent:txtName];
    [fileManager createFileAtPath:txtPath contents:data attributes:nil];
}
#pragma mark -----用于切图
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}
#pragma mark 累积数
-(void)loadCurrentData
{
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * miyaoNum = [appDelegate.accountBasicDict  objectForKey:@"secretKey"];
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSDictionary * currentDict=@{@"secretKey":miyaoNum,@"huaienID":huaien,@"taskCode":@501};
    NSDictionary * currentDict1 = @{@"params":[NSString stringWithFormat:@"%@",currentDict]};
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,ptxGetUserTaskCurrentStatInfo]  parameters:currentDict1 success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"抄经累积数＝%@",jsonData);
        
        NSNumber * totalTimes=jsonData[@"totalQty"];
        totalWriteTimes=[totalTimes integerValue];
        [self.view addSubview:self.bottomView];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

@end
