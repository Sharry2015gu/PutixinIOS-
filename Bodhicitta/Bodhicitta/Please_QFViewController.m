//
//  Please_QFViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/20.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "Please_QFViewController.h"
#import "QingFoView1.h"
#import "HeaderFile.h"
#import "PTXCollectionView.h"
#import "TempleImageViewCell.h"
#import "BuddhaCollectionViewCell.h"

#define Start_X 10.0f           // 第一个按钮的X坐标

#define Start_Y 60.0f           // 第一个按钮的Y坐标

#define Width_Space 10.0f        // 2个按钮之间的横间距

#define Height_Space 10.0f      // 竖间距

#define Row_Space   30.0f       //行距

#define Button_Height 20.0f    // 高

#define Button_Width 68.0f      // 宽

@interface Please_QFViewController ()<MyLayoutDelegte,UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray *_dataArray;
    //分页
    NSInteger _curPage;
    NSInteger _pageSize;
    
    NSInteger _maxPageNum;
    
    BOOL _isLoading;
    
    //列表
    PTXCollectionView *_collectionView;
    UIImageView *selectImageView;
    UILabel  *selectNameLabel ;
    UIImageView *selectNameBGImageView;
}


@property(nonatomic,strong)QingFoView1 *myQf;
@property(nonatomic,strong)MyLayout *layout;
@property(nonatomic,strong)UICollectionView *buddaCollectionView;
@property(nonatomic,strong)NSMutableArray *buddaArray;
@end
@implementation Please_QFViewController

@synthesize dataArray;
@synthesize maskView;
@synthesize delegate;
//@synthesize model;
#pragma mark ----自定义-----
-(NSMutableArray *)buddaArray
{
    if (_buddaArray == nil) {
        _buddaArray = [[NSMutableArray alloc]init];
    }
    return _buddaArray;
}
-(UICollectionView *)buddaCollectionView
{
    if (_buddaCollectionView == nil) {
        _buddaCollectionView = [[UICollectionView  alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH,SCREEN_HEIGHT - 64) collectionViewLayout:self.layout];
        _buddaCollectionView.backgroundColor = [UIColor clearColor];
        _buddaCollectionView.delegate  = self;
        _buddaCollectionView.dataSource = self;
        _buddaCollectionView.showsVerticalScrollIndicator = NO;
        [_buddaCollectionView registerClass:[BuddhaCollectionViewCell class] forCellWithReuseIdentifier:@"BuddhaCollectionCellID"];
    }
    return _buddaCollectionView;
}
-(MyLayout *)layout
{
    if (_layout == nil) {
        _layout  = [[MyLayout alloc]init];
        _layout.sectionInsets = UIEdgeInsetsMake(0,0, 0,0) ;
        _layout.itemSpace = 0 ;
        _layout.lineSpace = 0 ;
        _layout.delegate = self;
    }
    return _layout;
}
#pragma mark -----Layout代理方法---
-(NSInteger) numberOfColumns
{
    return 2;
}
-(CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
    return (SCREEN_HEIGHT - 64) / 3;
}
#pragma mark ---UICollectionView代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return   self.buddaArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TempleImage *model = self.buddaArray[indexPath.row];
    BuddhaCollectionViewCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"BuddhaCollectionCellID" forIndexPath:indexPath];
    if (indexPath.row % 2 == 0 )
    {
        cell.frameWorkImageView.image = [UIImage imageNamed:@"WoodBox_Left"];
    }
    else
    {
        cell.frameWorkImageView.image = [UIImage imageNamed:@"WoodBox_Right"];
    }
    
    cell.selectBlock = ^void(TempleImage *model,UIImageView *lightView,UIImageView * nameBgImageView,UILabel *nameLabel)
    {
        lightView.hidden = NO;
        selectImageView.hidden = YES;
        selectImageView = lightView;
        nameBgImageView.image = [UIImage imageNamed:@"RedBlock"];
        selectNameBGImageView.image = [UIImage imageNamed:@"RedBlock1"];
        selectNameBGImageView = nameBgImageView;
        
        nameLabel.textColor = majorityColor;
        selectNameLabel.textColor =  TempleNameLa;
        selectNameLabel = nameLabel;
        [self  getBuddhaIntrol:model];
        WS(weakSelf);
        self.myQf =  [[QingFoView1 alloc] initWithFrame:self.view.bounds WithModel:model];
        self.myQf.submitBlock = ^void(TempleImage *model)
        {
//            [weakSelf getBuddhaIntrol:model];
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake((SCREEN_WIDTH - 200) / 2, SCREEN_HEIGHT*0.68, 200, 50);
            label.text = [NSString stringWithFormat:@"佛像已被恭请过了!"];
            label.textColor = [UIColor whiteColor];
            label.textAlignment = 1;
            label.backgroundColor = [UIColor blackColor];
            label.font = [UIFont boldSystemFontOfSize:12];
            [weakSelf.view addSubview:label];
            
            [UIView animateWithDuration:1.5 animations:^{
                label.alpha = 0;
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
            }];
            [weakSelf.myQf removeFromSuperview];
            [weakSelf createNewTemple:model];
        };
        [self.view addSubview:self.myQf];
    };
    [cell setModel:model];
    return cell;
}
#pragma mark ------主页面UI----
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar * bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [bar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:bar];
    
    UIButton * bu=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [bu setBackgroundImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(buclick) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:bu];
    
    title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"神佛阁";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [bar addSubview:title];
    
    UIView * background=[[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    background.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bookshelf_items_bg1.jpg"]];
    [self.view addSubview:background];
    [self createBgUIView];
    [self getTempleList];
}
//返回上一级
-(void)createBgUIView
{
    CGFloat falgHeight  = 64;
    CGFloat height = (SCREEN_HEIGHT - 64) / 3;
    for(int i = 0  ; i < 6 ; i ++)
    {
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0.5 * SCREEN_WIDTH *(i % 2),height*(i / 2)+falgHeight,0.5*SCREEN_WIDTH,height)];
        if (i % 2 == 0) {
            imageView1.image = [UIImage imageNamed:@"WoodBox_Left"];
        }
        else
        {
            imageView1.image = [UIImage imageNamed:@"WoodBox_Right"];
        }
        [self.view addSubview:imageView1];
        imageView1.userInteractionEnabled = YES;
    }
}
-(void)buclick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if([textView isFirstResponder]){
        return YES;
    }
    return NO;
}

#pragma mark ----列表接口
-(void)getTempleList{
    AppDelegate *appDelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSNumber * huaien = [[NSUserDefaults standardUserDefaults] objectForKey:@"huaienID"];
    
    NSDictionary * dic=@{@"sceneType":@1,@"huaienID":huaien};
    NSDictionary * mainDic=@{@"params":[NSString stringWithFormat:@"%@",dic]};
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,TempleList] parameters:mainDic success:^(NSURLSessionDataTask *task, id responseObject){
        
        id jsonDate = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSNumber * taskCode = jsonDate[@"taskCode"];
//        [[NSUserDefaults standardUserDefaults]setObject:taskCode forKey:@"taskCode"];
        NSArray *dictArray = jsonDate[@"data"];//把里面的字典取出来
        for(int i = 0 ; i < dictArray.count;i++)
        {
            NSDictionary *dict = dictArray[i];
            TempleImage *model = [[TempleImage alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.buddaArray addObject:model];
        }
        [self.view addSubview:self.buddaCollectionView];
    } failure:^(NSURLSessionDataTask *task, id responseObject){
    }];
}
#pragma mark -----佛像简介---
-(void)getBuddhaIntrol:(TempleImage *)model
{

    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary * dic = @{@"taskCode":model.taskCode};
    NSLog(@"dic=%@",dic);
    NSDictionary * budDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    [appdelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,GetMaterailByIDURL] parameters:budDic success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"佛像简介=%@",jsonData);
        self.myQf.textview.text=jsonData[@"taskDesc"];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark ------恭请佛像接口-----
-(void)createNewTemple:(TempleImage *) model
{
    AppDelegate * appdelegta=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber *loginId = [appdelegta.accountBasicDict  objectForKey:@"userLoginID"];
    NSNumber * miyaoNum = [appdelegta.accountBasicDict  objectForKey:@"secretKey"];
    NSNumber * huaien = [appdelegta.accountBasicDict  objectForKey:@"huaienID"];
    
    NSArray  *paramsKeyArray = @[@"secretKey",@"userLoginID",@"huaienID",@"taskCode"];
    NSDictionary * wishdic=@{@"secretKey":miyaoNum,@"userLoginID":loginId,@"huaienID":huaien,@"taskCode":model.taskCode};
    NSString *jsonParamsStr = @"{";
    for(int i = 0 ; i < paramsKeyArray.count; i++)
    {
        NSString *keyValue = paramsKeyArray[i];
        if (i == paramsKeyArray.count- 1) {
            jsonParamsStr = [NSString stringWithFormat:@"%@%@:%@}",jsonParamsStr,keyValue,[wishdic valueForKey:keyValue]];
        }
        else
        {
            jsonParamsStr = [NSString stringWithFormat:@"%@%@:%@,",jsonParamsStr,keyValue,[wishdic valueForKey:keyValue]];
        }
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@%@params=%@",__kBaseURLString,ptxAddTemple,jsonParamsStr];
    [appdelegta.sessionManager GET:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject){
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *result = jsonData[@"result"];
        if ([result integerValue] > 0)
        {
            MyBuddhaHallViewController *myBuddhaHallVc = (MyBuddhaHallViewController *)self.vc;
            //[myBuddhaHallVc.MyBuddhaArray removeLastObject];
            [myBuddhaHallVc.MyBuddhaArray insertObject:model atIndex:myBuddhaHallVc.MyBuddhaArray.count - 2];
            //请佛请满了后 把空的佛信息去了
            if (myBuddhaHallVc.MyBuddhaArray.count == 4) {
                [myBuddhaHallVc.MyBuddhaArray removeLastObject];
            }
            [myBuddhaHallVc changeBuhhaImage:model withInfo:jsonData];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            
        }
    } failure:^(NSURLSessionDataTask *task, id responseObject){
        
    }];
}

@end

//传值
@implementation button_fozu


@end

