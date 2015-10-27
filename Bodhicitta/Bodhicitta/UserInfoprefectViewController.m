//
//  UserInfoprefectViewController.m
//  Bodhicitta
//
//  Created by 怀恩11 on 15/9/21.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "UserInfoprefectViewController.h"
#import "UserInfoEditingTableViewCell.h"
#import "TieUpTeleNumberViewController.h"
#import "TieUpEmailViewController.h"
#import "ProvinceViewController.h"
#import "HeaderFile.h"
#import "ChangeSkinViewController.h"
#import "LeftViewController.h"
#import "ZhuYeMianViewController.h"
@interface UserInfoprefectViewController()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIImageView  * imageView1;
    BOOL    isIndex;
    BOOL    isKeyboardShow;
    //选择的性别
    NSInteger  sexIndex;
    //选择的生肖
    NSInteger  animalSignIndex;
    UITextField  * editingFiled;
    NSString *_isUptPubInfo;
    NSString *_sex;
    NSString *_isUptPtxInfo;
    
    
}
@property(nonatomic,strong)UIImage  * headImage;
@property(nonatomic,strong)UIImage  * bgImage;
@property(nonatomic,strong)NSDictionary  *userDict;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray  * titleArray;
@property(nonatomic,strong)NSArray  * placeHolderArray;
@property(nonatomic,strong)NSMutableDictionary *userInfoDict;
@property(nonatomic,strong)NSArray * fixedArray;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UIActionSheet  *sexActionSheet;
@property(nonatomic,strong)UIActionSheet  *animalSignActionSheet;
@property(nonatomic,strong)UIActionSheet  *headImageActionSheet;
@property(nonatomic,strong)NSArray  *sexArray;
@property(nonatomic,strong)NSArray  *animalSignArray;
@property(nonatomic,strong)UIDatePicker  *datePicker;
@property(nonatomic,strong)UIView  *datePickerView;
@property(nonatomic,strong)UIView  *maskView;
@property(nonatomic,strong)NSMutableArray *filedArray;
@property(nonatomic,strong)UIButton * baocun;
@property(nonatomic,strong)UINavigationBar * bar;
//自己写的
@property (nonatomic,strong)UITextField *nicknameField;
@property (nonatomic,strong)UITextField *autographField;
@property (nonatomic,strong)UITextField *nameField;
@property (nonatomic,strong)UITextField *sexField;
@property (nonatomic,strong)UITextField *birthdayField;
@property (nonatomic,strong)UITextField *zodiacField;
@property (nonatomic,strong)UITextField *phoneNumberField;
@property (nonatomic,strong)UITextField *emailField;
@property (nonatomic,strong)UITextField *addressField;

@end
@implementation UserInfoprefectViewController
#pragma mark ---自定义---
-(NSMutableArray *)filedArray
{
    if (_filedArray == nil) {
        _filedArray = [[NSMutableArray alloc] init];
    }
    return _filedArray;
}
-(UIView *)maskView
{
    if (_maskView == nil) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.7;
    }
    return _maskView;
}
-(UIView *)datePickerView
{
    if (_datePickerView == nil) {
        _datePickerView = [[UIView alloc] initWithFrame:CGRectMake(0.1 *SCREEN_WIDTH ,0.28 * SCREEN_HEIGHT,0.8 * SCREEN_WIDTH,0.4 * SCREEN_HEIGHT)];
        _datePickerView.backgroundColor = [UIColor whiteColor];
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0,0,_datePickerView.frame.size.width,0.2 * _datePickerView.frame.size.height)];
        UILabel * hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,_datePickerView.frame.size.width,_datePickerView.frame.size.height * 0.2)];
        hintLabel.text = @"选择生辰";
        hintLabel.backgroundColor = [UIColor clearColor];
        hintLabel.font = [UIFont systemFontOfSize:17];
        hintLabel.textColor = [UIColor blueColor];
        hintLabel.textAlignment = NSTextAlignmentCenter;
        topView.backgroundColor = [UIColor colorWithRed: 231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:1];
        [_datePickerView addSubview:topView];
        [_datePickerView addSubview:hintLabel];
        
        //时间选择器
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(topView.frame), _datePickerView.frame.size.width,0.6 *_datePickerView.frame.size.height)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans"];
        _datePicker.timeZone = [NSTimeZone localTimeZone];
        _datePicker.minimumDate = [NSDate dateWithTimeIntervalSince1970:0];
        _datePicker.maximumDate = [NSDate date];
        [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventEditingChanged];
        [_datePickerView addSubview:_datePicker];
        
        UIView  * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,0.8 * _datePickerView.frame.size.height,_datePicker.frame.size.width,0.2 * _datePickerView.frame.size.height)];
        
        UIButton  * resignBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0.8 *_datePickerView.frame.size.height,_datePickerView.frame.size.width* 0.5- 0.5, bottomView.frame.size.height)];
        //resignBtn.backgroundColor = [UIColor colorWithRed: 231/255.0 green: 231 / 255.0 blue:231 / 255.0 alpha:1];
        [resignBtn setTitle:@"取消" forState:UIControlStateNormal];
        resignBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [resignBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [resignBtn addTarget:self action:@selector(datePickerResignBtnClick) forControlEvents:UIControlEventTouchDragInside];
        
        UIView *seperatorLineView = [[UIView alloc] initWithFrame:CGRectMake(_datePickerView.frame.size.width* 0.5,5+0.8*_datePickerView.frame.size.height,1,bottomView.frame.size.height - 10)];
        seperatorLineView.backgroundColor = [UIColor darkGrayColor];
        seperatorLineView.alpha = 0.3;
        
        UIButton  *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(_datePickerView.frame.size.width* 0.5+0.5,0.8 * _datePickerView.frame.size.height,0.5 * _datePickerView.frame.size.width,bottomView.frame.size.height)];
        [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
        submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [submitBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        submitBtn.backgroundColor= [UIColor colorWithRed: 231 / 255.0 green:231 /  255.0 blue: 231 /  255.0 alpha:1];
        bottomView.backgroundColor = [UIColor colorWithRed:231 / 255.0 green: 231 / 255.0 blue:231 /  255.0 alpha:1];
        [submitBtn addTarget:self action:@selector(datePickerSubmitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_datePickerView addSubview:bottomView];
        CALayer *datePickViewLayer = _datePickerView.layer;
        datePickViewLayer.cornerRadius = 10;
        datePickViewLayer.masksToBounds = YES;
        
        [_datePickerView addSubview:resignBtn];
        [_datePickerView addSubview:seperatorLineView];
        [_datePickerView addSubview:submitBtn];
    }
    return _datePickerView;
}
-(UIDatePicker *) datePicker
{
    if (_datePicker == nil) {
        
    }
    return _datePicker;
}
-(UIActionSheet  *)headImageActionSheet
{
    if (_headImageActionSheet == nil) {
        _headImageActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    }
    return _headImageActionSheet;
}
-(UIActionSheet  *)sexActionSheet
{
    if (_sexActionSheet == nil) {
        _sexActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女",@"保密", nil];
    }
    return _sexActionSheet;
}
-(UIActionSheet *)animalSignActionSheet
{
    if (_animalSignActionSheet == nil) {
        _animalSignActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪", nil];
    }
    return _animalSignActionSheet;
}
-(NSArray *)sexArray
{
    if (_sexArray == nil) {
        _sexArray = @[@"男",@"女",@"保密"];
    }
    return _sexArray;
}
-(NSArray *)animalSignArray
{
    if (_animalSignArray == nil) {
        _animalSignArray  = @[@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪"];
    }
    return _animalSignArray;
}
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(imageView1.frame)+8,SCREEN_WIDTH,self.view.frame.size.height - imageView1.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        // _tableView.scrollEnabled = YES;
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}
-(NSArray *) fixedArray
{
    if (_fixedArray == nil) {
        //_fixedArray = @[@"nickName",@"signature",@"realName",@"sex",@"birthday",@"animalSign",@"mobile",@"Email",@"nowAddr"];
        _fixedArray=@[@"nickName",@"signature",@"realName",@"sex",@"birthday",@"animalSign",@"mobile",@"Email",@"nowAddr"];
    }
    return _fixedArray;
}
-(NSMutableDictionary *) userInfoDict
{
    if(_userInfoDict ==  nil)
    {
        _userInfoDict = [[NSMutableDictionary alloc] init];
    }
    return _userInfoDict;
}
#pragma mark ------- 标签
-(NSArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = @[@"昵称",@"签名",@"姓名",@"性别",@"生辰",@"生肖",@"手机",@"所在地"];
    }
    return _titleArray;
}
#pragma mark  ------ 默认
-(NSArray *)placeHolderArray
{
    if (_placeHolderArray == nil) {
        _placeHolderArray = @[@"请输入昵称",@"请输入个性签名",@"请输入真实姓名",@"点击选择性别",@"点击选择生日",@"点击选择生肖",@"手机",@"你的所在地"];
    }
    return _placeHolderArray;
}
#pragma mark -------
-(void)viewDidLoad
{
    
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor colorWithRed:235.0f/255.0f green:235.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
   
    isKeyboardShow = NO;
    [self createNavBar];
    [self createUI];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myKeybordWillShow:) name:@"UIKeyboardWillShowNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:@"UIKeyboardWillHideNotification" object:nil];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)myKeybordWillShow:(NSNotification *) not
{
    if (isKeyboardShow ) return;
    NSDictionary  *userInfo = not.userInfo;
    NSTimeInterval duration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        isKeyboardShow = YES;
        CGRect frame = self.view.frame;
        frame.origin.y -= 50;
        self.view.frame = frame;
    }];
}
-(void)keyboardWillHide:(NSNotification *) not
{
    isKeyboardShow = NO;
    NSDictionary  *userInfo = not.userInfo;
    NSTimeInterval duration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y += 50;
        self.view.frame = frame;
    }];
}
-(void)createNavBar
{
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    _bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.1)];
    [_bar setBackgroundImage:[UIImage imageNamed:@"顶部导航背景.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:_bar];
    
    UIButton * bu=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.01, 0.05*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.08*SCREEN_WIDTH)];
    [bu setBackgroundImage:[UIImage imageNamed:@"返回上级.png"] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bar addSubview:bu];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4,0.01*SCREEN_HEIGHT,0.5*SCREEN_WIDTH,0.1*SCREEN_HEIGHT+10)];
    title.text=@"完善资料";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [_bar addSubview:title];
    
    _baocun=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.85, 0.05*SCREEN_HEIGHT, 0.05*SCREEN_WIDTH+30, 0.08*SCREEN_WIDTH)];
    [_baocun setTitle:@"跳过" forState:UIControlStateNormal];
    [_baocun setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_baocun addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bar addSubview:_baocun];
}

-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
  
}
- (void)rightBtnClick
{
    ZhuYeMianViewController *zhuyeVC =[[ZhuYeMianViewController alloc]init];
    [self.navigationController pushViewController:zhuyeVC animated:YES];
}

-(void)createUI
{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,NAVBARHEIGHT,SCREEN_WIDTH,0.3 * SCREEN_HEIGHT)];
    imageView1 = imageView;
    imageView.image = [UIImage imageNamed:@"背景.jpg"];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.center.x - 0.2 * imageView.frame.size.height,0.2 * imageView.frame.size.height,0.4 * imageView.frame.size.height,0.4 * imageView.frame.size.height)];
    self.headImageView.image = [UIImage imageNamed:@"默认头像"];
    self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
    CALayer  *layerHeadImageViewLayer = self.headImageView.layer;
    layerHeadImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
    layerHeadImageViewLayer.borderWidth = 1.5;
    layerHeadImageViewLayer.masksToBounds = YES;
    layerHeadImageViewLayer.cornerRadius = self.headImageView.frame.size.height * 0.5;
    [imageView addSubview:self.headImageView];
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(imageView.frame) - 0.25*imageView.frame.size.height,SCREEN_WIDTH,0.25*imageView.frame.size.height)];
    maskView.alpha = 0.2;
    maskView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:maskView];
    
    UIButton *changeIconBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,maskView.frame.origin.y,0.5 * SCREEN_WIDTH,maskView.frame.size.height)];
    [changeIconBtn setTitle:@"更换头像" forState:UIControlStateNormal];
    changeIconBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [changeIconBtn addTarget:self action:@selector(changeIconBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeIconBtn];
    
    UIButton * changeBgBtn =  [[UIButton alloc] initWithFrame:CGRectMake(0.5 * SCREEN_WIDTH,maskView.frame.origin.y,0.5 * SCREEN_WIDTH,maskView.frame.size.height)];
    [changeBgBtn setTitle:@"更换封面" forState:UIControlStateNormal];
    changeBgBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [changeBgBtn addTarget:self action:@selector(changeBgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBgBtn];
    [self.view addSubview:self.tableView];
    UIButton *saveBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 40*8+self.tableView.frame.origin.y+30, SCREEN_WIDTH, 43)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font=[UIFont systemFontOfSize:20];
    saveBtn.backgroundColor=[UIColor whiteColor];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitleColor:majorityColor forState:UIControlStateNormal];
    [self.view addSubview:saveBtn];
    [self loadMemberData];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, saveBtn.frame.origin.y+saveBtn.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:view];
    //[self loadPutixinData];
}

- (void)fieldAction:(UITextField*)field
{
    
}
#pragma mark ---- 更换头像
-(void)changeIconBtnClick
{
    [self.headImageActionSheet showInView:self.view];
}
#pragma matk ---- 更换封面
-(void)changeBgBtnClick
{
    ChangeSkinViewController *changeSkinVc = [[ChangeSkinViewController alloc]init];
    changeSkinVc.block  = ^void(UIImage *image)
    {
        imageView1.image = image;
    };
    [self.navigationController pushViewController:changeSkinVc animated:YES];
}
-(void)loadMemberData
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.userDict = delegate.accountBasicDict;
    NSDictionary *dict = @{@"huaienID":[[NSUserDefaults standardUserDefaults]objectForKey:@"result"]};
    NSDictionary * paramsDict = @{@"params":[NSString stringWithFormat:@"%@",dict]};
    [delegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,memberVipURL] parameters:paramsDict success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:
                       NSJSONReadingMutableContainers error:nil];
        NSLog(@"下载用户基本信息=%@",jsonData);
        NSNumber * result = jsonData[@"result"];
        if ([result integerValue] == 0) {
            [self.userInfoDict setObject:jsonData[@"mobile"] forKey:@"mobile"];
            [self.userInfoDict setObject:jsonData[@"Email"] forKey:@"Email"];
            [self.userInfoDict setObject:jsonData[@"realName"] forKey:@"realName"];
            [self.userInfoDict setObject:jsonData[@"isAuth"] forKey:@"isAuth"];
            [self.userInfoDict setObject:jsonData[@"userType"] forKey:@"userType"];
            [self.userInfoDict setObject:jsonData[@"userStatus"] forKey:@"userStatus"];
        }
        [self.tableView reloadData];
        NSLog(@"用户字典＝%@",self.userInfoDict);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}
#pragma mark ----- 保存
-(void)saveBtnClick
{
    NSArray  *keyArray =@[@"secretKey",@"huaienID",@"userLoginID",@"isUptPtxInfo",@"nickName",@"sex",@"signature",@"birthdayType",@"birthday",@"constellation",@"animalSign",@"nowCity",@"nowAddr",@"headImg",@"isVIP",@"createDate",@"isUptPubInfo",@"realName"];
    //_fixedArray=@[@"nickName",@"signature",@"realName",@"sex",@"birthday",@"animalSign",@"mobile",@"Email",@"nowAddr",@"signature"];
    NSArray *keyArray1 = @[@"nickName",@"signature",@"realName",@"sex",@"birthday",@"animalSign",@"mobile",@"email",@"nowAddr"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for(int i = 0 ; i < keyArray1.count; i++)
    {
        //3 5 6
        NSString * valueStr;
        if(i == 3||i == 5 ||i == 6)
        {
            
        }
        else
        {
            //昵称，签名 姓名是必须要填写的，这里有问题
            UITextField  *filed = self.filedArray[i];
            valueStr = filed.text;
            NSLog(@"valueStr =%@",valueStr);
            NSString *keyStr = keyArray1[i];
            [dict  setObject:valueStr forKey:keyStr];
        }
    }
    
    [dict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"secretKey"] forKey:@"secretKey"];
    [dict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userLoginID"] forKey:@"userLoginID"];
    //是否修改
    if (self.filedArray[2]!=[[NSUserDefaults standardUserDefaults]objectForKey:@"realName"])
    {
        _isUptPubInfo=@"Y";
    }else{
        _isUptPubInfo =@"N";
    }
    if ([_sex isEqualToString:@"男"]){
        sexIndex=1;
    }else if ([_sex isEqualToString:@"女"]){
        sexIndex=2;
        
    }else{
        sexIndex=3;
    }
    
    //@"\"\""
    [dict setObject:@"N" forKey:@"isUptPtxInfo"];
    [dict setObject:@"N" forKey:@"isVIP"];
    [dict setObject:_isUptPubInfo forKey:@"isUptPubInfo"];
    [dict  setObject:[NSString stringWithFormat:@"%ld",animalSignIndex+1] forKey:@"animalSign"];
    [dict setObject:[NSString stringWithFormat:@"%ld",sexIndex] forKey:@"sex"];
    [dict setObject:[[NSUserDefaults  standardUserDefaults]objectForKey:@"result"]forKey:@"huaienID"];
    [dict setObject:@"S" forKey:@"birthdayType"];
    [dict setObject:@0 forKey:@"constellation"];
    [dict setObject:@"\"\"" forKey:@"createDate"];
    [dict setObject:@"\"\"" forKey:@"nowCity"];
    [dict setObject:@"\"\"" forKey:@"headImg"];
    
    NSString *jsonParamsStr = @"{";
    for(int i = 0 ; i < keyArray.count; i++)
    {
        NSString  *keyValue  = keyArray[i];
        if (i == keyArray.count - 1) {
            jsonParamsStr = [NSString stringWithFormat:@"%@%@:%@}",jsonParamsStr,keyValue,[dict valueForKey:keyValue]];
        }
        else
        {
            jsonParamsStr = [NSString stringWithFormat:@"%@%@:%@,",jsonParamsStr,keyValue,[dict valueForKey:keyValue]];
        }
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@%@params=%@",__kBaseURLString,UserInfoAndRealName,jsonParamsStr];
    NSLog(@"url=%@",urlStr);
    AppDelegate  *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.sessionManager GET:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"保存信息=%@",jsonData);
        ZhuYeMianViewController * zhuye = [[ZhuYeMianViewController alloc]init];
        [self.navigationController pushViewController:zhuye animated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark -----tableView的代理方法
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * cellId = @"cellID";
    UserInfoEditingTableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell =  [[UserInfoEditingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    WS(weakSelf);
    __weak UserInfoEditingTableViewCell *currentCell = cell;
    cell.block = ^void()
    {
        editingFiled = currentCell.filed;
        [weakSelf.view endEditing:YES];
        [weakSelf pushToOtherViewControllerWithIndex:indexPath.row];
    };
    [cell setTitle:self.titleArray[indexPath.row]];
    NSString    * fixStr =  self.fixedArray[indexPath.row];
    
    NSString  * infoStr = [NSString stringWithFormat:@"%@",[self.userInfoDict objectForKey:fixStr]];
    NSLog(@"infoStr=%@",infoStr);
    NSLog(@"str=%@",[self.userInfoDict objectForKey:fixStr]);
    
    [self.filedArray addObject:cell.filed];
    
    //cell.filed.placeholder=@"请输入地址";
  
        NSString * placeHolderStr = self.placeHolderArray[indexPath.row];
        cell.filed.placeholder = placeHolderStr;
    
    if (indexPath.row == 6) {
        
        cell.isHintLabelShow = NO;
        [cell setHintString:@"已绑定"];
        NSLog(@"shouj=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"telePhone"]);

       //cell.filed.text=self.userInfoDict[@"mobile"];
        cell.filed.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"telePhone"];
    }
    else
    {
        cell.isHintLabelShow = NO;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43;
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark -------跳转界面
-(void)pushToOtherViewControllerWithIndex:(NSInteger)index
{
    if (index == 3) {
        [self.sexActionSheet showInView:self.view];
    }
    //显示日期选择器
    if (index == 4) {
        [self.view addSubview:self.maskView];
        [self.view addSubview:self.datePickerView];
    }
    if (index == 5) {
        [self.animalSignActionSheet showInView:self.view];
    }
    if (index ==  6) {
        TieUpTeleNumberViewController  *tieUpVc = [[TieUpTeleNumberViewController alloc] init];
        tieUpVc.block = ^void(NSString *teleNumberStr)
        {
            editingFiled.text = teleNumberStr;
        };
        [self.navigationController pushViewController:tieUpVc animated:YES];
    }
//    if (index == 7)
//    {
//        TieUpEmailViewController  *tieUpEmailVc = [[TieUpEmailViewController alloc] init];
//        tieUpEmailVc.block = ^void(NSString * emailStr)
//        {
//            editingFiled.text = emailStr;
//        };
//        [self.navigationController pushViewController:tieUpEmailVc animated:YES];
//    }
    if (index == 7) {
        ProvinceViewController  * provinceVC = [[ProvinceViewController alloc] init];
        provinceVC.createVc = self;
        [self.navigationController pushViewController:provinceVC animated:YES];
    }
}
#pragma mark ------从具体地址的界面跳回
-(void)changeAddressFunctionWithAdressStr:(NSString *) addressStr
{
    editingFiled.text =  addressStr;
}
#pragma mark ------UIActionSheet的代理方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet == self.sexActionSheet) {
        if (buttonIndex == 3) {
            return;
        }
        sexIndex = buttonIndex;
        editingFiled.text = self.sexArray[buttonIndex];
    }
    if (actionSheet == self.animalSignActionSheet) {
        if (buttonIndex == 12){
            return;
        }
        animalSignIndex = buttonIndex;
        editingFiled.text  = self.animalSignArray[buttonIndex];
    }
    if (actionSheet == self.headImageActionSheet ) {
        if (buttonIndex == 0) {
            UIImagePickerController * pickerController = [[UIImagePickerController alloc]init];
            pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerController.delegate = self;
            pickerController.allowsEditing =  YES;
            [self presentViewController:pickerController animated:YES completion:nil];
        }
        if (buttonIndex == 1) {
            UIImagePickerController *pickeImageVC = [[UIImagePickerController alloc]init];
            pickeImageVC.delegate = self;
            pickeImageVC.allowsEditing  = YES;
            pickeImageVC.sourceType  = UIImagePickerControllerSourceTypeCamera;
            // [self presentViewController:pickeImageVC animated:YES completion:nil];
            [self presentModalViewController:pickeImageVC animated:nil];
        }
    }
}
#pragma mark ------处理时间
-(void)datePickerValueChanged:(UIDatePicker *) dp
{
    NSDateFormatter  *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.timeZone = [NSTimeZone localTimeZone];
    NSString   *dateString  = [formatter stringFromDate:dp.date];
    editingFiled.text = dateString;
}
#pragma mark --------
-(void)datePickerResignBtnClick
{
    [self.maskView removeFromSuperview];
    [self.datePickerView removeFromSuperview];
}
#pragma mark ---------
-(void)datePickerSubmitBtnClick
{
    NSDateFormatter  *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.timeZone = [NSTimeZone localTimeZone];
    NSString   *dateString  = [formatter stringFromDate:self.datePicker.date];
    editingFiled.text = dateString;
    [self.maskView removeFromSuperview];
    [self.datePickerView removeFromSuperview];
}
#pragma mark  UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString * type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        self.headImage =  [info objectForKey:@"UIImagePickerControllerOriginalImage"];
       
        self.headImageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }
    [picker dismissModalViewControllerAnimated:YES];
}
/**
 *  等比例缩放
 *
 *  @param targetSize 大小
 *
 *  @return
 */
// 改变图像的尺寸，方便上传服务器
- (UIImage *)scaleFromImage:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
