//
//  ChangeSkinViewController.m
//  Bodhicitta
//
//  Created by 怀恩03 on 15/9/15.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "ChangeSkinViewController.h"
#import "HMSegmentedControl.h"
#import "HeaderFile.h"
#import "BgImagViewCollectionViewCell.h"
#import "BgImageModel.h"
@interface ChangeSkinViewController()<UITableViewDataSource,UITableViewDelegate,MyLayoutDelegte,UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIButton *selectBtn;
}
@property(nonatomic,strong)HMSegmentedControl  *segmentControl;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UIImageView  *bgImageView;
@property(nonatomic,strong)UITableView   *selectTableView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)MyLayout  *layout;
@property(nonatomic,strong)NSMutableArray *bgImageArray;
@property(nonatomic,strong)NSMutableDictionary * userInfoDict;
@end
@implementation ChangeSkinViewController
-(NSMutableDictionary *) userInfoDict
{
    if(_userInfoDict ==  nil)
    {
        _userInfoDict = [[NSMutableDictionary alloc] init];
    }
    return _userInfoDict;
}
-(NSMutableArray *) bgImageArray
{
    if (_bgImageArray == nil) {
        _bgImageArray = [[NSMutableArray alloc] init];
    }
    return _bgImageArray;
}
-(UITableView *)selectTableView
{
    if (_selectTableView ==  nil) {
        _selectTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH,0,SCREEN_WIDTH,SCREEN_HEIGHT - NAVBARHEIGHT - 50) style:UITableViewStylePlain];
        _selectTableView.delegate = self;
        _selectTableView.dataSource = self;
        _selectTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    }
    return _selectTableView;
}
-(MyLayout *)layout
{
    if (_layout == nil) {
        _layout = [[MyLayout alloc] init];
        _layout.sectionInsets = UIEdgeInsetsMake(5,10,5,10);
        _layout.itemSpace = 10 ;
        _layout.lineSpace = 5 ;
        _layout.delegate = self;
    }
    return _layout;
}
-(UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        _collectionView  = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT - NAVBARHEIGHT - 50) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor  clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[BgImagViewCollectionViewCell class] forCellWithReuseIdentifier:@"BgImagViewCollectionViewCellID"];
    }
    return _collectionView;
}
-(UIScrollView *) scrollView
{
    if (_scrollView == nil)
    {
        _scrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0,NAVBARHEIGHT + 50 + 0.2 * SCREEN_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT- NAVBARHEIGHT - 50)];
        //[_scrollView addSubview:self.collectionView];
        [_scrollView addSubview:self.selectTableView];
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
    //默认刚进来时没有改变
    self.isChange = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.segmentControl];
    [self createNavBar];
    [self loadData];
}
-(HMSegmentedControl * )segmentControl
{
    if (_segmentControl  == nil) {
        _segmentControl = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0,NAVBARHEIGHT,SCREEN_WIDTH,50)];
        [_segmentControl setSectionTitles:@[@"推荐",@"自定义"]];
        [_segmentControl  setSelectedSegmentIndex:0];
        [_segmentControl  setBackgroundColor:[UIColor whiteColor]];
        [_segmentControl  setTextColor:[UIColor blackColor]];
        [_segmentControl  setSelectedTextColor:SelectTitleColor];
        [_segmentControl  setSelectionStyle:HMSegmentedControlSelectionStyleBox];
        [_segmentControl  setSelectionIndicatorColor:SelectTitleColor];
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
-(void)createUI
{
    self.bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,NAVBARHEIGHT + 50,SCREEN_WIDTH,0.2 *SCREEN_HEIGHT)];
    self.bgImageView.image = [UIImage imageNamed:@""];
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.scrollView];
}
-(void)createNavBar
{
    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NAVBARHEIGHT)];
    [navBar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景"] forBarMetrics:UIBarMetricsDefault];
    UINavigationItem *titleItem = [[UINavigationItem alloc]initWithTitle:@"个性页面"];
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
    
    UIButton * rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(20,20,30,25)];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [titleItem setRightBarButtonItem:rightItem];
    [navBar pushNavigationItem:titleItem animated:NO];
    [self.view addSubview:navBar];
}
-(void)backBtnClick
{
    //返回时把图片带回 前提是图片有改
//    if (self.isChange)
//    {
//          self.block(self.bgImageView.image);
//    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -----保存 点击保存时将
-(void)rightBtnClick
{
   //调接口把 bgImageView的图上传
//    self.isChange = YES;
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.userInfoDict=delegate.accountBasicDict;
    NSDictionary * dic = @{@"secretKey":[self.userInfoDict objectForKey:@"secretKey"],@"userLoginID":[self.userInfoDict objectForKey:@"userLoginID"],@"huaienID":[self.userInfoDict objectForKey:@"huaienID"],@"backgroundImg":self.bgImageView.image};
    NSDictionary * imageDic=@{@"params":[NSString stringWithFormat:@"%@",dic]};
    [delegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,UptUserURL] parameters:imageDic success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"保存图片=%@",jsonData);
        if (self.isChange)
        {
            self.block(self.bgImageView.image);
        }
        [self.navigationController popViewControllerAnimated:YES];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
   
}
#pragma mark ----- 获取系统提供的候选背景List

-(void)loadData
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,ptxGetUserBackGroundImgListURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
      id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"获取系统提供的候选背景List=%@",jsonData);
        NSArray  * array = jsonData[@"data"];
        for(int i = 0 ; i < array.count; i++)
        {
            NSDictionary  *dict = array[i];
            BgImageModel * model = [[BgImageModel alloc] init];
            if (i == 0) {
                [self.bgImageView setImageWithURL:[NSURL URLWithString:model.materialUrl] placeholderImage:[UIImage imageNamed:@"bluesky_fozu.jpg"]];
            }
            [model setValuesForKeysWithDictionary:dict];
            [self.bgImageArray addObject:model];
        }
         [self.scrollView addSubview:self.collectionView];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}
#pragma mark ----- Layout代理方法
-(NSInteger) numberOfColumns
{
    return 3;
}
-(CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
#pragma mark -----UICollectionView代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.bgImageArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BgImageModel * model = self.bgImageArray[indexPath.row];
    BgImagViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BgImagViewCollectionViewCellID" forIndexPath:indexPath];
    [cell  setModel:model];
    WS(weakSelf);
    __weak BgImagViewCollectionViewCell *weakCell = cell;
     cell.block =  ^void(UIImage *image)
    {
        weakSelf.isChange = YES;
        [weakSelf selectBgImageWithBtn:weakCell.selectBtn WithImage:image];
    };
   
    return cell;
}
-(void)selectBgImageWithBtn:(UIButton *)btn WithImage:(UIImage *) image
{
    if (btn == selectBtn) {
        return;
    }
    btn.hidden = NO;
    selectBtn.hidden = YES;
    selectBtn = btn;
    self.bgImageView.image = image;
}
#pragma mark -------UITableView代理
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *titleArray = @[@"拍照",@"从相册中选择"];
    NSString * cellID = @"cellID1";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *titleStr = titleArray[indexPath.row];
    cell.textLabel.text = titleStr;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(5,cell.contentView.frame.size.height - 1,SCREEN_WIDTH - 10,1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.alpha = 0.3;
    [cell.contentView addSubview:lineView];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UIImagePickerController * pickerController = [[UIImagePickerController alloc]init];
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerController.delegate = self;
        pickerController.allowsEditing =  YES;
        [self presentViewController:pickerController animated:YES completion:nil];
    }
    else
    {
        UIImagePickerController *pickeImageVC = [[UIImagePickerController alloc]init];
        pickeImageVC.delegate = self;
        pickeImageVC.allowsEditing  = YES;
        pickeImageVC.sourceType  = UIImagePickerControllerSourceTypeCamera;
        // [self presentViewController:pickeImageVC animated:YES completion:nil];
        [self presentModalViewController:pickeImageVC animated:nil];
    }
}
#pragma mark  UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString * type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        self.isChange = YES;
      self.bgImageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }
    [picker dismissModalViewControllerAnimated:YES];
}
@end
