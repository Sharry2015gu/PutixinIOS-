//
//  ZaiXian_JSViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/2.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "ZaiXian_JSViewController.h"
#import "HeaderFile.h"
#import "WisdomModel.h"
#import "ClassicBookCell.h"
#import "SelectBookCell.h"
#import "ShuJia_MyViewController.h"
#import "SearchBookOrMusicViewController.h"
@interface ZaiXian_JSViewController ()
{
    NSInteger classicBookPage;
    NSInteger translationPage;
    NSInteger spellPage;
    NSInteger academicPage;
    NSInteger goodBookPage;
    WisdomModel  *selectModel;
    UIButton *selectBtn;
}
@property(nonatomic,strong)UILabel * totalLabel;
@property(nonatomic,strong)UILabel * downloadLabel;
@property(nonatomic,strong)NSMutableArray * classicBookArray;//佛经
@property(nonatomic,strong)UITableView  *classicBookTableView;

@property(nonatomic,strong)NSMutableArray  *translationArray;//译文
@property(nonatomic,strong)UITableView  *translationTableView;

@property(nonatomic,strong)NSMutableArray *spellArray;//咒语
@property(nonatomic,strong)UITableView  *spellTableView;

@property(nonatomic,strong)NSMutableArray  *academicArray;//学术
@property(nonatomic,strong)UITableView  *academicTableView;

@property(nonatomic,strong)UITableView  *goodBookTableView;//善书
@property(nonatomic,strong)NSMutableArray  *goodBookArray;
@property(nonatomic,strong)UITableView *selectTable;
@end

@implementation ZaiXian_JSViewController
#pragma mark -初始化
//佛经
-(NSMutableArray *)classicBookArray
{
    if (_classicBookArray == nil) {
        _classicBookArray = [[NSMutableArray alloc]init];
    }
    return _classicBookArray;
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
-(NSMutableArray *)goodBookArray
{
    if (_goodBookArray == nil) {
        _goodBookArray = [[NSMutableArray alloc] init];
    }
    return _goodBookArray;
}
//佛经
-(UITableView *)classicBookTableView
{
    if (_classicBookTableView == nil) {
        _classicBookTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0.175 * SCREEN_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT - 0.175 * SCREEN_HEIGHT)];
        _classicBookTableView.separatorStyle = NO;
        _classicBookTableView.delegate = self;
        _classicBookTableView.showsHorizontalScrollIndicator=NO;
        _classicBookTableView.showsVerticalScrollIndicator=NO;
        _classicBookTableView.dataSource = self;
        
        WS(weakself);
        [_classicBookTableView addHeaderWithCallback:^{
            [weakself downloadDataWithCategory:@1 isRefresh:YES];
        }];
        [_classicBookTableView addFooterWithCallback:^{
            [weakself downloadDataWithCategory:@1 isRefresh:NO];
        }];
    }
    return _classicBookTableView;
}
//译文
-(UITableView *)translationTableView
{
    if (_translationTableView == nil) {
        _translationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0.175 * SCREEN_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT - 0.175 * SCREEN_HEIGHT)];
        _translationTableView.separatorStyle = NO;
        _translationTableView.delegate = self;
        _translationTableView.showsHorizontalScrollIndicator=NO;
        _translationTableView.showsVerticalScrollIndicator=NO;
        _translationTableView.dataSource = self;
        WS(weakself);
        [_translationTableView addHeaderWithCallback:^{
            [weakself downloadDataWithCategory:@2 isRefresh:YES];
        }];
        [_translationTableView addFooterWithCallback:^{
            [weakself downloadDataWithCategory:@2 isRefresh:NO];
        }];
    }
    return _translationTableView;
}
//咒语
-(UITableView *)spellTableView
{
    if (_spellTableView == nil) {
        _spellTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0.175 * SCREEN_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT - 0.175 * SCREEN_HEIGHT)];
        _spellTableView.separatorStyle = NO;
        _spellTableView.delegate = self;
        _spellTableView.dataSource = self;
        WS(weakself);
        [_spellTableView addHeaderWithCallback:^{
            [weakself downloadDataWithCategory:@3 isRefresh:YES];
        }];
        [_spellTableView addFooterWithCallback:^{
            [weakself downloadDataWithCategory:@3 isRefresh:NO];
        }];
    }
    return _spellTableView;
}
//学术
-(UITableView *)academicTableView
{
    if (_academicTableView == nil) {
        _academicTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0.175 * SCREEN_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT - 0.175 * SCREEN_HEIGHT)];
        _academicTableView.separatorStyle = NO;
        _academicTableView.delegate = self;
        _academicTableView.dataSource = self;
        WS(weakself);
        [_academicTableView addHeaderWithCallback:^{
            [weakself downloadDataWithCategory:@4 isRefresh:YES];
        }];
        [_academicTableView addFooterWithCallback:^{
            [weakself downloadDataWithCategory:@4 isRefresh:NO];
        }];
    }
    return _academicTableView;
}
//善书
-(UITableView *)goodBookTableView
{
    if (_goodBookTableView == nil) {
        _goodBookTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0.175 * SCREEN_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT - 0.175 * SCREEN_HEIGHT)];
        _goodBookTableView.separatorStyle = NO;
        _goodBookTableView.delegate = self;
        _goodBookTableView.dataSource = self;
        WS(weakself);
        [_goodBookTableView addHeaderWithCallback:^{
            [weakself downloadDataWithCategory:@5 isRefresh:YES];
        }];
        [_goodBookTableView addFooterWithCallback:^{
            [weakself downloadDataWithCategory:@5 isRefresh:NO];
        }];
    }
    return _goodBookTableView;
}
//主页面
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self downloadDataWithCategory:@1 isRefresh:YES];
    
    self.navigationController.navigationBarHidden=YES;
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.1)];
    view.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"顶部导航背景"]];
    [self.view addSubview:view];
    
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"智慧文库";
    title.font=[UIFont systemFontOfSize:20];
    title.textColor=[UIColor whiteColor];
    [view addSubview:title];
    
    fanhuiBt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [fanhuiBt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [fanhuiBt addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:fanhuiBt];
    
    bookShelfBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.9, 0.05*SCREEN_HEIGHT, 0.07*SCREEN_WIDTH, 0.07*SCREEN_WIDTH)];
    [bookShelfBtn setBackgroundImage:[UIImage imageNamed:@"goto_my_bookshelf"] forState:UIControlStateNormal];
    [bookShelfBtn addTarget:self action:@selector(bookShelfBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:bookShelfBtn];
    
    seachBt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.8, 0.05*SCREEN_HEIGHT, 0.085*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [seachBt setBackgroundImage:[UIImage imageNamed:@"search_music"] forState:UIControlStateNormal];
    [seachBt addTarget:self action:@selector(seachClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:seachBt];
    
    
    UIView * background=[[UIView alloc]initWithFrame:CGRectMake(0, 0.1*SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    // background.backgroundColor=[UIColor redColor];
    
    background.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    [self.view addSubview:background];
    //@"1.jpg"  @"底部导航背景.jpg"
    UIView * quanziView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.1, SCREEN_WIDTH, SCREEN_HEIGHT*0.07)];
    
    quanziView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:quanziView];
    NSArray  * btnTitleArray = @[@"佛经",@"译文",@"咒语",@"学术",@"善书"];
    for( int i = 0 ; i < btnTitleArray.count; i++)
    {
        UIButton *btn = [[UIButton alloc] init];
        
        
        [btn setTitle:btnTitleArray[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:WorkDayColor forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"底部导航背景.jpg"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"底部导航背景.jpg"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 200 + i;
        CGFloat  marginX =1;
        btn.backgroundColor=[UIColor redColor];
        CGFloat btnWidth=(SCREEN_WIDTH-5*marginX)/5;
        if (i == 0) {
            btn.selected = YES;
            selectBtn = btn;
            btn.frame = CGRectMake(0,0, btnWidth,quanziView.frame.size.height);
        }
        else
        {
            btn.frame=CGRectMake((btnWidth+marginX)*i, 0,btnWidth,quanziView.frame.size.height);
        }
        if (i == self.selectedNumber) {
            btn.selected = YES;
            selectBtn = btn;
        }

        [quanziView addSubview:btn];
    }
    [self downloadDataWithCategory:@1 isRefresh:YES];
    [self downloadDataWithCategory:@2 isRefresh:YES];
    [self downloadDataWithCategory:@3 isRefresh:YES];
    [self downloadDataWithCategory:@4 isRefresh:YES];
    [self downloadDataWithCategory:@5 isRefresh:YES];
}

- (void)selectBtnClick:(UIButton*)btn
{
    if (btn == selectBtn) return;
    btn.selected = YES;
    selectBtn.selected = NO;
    selectBtn = btn;
    [self.selectTable removeFromSuperview];
    if (btn.tag==200)
    {
        self.selectTable=self.classicBookTableView;
        [self.view addSubview:self.classicBookTableView];
    }else if (btn.tag==201){
        
        self.selectTable=self.translationTableView;
        [self.view addSubview:self.translationTableView];
    }else if (btn.tag==202)
    {
        self.selectTable=self.spellTableView;
        [self.view addSubview:self.spellTableView];
    }else if (btn.tag==203){
        self.selectTable=self.academicTableView;
        [self.view addSubview:self.academicTableView];
    }else if (btn.tag==204){
        self.selectTable=self.goodBookTableView;
        [self.view addSubview:self.goodBookTableView];
    }
    
}

#pragma mark ----按钮事件-----
-(void)backclick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)bookShelfBtnClick{
    
    ShuJia_MyViewController * shujia = [[ShuJia_MyViewController alloc]init];
    [self.navigationController pushViewController:shujia animated:YES];
}

-(void)viewDidLayoutSubviews
{
    if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,1)];
    }
    
    if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark ------tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.classicBookTableView)
    {
        return self.classicBookArray.count + 1;
    }
    else if(tableView==self.translationTableView)
    {
        return self.translationArray.count + 1;
    }else if (tableView==self.spellTableView){
        return self.spellArray.count+1;
    }else if (tableView==self.academicTableView){
        return self.academicArray.count+1;
    }else{
        return self.goodBookArray.count+1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) return 150;
    if (tableView == self.selectTable) {
        if (indexPath.row == self.selectIndex.row && self.selectIndex != nil){
            return 110;
        }
    }
    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width;
    CGFloat height ;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        width = 205;
        height =  120;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            width = 180;
            height = 125;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            width = 230;
            height = 120;
        }
        else
        {
            width = 175;
            height  = 125;
        }
    }
    
    if (indexPath.row==0) {
        static NSString *identifier_ = @"cell_";
        UITableViewCell *cell_ = [tableView dequeueReusableCellWithIdentifier:identifier_];
        if (cell_ == nil) {
            
            cell_ = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_] ;
            backgroundImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height+SCREEN_HEIGHT*0.03)];
            backgroundImage.image=[UIImage imageNamed:@"classical_music_bg.jpg"];
            [cell_.contentView addSubview:backgroundImage];
            
        }
        cell_.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell_;
        
    }
    WisdomModel * model;
    if (tableView == self.classicBookTableView) {
        model = self.classicBookArray[indexPath.row - 1];
    }
    else if (tableView==self.translationTableView){
        model=self.translationArray[indexPath.row-1];
    }else if (tableView==self.spellTableView){
        model=self.spellArray[indexPath.row-1];
        
    }else if (tableView==self.academicTableView){
        model=self.academicArray[indexPath.row-1];
        
    }else
    {
        model = self.goodBookArray[indexPath.row - 1];
    }
    
    static NSString *identifier_ = @"cell";
    ClassicBookCell *cell_ = [tableView dequeueReusableCellWithIdentifier:identifier_];
    if (cell_ == nil) {
        
        cell_ = [[ClassicBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_] ;
        cell_.expandBlock = ^void(WisdomModel * model)
        {
            selectModel = model;
            [self dowloadBookContent:model.bookId];
            
        };
    }
    [cell_ setModel:model];
    cell_.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell_;
}

-(void)seachClick{
    SearchBookOrMusicViewController * search = [[SearchBookOrMusicViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
}
#pragma mark -下载数据
-(void)downloadDataWithCategory:(NSNumber *) category isRefresh:(BOOL) isRefresh
{
    NSInteger page;
    if ([category integerValue] == 1) {
        if (isRefresh) {
            classicBookPage = 0 ;
        }
        else
        {
            classicBookPage ++;
        }
        page = classicBookPage;
    }
    else if ([category integerValue]==2)
    {
        if (isRefresh) {
            translationPage = 0 ;
        }
        else
        {
            translationPage ++;
        }
        page = translationPage;
    }else if ([category integerValue]==3){
        if (isRefresh){
            spellPage=0;
            
        }else{
            spellPage++;
        }
        page=spellPage;
    }else if ([category integerValue]==4){
        if (isRefresh){
            academicPage=0;
            
        }else{
            academicPage++;
        }
        page=academicPage;
        
    }else if ([category integerValue]==5){
        if (isRefresh) {
            goodBookPage = 0 ;
        }
        else
        {
            goodBookPage ++;
        }
        page = goodBookPage;
    }
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * miyaoNum = [appdelegate.accountBasicDict objectForKey:@"secretKey"];
    NSNumber * huaien = [appdelegate.accountBasicDict  objectForKey:@"huaienID"];
    
    NSDictionary * dic =@{@"secretKey":miyaoNum,@"huaienID":huaien,@"category":category,@"bookType":@1,@"pageIndex":[NSNumber numberWithInteger:page]};
    NSDictionary * bookDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    
    [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,ClassicURL] parameters:bookDic success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"下载数据=%@",jsonData);
        NSArray * bookArray = jsonData[@"data"];
        if ([category integerValue] == 1) {
            if (page == 0)
            {
                [self.classicBookArray removeAllObjects];
            }
        }
        else  if ([category integerValue]==2){
            if (page == 0)
            {
                [self.translationArray removeAllObjects];
            }
        }else if ([category integerValue]==3){
            if (page == 0)
            {
                [self.spellArray removeAllObjects];
            }
        }else if ([category integerValue]==4){
            if (page == 0)
            {
                [self.academicArray removeAllObjects];
            }
        }else if ([category integerValue]==5)
        {
            if (page == 0 )
            {
                [self.goodBookArray removeAllObjects];
            }
        }
        for (int i = 0; i<bookArray.count; i++) {
            NSDictionary * arrdic =bookArray[i];
            WisdomModel * bookshelf = [[WisdomModel alloc]init];
            [bookshelf setValuesForKeysWithDictionary:arrdic];

            if ([category integerValue] == 1)
            {
                [self.classicBookArray addObject:bookshelf];
            }
            else if ([category integerValue] == 2)
            {
                [self.translationArray addObject:bookshelf];
            }
            else if ([category integerValue] == 3)
            {
                [self.spellArray addObject:bookshelf];
            }else if([category integerValue] == 4)
            {
                [self.academicArray addObject:bookshelf];
            }else if([category integerValue] == 5){
                [self.goodBookArray addObject:bookshelf];
            }
        }
        if ([category integerValue] == 1) {
            if (_classicBookTableView == nil) {
                [self.view addSubview:self.classicBookTableView];
                self.selectTable = self.classicBookTableView;
            }
            else
            {
                [self.classicBookTableView reloadData];
                [self.classicBookTableView headerEndRefreshing];
                [self.classicBookTableView  footerEndRefreshing];
            }
        }
        else if([category integerValue] == 2)
        {
            [self.translationTableView reloadData];
            [self.translationTableView headerEndRefreshing];
            [self.translationTableView footerEndRefreshing];
        }else if ([category integerValue] == 3)
        {
            [self.spellTableView reloadData];
            [self.spellTableView headerEndRefreshing];
            [self.spellTableView footerEndRefreshing];
        }else if ([category integerValue]==4)
        {
            [self.academicTableView reloadData];
            [self.academicTableView headerEndRefreshing];
            [self.academicTableView footerEndRefreshing];
        }else if ([category integerValue]==5){
            [self.goodBookTableView reloadData];
            [self.goodBookTableView headerEndRefreshing];
            [self.goodBookTableView footerEndRefreshing];
        }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark -----处理收藏经书的
-(void)dowloadBookContent:(NSInteger) bookID
{
    AppDelegate * bookDelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * miyaoNum = [bookDelegate.accountBasicDict objectForKey:@"secretKey"];
    NSNumber * userLogin = [bookDelegate.accountBasicDict objectForKey:@"userLoginID"];
    NSNumber * huaien = [bookDelegate.accountBasicDict objectForKey:@"huaienID"];
    
    NSDictionary * dic = @{@"secretKey":miyaoNum,@"userLoginID":userLogin,@"huaienID":huaien,@"objectID":[NSNumber numberWithInteger:bookID],@"objectType":@"1"};
    // NSDictionary * bookDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    NSArray  *keyArray = @[@"secretKey",@"userLoginID",@"huaienID",@"objectID",@"objectType"];
    NSString *jsonParamStr  = @"{";
    for(int i = 0 ; i < keyArray.count; i++)
    {
        NSString *keyValue  = keyArray[i];
        if (i == keyArray.count- 1) {
            jsonParamStr = [NSString stringWithFormat:@"%@%@:%@}",jsonParamStr,keyValue,[dic valueForKey:keyValue]];
        }
        else
        {
            jsonParamStr = [NSString stringWithFormat:@"%@%@:%@,",jsonParamStr,keyValue,[dic valueForKey:keyValue]];
        }
    }
    NSString *urlStr  = [NSString stringWithFormat:@"%@%@params=%@",__kBaseURLString,CollectionInfoURL,jsonParamStr];
    [bookDelegate.sessionManager GET:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonBook =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"收藏经书=%@",jsonBook);
        NSNumber  *resultNumber = jsonBook[@"result"];
        if ([resultNumber integerValue]==0) {
            
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.78, 100, 30);
            label.text = @"经书下载完成";
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
        else
        {
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.7, 100, 30);
            label.text = @"已经添加";
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
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}
@end