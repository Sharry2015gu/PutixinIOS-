//
//  ShuJia_MyViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/2.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "ShuJia_MyViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "HeaderFile.h"
#import "PTXCollectionView.h"
#import "MyLayout.h"
#import "CollectModel.h"
#import "BookView.h"
#import "ReadingBookViewController.h"
#import "WritingBookViewController.h"
#import "ProgressHUD.h"
#import "ZaiXian_JSViewController.h"
#define ImageHeight 120

@interface ShuJia_MyViewController ()<UIAlertViewDelegate,ZaiXian_JSViewControllerDelegate>
{
    //分页
    NSInteger _curPage;
    NSInteger _pageSize;
    NSInteger _maxPageNum;
    BOOL _isLoading;
    UIButton *selectBtn;
    UIScrollView *selectScrollView;
    BOOL  isDelete;
    CollectModel *selectCollectModel;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *buddhistScriptureArray;
@property(nonatomic,strong)NSMutableArray *goodBookArray;
@property(nonatomic,strong)NSMutableArray *translationArray;
@property(nonatomic,strong)NSMutableArray *spellArray;
@property(nonatomic,strong)NSMutableArray *academicArray;
@property(nonatomic,strong)NSMutableArray *scrollViewArray;//读经
@property(nonatomic,strong)NSMutableArray  *bookViewArray1;
@property(nonatomic,strong)NSMutableArray  *bookViewArray2;
@property(nonatomic,strong)NSMutableArray  *bookViewArray3;
@property(nonatomic,strong)NSMutableArray  *bookViewArray4;
@property(nonatomic,strong)NSMutableArray  *bookViewArray5;
@property(nonatomic,strong)NSMutableArray  *bookViewArray;
@property(nonatomic,strong)UIActionSheet  *actionsheet;
@property(nonatomic,strong)UIActionSheet  *actionSheet1;
@property(nonatomic,strong)UIButton * fanhuiBtn;
@property(nonatomic,strong)UIButton * paihangBt;
@property(nonatomic,strong)UIButton * wisBtn;
@end

@implementation ShuJia_MyViewController

@synthesize selectIndex;

#pragma mark -------初始化
-(UIActionSheet *)actionSheet1
{
    if (_actionSheet1 == nil) {
        _actionSheet1  = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"读经",@"读经排行",@"删除",nil];
        _actionsheet.delegate = self;
        _actionsheet.tag=2;
    }
    return _actionSheet1;
}
-(UIActionSheet *)actionsheet
{
    if (_actionsheet ==  nil) {
        _actionsheet =[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"读经",@"抄经",@"读经排行",@"抄经排行",@"删除", nil];
        _actionsheet.delegate = self;
        _actionsheet.tag=1;
    }
    return _actionsheet;
}

-(NSMutableArray *)bookViewArray
{
    if (_bookViewArray == nil) {
        _bookViewArray = [[NSMutableArray alloc]init];
        [_bookViewArray addObject:self.bookViewArray1];
        [_bookViewArray addObject:self.bookViewArray2];
        [_bookViewArray addObject:self.bookViewArray3];
        [_bookViewArray addObject:self.bookViewArray4];
        [_bookViewArray addObject:self.bookViewArray5];
    }
    return _bookViewArray;
}
-(NSMutableArray *)bookViewArray1
{
    if (_bookViewArray1 == nil) {
        _bookViewArray1 = [[NSMutableArray alloc] init];
    }
    return _bookViewArray1;
}
-(NSMutableArray *)bookViewArray2
{
    if (_bookViewArray2 == nil) {
        _bookViewArray2 = [[NSMutableArray alloc] init];
    }
    return _bookViewArray2;
}
-(NSMutableArray *)bookViewArray3
{
    if (_bookViewArray3 == nil) {
        _bookViewArray3 = [[NSMutableArray alloc] init];
    }
    return _bookViewArray3;
}
-(NSMutableArray *)bookViewArray4
{
    if (_bookViewArray4 == nil) {
        _bookViewArray4 = [[NSMutableArray alloc] init];
    }
    return _bookViewArray4;
}
-(NSMutableArray *)bookViewArray5
{
    if (_bookViewArray5 == nil) {
        _bookViewArray5 = [[NSMutableArray alloc] init];
    }
    return _bookViewArray5;
}
-(NSMutableArray *)scrollViewArray
{
    if (_scrollViewArray  == nil) {
        _scrollViewArray = [[NSMutableArray alloc] init];
        for(int i = 0 ; i < 5; i++)
        {
            UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVBARHEIGHT+55, SCREEN_WIDTH,(SCREEN_HEIGHT - NAVBARHEIGHT - 55))];
            scrollView.bounces = NO;
            [_scrollViewArray addObject:scrollView];
        }
    }
    return _scrollViewArray;
}
//佛经
-(NSMutableArray *)buddhistScriptureArray
{
    if (_buddhistScriptureArray == nil) {
        _buddhistScriptureArray = [[NSMutableArray alloc]init];
    }
    return _buddhistScriptureArray;
}

//译文
-(NSMutableArray *)translationArray
{
    if (_translationArray == nil) {
        _translationArray = [[NSMutableArray alloc]init];
    }
    return _translationArray;
}
//咒语
-(NSMutableArray *)spellArray
{
    if (_spellArray == nil) {
        _spellArray= [[NSMutableArray alloc]init];
    }
    return _spellArray;
}
//学术
-(NSMutableArray *)academicArray
{
    if (_academicArray == nil) {
        _academicArray = [[NSMutableArray alloc]init];
    }
    return _academicArray;
}

//善书
-(NSMutableArray *) goodBookArray
{
    if (_goodBookArray == nil) {
        _goodBookArray = [[NSMutableArray alloc] init];
    }
    return _goodBookArray;
}
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
        [_dataArray addObject:self.translationArray];
        [_dataArray addObject:self.goodBookArray];
        [_dataArray addObject:self.buddhistScriptureArray];
        [_dataArray addObject:self.academicArray];
        [_dataArray addObject:self.spellArray];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getBookShelfInfoWithCategory:1];
    [self getBookShelfInfoWithCategory:2];
    [self getBookShelfInfoWithCategory:3];
    [self getBookShelfInfoWithCategory:4];
    [self getBookShelfInfoWithCategory:5];
    self.navigationController.navigationBarHidden=YES;
    //初始默认是不显示删除按钮
    isDelete = YES;
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NAVBARHEIGHT)];
    view.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"顶部导航背景"]];
    [self.view addSubview:view];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.25,(NAVBARHEIGHT - 10) / 2,0.5*SCREEN_WIDTH, 30)];
    title.text=@"我的书架";
    title.textAlignment =  NSTextAlignmentCenter;
    title.font=[UIFont systemFontOfSize:20];
    title.textColor=[UIColor whiteColor];
    [view addSubview:title];
    
    _fanhuiBtn=[[UIButton alloc]initWithFrame:CGRectMake(10 , (NAVBARHEIGHT - 10) / 2, 30, 30)];
    [_fanhuiBtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [_fanhuiBtn addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_fanhuiBtn];
    
    _paihangBt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 30 - 30  - 15, (NAVBARHEIGHT  - 10) / 2, 30,30)];
    [_paihangBt setBackgroundImage:[UIImage imageNamed:@"pop_more_choose"] forState:UIControlStateNormal];
    [_paihangBt addTarget:self action:@selector(paihangClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_paihangBt];
    //右边
    _wisBtn=[[UIButton alloc]initWithFrame:CGRectMake(
                                                      SCREEN_WIDTH - 30 - 10,(NAVBARHEIGHT - 10) / 2, 30, 30)];
    [_wisBtn setBackgroundImage:[UIImage imageNamed:@"goto_online_book"] forState:UIControlStateNormal];
    [_wisBtn addTarget:self action:@selector(wisBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_wisBtn];
    
    UIView * imageview=[[UIView alloc]initWithFrame:CGRectMake(0,NAVBARHEIGHT, SCREEN_WIDTH, 55)];
    imageview.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"my_bookshelf_top_bg.jpg"]];
    [self.view addSubview:imageview];
    
    NSArray  * btnTitleArray = @[@"佛经",@"译文",@"咒语",@"学术",@"善书"];
    for( int i = 0 ; i < btnTitleArray.count; i++)
    {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag=100+i;
        [btn setTitle:btnTitleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"my_bookshelf_choosed"] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"my_bookshelf_no_choosed"] forState:UIControlStateNormal];
        //btn.backgroundColor=[UIColor redColor];
        [btn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 200 + i;
        CGFloat  marginX =1;
        CGFloat btnWidth=(SCREEN_WIDTH-5*marginX)/5;
        if (i == 0) {
            btn.selected = YES;
            selectBtn = btn;
            btn.frame = CGRectMake(0,(55 - 30) / 2 , btnWidth,30);
        }
        else
        {
            btn.frame=CGRectMake((btnWidth+marginX)*i, (55 - 30) / 2 ,btnWidth,30);
        }
        [imageview addSubview:btn];
    }
    [self createBgUIView];
}
-(void)selectBtnClick:(UIButton *)btn
{
    if (btn == selectBtn) return;
    btn.selected = YES;
    selectBtn.selected = NO;
    selectBtn = btn;
    NSInteger flag = btn.tag - 200;
    UIScrollView *scrollView = self.scrollViewArray[flag];
    [selectScrollView removeFromSuperview];
    [self.view addSubview:scrollView];
    selectScrollView = scrollView;
    
}
//返回上一级
#pragma mark ---按钮事件----
-(void)backclick{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
#pragma markpaihang
-(void)paihangClick{
    
    UIActionSheet * action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"读经总排行",@"抄经总排行", nil];
    action.tag=3;
    [action showInView:self.view];
}
-(void)wisBtnClick{
    
    ZaiXian_JSViewController * zaixian = [[ZaiXian_JSViewController alloc]init];
    [self.navigationController pushViewController:zaixian animated:YES];
    
}
#pragma mark -------获取我收藏的书籍
-(void)getBookShelfInfoWithCategory:(NSInteger) category
{
    [ProgressHUD showOnView:self.view];
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * miyaoNum = [appdelegate.accountBasicDict  objectForKey:@"secretKey"];
    NSNumber * huaien = [appdelegate.accountBasicDict objectForKey:@"huaienID"];
    NSDictionary * dic =@{@"secretKey":miyaoNum,@"huaienID":huaien,@"category":[NSNumber numberWithInteger:category],@"bookType":@1};
    NSDictionary * bookDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,BookShelfURL] parameters:bookDic success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * bookArray = jsonData[@"data"];
        NSMutableArray *array = self.dataArray[category - 1];
        for (int i = 0; i<bookArray.count; i++) {
            
            NSDictionary * arrdic =bookArray[i];
            CollectModel * book = [[CollectModel alloc]init];
            [book setValuesForKeysWithDictionary:arrdic];
            //这里是什么意思
            if (category == 1) {
                [array addObject:book];
            }
            else if(category==2){
                [array addObject:book];
            }else if (category==3){
                [array addObject:book];
            }else if (category==4){
                [array addObject:book];
            }else
            {
                [array addObject:book];
            }
        }
        [ProgressHUD hideAfterSuccessOnView:self.view];
        [self createScrollViewWithCategory:category];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}
#pragma mark -----进入书架的初始界面
-(void)createBgUIView
{
    CGFloat falgHeight  = 64 + 55;
    CGFloat height = (SCREEN_HEIGHT - 64 - 55) / 4;
    for(int i = 0  ; i < 4 ; i ++)
    {
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,height * i+falgHeight,SCREEN_WIDTH,height)];
        imageView1.image = [UIImage imageNamed:@"bookshelf_items_bg1.jpg"];
        [self.view addSubview:imageView1];
        imageView1.userInteractionEnabled = YES;
    }
}
#pragma mark -----书架界面
-(void)createScrollViewWithCategory:(NSInteger) category
{
    
    UIScrollView *scrollView = self.scrollViewArray[category - 1];
    NSMutableArray *array = self.dataArray[category - 1];
    NSMutableArray *bookViewArray = self.bookViewArray[category - 1];
    for(UIView *subView in scrollView.subviews)
    {
        [subView removeFromSuperview];
    }
    [bookViewArray removeAllObjects];
    
    UIImageView *currentImageView;
    CGFloat falgHeight  = 0;
    CGFloat height = (SCREEN_HEIGHT - 64 - 55) / 4;
    
    CGFloat marginX = 30;
    CGFloat relativeX = 30;
    CGFloat bookWidth  = (SCREEN_WIDTH - 2 * marginX - 2 * relativeX) / 3 ;
    
    if (array.count == 0)
    {
        CollectModel * model = [[CollectModel alloc] init];
        [array addObject:model];
    }
    for(int i = 0 ; i < array.count ; i++)
    {
        CollectModel *model = array[i];
        int rank = i / 3;
        int column  = i % 3;
        if ( column == 0 ) {
            currentImageView = [[UIImageView  alloc] initWithFrame:CGRectMake(0,height * rank + falgHeight,SCREEN_WIDTH,height)];
            currentImageView.image = [UIImage imageNamed:@"bookshelf_items_bg1.jpg"];
            currentImageView.userInteractionEnabled  = YES;
            [scrollView addSubview:currentImageView];
        }
        BookView *bookView = [[BookView alloc]initWithFrame:CGRectMake(marginX+(relativeX+bookWidth) * column,0.1* currentImageView.frame.size.height, bookWidth, 0.78*currentImageView.frame.size.height)];
        [bookView setModel:model];
        [bookView setIsDelete:isDelete];
        [bookViewArray addObject:bookView];
        WS(weakSelf);
        bookView.deleteBlock = ^void(CollectModel *model)
        {
            // [weakSelf deleClickWith:model];
        };
        bookView.selectBlock = ^void(CollectModel *model)
        {
            selectCollectModel = model;
            if (category==1){
                [weakSelf.actionsheet showInView:self.view];
            }else{
                [weakSelf.actionSheet1 showInView:self.view];
            }
            
        };
        //
        bookView.addBlock = ^void(UIButton *btn)
        {
            ZaiXian_JSViewController * vc = [[ZaiXian_JSViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        [currentImageView addSubview:bookView];
        [bookViewArray addObject:bookView];
        
    }
    NSInteger level = (array.count % 3) == 0?array.count / 3 :array.count / 3 + 1;
    scrollView.contentSize = CGSizeMake(0,level * height);
    if (category == 1) {
        selectScrollView = scrollView;
        [self.view addSubview:scrollView];
    }
}
#pragma mark ------关于删除
-(void)deleteBtnClick
{
    NSMutableArray *bookViewArray1 = self.bookViewArray[0];
    NSMutableArray *bookViewArray2 = self.bookViewArray[1];
    NSMutableArray *bookViewArray3 = self.bookViewArray[2];
    NSMutableArray *bookViewArray4 = self.bookViewArray[3];
    NSMutableArray *bookViewArray5 = self.bookViewArray[4];
    isDelete =! isDelete;
    for(int i = 0 ; i < bookViewArray1.count ; i++)
    {
        BookView *bookView = bookViewArray1[i];
        [bookView setIsDelete:isDelete];
        
    }
    for (int i = 0 ; i < bookViewArray2.count; i++) {
        BookView *bookView = bookViewArray2[i];
        [bookView setIsDelete:isDelete];
        
    }
    for(int i = 0 ; i < bookViewArray3.count ; i++)
    {
        BookView *bookView = bookViewArray3[i];
        [bookView setIsDelete:isDelete];
        
    }
    for (int i = 0 ; i < bookViewArray4.count; i++) {
        BookView *bookView = bookViewArray4[i];
        [bookView setIsDelete:isDelete];
        
    }
    for (int i = 0 ; i < bookViewArray5.count; i++) {
        BookView *bookView = bookViewArray5[i];
        [bookView setIsDelete:isDelete];
        
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
}
#pragma mark ------处理删除
-(void)deleClickWith:(CollectModel *) model
{
    
    NSInteger collectID = model.collectID;
    AppDelegate * deleteDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * miyaoNum = [deleteDelegate.accountBasicDict objectForKey:@"secretKey"];
    NSNumber * userLgon = [deleteDelegate.accountBasicDict objectForKey:@"userLoginID"];
    NSNumber * huaien = [deleteDelegate.accountBasicDict  objectForKey:@"huaienID"];
    NSDictionary * dic = @{@"secretKey":miyaoNum,@"userLoginID":userLgon,@"huaienID":huaien,@"collectID":[NSNumber numberWithInteger:collectID]};
    NSDictionary * deletegDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    [deleteDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,DeleteURL] parameters:deletegDic success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonDelete = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber  * result = jsonDelete[@"result"];
        if ([result isEqualToNumber:@0]) {
#pragma mark ----提示删除成功
            NSMutableArray  *array = self.dataArray[selectBtn.tag - 200];
            [array removeObject:model];
            [self createScrollViewWithCategory:selectBtn.tag - 200+1];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark ----UIActionSheet的代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet==_actionsheet) {
        
        if (buttonIndex == 0) {
            ReadingBookViewController  *readingBookVc  = [[ReadingBookViewController alloc] init];
            [readingBookVc setModel:selectCollectModel];
            [readingBookVc downLoadBookData:selectCollectModel WithUrl:selectCollectModel.downloadUrl_r IsReading:YES];
            [self.navigationController pushViewController:readingBookVc animated:YES];
        }
        if (buttonIndex == 1) {
            WritingBookViewController  *writingBookVc = [[WritingBookViewController alloc] init];
            [writingBookVc setModel:selectCollectModel];
            [writingBookVc downLoadBookData:selectCollectModel WithUrl:selectCollectModel.downloadUrl_w IsReading:NO];
            [self.navigationController pushViewController:writingBookVc animated:YES];
        }
        if (buttonIndex == 2) {
            DuJing_PHViewController * dujing = [[DuJing_PHViewController alloc]init];
            [dujing setModel:selectCollectModel];
            [dujing getReadRankingWit:selectCollectModel IsFresh:YES];
            [self.navigationController pushViewController:dujing animated:YES];
        }
        if (buttonIndex == 3) {
            ChaoJing_PHViewController * chaojing = [[ChaoJing_PHViewController alloc]init];
            [chaojing setModel:selectCollectModel];
            [chaojing getScribeRanking:selectCollectModel IsFresh:YES];
            [self.navigationController pushViewController:chaojing animated:YES];
        }
        if (buttonIndex == 4) {
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"确定要删除%@这本书吗?",selectCollectModel.title] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.delegate = self;
            [alert show];
        }
    }
    else if (actionSheet==_actionSheet1){
        
        if (buttonIndex == 0) {
            ReadingBookViewController  *readingBookVc  = [[ReadingBookViewController alloc] init];
            [readingBookVc setModel:selectCollectModel];
            [readingBookVc downLoadBookData:selectCollectModel WithUrl:selectCollectModel.downloadUrl_r IsReading:YES];
            [self.navigationController pushViewController:readingBookVc animated:YES];
        }
        if (buttonIndex==1){
            DuJing_PHViewController * dujing = [[DuJing_PHViewController alloc]init];
            [dujing setModel:selectCollectModel];
            [dujing getReadRankingWit:selectCollectModel IsFresh:YES];
            [self.navigationController pushViewController:dujing animated:YES];
        }
        if (buttonIndex==2){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"确定要删除%@这本书吗?",selectCollectModel.title] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.delegate = self;
            [alert show];
            
        }
        
    }
    else
    {
        switch (buttonIndex) {
            case 0:
            {
                DuJingViewController * dujing = [[DuJingViewController alloc]init];
                [dujing getReadRankingIsResh:YES];
                [self.navigationController pushViewController:dujing animated:YES];
            }
                break;
            case 1:
            {
                ChaoJingViewController * chaojing = [[ChaoJingViewController alloc]init];
                [chaojing getScribeRankingIsFresh:YES];
                [self.navigationController pushViewController:chaojing animated:YES];
            }
                
                break;
            case 2:
                [self dismissViewControllerAnimated:YES completion:nil];
                break;
                
            default:
                break;
        }
    }
}
#pragma mark ------UIAlertView代理方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self deleClickWith:selectCollectModel];
    }
    else
    {
        
    }
}
@end
