//
//  SeachBookOrMusicViewController.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/10/9.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//
#import "HeaderFile.h"
#import "MySearchBar.h"
#import "OnlineMusicTableViewCell.h"
#import "ClassicBookCell.h"
#import "WisdomModel.h"
#import "SearchBookOrMusicViewController.h"
@interface SearchBookOrMusicViewController ()<MySearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    MySearchBar  * mySearchBar;
}
@property(nonatomic,strong)UITableView  *  searchResultView;
@property(nonatomic,strong)NSMutableArray  *  searchResultArray;
@end

@implementation SearchBookOrMusicViewController
#pragma mark ---  初始化
-(NSMutableArray *) searchResultArray
{
    if (_searchResultArray == nil) {
        _searchResultArray = [[NSMutableArray alloc] init];
    }
    return _searchResultArray;
}
-(UITableView *) searchResultView
{
    if (_searchResultView == nil) {
        _searchResultView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVBARHEIGHT + 50, SCREEN_WIDTH,SCREEN_HEIGHT - NAVBARHEIGHT - 50)];
        //_searchResultView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
        _searchResultView.separatorStyle =  NO;
        //_searchResultView.backgroundColor = [UIColor yellowColor];
        _searchResultView.delegate = self;
        _searchResultView.dataSource = self;
    }
    return _searchResultView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createMySearchBar];
    [self createNavBar];
     self.view.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
}
#pragma mark  --- 创建搜索条
-(void)createMySearchBar
{
    MySearchBar  * searchBar = [[MySearchBar alloc] initWithFrame:CGRectMake(0, NAVBARHEIGHT,SCREEN_WIDTH,50)];
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.cancelButtonHidden = NO;
    NSArray  * hintStrArray = @[@"请输入搜索的经书关键词",@"请输入搜索的诵经名关键词"];
    NSString * placeHolderStr = hintStrArray[self.searchType];
    searchBar.placeholder = NSLocalizedString(placeHolderStr,nil);
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
}
//三
#pragma mark ----  创建
-(void)createNavBar
{
    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NAVBARHEIGHT)];
    [navBar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    UINavigationItem *titleItem = [[UINavigationItem alloc]initWithTitle:@"搜索"];
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
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -----  MySearchBar的代理方法
-(void)searchBarCancelButtonClicked:(MySearchBar *)searchBar
{
    [mySearchBar resignFirstResponder];
    [self.view endEditing:YES];
    if ([mySearchBar.text  isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提 示" message:@"请输入搜索的信息" delegate: self cancelButtonTitle:@"好的,知道了" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    else
    {
        [self loadDataWithKeyStr:searchBar.text];
         searchBar.text = @"";
        [mySearchBar resignFirstResponder];
    }
}
#pragma mark ---- 申请网络数据
-(void)loadDataWithKeyStr:(NSString *) keyStr
{
    AppDelegate  * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * miyaoNum = [delegate.accountBasicDict objectForKey:@"secretKey"];
    NSNumber * huaien =   [delegate.accountBasicDict  objectForKey:@"huaienID"];
    NSDictionary * dict = @{@"secretKey":miyaoNum,@"huaienID":huaien,@"bookType":[NSNumber numberWithInteger:self.searchType+1],@"keywords":keyStr};
    NSArray  * keyArray  = @[@"secretKey",@"huaienID",@"bookType",@"keywords"];
    NSString * jsonParamsStr  = @"{";
    for(int i = 0 ; i < keyArray.count ; i++)
    {
        NSString  * keyValue = keyArray[i];
        if (i == keyArray.count - 1) {
             jsonParamsStr = [NSString stringWithFormat:@"%@%@:%@}",jsonParamsStr,keyValue,[dict valueForKey:keyValue]];
        }
        else
        {
              jsonParamsStr = [NSString stringWithFormat:@"%@%@:%@,",jsonParamsStr,keyValue,[dict valueForKey:keyValue]];
        }
    }
     NSString * url = [NSString stringWithFormat:@"%@%@params=%@",__kBaseURLString,SearchWordsURL,jsonParamsStr];
    [delegate.sessionManager GET:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
          id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber  * result = jsonData[@"result"];
        [self.searchResultArray removeAllObjects];
         if ([result integerValue] == 0) {
        
            NSArray  * dataArray = jsonData[@"data"];
            if (dataArray.count == 0 )
             {
                
                UILabel *label = [[UILabel alloc]init];
                label.frame = CGRectMake(SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.78, 100, 30);
                label.text = @"没有搜索结果!";
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
                 if (self.searchType == NO)  {
                     for(int i = 0 ; i < dataArray.count ; i++)
                     {
                         NSDictionary  * bookDict = dataArray[i];
                         WisdomModel * model = [[WisdomModel alloc] init];
                         [model setValuesForKeysWithDictionary:bookDict];
                         [self.searchResultArray addObject:model];
                     }
                 }
                 else
                 {
                     for(int i = 0 ; i < dataArray.count ; i++)
                     {
                         NSDictionary  * bookDict = dataArray[i];
                         WisdomModel * model = [[WisdomModel alloc] init];
                         [model setValuesForKeysWithDictionary:bookDict];
                         NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithDictionary:@{@"model":model,@"isDownLoad":@0}];
                         [self.searchResultArray addObject:dict];
                     }
                 }
                 if (_searchResultView == nil) {
                     [self.view addSubview:self.searchResultView];
                 }
                else
                {
                    [self.searchResultView reloadData];
                }
            }
        }
        else
        {
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.78, 100, 30);
            label.text = @"操作失败!";
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
#pragma mark  ---UITableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResultArray.count;
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchType == NO) {
        static NSString  * cellId = @"cellID";
        WisdomModel *model = self.searchResultArray[indexPath.row];
        ClassicBookCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[ClassicBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [cell setModel:model];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        cell.expandBlock = ^void(WisdomModel * model)
        {
            [self dowloadBookContent:model.bookId];
        };
        return cell;
    }
    else
    {
        static  NSString * cellId1 = @"cellID1";
        NSMutableDictionary *  dict = self.searchResultArray[indexPath.row];
        OnlineMusicTableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:cellId1];
        if (cell == nil) {
            cell = [[OnlineMusicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setMusicInfoDictionary:dict];
         cell.block = ^void(WisdomModel  *model)
        {
            [self downLoadFileWithModel:model WithIndexPath:indexPath];
        };
        cell.hintBlock = ^void(WisdomModel * model)
        {
            [self showHintHasDownLoadWithModel:model];
        };
        return cell;
    }
}
//-(CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return  60;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchType == NO) {
        return 60;
    }
    else
    {
        return 58;
    }
}
#pragma mark  ------诵经下载处理
//下载歌词及歌曲
//用于歌词和歌曲都下载完的标记
int flagDownLoadMusic11 = 0 ;
int flagDownLoadLysic11 = 0 ;
-(void)downLoadFileWithModel:(WisdomModel * )model WithIndexPath:(NSIndexPath *) indexPath
{
    NSString  *url1 =  [model.downloadUrl_r stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [NetWorking sendAsynchronousRequestWithURLString:url1 completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError == nil) {
            flagDownLoadMusic11 = 1;
            [self selectAllFileWith:model WithData:data Islyrics:NO];
            [self showHintLabelWithModel:model WithIndexPath:indexPath];
        }
    }];
    NSString  *url2  = [model.downloadUrl_w stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [NetWorking sendAsynchronousRequestWithURLString:url2 completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError == nil) {
            flagDownLoadLysic11 = 1;
            [self selectAllFileWith:model WithData:data Islyrics:YES];
            [self showHintLabelWithModel:model WithIndexPath:indexPath];
        }
    }];
}
#pragma mark ----用于显示已经下载完
-(void)showHintLabelWithModel:(WisdomModel *) model WithIndexPath:(NSIndexPath *) indexPath
{
    if (flagDownLoadLysic11 && flagDownLoadMusic11) {
        flagDownLoadLysic11  = 0 ;
        flagDownLoadMusic11  = 0 ;
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
                NSMutableDictionary  * dict = self.searchResultArray[indexPath.row];
                [dict setObject:@0 forKey:@"isDownLoad"];
                [self.searchResultView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
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
        NSDictionary * dict =  @{txtName:data};
        [lrcOrMp3MutableArray  addObject:dict];
        [[NSUserDefaults standardUserDefaults] setObject:lrcOrMp3Array forKey:[NSString stringWithFormat:@"%@Array",flagStr]];
    }
    else
    {
        NSDictionary * dict =  @{txtName:data};
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
        NSNumber  *resultNumber = jsonBook[@"result"];
        if ([resultNumber isEqualToNumber:@0]) {
            
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.78, 100, 30);
            label.text = @"收藏成功!";
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
            label.text = @"已经收藏!";
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
