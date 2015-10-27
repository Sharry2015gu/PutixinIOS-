//
//  FoZhuViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/24.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "FoZhuViewController.h"
#import "HeaderFile.h"
#import "ProgressHUD.h"
#import "BeabsRankViewController.h"
#import "SimpleAudioEngine.h"
#import "AudioToolbox/AudioToolbox.h"
#define beadRadius  (SCREEN_HEIGHT - NAVBARHEIGHT - 50 - 20) / 6
@interface FoZhuViewController ()
{
    UILabel  * myLevelLabel;
    UILabel  * myValueLabel;
    CGPoint  * rightReferencePoint;
    CGPoint  * leftReferencePoint;
    CGPoint  _prePoint;
    BOOL   isExpand;
    CGRect rightBtnFrame;
    CGRect leftBtnFrame;
    //默认手机震动
    BOOL  isShake ;
    //本次波佛珠的次数
    NSInteger   recentTimes;
    
    NSInteger  toDayBeadsNumber ;
    NSInteger  totalNumber;
}
@property(nonatomic,strong)NSMutableArray *fozhuArray;
@property(nonatomic,strong)NSMutableArray *positionArray;
@property(nonatomic,strong)UIView * leftBeadsView;
@property(nonatomic,strong)UIView * rightBeadsView;
@property(nonatomic,strong)UIImageView * beadsImageView;
@property(nonatomic,strong)UIImageView * hintView;
@property(nonatomic,strong)UIButton * rightBtn;
@property(nonatomic,strong)UIView   * whiteView;
@property(nonatomic,strong)UILabel  *  scoreLabel;
@property(nonatomic,strong)UIButton  * rightMenuBtn;
@property(nonatomic,strong)UIButton  * leftMenuBtn;
@property(nonatomic,strong)UIButton  * translateBtn;
@property(nonatomic,strong)UIButton  * pearlBtn;
@property(nonatomic,strong)UIButton  * musicBtn;
@property(nonatomic,strong)UIButton  * volumeBtn;
@property(nonatomic,strong)UIButton  * shakeBtn;
@property(nonatomic,strong)NSArray  * titleBtnArray;
@property(nonatomic,strong)NSMutableArray  * rightFrameArray;
@property(nonatomic,strong)NSMutableArray  * leftFrameArray;
@property(nonatomic,strong)NSMutableArray  * leftBeadArray;
@property(nonatomic,strong)NSMutableArray  * rightBeadArray;
@property(nonatomic,strong)NSMutableArray  * beadPositionArray;
@property(nonatomic,strong)UIView  * leftBeadView;
@property(nonatomic,strong)UIView  * rightReadView;
@property(nonatomic,strong)UISwipeGestureRecognizer *swipeDown;
@property(nonatomic,strong)UIButton * hintBtn;
@property(nonatomic,strong)UILabel *levelLabel;
@property(nonatomic,strong)UILabel *valueLabel;
@end
@implementation FoZhuViewController
-(UISwipeGestureRecognizer *)swipeDown
{
    if (_swipeDown == nil) {
        _swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownActivity)];
        _swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    }
    return _swipeDown;
}
-(UIView *)leftBeadsView
{
    if (_leftBeadsView == nil) {
        _leftBeadsView = [[UIView alloc]initWithFrame:CGRectMake(50,NAVBARHEIGHT + 50,beadRadius,beadRadius * 6)];
        [_leftBeadView addGestureRecognizer:self.swipeDown];
        CALayer *leftBeadsViewLayer = _leftBeadsView.layer;
        leftBeadsViewLayer.masksToBounds = YES;
        for(int i = 0 ; i < 8 ; i++)
        {
            UIImageView * imageView = self.leftBeadArray[i];
            NSNumber * yPosition = self.beadPositionArray[i];
            imageView.frame = CGRectMake(0,[yPosition floatValue],beadRadius,beadRadius);
            [_leftBeadsView addSubview:imageView];
        }
    }
    return _leftBeadsView;
}
-(NSMutableArray *)beadPositionArray
{
    
    if (_beadPositionArray == nil) {
        _beadPositionArray = [[NSMutableArray alloc] init];
        for(int i = 0 ; i < 8; i++)
        {
            [_beadPositionArray addObject:[NSNumber  numberWithInteger:beadRadius * i- beadRadius-beadRadius]];
        }
    }
    return _beadPositionArray;
}
-(NSMutableArray *)leftBeadArray
{
    
    if (_leftBeadArray == nil)
    {
        _leftBeadArray = [[NSMutableArray alloc] init];
        for(int i = 0 ; i < 8 ; i++)
        {
            UIImageView * beadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,beadRadius,beadRadius)];
            beadImageView.userInteractionEnabled = YES;
            beadImageView.image = [UIImage imageNamed:@"beads_one"];
            [beadImageView addGestureRecognizer:self.swipeDown];
            [_leftBeadArray addObject:beadImageView];
        }
    }
    return _leftBeadArray;
}

-(NSMutableArray *)rightFrameArray
{
    CGFloat  radius  =  SCREEN_WIDTH / 2  * 0.8 ;
    if (_rightFrameArray == nil) {
        _rightFrameArray = [[NSMutableArray alloc]init];
        for(int i = 0 ; i <  5 ; i++)
        {
            CGFloat y = CGRectGetMaxY(self.rightMenuBtn.frame) - radius * cosf((18 * i) /  180.00 *  M_PI );
            CGFloat x  =  CGRectGetMinX(self.rightMenuBtn.frame) - radius * sinf((18 * i) /  180.00 *  M_PI) + self.rightMenuBtn.frame.size.width * 0.5;
            NSDictionary *rightFrameDict = @{@"xFrame":[NSNumber numberWithFloat:x],@"yFrame":[NSNumber numberWithFloat:y]};
            [_rightFrameArray addObject:rightFrameDict];
        }
    }
    return _rightFrameArray;
}
-(NSMutableArray *)leftFrameArray
{
    CGFloat radius  =  SCREEN_WIDTH / 2 * 0.8;
    if (_leftFrameArray == nil) {
        _leftFrameArray = [[NSMutableArray  alloc]init];
        for(int i = 0 ; i < 5 ; i++)
        {
            CGFloat y = CGRectGetMaxY(self.leftMenuBtn.frame) - radius * cosf((18 * i ) /180.00 * M_PI);
            CGFloat x =  CGRectGetMaxX(self.leftMenuBtn.frame)+ radius * sinf((18 * i) / 180.00 * M_PI) - self.leftMenuBtn.frame.size.width;
            NSDictionary * leftFrameDict = @{@"xFrame":[NSNumber numberWithFloat:x],@"yFrame":[NSNumber numberWithFloat:y]};
            [_leftFrameArray  addObject:leftFrameDict];
        }
    }
    return _leftFrameArray;
}
-(NSArray *) titleBtnArray
{
    if (_titleBtnArray ==  nil) {
        _titleBtnArray =  @[self.translateBtn,self.pearlBtn,self.musicBtn,self.volumeBtn,self.shakeBtn];
    }
    return _titleBtnArray;
}
#pragma mark  改变左右
-(UIButton *)translateBtn
{
    CGFloat width =  0;
    if (_translateBtn == nil) {
        _translateBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.rightMenuBtn.frame.origin.x,self.rightMenuBtn.frame.origin.y,width,width)];
        [_translateBtn setImage:[UIImage imageNamed:@"putibeads_left_right"] forState:UIControlStateNormal];
    }
    return _translateBtn;
}
#pragma mark  改变珠子肤色
-(UIButton *)pearlBtn
{
    CGFloat width = 0;
    if (_pearlBtn == nil) {
        _pearlBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.rightMenuBtn.frame.origin.x,self.rightMenuBtn.frame.origin.y,width,width)];
        [_pearlBtn setImage:[UIImage imageNamed:@"putibeads_change_skin"] forState:UIControlStateNormal];
    }
    return _pearlBtn;
}
#pragma mark 音乐
-(UIButton *)musicBtn
{
    CGFloat  width  = 0;
    if (_musicBtn == nil) {
        _musicBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.rightMenuBtn.frame.origin.x,self.rightMenuBtn.frame.origin.y,width,width)];
        [_musicBtn setImage:[UIImage imageNamed:@"putibeads_music_off"] forState:UIControlStateNormal];
    }
    return _musicBtn;
}
-(void)musicClick:(UIButton *)btn{
    
    isShake = !isShake;
    if (isShake) {
        
        [btn setImage:[UIImage imageNamed:@"putibeads_music_off"] forState:UIControlStateNormal];
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        
    }else{
        
        [btn setImage:[UIImage imageNamed:@"putibeads_music_on"] forState:UIControlStateNormal];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"beads_bg_music.mp3"];
        
    }
}
#pragma mark 音量
-(UIButton *)volumeBtn
{
    CGFloat  width  = 0;
    if (_volumeBtn == nil) {
        _volumeBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.rightMenuBtn.frame.origin.x,self.rightMenuBtn.frame.origin.y,width,width)];
        [_volumeBtn setImage:[UIImage imageNamed:@"putibeads_bo_off"] forState:UIControlStateNormal];
    }
    return _volumeBtn;
}
-(void)voluClick:(UIButton *)btn{
    
    isShake = !isShake;
    if (isShake) {
        
        [btn setImage:[UIImage imageNamed:@"putibeads_bo_off"] forState:UIControlStateNormal];
        
    }else{
        
        [btn setImage:[UIImage imageNamed:@"putibeads_bo_on"] forState:UIControlStateNormal];
        
    }
    
}
#pragma mark  振动
-(UIButton *) shakeBtn
{
    CGFloat  width  = 0;
    if (_shakeBtn == nil) {
        _shakeBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.rightMenuBtn.frame.origin.x,self.rightMenuBtn.frame.origin.y,width,width)];
        [_shakeBtn setImage:[UIImage imageNamed:@"putibeads_vibrate_off"] forState:UIControlStateNormal];
    }
    return _shakeBtn;
}

-(UIButton *)leftMenuBtn
{
    if (_leftMenuBtn == nil) {
        CGFloat width =   75 * SCREEN_HEIGHT / 667;
        _leftMenuBtn  = [[UIButton alloc] initWithFrame:CGRectMake(20 ,SCREEN_HEIGHT - width - 20,width, width)];
        [_leftMenuBtn setBackgroundImage:[UIImage imageNamed:@"puti_beads_menu_main"] forState:UIControlStateNormal];
        [_leftMenuBtn addTarget:self action:@selector(rightMenuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftMenuBtn;
}

-(UIButton *)rightMenuBtn
{
    if (_rightMenuBtn ==  nil) {
        CGFloat  btnWidth  = 50 * SCREEN_HEIGHT / 667;
        CGFloat width =   75 * SCREEN_HEIGHT / 667;
        _rightMenuBtn  = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - width - btnWidth +30,SCREEN_HEIGHT - width - 20 - 5, 60, 60)];
        [_rightMenuBtn setBackgroundImage:[UIImage imageNamed:@"puti_beads_menu_main"] forState:UIControlStateNormal];
        [_rightMenuBtn addTarget:self action:@selector(rightMenuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightMenuBtn;
}
-(void)singleBtnClick:(UIButton *) btn
{
    NSInteger btnIndex  = btn.tag - 300;
    switch (btnIndex) {
        case 0:
            [self translateMenuBtn];
            break;
        case 1:
            //更改佛珠颜色
            [self changeBeadSkinfunction];
            [self rightMenuBtnClick];
            break;
        case 2:
            [self musicClick:btn];
            break;
        case 3:
            [self voluClick:btn];
            break;
        default:
            [self playShake:btn];
            break;
    }
}
#pragma mark  ----  播放震动
-(void)playShake:(UIButton *) btn
{
    
    isShake = !isShake;
    if (isShake) {
        [btn setImage:[UIImage imageNamed:@"putibeads_vibrate_off"] forState:UIControlStateNormal];
    }
    else
    {
        [btn setImage:[UIImage imageNamed:@"putibeads_vibrate_on"] forState:UIControlStateNormal];
    }
}
static int  skinIndex = 0 ;
#pragma mark  ---- 更改佛珠颜色
-(void)changeBeadSkinfunction
{
    
    if (skinIndex == 2)
    {
        skinIndex = 0;
    }
    else
    {
        skinIndex++;
    }
    NSArray * beadSkinNameStr =  @[@"beads_one",@"beads_two",@"beads_three"];
    NSString  * imageStr = beadSkinNameStr[skinIndex];
    for(int i = 0 ; i < self.leftBeadArray.count;i++)
    {
        UIImageView *beadImageView = self.leftBeadArray[i];
        beadImageView.image = [UIImage imageNamed:imageStr];
    }
}
#pragma mark  ---- 用于左右替换
-(void)translateMenuBtn
{
    //表示左边的显示
    if (self.rightMenuBtn.hidden)
    {
        self.leftMenuBtn.hidden = YES;
        self.rightMenuBtn.hidden = NO;
        self.leftBeadsView.frame = CGRectMake(50,self.leftBeadsView.frame.origin.y,self.leftBeadsView.frame.size.width, self.leftBeadsView.frame.size.height);
    }
    else
    {
        if (_leftMenuBtn == nil) {
            [self.view addSubview:self.leftMenuBtn];
        }
        else
        {
            self.leftMenuBtn.hidden = NO;
        }
        self.rightMenuBtn.hidden = YES;
        self.leftBeadsView.frame = CGRectMake(SCREEN_WIDTH - 50 - beadRadius,self.leftBeadsView.frame.origin.y,beadRadius,self.leftBeadsView.frame.size.height);
    }
    
    for(int i = 1 ; i <  self.titleBtnArray.count; i++)
    {
        UIButton  *btn  = self.titleBtnArray[i];
        [btn removeFromSuperview];
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.translateBtn.alpha = 0;
    } completion:^(BOOL finished) {
        [self.translateBtn removeFromSuperview];
    }];
    isExpand = NO;
    
}
-(void)rightMenuBtnClick
{
    //右边隐藏 左边出现
    if(self.rightMenuBtn.hidden)
    {
        [UIView  animateWithDuration:0.08  animations:^{
            CALayer   * layer  = self.leftMenuBtn.layer;
            layer.transform  = CATransform3DRotate(layer.transform,   M_PI, 0,0,1);
        } completion:^(BOOL finished) {
            [UIView  animateWithDuration:0.08 animations:^{
                CALayer   * layer  = self.leftMenuBtn.layer;
                layer.transform  = CATransform3DRotate(layer.transform,   M_PI, 0,0,1);
            }];
        }];
        if (isExpand == NO)
        {
            CGFloat  width  = 50 * SCREEN_HEIGHT / 667;
            for (int i = 0 ; i < self.titleBtnArray.count; i++)
            {
                UIButton * btn = self.titleBtnArray[i];
                btn.frame = CGRectMake(self.leftMenuBtn.frame.origin.x,self.leftMenuBtn.frame.origin.y,0, 0);
                [self.view addSubview:btn];
                self.translateBtn.alpha = 1;
                btn.tag = 300 + i;
                [self.view addSubview:btn];
                [UIView animateWithDuration:0.16 animations:^{
                    NSDictionary * dict = self.leftFrameArray[i];
                    NSNumber  *xNumber = [dict objectForKey:@"xFrame"];
                    NSNumber  *yNumber = [dict objectForKey:@"yFrame"];
                    CGFloat  x = [xNumber integerValue];
                    CGFloat  y = [yNumber  integerValue];
                    btn.frame = CGRectMake(x, y,width, width);
                }];
            }
            //展开后状态改变
            isExpand = YES;
        }
        else
        {
            for (int i = 0 ; i < self.titleBtnArray.count; i++)
            {
                UIButton * btn = self.titleBtnArray[i];
                btn.frame = CGRectMake(self.rightMenuBtn.frame.origin.x,self.rightMenuBtn.frame.origin.y,0,0);
                [self.view addSubview:btn];
                [UIView animateWithDuration:0.16 animations:^{
                    btn.frame = CGRectMake(self.rightMenuBtn.frame.origin.x,self.rightMenuBtn.frame.origin.y,0,0);
                }];
            }
            isExpand = NO;
        }
    }
    else
    {
        [UIView  animateWithDuration:0.08  animations:^{
            CALayer   * layer  = self.rightMenuBtn.layer;
            layer.transform  = CATransform3DRotate(layer.transform,   M_PI, 0,0,1);
        } completion:^(BOOL finished) {
            [UIView  animateWithDuration:0.08 animations:^{
                CALayer   * layer  = self.rightMenuBtn.layer;
                layer.transform  = CATransform3DRotate(layer.transform,   M_PI, 0,0,1);
            }];
        }];
        if (isExpand == NO) {
            CGFloat  width  = 50 * SCREEN_HEIGHT / 667;
            for (int i = 0 ; i < self.titleBtnArray.count; i++)
            {
                UIButton * btn = self.titleBtnArray[i];
                btn.tag = 300 + i;
                self.translateBtn.alpha = 1;
                btn.frame = CGRectMake(CGRectGetMaxX(self.rightMenuBtn.frame),CGRectGetMaxY(self.rightMenuBtn.frame),0,0);
                [btn addTarget:self action:@selector(singleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:btn];
                [UIView animateWithDuration:0.16 animations:^{
                    NSDictionary * dict = self.rightFrameArray[i];
                    NSNumber  *xNumber = [dict objectForKey:@"xFrame"];
                    NSNumber  *yNumber = [dict objectForKey:@"yFrame"];
                    CGFloat  x = [xNumber integerValue];
                    CGFloat  y = [yNumber  integerValue];
                    btn.frame = CGRectMake(x, y,width, width);
                }];
            }
            //展开后状态改变
            isExpand = YES;
        }
        else
        {
            for (int i = 0 ; i < self.titleBtnArray.count; i++)
            {
                UIButton * btn = self.titleBtnArray[i];
                [self.view addSubview:btn];
                [UIView animateWithDuration:0.16 animations:^{
                    btn.frame = CGRectMake(self.rightMenuBtn.frame.origin.x,self.rightMenuBtn.frame.origin.y,0,0);
                }];
            }
            isExpand = NO;
        }
        
    }
}

-(UIButton *)rightBtn
{
    if (_rightBtn == nil) {
        _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(25,0,15,_whiteView.frame.size.height)];
        [_rightBtn addTarget:self action:@selector(jumpRankView) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.backgroundColor = [UIColor whiteColor];
    }
    return _rightBtn;
}
-(UIView *)whiteView
{
    if (_whiteView == nil) {
        _whiteView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 40,NAVBARHEIGHT+15,40,80 * SCREEN_HEIGHT / 667)];
        UIControl *control = [[UIControl alloc]initWithFrame:CGRectMake(0,0,_whiteView.frame.size.width,_whiteView.frame.size.height)];
        [control addTarget:self action:@selector(jumpRankView) forControlEvents:UIControlEventTouchUpInside];
        [_whiteView addSubview:control];
        [_whiteView addSubview:self.rightBtn];
    }
    return _whiteView;
}

-(UIButton *)hintBtn{
    
    if (_hintBtn == nil) {
        _hintBtn  = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 120,NAVBARHEIGHT + 10,110,80)];
        [_hintBtn  setBackgroundImage:[UIImage scaleFromImage:[UIImage imageNamed:@"level_designation_bg"] toSize:CGSizeMake(_hintBtn.frame.size.width,_hintBtn.frame.size.height)] forState:UIControlStateNormal];
        //        [_hintBtn addTarget:self action:@selector(hintClick) forControlEvents:UIControlEventTouchUpInside];
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0,10,110,60)];
        [_hintBtn addSubview:contentView];
        CGSize maxSize = CGSizeMake(MAXFLOAT,MAXFLOAT);
        NSString * rankName = @"佛珠排行榜";
        CGFloat rankNameWidth = [rankName sizeWithFont:[UIFont systemFontOfSize:12] maxSize:maxSize].width;
        UIImageView * labelBGImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_hintBtn.frame.size.width*0.5 - (rankNameWidth + 4)/ 2,2,(rankNameWidth + 4),25)];
        labelBGImageView.userInteractionEnabled=YES;
        labelBGImageView.image = [UIImage imageNamed:@"03"];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        [labelBGImageView addGestureRecognizer:tap];
        [contentView addSubview:labelBGImageView];
        UILabel *rankLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, labelBGImageView.frame.size.width,labelBGImageView.frame.size.height)];
        rankLabel.textAlignment = NSTextAlignmentCenter;
        rankLabel.font = [UIFont systemFontOfSize:12];
        rankLabel.textColor = majorityColor;
        rankLabel.text = rankName;
        [labelBGImageView addSubview:rankLabel];
        NSString * currentLevelStr = @"当前等级";
        CGFloat  currentLavelStrWidth = [currentLevelStr sizeWithFont:[UIFont systemFontOfSize:10] maxSize:maxSize].width;
        UILabel *currentLevelLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelBGImageView.frame.origin.x,CGRectGetMaxY(labelBGImageView.frame)+2,currentLavelStrWidth,15)];
        currentLevelLabel.text = currentLevelStr;
        //currentLevelLabel.backgroundColor = [UIColor blueColor];
        currentLevelLabel.textColor = [UIColor whiteColor];
        currentLevelLabel.font = [UIFont systemFontOfSize:10];
        [contentView addSubview:currentLevelLabel];
        
        NSString *levelStr =@"Lv100";
        CGFloat  levelWidth  = [levelStr sizeWithFont:[UIFont systemFontOfSize:10] maxSize:maxSize].width;
        self.levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(currentLevelLabel.frame)+2,currentLevelLabel.frame.origin.y+1.5,levelWidth,12)];
        self.levelLabel.backgroundColor=[UIColor colorWithPatternImage:[self OriginImage:[UIImage imageNamed:@"LV背景"] scaleToSize:CGSizeMake(levelWidth, 12)]];
        
        myLevelLabel = self.levelLabel;
        myLevelLabel.font = [UIFont systemFontOfSize:10];
        
        self.levelLabel .textColor = [UIColor whiteColor];
        CALayer  *levelLabelLayer = self.levelLabel .layer;
        levelLabelLayer.cornerRadius = 3;
        levelLabelLayer.masksToBounds = YES;
        [contentView addSubview: self.levelLabel ];
        
        UILabel *valueHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(currentLevelLabel.frame.origin.x,CGRectGetMaxY(currentLevelLabel.frame),currentLevelLabel.frame.size.width,15)];
        valueHintLabel.text = @"修行值";
        //valueHintLabel.backgroundColor = [UIColor orangeColor];
        valueHintLabel.font = [UIFont systemFontOfSize:10];
        valueHintLabel.textColor = [UIColor whiteColor];
        [contentView addSubview:valueHintLabel];
        
        self.valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(valueHintLabel.frame),valueHintLabel.frame.origin.y,myLevelLabel.frame.size.width,15)];
        self.valueLabel.textColor = [UIColor whiteColor];
        self.valueLabel.font = [UIFont systemFontOfSize:10];
        self.valueLabel.textAlignment = NSTextAlignmentLeft;
        myLevelLabel = self.valueLabel;
        [contentView addSubview:self.valueLabel];
        [self setPerson];
    }
    return _hintBtn;
    
    
}
-(void)tapClick{
    
    BeabsRankViewController * bead = [[BeabsRankViewController alloc]init];
    [bead getBeadsRankInfo];
    [self.navigationController pushViewController:bead animated:YES];
}
#pragma mark ---跳出排行榜
-(void)jumpRankView
{
    BeabsRankViewController * bead = [[BeabsRankViewController alloc]init];
    [self.navigationController pushViewController:bead animated:YES];
}
#pragma mark ----自定义-----
-(NSMutableArray *)positionArray
{
    if (_positionArray == nil) {
        _positionArray = [[NSMutableArray alloc]init];
        for(int i = 0 ; i < 8 ; i++)
        {
            [_positionArray addObject:[NSNumber numberWithInteger:80*i-80]];
        }
    }
    return _positionArray;
}
-(NSMutableArray *)fozhuArray
{
    if (_fozhuArray == nil) {
        _fozhuArray = [[NSMutableArray alloc]init];
        for(int i = 0 ; i < 8;i ++)
        {
            _beadsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,80,80)];
            _beadsImageView.image = [UIImage imageNamed:@"beads_one"];
            CALayer *roundViewLayer = _beadsImageView.layer;
            roundViewLayer.cornerRadius =  20;
            roundViewLayer.masksToBounds = YES;
            [_fozhuArray addObject:_beadsImageView];
        }
    }
    return _fozhuArray;
}
#pragma mark ---主页面-----
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadCurrentData];
    [self loadRankData];
    NSString *numberStr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"todayBeadsNumber"]];
    if ([numberStr isEqualToString:@"(null)"]) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        NSDate * date = [NSDate date];
        NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"YYYY/MM/dd"];
        NSString  *dateString  = [dateFormatter stringFromDate:date];
        [dict setObject:@0 forKey:@"todayBeadsNumber"];
        [dict setObject:dateString forKey:@"dateString"];
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"todayBeadsNumber"];
        toDayBeadsNumber =  0 ;
        NSLog(@"1111");
    }
    else
    {
        NSDictionary  *dict1 =  [[NSUserDefaults standardUserDefaults]objectForKey:@"todayBeadsNumber"];
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithDictionary:dict1];
        NSNumber *  number = [dict objectForKey:@"todayBeadsNumber"];
        NSLog(@"-----%ld",[number integerValue]);
        NSString * dateString = [dict objectForKey:@"dateString"];
        NSDate * date = [NSDate date];
        NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"YYYY/MM/dd"];
        NSString  *currentDateString  = [dateFormatter stringFromDate:date];
        
        
        if ([currentDateString isEqualToString:dateString]) {
            toDayBeadsNumber = [number integerValue];
        }
        else
        {
            [dict setValue:currentDateString forKey:@"dateString"];
            toDayBeadsNumber = 0 ;
            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"todayBeadsNumber"];
        }
        
    }
    recentTimes = 0 ;
    isShake = YES;
    //默认没有展开
    isExpand = NO ;
    bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height)];
    bgImage.image=[UIImage imageNamed:@"puti_beads_bg.jpg"];
    [self.view addSubview:bgImage];
    
    bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NAVBARHEIGHT)];
    [bar setBackgroundImage:[UIImage imageNamed:@"meditation_top_bg.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:bar];
    
    fanhuiBt=[[UIButton alloc]initWithFrame:CGRectMake(6,(NAVBARHEIGHT - 25) / 2 + 10, 25, 25)];
    [fanhuiBt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [fanhuiBt addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:fanhuiBt];
    
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(0.5 *SCREEN_WIDTH - 45,(NAVBARHEIGHT - 25) / 2 +10,90,25)];
    title.text=@"菩提佛珠";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    [bar addSubview:title];
    
    
    [self.view addSubview:self.rightMenuBtn];
    [self.view addSubview:self.leftBeadsView];
    [self.view addGestureRecognizer:self.swipeDown];
    [self.view addSubview:self.hintBtn];
}
-(UILabel *)scoreLabel
{
    if (_scoreLabel == nil) {
        _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,NAVBARHEIGHT + 2,SCREEN_WIDTH - 10,20)];
        _scoreLabel.textColor=[UIColor colorWithRed:255.0f/255.0f green:246.0f/255.0f blue:218.0f/255.0f alpha:1.0f];
        _scoreLabel.font = [UIFont systemFontOfSize:15];
        _scoreLabel.text = [NSString stringWithFormat:@"本次念珠:  0  今日念珠:  %ld  累积念珠:  %ld",toDayBeadsNumber, totalNumber];
    }
    return _scoreLabel;
}
-(void)swipeDownActivity
{
    recentTimes ++;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"本次念珠:  %ld  今日念珠:%ld    累积念珠:   %ld",recentTimes,toDayBeadsNumber+1,++totalNumber];
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    [UIView animateWithDuration:0.2 animations:^{
        
        for(int i = 0 ; i < self.leftBeadArray.count;i++)
        {
            UIImageView * beadImageView = self.leftBeadArray[i];
            NSNumber *yPosition = self.beadPositionArray[i];
            beadImageView.frame = CGRectMake(0,[yPosition floatValue] + beadRadius,beadRadius,beadRadius);
        }
        //设置值
        
    } completion:^(BOOL finished) {
        [[NSUserDefaults standardUserDefaults]objectForKey:@"totalNumber"];
        [self transformFunction];
    }];
    if (++toDayBeadsNumber%60==0){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.5, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.08)];
        
        view.backgroundColor=[UIColor blackColor];
        //        view.alpha=0.5;
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, -2, view.frame.size.width*0.7, view.frame.size.height)];
        label1.text=@"修行值";
        
        label1.font=[UIFont systemFontOfSize:20.0f];
        label1.textColor=[UIColor whiteColor];
        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(2+label1.frame.size.width, label1.frame.origin.y, label1.frame.size.width*0.3, view.frame.size.height)];
        label2.text=@"+1";
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
}
-(void)transformFunction
{
    UIImageView * beadImageView  = [self.leftBeadArray lastObject];
    beadImageView.frame = CGRectMake(0,-beadRadius,beadRadius,beadRadius);
    for(int i =  (int)self.leftBeadArray.count -2 ; i >= 0;i--)
    {
        self.leftBeadArray[i+1] = self.leftBeadArray[i];
    }
    [self.leftBeadArray replaceObjectAtIndex:0 withObject:beadImageView];
}
#pragma mark ---返回时提交的接口------
#pragma mark ---返回时提交的接口------
-(void)backclick{
    
    if (recentTimes == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        NSDictionary *dict2 = [[NSUserDefaults standardUserDefaults]objectForKey:@"todayBeadsNumber"];
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithDictionary:dict2];
        [dict setObject:[NSNumber numberWithInteger:toDayBeadsNumber] forKey:@"todayBeadsNumber"];
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"todayBeadsNumber"];
        UIAlertView * alret = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"您已本次已经拨珠%ld,确定停止拨珠吗?",recentTimes] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alret show];
    }
    
}
//提交数据
#pragma mark ----alretsheet代理----
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (buttonIndex == 1){
        
        // [ProgressHUD showOnView:self.view];
        AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
        NSLog(@"id =%@",huaien);
        NSNumber *miyaoNum= [appDelegate.accountBasicDict objectForKey:@"secretKey"];
        NSNumber * userLoginID= [appDelegate.accountBasicDict objectForKey:@"userLoginID"];
        NSDictionary * dic = @{@"secretKey":miyaoNum,@"userLoginID":userLoginID,@"huaienID":huaien,@"userTaskID":@0,@"taskCode":@800,@"sceneType":@1,@"buddhistTempleID":@0,@"bookID":@0,@"beginPostion":[NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:recentTimes]],@"endPostion":@0};
        NSDictionary * meditionDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
        [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,SubmitSitMeditationURL] parameters:meditionDic success:^(NSURLSessionDataTask *task, id responseObject) {
            
            id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"提交数据=%@",jsonData);
            NSNumber *result =jsonData[@"result"];
            NSString *desc =jsonData[@"desc"];
            if([result integerValue]>0){
                UILabel *label = [[UILabel alloc]init];
                label.frame = CGRectMake(SCREEN_WIDTH *0.3, SCREEN_HEIGHT*0.8,SCREEN_WIDTH*0.4, 30);
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
                label.frame = CGRectMake(SCREEN_WIDTH *0.3, SCREEN_HEIGHT*0.8,SCREEN_WIDTH*0.4, 30);
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
- (void)setPerson
{
    //等级
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *levelStr =[appDelegate.accountBasicDict objectForKey:@"levelAndDesignation"];
    NSArray *array = [levelStr componentsSeparatedByString:@"|"];
    for (int i=0;i<array.count;i++){
        self.levelLabel.text =[NSString stringWithFormat:@" LV%@",array[0]];
    }
    NSNumber *totalIntegral=appDelegate.accountBasicDict[@"totalIntegral"];
    NSLog(@"数据＝%@",totalIntegral);
    NSString *str1 =[totalIntegral stringValue];
    NSLog(@"str1=%@",str1);
    
    self.valueLabel.text=str1;
    
}
#pragma mark－－ 获取修行值
- (void)loadRankData
{
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSNumber *secretKey =[appDelegate.accountBasicDict objectForKey:@"secretKey"];
    NSDictionary * rankDic=@{@"huaienID":huaien,@"secretKey":secretKey};
    NSLog(@"字典＝%@",rankDic);
    NSDictionary * rankDic1 = @{@"params":[NSString stringWithFormat:@"%@",rankDic]};
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,ptxGetUserLevel] parameters:rankDic1 success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"等级＝%@",jsonData);
        NSNumber *result =jsonData[@"result"];
        if ([result integerValue]==0){
            [appDelegate.accountBasicDict setObject:jsonData[@"totalIntegral"] forKey:@"totalIntegral"];
            [appDelegate.accountBasicDict setObject:jsonData[@"levelAndDesignation"] forKey:@"levelAndDesignation"];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
#pragma mark 累积数
-(void)loadCurrentData
{
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * miyaoNum = [appDelegate.accountBasicDict  objectForKey:@"secretKey"];
    NSLog(@"密码＝%@",miyaoNum);
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSLog(@"ID＝%@",huaien);
    NSDictionary * currentDict=@{@"secretKey":miyaoNum,@"huaienID":huaien,@"taskCode":@800};
    NSDictionary * currentDict1 = @{@"params":[NSString stringWithFormat:@"%@",currentDict]};
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,ptxGetUserTaskCurrentStatInfo]  parameters:currentDict1 success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber * totalQty=jsonData[@"totalQty"];
        totalNumber = [totalQty integerValue];
        [self.view addSubview:self.scoreLabel];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}
@end

